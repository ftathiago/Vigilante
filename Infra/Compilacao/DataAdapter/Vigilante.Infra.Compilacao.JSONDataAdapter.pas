unit Vigilante.Infra.Compilacao.JSONDataAdapter;

interface

uses
  System.JSON, Vigilante.Infra.Compilacao.DataAdapter, Vigilante.Aplicacao.SituacaoBuild,
  Vigilante.ChangeSetItem.Model;

type
  TCompilacaoJSONDataAdapter = class(TInterfacedObject, ICompilacaoAdapter)
  private
    FJSON: TJSONObject;
    FChangesSet: TArray<TChangeSetItem>;
    procedure CarregarChangeSet;
    function PegarChangeSetItemsJSON(const AChangeSet: TJSONObject): TJSONArray;
    function PegarChangeSet: TJSONObject;
  protected
    function GetNome: string;
    function GetNumero: Integer;
    function GetSituacao: TSituacaoBuild;
    function GetURL: string;
    function GetBuilding: boolean;
    function GetChangesSet: TArray<TChangeSetItem>;
  public
    constructor Create(const AJson: TJSONObject);
  end;

implementation

uses
  System.SysUtils, Vigilante.Infra.ChangeSet.JSONDataAdapter,
  Vigilante.Infra.ChangeSet.DataAdapter;

constructor TCompilacaoJSONDataAdapter.Create(const AJson: TJSONObject);
begin
  FJSON := AJson;
  CarregarChangeSet;
end;

procedure TCompilacaoJSONDataAdapter.CarregarChangeSet;
var
  _changeSetAdapter: IChangeSetAdapter;
  _items: TJSONArray;
  _changeSet: TJSONObject;
begin
  FChangesSet := [];
  _changeSet := PegarChangeSet;
  if not Assigned(_changeSet) then
    Exit;

  _items := PegarChangeSetItemsJSON(_changeSet);

  if not Assigned(_items) then
    Exit;

  _changeSetAdapter := TChangeSetAdapterJSON.Create(_items);
  FChangesSet := _changeSetAdapter.PegarChangesSet;
end;

function TCompilacaoJSONDataAdapter.PegarChangeSet: TJSONObject;
var
  _changeSet: TJSONObject;
begin
  _changeSet := Nil;
  if not FJSON.TryGetValue<TJSONObject>('changeSet', _changeSet) then
    FJSON.TryGetValue<TJSONObject>('changeSets', _changeSet);

  if not Assigned(_changeSet) then
    Exit(Nil);

  if _changeSet.Null then
    Exit(Nil);

  Result := _changeSet;
end;

function TCompilacaoJSONDataAdapter.PegarChangeSetItemsJSON(const AChangeSet: TJSONObject): TJSONArray;
var
  _items: TJSONArray;
begin
  if not AChangeSet.TryGetValue('items', _items) then
    Exit(Nil);

  if _items.Null then
    Exit(Nil);

  Result := _items;
end;

function TCompilacaoJSONDataAdapter.GetBuilding: boolean;
begin
  Result := False;
  if FJSON.GetValue('building').Null then
    Exit;
  Result := (FJSON.GetValue('building') as TJSONBool).AsBoolean;
end;

function TCompilacaoJSONDataAdapter.GetChangesSet: TArray<TChangeSetItem>;
begin
  Result := FChangesSet;
end;

function TCompilacaoJSONDataAdapter.GetNome: string;
begin
  Result := FJSON.GetValue('fullDisplayName').Value;
end;

function TCompilacaoJSONDataAdapter.GetNumero: Integer;
begin
  Result := FJSON.GetValue('number').Value.ToInteger;
end;

function TCompilacaoJSONDataAdapter.GetSituacao: TSituacaoBuild;
var
  _situacao: string;
begin
  _situacao := FJSON.GetValue('result').Value;
  Result := TSituacaoBuild.Parse(_situacao);
end;

function TCompilacaoJSONDataAdapter.GetURL: string;
begin
  Result := FJSON.GetValue('url').Value;
end;

end.
