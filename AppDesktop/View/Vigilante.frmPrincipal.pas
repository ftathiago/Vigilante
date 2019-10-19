unit Vigilante.frmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Generics.Collections,
  System.Threading,
  System.SysUtils, System.Variants, System.Notification, System.Classes,
  Vcl.Forms, Vcl.ExtCtrls, Vcl.AppEvnts, System.Actions, Vcl.ActnList,
  Vcl.Menus, Vcl.WinXCtrls, Vcl.Controls, Vcl.StdCtrls, Vcl.ComCtrls,
  Module.View.FormBase, ThreadingEx,
  Vigilante.Controller.Mediator,
  Vigilante.Configuracao,
  Vigilante.Controller.Base,
  Vigilante.Build.Observer,
  Vigilante.Build.Event,
  Vigilante.Build.View,
  Vigilante.Build.Model,
  Vigilante.Controller.Build,
  Vigilante.Compilacao.Observer,
  Vigilante.Compilacao.View,
  Vigilante.Compilacao.Model,
  Vigilante.Controller.Compilacao,
  Vigilante.Configuracao.Observer,
  Vigilante.Configuracao.View,
  Vigilante.Controller.Configuracao;

type
  TfrmPrincipal = class(TFormBase, IBuildObserver, ICompilacaoObserver,
    IConfiguracaoObserver)
    TrayIcon: TTrayIcon;
    PopupMenu1: TPopupMenu;
    ActionList1: TActionList;
    actVigiarCompilacao: TAction;
    VigiarLink1: TMenuItem;
    NotificationCenter: TNotificationCenter;
    ApplicationEvents: TApplicationEvents;
    pgcVisualizacoes: TPageControl;
    tbsBuild: TTabSheet;
    tbsCompilacao: TTabSheet;
    tmrBuscarAtualizacoes: TTimer;
    actVigiarBuild: TAction;
    VigiarBuild1: TMenuItem;
    pnlTopo: TPanel;
    lblUltimaAtualizacao: TLabel;
    chkAtualizacaoAutomatica: TToggleSwitch;
    tbsConfiguracoes: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actVigiarCompilacaoExecute(Sender: TObject);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure ApplicationEventsRestore(Sender: TObject);
    procedure NotificationCenterReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure tmrBuscarAtualizacoesTimer(Sender: TObject);
    procedure actVigiarBuildExecute(Sender: TObject);
    procedure chkAtualizacaoAutomaticaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    frmBuildView: TfrmBuildView;
    frmCompilacaoView: TfrmCompilacaoView;
    FBuildController: IBuildController;
    FCompilacaoController: ICompilacaoController;
    FConfiguracaoController: IConfiguracaoController;
    frmConfiguracaoView: TfrmConfiguracaoView;
    FConfiguracaoSubject: IConfiguracaoSubject;
    FBuildSubject: IBuildSubject;
    FCompilacaoSubject: ICompilacaoSubject;
    FControllerMediator: IControllerMediator;
    FAtualizacaoTask: ITask;
    procedure LigarNotificacoes(const ALigar: Boolean = true);
    procedure InicializarFrames;
    procedure MostrarBuild(const AID: TGUID);
    procedure AdicionarBuild;
    procedure AdicionarCompilacao;
    procedure MostrarCompilacao(const AID: TGUID);
    procedure CarregarObservadoresBuild;
    procedure CarregarObservadoresConfiguracao;
    procedure CarregarObservadoresCompilacao;
    procedure MostrarNotificacaoBuild(const ABuild: IBuildModel);
    procedure MostrarNotificacaoCompilacao(const ACompilacao: ICompilacaoModel);
  public
    procedure IBuildObserver.NovaAtualizacao = MostrarNotificacaoBuild;
    procedure ICompilacaoObserver.NovaAtualizacao =
      MostrarNotificacaoCompilacao;
    procedure ConfiguracoesAlteradas(const AConfiguracao: IConfiguracao);
    procedure AfterConstruction; override;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  System.Rtti, DateTimeHelper, System.UITypes, Vcl.Dialogs,
  ContainerDI, Vigilante.Configuracao.Impl, Vigilante.Aplicacao.SituacaoBuild,
  Vigilante.View.URLDialog, Vigilante.View.BuildURLDialog;

const
  NOTIFICATION_BUILD = 'BUILD';
  NOTIFICATION_COMPILACAO = 'COMPILACAO';

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FControllerMediator := CDI.Resolve<IControllerMediator>;
  frmBuildView := CDI.Resolve<TfrmBuildView>([Self]);
  frmCompilacaoView := CDI.Resolve<TfrmCompilacaoView>([Self]);
  frmConfiguracaoView := CDI.Resolve<TfrmConfiguracaoView>([Self]);

  FConfiguracaoSubject := CDI.Resolve<IConfiguracaoSubject>;
  FBuildSubject := CDI.Resolve<IBuildSubject>;
  FCompilacaoSubject := CDI.Resolve<ICompilacaoSubject>;

  FConfiguracaoController := CDI.Resolve<IConfiguracaoController>;
  FBuildController := CDI.Resolve<IBuildController>
    ([TValue.From(FControllerMediator)]);
  FCompilacaoController := CDI.Resolve<ICompilacaoController>
    ([TValue.From(FControllerMediator)]);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  if Assigned(FAtualizacaoTask) then
    FAtualizacaoTask.Cancel;
  FConfiguracaoSubject.Remover(Self);
  FConfiguracaoSubject.Remover(FConfiguracaoController);
  FControllerMediator.RemoverController(tcBuild);
  FControllerMediator.RemoverController(tcCompilacao);
  TrayIcon.Visible := False;
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageDlg('Deseja realmente encerrar o sistema?', mtConfirmation,
    [mbYes, mbNo], 0, mbNo) = mrYes;
  if not CanClose then
    Application.Minimize;
end;

procedure TfrmPrincipal.AfterConstruction;
begin
  inherited;
  InicializarFrames;
  CarregarObservadoresBuild;
  CarregarObservadoresCompilacao;
  CarregarObservadoresConfiguracao;
  pgcVisualizacoes.ActivePageIndex := 0;
end;

procedure TfrmPrincipal.InicializarFrames;
begin
  frmBuildView.Parent := tbsBuild;
  frmBuildView.Align := alClient;
  frmBuildView.DefinirController(FBuildController);

  frmCompilacaoView.Parent := tbsCompilacao;
  frmCompilacaoView.Align := alClient;
  frmCompilacaoView.DefinirController(FCompilacaoController);

  frmConfiguracaoView.Parent := tbsConfiguracoes;
  frmConfiguracaoView.Align := alClient;
  frmConfiguracaoView.DefinirController(FConfiguracaoController);
end;

procedure TfrmPrincipal.CarregarObservadoresBuild;
begin
  FBuildSubject.Adicionar(frmBuildView);
  FBuildSubject.Adicionar(Self);
end;

procedure TfrmPrincipal.CarregarObservadoresCompilacao;
begin
  FCompilacaoSubject.Adicionar(frmCompilacaoView);
  FCompilacaoSubject.Adicionar(Self);
end;

procedure TfrmPrincipal.CarregarObservadoresConfiguracao;
begin
  FConfiguracaoSubject.Adicionar(FConfiguracaoController);
  FConfiguracaoSubject.Adicionar(frmConfiguracaoView);
  FConfiguracaoSubject.Adicionar(Self);
  FConfiguracaoSubject.Notificar(PegarConfiguracoes);
end;

procedure TfrmPrincipal.LigarNotificacoes(const ALigar: Boolean);
var
  _state: TToggleSwitchState;
begin
  _state := tssOff;
  if ALigar then
    _state := tssOn;
  chkAtualizacaoAutomatica.State := _state;
  tmrBuscarAtualizacoes.Enabled := ALigar;
end;

procedure TfrmPrincipal.NotificationCenterReceiveLocalNotification
  (Sender: TObject; ANotification: TNotification);
begin
  TThread.Queue(TThread.CurrentThread,
    procedure
    var
      _id: TGUID;
    begin
      Application.Restore;
      Application.BringToFront;
      _id := StringToGUID(ANotification.Name);
      if ANotification.ChannelId = NOTIFICATION_BUILD then
      begin
        MostrarBuild(_id);
      end
      else if ANotification.ChannelId = NOTIFICATION_COMPILACAO then
      begin
        MostrarCompilacao(_id);
      end;
    end);
end;

procedure TfrmPrincipal.MostrarBuild(const AID: TGUID);
begin
  FBuildController.VisualizadoPeloUsuario(AID);
  pgcVisualizacoes.ActivePage := tbsBuild;
  frmBuildView.MostrarBuild(AID);
end;

procedure TfrmPrincipal.MostrarCompilacao(const AID: TGUID);
begin
  FCompilacaoController.VisualizadoPeloUsuario(AID);
  pgcVisualizacoes.ActivePage := tbsCompilacao;
  frmCompilacaoView.MostrarCompilacao(AID);
end;

procedure TfrmPrincipal.MostrarNotificacaoCompilacao(const ACompilacao
  : ICompilacaoModel);
var
  _notificacao: TNotification;
begin
  if not(ACompilacao.Situacao in SITUACOES_NOTIFICAVEIS) then
    Exit;
  _notificacao := TNotification.Create;
  try
    _notificacao.ChannelId := NOTIFICATION_COMPILACAO;
    _notificacao.Name := ACompilacao.Id.ToString;
    _notificacao.Number := ACompilacao.Numero;
    _notificacao.Title := ACompilacao.Nome;
    _notificacao.AlertBody := ACompilacao.Situacao.AsString;
    NotificationCenter.PresentNotification(_notificacao);
  finally
    FreeAndNil(_notificacao);
  end;
end;

procedure TfrmPrincipal.MostrarNotificacaoBuild(const ABuild: IBuildModel);
var
  _notificacao: TNotification;
begin
  if not(ABuild.Situacao in SITUACOES_NOTIFICAVEIS) then
    Exit;
  _notificacao := TNotification.Create;
  try
    _notificacao.ChannelId := NOTIFICATION_BUILD;
    _notificacao.Name := ABuild.Id.ToString;
    _notificacao.Number := ABuild.BuildAtual;
    _notificacao.Title := ABuild.Nome;
    _notificacao.AlertBody := ABuild.Situacao.AsString;
    NotificationCenter.PresentNotification(_notificacao);
  finally
    FreeAndNil(_notificacao);
  end;
end;

procedure TfrmPrincipal.actVigiarBuildExecute(Sender: TObject);
begin
  AdicionarBuild;
end;

procedure TfrmPrincipal.AdicionarCompilacao;
begin
  frmCompilacaoView.AdicionarNovoLink;
end;

procedure TfrmPrincipal.AdicionarBuild;
begin
  frmBuildView.AdicionarNovoLink;
end;

procedure TfrmPrincipal.actVigiarCompilacaoExecute(Sender: TObject);
begin
  AdicionarCompilacao;
end;

procedure TfrmPrincipal.tmrBuscarAtualizacoesTimer(Sender: TObject);
const
  ULTIMA_REQUISICAO = 'Última atualizaçãoo: %s';
  BUSCANDO_ATUALIZACOES = 'Buscando atualizações';
begin
  FAtualizacaoTask := TTask.Create(
    procedure
    begin
      lblUltimaAtualizacao.Caption := BUSCANDO_ATUALIZACOES;
      LigarNotificacoes(False);
      try
        FBuildController.BuscarAtualizacoes;
        if TTask.CurrentTask.Status = TTaskStatus.Canceled then
          Exit;
        FCompilacaoController.BuscarAtualizacoes;
        if TTask.CurrentTask.Status = TTaskStatus.Canceled then
          Exit;
      finally
        if TTask.CurrentTask.Status <> TTaskStatus.Canceled then
        begin
          TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              lblUltimaAtualizacao.Caption := Format(ULTIMA_REQUISICAO,
                [Now.ToString('dd/mm/yyyy hh:MM:ss')]);
              LigarNotificacoes();
            end);
        end;
      end;
    end);
  FAtualizacaoTask.Start;
end;

procedure TfrmPrincipal.chkAtualizacaoAutomaticaClick(Sender: TObject);
begin
  LigarNotificacoes(chkAtualizacaoAutomatica.State = tssOn);
end;

procedure TfrmPrincipal.ConfiguracoesAlteradas(const AConfiguracao
  : IConfiguracao);
var
  _state: TToggleSwitchState;
begin
  _state := tssOff;
  if AConfiguracao.AtualizacoesAutomaticas then
    _state := tssOn;
  chkAtualizacaoAutomatica.State := _state;

  tmrBuscarAtualizacoes.Interval := AConfiguracao.AtualizacoesIntervalo;
  tmrBuscarAtualizacoes.Enabled := AConfiguracao.AtualizacoesAutomaticas;
  lblUltimaAtualizacao.Caption := 'Última atualização: 00/00/0000 00:00:00';
end;

procedure TfrmPrincipal.TrayIconDblClick(Sender: TObject);
begin
  Application.Restore;
  Application.BringToFront;
  Application.ProcessMessages;
end;

procedure TfrmPrincipal.ApplicationEventsMinimize(Sender: TObject);
begin
  Application.MainFormOnTaskBar := False;
  Hide;
end;

procedure TfrmPrincipal.ApplicationEventsRestore(Sender: TObject);
begin
  Application.MainFormOnTaskBar := true;
  Show;
end;

end.
