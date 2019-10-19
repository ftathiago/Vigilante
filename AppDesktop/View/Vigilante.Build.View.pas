unit Vigilante.Build.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Vigilante.View.Component.SituacaoBuild, Vigilante.Controller.Build,
  Vcl.WinXCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vigilante.Build.Observer,
  Vigilante.Build.Model, FireDAC.Stan.StorageBin, System.Actions, Vcl.ActnList,
  Vigilante.DataSet.Build;

type
  TfrmBuildView = class(TFrame, IBuildObserver)
    dtsDataSet: TDataSource;
    pnlCliente: TPanel;
    BuildAtualLabel: TLabel;
    Label1: TLabel;
    UltimoBuildSucesso: TDBText;
    Label2: TLabel;
    UltimoBuildFalha: TDBText;
    DBGrid1: TDBGrid;
    frmSituacaoBuild1: TfrmSituacaoBuild;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    Bevel1: TBevel;
    DBNavigator1: TDBNavigator;
    DBGrid2: TDBGrid;
    ActionList1: TActionList;
    actMostrardados: TAction;
    lblTransformarEmCompilacao: TLinkLabel;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure actMostrardadosExecute(Sender: TObject);
    procedure lblTransformarEmCompilacaoLinkClick(Sender: TObject;
      const Link: string; LinkType: TSysLinkType);
    procedure dtsDataSetDataChange(Sender: TObject; Field: TField);
  private
    FController: IBuildController;
    FDadosClone: TBuildDataSet;
    procedure SincronizarLink;
  public
    procedure DefinirController(const AController: IBuildController);
    procedure NovaAtualizacao(const ABuild: IBuildModel);
    procedure MostrarBuild(const AID: TGUID);
    procedure AdicionarNovoLink;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

{$R *.dfm}

uses
  ContainerDI, Vigilante.Aplicacao.SituacaoBuild, Vigilante.View.URLDialog,
  Vigilante.Controller.Mediator;

procedure TfrmBuildView.AfterConstruction;
begin
  inherited;
  FDadosClone := TBuildDataSet.Create(nil);
  dtsDataSet.DataSet := FDadosClone;
end;

procedure TfrmBuildView.BeforeDestruction;
begin
  inherited;
  FreeAndNil(FDadosClone);
end;

procedure TfrmBuildView.actMostrardadosExecute(Sender: TObject);
begin
  DBGrid2.Visible := not DBGrid2.Visible;
end;

procedure TfrmBuildView.AdicionarNovoLink;
var
  _urlDialog: IURLDialog;
begin
  if FDadosClone.State in dsEditModes then
    FDadosClone.Cancel;
  _urlDialog := CDI.Resolve<IURLDialog>('IBuildURLDialog');
  if _urlDialog.Executar then
    FController.AdicionarNovaURL(_urlDialog.URLInformada);
end;

procedure TfrmBuildView.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  case FDadosClone.Situacao of
    sbFalhouInfra:
      begin
        DBGrid1.Canvas.Brush.Color := clWebLightSalmon;
        // DBGrid1.Canvas.Font.Color := clWindowText;
      end;
    sbAbortado:
      begin
        DBGrid1.Canvas.Brush.Color := clWebLightSalmon;
        // DBGrid1.Canvas.Font.Color := clWindowText;
      end;
    sbFalhou:
      begin
        DBGrid1.Canvas.Brush.Color := clWebLightSalmon;
        // DBGrid1.Canvas.Font.Color := clWindowText;
      end;
    sbSucesso:
      begin
        DBGrid1.Canvas.Brush.Color := clWebLightGreen;
        DBGrid1.Canvas.Font.Color := clWebSlateGray;
      end;
  end;
  // DBGrid1.Canvas.Font.Style := [fsBold];
  DBGrid1.Canvas.FillRect(Rect);
  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmBuildView.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
  if Button = nbInsert then
  begin
    AdicionarNovoLink;
  end;
end;

procedure TfrmBuildView.DefinirController(const AController: IBuildController);
begin
  FController := AController;
  FDadosClone.CloneCursor(FController.DataSet);
  frmSituacaoBuild1.DataSet := FDadosClone;
  frmSituacaoBuild1.NomeFieldName := 'Nome';
  frmSituacaoBuild1.SituacaoBuildFieldName := 'Situacao';
  frmSituacaoBuild1.URLFieldName := 'URL';
end;

procedure TfrmBuildView.dtsDataSetDataChange(Sender: TObject; Field: TField);
begin
  if (not Assigned(FDadosClone)) or (not FDadosClone.Active) then
    Exit;
  SincronizarLink;
end;

procedure TfrmBuildView.lblTransformarEmCompilacaoLinkClick(Sender: TObject;
  const Link: string; LinkType: TSysLinkType);
begin
  FController.TransformarEmCompilacao(FDadosClone.ID);
end;

procedure TfrmBuildView.NovaAtualizacao(const ABuild: IBuildModel);
begin
  if not(ABuild.Situacao in SITUACOES_NOTIFICAVEIS) then
    Exit;
  if not FController.DataSet.Locate('ID', ABuild.ID.ToString, []) then
    Exit;
  if not FController.DataSet.Notificar then
    Exit;
  MostrarBuild(ABuild.ID);
end;

procedure TfrmBuildView.MostrarBuild(const AID: TGUID);
begin
  if FDadosClone.IsEmpty then
    Exit;
  FDadosClone.Locate('ID', AID.ToString, []);
end;

procedure TfrmBuildView.SincronizarLink;
const
  Link = '<a href="#">%d</a>';
  HINT = 'Envia informações para tela de compilação';
begin
  lblTransformarEmCompilacao.Caption := EmptyStr;
  if FDadosClone.UltimoBuild > 0 then
    lblTransformarEmCompilacao.Caption :=
      Format(Link, [FDadosClone.UltimoBuild]);
  lblTransformarEmCompilacao.HINT := HINT;
end;

end.
