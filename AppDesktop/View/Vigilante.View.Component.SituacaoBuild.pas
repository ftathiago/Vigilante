unit Vigilante.View.Component.SituacaoBuild;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.WinXCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vigilante.Aplicacao.SituacaoBuild;

type
  TfrmSituacaoBuild = class(TFrame)
    imgAborted: TImage;
    imgBuildIndefinido: TImage;
    imgBuildOK: TImage;
    imgBuildFailed: TImage;
    imgProgresso: TActivityIndicator;
    lblDescricao: TDBText;
    dtsSituacaoBuild: TDataSource;
    lblLink: TLinkLabel;
    pnlImagem: TPanel;
    Bevel1: TBevel;
    procedure dtsSituacaoBuildDataChange(Sender: TObject; Field: TField);
    procedure dtsSituacaoBuildStateChange(Sender: TObject);
    procedure lblLinkLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure dtsSituacaoBuildUpdateData(Sender: TObject);
  private
    FSituacaoBuildFieldName: string;
    FSituacaoBuildField: TField;
    FDescricaoField: TField;
    FURL: string;
    FURLField: TField;
    procedure CarregarCampos;
    procedure SetDataSet(const Value: TDataSet);
    procedure SetNomeFieldName(const Value: string);
    procedure SetSituacaoBuild(const Value: string);
    function GetDataSet: TDataSet;
    function GetNomeFieldName: string;
    procedure SelecionarImagemBuild;
    procedure SetURL(const Value: string);
    procedure AtualizarLink;
    procedure SincronizarTela;
  public
  published
    property NomeFieldName: string read GetNomeFieldName write SetNomeFieldName;
    property SituacaoBuildFieldName: string read FSituacaoBuildFieldName write SetSituacaoBuild;
    property URLFieldName: string read FURL write SetURL;
    property DataSet: TDataSet read GetDataSet write SetDataSet;
  end;

implementation

{$R *.dfm}


uses
  Winapi.ShellAPI;

procedure TfrmSituacaoBuild.CarregarCampos;
begin
  if not Assigned(dtsSituacaoBuild.DataSet) then
    Exit;
  if lblDescricao.DataField.Trim.IsEmpty then
    Exit;
  if FSituacaoBuildFieldName.Trim.IsEmpty then
    Exit;
  if FURL.Trim.IsEmpty then
    Exit;
  FDescricaoField := DataSet.FindField(lblDescricao.DataField);
  FSituacaoBuildField := DataSet.FindField(FSituacaoBuildFieldName);
  FURLField := DataSet.FindField(FURL);
  SincronizarTela;
end;

procedure TfrmSituacaoBuild.dtsSituacaoBuildDataChange(Sender: TObject;
  Field: TField);
begin
  SincronizarTela;
end;

procedure TfrmSituacaoBuild.dtsSituacaoBuildStateChange(Sender: TObject);
begin
  SincronizarTela;
end;

procedure TfrmSituacaoBuild.dtsSituacaoBuildUpdateData(Sender: TObject);
begin
  SincronizarTela;
end;

procedure TfrmSituacaoBuild.SincronizarTela;
begin
  AtualizarLink;
  SelecionarImagemBuild;
end;

procedure TfrmSituacaoBuild.AtualizarLink;
const
  CONTEUDO_LINK = '<a href="%s">Abrir link da compila��o</a>';
  HINT_LINK = 'Abrir a p�gina: %s';
begin
  if not Assigned(FURLField) then
    Exit;
  lblLink.Visible := not FURLField.AsString.Trim.IsEmpty;
  lblLink.Caption := Format(CONTEUDO_LINK, [FURLField.AsString]);
  lblLink.Hint := Format(HINT_LINK, [FURLField.AsString]);
end;

procedure TfrmSituacaoBuild.SelecionarImagemBuild;
var
  _situacaoBuild: TSituacaoBuild;
begin
  if not Assigned(FSituacaoBuildField) then
    Exit;

  _situacaoBuild := TSituacaoBuild.Parse(FSituacaoBuildField.AsInteger);

  imgBuildOK.Visible := _situacaoBuild = sbSucesso;
  imgBuildFailed.Visible := _situacaoBuild in [sbFalhou, sbFalhouInfra];
  imgBuildIndefinido.Visible := _situacaoBuild = sbUnknow;
  imgAborted.Visible := _situacaoBuild = sbAbortado;
  imgProgresso.Visible := _situacaoBuild = sbProgresso;
  if imgProgresso.Animate and (_situacaoBuild = sbProgresso) then
    Exit;
  imgProgresso.Animate := _situacaoBuild = sbProgresso;
end;

function TfrmSituacaoBuild.GetDataSet: TDataSet;
begin
  Result := dtsSituacaoBuild.DataSet;
end;

function TfrmSituacaoBuild.GetNomeFieldName: string;
begin
  Result := lblDescricao.DataField;
end;

procedure TfrmSituacaoBuild.lblLinkLinkClick(Sender: TObject;
  const Link: string; LinkType: TSysLinkType);
var
  _url: PWideChar;
begin
  _url := PWideChar(Link);
  ShellExecute(Handle, 'open', _url, nil, nil, SW_SHOW);
end;

procedure TfrmSituacaoBuild.SetDataSet(const Value: TDataSet);
begin
  dtsSituacaoBuild.DataSet := Value;
  CarregarCampos;
end;

procedure TfrmSituacaoBuild.SetNomeFieldName(const Value: string);
begin
  lblDescricao.DataField := Value;
  CarregarCampos;
end;

procedure TfrmSituacaoBuild.SetSituacaoBuild(const Value: string);
begin
  FSituacaoBuildFieldName := Value;
  CarregarCampos;
end;

procedure TfrmSituacaoBuild.SetURL(const Value: string);
begin
  FURL := Value;
  CarregarCampos;
end;

end.
