unit Module.DataSet.VigilanteBase;

interface

uses
  System.Classes, System.Generics.Collections, Data.DB, FireDac.Comp.Client,
  Vigilante.Aplicacao.SituacaoBuild, Vigilante.Aplicacao.ModelBase;

type
  TVigilanteDataSetBase<T: IVigilanteModelBase> = class abstract(TFDMemTable)
  private
    FBuilding: TField;
    FNome: TField;
    FSituacao: TField;
    FURL: TField;
    FID: TField;
    FAtualizar: TField;
    FUltimaAtualizacao: TField;
    FNotificar: TField;
    function GetBuilding: boolean;
    function GetNome: string;
    function GetSituacao: TSituacaoBuild;
    function GetURL: string;
    procedure SetBuilding(const Value: boolean);
    procedure SetNome(const Value: string);
    procedure SetSituacao(const Value: TSituacaoBuild);
    procedure SetURL(const Value: string);
    function GetID: TGuid;
    procedure SetID(const Value: TGuid);
    function GetAtualizar: boolean;
    function GetUltimaAtualizacao: TDateTime;
    procedure SetAtualizar(const Value: boolean);
    function GetNotificar: boolean;
    procedure SetNotificar(const Value: boolean);
    function EditOuInsert(const AModel: T): TDataSetState;
  protected
    procedure SetUltimaAtualizacao(const Value: TDateTime);
    procedure ConfigurarCampos; virtual;
    procedure MapearCampos; virtual;
    procedure CriarCampos; virtual;
    procedure DoAfterOpen; override;
    procedure DoOnNewRecord; override;
    procedure ImportarDetalhes(const AModel: T); virtual; abstract;
    procedure CriarIndices; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ApenasAtualizaveis(const AFiltrar: boolean = true);
    procedure CreateDataSet; override;
    procedure Importar(const AModel: T);
    function ExportarRegistro: T; virtual; abstract;
    function LocalizarPorID(const AID: TGuid): boolean;
    procedure DesativarNotificacao;
    property ID: TGuid read GetID write SetID;
    property Nome: string read GetNome write SetNome;
    property URL: string read GetURL write SetURL;
    property Situacao: TSituacaoBuild read GetSituacao write SetSituacao;
    property Building: boolean read GetBuilding write SetBuilding;
    property UltimaAtualizacao: TDateTime read GetUltimaAtualizacao;
    property Atualizar: boolean read GetAtualizar write SetAtualizar;
    property Notificar: boolean read GetNotificar write SetNotificar;
  end;

implementation

uses
  System.SysUtils, Module.DataSet.ConfigMemento,
  Module.DataSet.ConfigMemento.ArmazenarConfiguracao;

constructor TVigilanteDataSetBase<T>.Create(AOwner: TComponent);
begin
  inherited;
  LogChanges := False;
  CriarCampos;
end;

procedure TVigilanteDataSetBase<T>.CriarCampos;
begin
  FieldDefs.Add('ID', ftGuid);
  FieldDefs.Add('Nome', ftString, 255);
  FieldDefs.Add('URL', ftString, 255);
  FieldDefs.Add('Situacao', ftInteger);
  FieldDefs.Add('Building', ftBoolean);
  FieldDefs.Add('UltimaAtualizacao', ftDateTime);
  FieldDefs.Add('Atualizar', ftBoolean);
  FieldDefs.Add('Notificar', ftBoolean);
  CriarIndices;
end;

procedure TVigilanteDataSetBase<T>.CriarIndices;
begin
  with Indexes.Add do
  begin
    Name := 'IDX_ID';
    Fields := 'ID';
    Active := true;
  end;
  with Indexes.Add do
  begin
    Name := 'IDX_ID_SITUACAO';
    Fields := 'ID;SITUACAO';
    Active := true;
  end;
end;

procedure TVigilanteDataSetBase<T>.CreateDataSet;
begin
  inherited;
  ConfigurarCampos;
  LogChanges := False;
end;

procedure TVigilanteDataSetBase<T>.DesativarNotificacao;
begin
  Edit;
  Notificar := False;
  Post;
end;

procedure TVigilanteDataSetBase<T>.DoAfterOpen;
begin
  ConfigurarCampos;
  inherited;
end;

procedure TVigilanteDataSetBase<T>.ConfigurarCampos;
begin
  MapearCampos;
  FID.Visible := False;
  FNome.DisplayWidth := 25;
  FURL.DisplayWidth := 50;

  FBuilding.Visible := False;
end;

procedure TVigilanteDataSetBase<T>.MapearCampos;
begin
  FID := FindField('ID');
  FBuilding := FindField('Building');
  FNome := FindField('Nome');
  FSituacao := FindField('Situacao');
  FURL := FindField('URL');
  FAtualizar := FindField('Atualizar');
  FUltimaAtualizacao := FindField('UltimaAtualizacao');
  FNotificar := FindField('Notificar');
end;

procedure TVigilanteDataSetBase<T>.ApenasAtualizaveis(const AFiltrar: boolean);
begin
  Filtered := AFiltrar;
  Filter := 'Atualizar = True or Atualizar is null';
  if not AFiltrar then
    Filter := EmptyStr;
end;

procedure TVigilanteDataSetBase<T>.DoOnNewRecord;
begin
  inherited;
  ID := TGuid.NewGuid;
  Nome := 'Informa��es indispon�veis';
  Atualizar := true;
  Building := False;
  Situacao := sbUnknow;
  Notificar := true;
end;

function TVigilanteDataSetBase<T>.GetAtualizar: boolean;
begin
  Result := FAtualizar.AsBoolean;
end;

function TVigilanteDataSetBase<T>.GetBuilding: boolean;
begin
  Result := FBuilding.AsBoolean;
end;

function TVigilanteDataSetBase<T>.GetID: TGuid;
begin
  Result := FID.AsGuid;
end;

function TVigilanteDataSetBase<T>.GetNome: string;
begin
  Result := FNome.AsString;
end;

function TVigilanteDataSetBase<T>.GetNotificar: boolean;
begin
  Result := FNotificar.AsBoolean;
end;

function TVigilanteDataSetBase<T>.GetSituacao: TSituacaoBuild;
begin
  Result := TSituacaoBuild.Parse(FSituacao.AsInteger);
end;

function TVigilanteDataSetBase<T>.GetUltimaAtualizacao: TDateTime;
begin
  Result := FUltimaAtualizacao.AsDateTime;
end;

function TVigilanteDataSetBase<T>.GetURL: string;
begin
  Result := FURL.AsString;
end;

procedure TVigilanteDataSetBase<T>.Importar(const AModel: T);
begin
  if EditOuInsert(AModel) = dsInsert then
    Insert
  else
    Edit;

  Nome := AModel.Nome;
  Building := AModel.Building;
  SetUltimaAtualizacao(Now);
  Situacao := AModel.Situacao;
  if Building then
    Situacao := sbProgresso;
  ImportarDetalhes(AModel);
  Post;
end;

function TVigilanteDataSetBase<T>.LocalizarPorID(const AID: TGuid): boolean;
var
  _configMemento: IConfigMemento;
  _state: TDataSetState;
begin
  Result := False;

  if IsEmpty then
    Exit;

  _configMemento := TConfigMemento.Create(Self, [acIndex]).GuardarConfig;

  IndexName := 'IDX_ID';
  IndexesActive := true;

  Result := FindKey([AID.ToString]);
end;

function TVigilanteDataSetBase<T>.EditOuInsert(const AModel: T): TDataSetState;
var
  _state: TDataSetState;
begin
  Result := dsInactive;
  if IsEmpty then
    Exit(dsInsert);

  _state := dsInsert;
  if ID.ToString.Equals(AModel.ID.ToString) or LocalizarPorID(AModel.ID) then
    _state := dsEdit;

  Result := _state;
end;

procedure TVigilanteDataSetBase<T>.SetAtualizar(const Value: boolean);
begin
  FAtualizar.AsBoolean := Value;
end;

procedure TVigilanteDataSetBase<T>.SetBuilding(const Value: boolean);
begin
  FBuilding.AsBoolean := Value;
end;

procedure TVigilanteDataSetBase<T>.SetID(const Value: TGuid);
begin
  FID.AsGuid := Value;
end;

procedure TVigilanteDataSetBase<T>.SetNome(const Value: string);
begin
  FNome.AsString := Value;
end;

procedure TVigilanteDataSetBase<T>.SetNotificar(const Value: boolean);
begin
  FNotificar.AsBoolean := Value;
end;

procedure TVigilanteDataSetBase<T>.SetSituacao(const Value: TSituacaoBuild);
begin
  if FSituacao.AsInteger <> Value.AsInteger then
    FNotificar.AsBoolean := true;
  FSituacao.AsInteger := Value.AsInteger;
end;

procedure TVigilanteDataSetBase<T>.SetUltimaAtualizacao(const Value: TDateTime);
begin
  FUltimaAtualizacao.AsDateTime := Value;
end;

procedure TVigilanteDataSetBase<T>.SetURL(const Value: string);
begin
  FURL.AsString := Value;
end;

end.
