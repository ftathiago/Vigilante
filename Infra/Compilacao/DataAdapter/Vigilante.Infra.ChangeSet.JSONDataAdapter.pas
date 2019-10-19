unit Vigilante.Infra.ChangeSet.JSONDataAdapter;

interface

uses
  System.Generics.Collections, System.JSON, Vigilante.Infra.ChangeSet.DataAdapter,
  Vigilante.ChangeSetItem.Model, Vigilante.Infra.ChangeSetItem.DataAdapter;

type
  TChangeSetAdapterJSON = class(TInterfacedObject, IChangeSetAdapter)
  private
    FChangeSet: TJSONArray;
    FListaChangeSet: TObjectList<TChangeSetItem>;
    procedure CarregarDados;
  public
    constructor Create(const AChangeSet: TJSONArray);
    destructor Destroy; override;
    function PegarChangesSet: System.TArray<TChangeSetItem>;
  end;

implementation

uses Vigilante.Infra.ChangeSetItem.JSONDataAdapter;

constructor TChangeSetAdapterJSON.Create(const AChangeSet: TJSONArray);
begin
  FListaChangeSet := TObjectList<TChangeSetItem>.Create(false);
  FChangeSet := AChangeSet;
  CarregarDados;
end;

destructor TChangeSetAdapterJSON.Destroy;
begin
  FListaChangeSet.Clear;
  FListaChangeSet.Free;
  inherited;
end;

procedure TChangeSetAdapterJSON.CarregarDados;
var
  _adapter: IChangeSetItemAdapter;
begin
  for var item in FChangeSet do
  begin
    _adapter := TChangeSetItemAdapterJSON.Create(item as TJSONObject);
    var
    ChangeSetItem := TChangeSetItem.Create(_adapter.Autor, _adapter.Descricao,
      _adapter.Arquivos);
    FListaChangeSet.Add(ChangeSetItem);
  end;
end;

function TChangeSetAdapterJSON.PegarChangesSet: System.TArray<TChangeSetItem>;
begin
  Result := FListaChangeSet.ToArray;
end;

end.
