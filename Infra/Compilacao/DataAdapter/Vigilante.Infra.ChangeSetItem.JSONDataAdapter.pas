unit Vigilante.Infra.ChangeSetItem.JSONDataAdapter;

interface

uses
  System.SysUtils, System.JSON, System.Generics.Collections,
  Vigilante.Infra.ChangeSetItem.DataAdapter;

type
  TChangeSetItemAdapterJSON = class(TInterfacedObject, IChangeSetItemAdapter)
  private
    FChangeSet: TJSONObject;
    FAutor: string;
    FArquivos: TList<TFileName>;
    FDescricao: string;
    procedure CarregarInformacoes;
    procedure CarregarListaArquivos;
    procedure CarregarAutor;
  public
    constructor Create(const AChangeSetItem: TJSONObject);
    destructor Destroy; override;
    function GetAutor: string;
    function GetDescricao: string;
    function GetArquivos: TArray<TFileName>;
  end;

implementation

constructor TChangeSetItemAdapterJSON.Create(const AChangeSetItem: TJSONObject);
begin
  FArquivos := TList<TFileName>.Create;
  FChangeSet := AChangeSetItem;
  CarregarInformacoes;
end;

destructor TChangeSetItemAdapterJSON.Destroy;
begin
  FArquivos.Clear;
  FreeAndNil(FArquivos);
  inherited;
end;

procedure TChangeSetItemAdapterJSON.CarregarInformacoes;
begin
  FDescricao := FChangeSet.GetValue('msg').Value;
  CarregarAutor;
  CarregarListaArquivos;
end;

procedure TChangeSetItemAdapterJSON.CarregarAutor;
var
  _author: TJSONObject;
begin
  _author := FChangeSet.GetValue('author') as TJSONObject;
  FAutor := _author.GetValue('fullName').Value;
end;

procedure TChangeSetItemAdapterJSON.CarregarListaArquivos;
var
  _arquivosAlterados: TJSONArray;
  _item: TJSONValue;
begin
  _arquivosAlterados := FChangeSet.GetValue('affectedPaths') as TJSONArray;
  for _item in _arquivosAlterados do
    FArquivos.Add(_item.Value);
end;

function TChangeSetItemAdapterJSON.GetAutor: string;
begin
  Result := FAutor;
end;

function TChangeSetItemAdapterJSON.GetDescricao: string;
begin
  Result := FDescricao;
end;

function TChangeSetItemAdapterJSON.GetArquivos: TArray<TFileName>;
begin
  Result := FArquivos.ToArray;
end;

end.
