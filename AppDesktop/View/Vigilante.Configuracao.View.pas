unit Vigilante.Configuracao.View;

interface

uses
  Vigilante.View.Base, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls, Vigilante.Configuracao,
  Vigilante.Configuracao.Observer, Vigilante.Controller.Configuracao;

type
  TfrmConfiguracaoView = class(TViewBase, IConfiguracao, IConfiguracaoObserver)
    chkSimulado: TToggleSwitch;
    chkAtualizacaoAutomatica: TToggleSwitch;
    Label2: TLabel;
    edtAtualizacaoIntervalo: TEdit;
    Label3: TLabel;
    Button1: TButton;
    gpbAtualizacoesAutomaticas: TGroupBox;
    gpbOrigemDosDados: TGroupBox;
    procedure edtAtualizacaoIntervaloClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FController: IConfiguracaoController;
    procedure AlterarStatusChkState(const chkToggle: TToggleSwitch;
      const ALigado: boolean);
  public
    function GetSimularBuild: boolean;
    function GetAtualizacoesAutomaticas: boolean;
    function GetAtualizacoesIntervalo: integer;
    procedure DefinirController(const AController: IConfiguracaoController);
    procedure SetSimularBuild(const Value: boolean);
    procedure SetAtualizacoesAutomaticas(const Value: boolean);
    procedure SetAtualizacoesIntervalo(const Value: integer);
    procedure PersistirConfiguracoes;
    procedure ConfiguracoesAlteradas(const AConfiguracao: IConfiguracao);
    procedure CarregarConfiguracoes;
  end;

implementation

{$R *.dfm}


uses
  System.StrUtils, Vigilante.Configuracao.Impl;

procedure TfrmConfiguracaoView.Button1Click(Sender: TObject);
begin
  inherited;
  PersistirConfiguracoes;
end;

procedure TfrmConfiguracaoView.CarregarConfiguracoes;
begin
  ConfiguracoesAlteradas(PegarConfiguracoes);
end;

procedure TfrmConfiguracaoView.ConfiguracoesAlteradas(
  const AConfiguracao: IConfiguracao);
begin
  if not Assigned(FController) then
    Exit;
  FController.CarregarConfiguracoes(AConfiguracao, Self);
end;

procedure TfrmConfiguracaoView.DefinirController(
  const AController: IConfiguracaoController);
begin
  FController := AController;
  FController.CarregarConfiguracoes(PegarConfiguracoes, Self);
end;

procedure TfrmConfiguracaoView.edtAtualizacaoIntervaloClick(Sender: TObject);
begin
  inherited;
  PersistirConfiguracoes;
end;

procedure TfrmConfiguracaoView.PersistirConfiguracoes;
begin
  FController.PersistirAlteracoes(Self);
end;

procedure TfrmConfiguracaoView.AlterarStatusChkState(
  const chkToggle: TToggleSwitch; const ALigado: boolean);
var
  _state: TToggleSwitchState;
begin
  _state := tssOff;
  if ALigado then
    _state := tssOn;
  chkToggle.State := _state;
end;

function TfrmConfiguracaoView.GetAtualizacoesAutomaticas: boolean;
begin
  Result := chkAtualizacaoAutomatica.State = tssOn;
end;

function TfrmConfiguracaoView.GetAtualizacoesIntervalo: integer;
var
  _atualizacaoIntervalo: string;
begin
  Result := -1;
  _atualizacaoIntervalo := edtAtualizacaoIntervalo.Text;
  if _atualizacaoIntervalo.Trim.IsEmpty then
    Exit;

  Result := _atualizacaoIntervalo.toInteger * 1000;
end;

function TfrmConfiguracaoView.GetSimularBuild: boolean;
begin
  Result := chkSimulado.State = tssOn;
end;

procedure TfrmConfiguracaoView.SetAtualizacoesAutomaticas(const Value: boolean);
begin
  AlterarStatusChkState(chkAtualizacaoAutomatica, Value);
end;

procedure TfrmConfiguracaoView.SetAtualizacoesIntervalo(const Value: integer);
begin
  edtAtualizacaoIntervalo.Text := (Value div 1000).ToString;
end;

procedure TfrmConfiguracaoView.SetSimularBuild(const Value: boolean);
begin
  AlterarStatusChkState(chkSimulado, Value);
end;

end.
