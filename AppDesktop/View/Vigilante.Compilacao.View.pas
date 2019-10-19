unit Vigilante.Compilacao.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Imaging.pngimage,
  Vigilante.Aplicacao.SituacaoBuild, FireDAC.Stan.StorageXML,
  Vigilante.Controller.Compilacao, Vcl.WinXCtrls, Vigilante.Compilacao.Observer,
  System.Notification, DateTimeHelper, Vigilante.Compilacao.Model, Vigilante.DataSet.Compilacao,
  Vigilante.View.Component.SituacaoBuild, System.Actions, Vcl.ActnList;

type
  TfrmCompilacaoView = class(TFrame, ICompilacaoObserver)
    dtsBuild: TDataSource;
    pgcView: TPageControl;
    tbsArquivosModificados: TTabSheet;
    ChangeSet: TDBMemo;
    tbsDados: TTabSheet;
    DBGrid1: TDBGrid;
    pnlHeader: TPanel;
    Label1: TLabel;
    UltimaAtualizacao: TDBText;
    DBNavigator1: TDBNavigator;
    Panel2: TPanel;
    pnlCliente: TPanel;
    dbgListaCompilacoes: TDBGrid;
    frmSituacaoBuild1: TfrmSituacaoBuild;
    ActionList1: TActionList;
    actMostrarDados: TAction;
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure actMostrarDadosExecute(Sender: TObject);
    procedure dbgListaCompilacoesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    FController: ICompilacaoController;
    FDadosClone: TCompilacaoDataSet;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure NovaAtualizacao(const ABuild: ICompilacaoModel);
    procedure AdicionarNovoLink;
    procedure DefinirController(const AController: ICompilacaoController);
    procedure MostrarCompilacao(const AID: TGUID);
  end;

implementation

{$R *.dfm}


uses
  Winapi.ShellAPI, System.StrUtils, System.IOUtils, System.Threading, IdURI,
  ContainerDI;

procedure TfrmCompilacaoView.AfterConstruction;
begin
  inherited;
  FDadosClone := TCompilacaoDataSet.Create(nil);
  dtsBuild.DataSet := FDadosClone;
end;

procedure TfrmCompilacaoView.BeforeDestruction;
begin
  inherited;
  FreeAndNil(FDadosClone);
end;

procedure TfrmCompilacaoView.actMostrarDadosExecute(Sender: TObject);
begin
  tbsDados.TabVisible := not tbsDados.TabVisible;
end;

procedure TfrmCompilacaoView.AdicionarNovoLink;
var
  _url: string;
begin
  if FDadosClone.State in dsEditModes then
    FDadosClone.Cancel;
  _url := InputBox('Vigilante',
    'Informe o link da BUILD que deseja vigiar', '');
  if _url.Trim.IsEmpty then
    Exit;
  FDadosClone.Insert;
  FDadosClone.URL := _url;
  FDadosClone.Post;
end;

procedure TfrmCompilacaoView.NovaAtualizacao(const ABuild: ICompilacaoModel);
begin
{ TODO : Apagar }
//  FController.AdicionarOuAtualizar(ABuild);
end;

procedure TfrmCompilacaoView.dbgListaCompilacoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  case FDadosClone.Situacao of
    sbFalhouInfra:
      begin
        dbgListaCompilacoes.Canvas.Brush.Color := clWebLightSalmon;
        // DBGrid1.Canvas.Font.Color := clWindowText;
      end;
    sbAbortado:
      begin
        dbgListaCompilacoes.Canvas.Brush.Color := clWebLightSalmon;
        // DBGrid1.Canvas.Font.Color := clWindowText;
      end;
    sbFalhou:
      begin
        dbgListaCompilacoes.Canvas.Brush.Color := clWebLightSalmon;
        // DBGrid1.Canvas.Font.Color := clWindowText;
      end;
    sbSucesso:
      begin
        dbgListaCompilacoes.Canvas.Brush.Color := clWebLightGreen;
        dbgListaCompilacoes.Canvas.Font.Color := clWebSlateGray;
      end;
  end;
  // DBGrid1.Canvas.Font.Style := [fsBold];
  dbgListaCompilacoes.Canvas.FillRect(Rect);
  dbgListaCompilacoes.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCompilacaoView.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
begin
  if Button = nbInsert then
  begin
    AdicionarNovoLink();
  end;
end;

procedure TfrmCompilacaoView.DefinirController(const AController: ICompilacaoController);
begin
  FController := AController;
  FDadosClone.CloneCursor(FController.DataSet);
  frmSituacaoBuild1.DataSet := FDadosClone;
  frmSituacaoBuild1.NomeFieldName := 'Nome';
  frmSituacaoBuild1.SituacaoBuildFieldName := 'Situacao';
  frmSituacaoBuild1.URLFieldName := 'URL';
end;

procedure TfrmCompilacaoView.MostrarCompilacao(const AID: TGUID);
begin
  FDadosClone.LocalizarPorID(AID);
end;

end.
