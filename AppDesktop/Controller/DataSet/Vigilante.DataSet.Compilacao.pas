unit Vigilante.DataSet.Compilacao;

interface

uses
  System.Classes, System.Generics.Collections, Data.DB, FireDac.Comp.Client,
  Vigilante.Compilacao.Model, Vigilante.ChangeSetItem.Model,
  Vigilante.Aplicacao.SituacaoBuild,
  Module.DataSet.VigilanteBase;

type
  TCompilacaoDataSet = class(TVigilanteDataSetBase<ICompilacaoModel>)
  private
    FChangeSet: TStringList;
    FoNumero: TField;
    FoSituacaoBuild: TField;
    FoChangeSet: TMemoField;
    function GetChangeSet: string;
    function GetNumero: integer;
    procedure SetNumero(const Value: integer);
    procedure CarregarChangeSet(const AChangeSet: TObjectList<TChangeSetItem>);
  protected
    procedure ConfigurarCampos; override;
    procedure MapearCampos; override;
    procedure ImportarDetalhes(const AModel: ICompilacaoModel); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExportarRegistro: ICompilacaoModel; override;
    procedure CreateDataSet; override;
    property Numero: integer read GetNumero write SetNumero;
    property ChangeSet: string read GetChangeSet;
  end;

implementation

uses
  System.SysUtils, Vigilante.Compilacao.Model.Impl, Module.ValueObject.URL.Impl;

constructor TCompilacaoDataSet.Create(AOwner: TComponent);
begin
  inherited;
  FChangeSet := TStringList.Create;
end;

destructor TCompilacaoDataSet.Destroy;
begin
  FreeAndNil(FChangeSet);
  inherited;
end;

function TCompilacaoDataSet.ExportarRegistro: ICompilacaoModel;
begin
  Result := TCompilacaoModel.Create(Numero, Nome, TURL.Create(Self.URL),
    Situacao, Building, nil);
  Result.DefinirID(ID);
end;

procedure TCompilacaoDataSet.CreateDataSet;
begin
  FieldDefs.Add('Numero', ftInteger);
  FieldDefs.Add('ChangeSet', ftMemo);
  inherited;
  ConfigurarCampos;
  LogChanges := False;
end;

procedure TCompilacaoDataSet.ConfigurarCampos;
begin
  inherited;
  FoChangeSet.Visible := False;
end;

procedure TCompilacaoDataSet.ImportarDetalhes(const AModel: ICompilacaoModel);
begin
  inherited;
  Atualizar := not(AModel.Situacao in [sbSucesso, sbFalhou, sbAbortado,
    sbFalhouInfra]);
  CarregarChangeSet(AModel.ChangeSet);
end;

procedure TCompilacaoDataSet.MapearCampos;
begin
  inherited;
  FoNumero := FindField('Numero');
  FoSituacaoBuild := FindField('SituacaoBuild');
  FoChangeSet := FindField('ChangeSet') as TMemoField;
end;

procedure TCompilacaoDataSet.CarregarChangeSet(const AChangeSet
  : TObjectList<TChangeSetItem>);
const
  AUTOR = 'Autor: %s - %s';
  ARQUIVO = '  - %s';
var
  _changeSetItem: TChangeSetItem;
  _arquivo: string;
  _str: TStringList;
begin
  if AChangeSet.Count = 0 then
    Exit;

  _str := TStringList.Create;
  try
    FChangeSet.Clear;
    for _changeSetItem in AChangeSet do
    begin
      _str.Add(Format(AUTOR, [_changeSetItem.AUTOR, _changeSetItem.Descricao]));
      for _arquivo in _changeSetItem.ArquivosAlterados do
        _str.Add(Format(ARQUIVO, [_arquivo]));
      _str.Add('');
    end;
    FoChangeSet.AsString := _str.Text;
  finally
    FreeAndNil(_str);
  end;
end;

function TCompilacaoDataSet.GetNumero: integer;
begin
  Result := FoNumero.AsInteger;
end;

procedure TCompilacaoDataSet.SetNumero(const Value: integer);
begin
  FoNumero.AsInteger := Value;
end;

function TCompilacaoDataSet.GetChangeSet: string;
begin
  Result := FoChangeSet.AsString;
end;

end.
