unit Teste.ChangeSetItem.Adapter;

interface

uses
  DUnitX.TestFramework, System.JSON, System.JSON.Readers,
  Vigilante.Infra.ChangeSetItem.DataAdapter;

type

  [TestFixture]
  TChangeSetItemAdapterJSONTest = class
  private
    FChangeSetItem: TJSONObject;
    FAdapter: IChangeSetItemAdapter;
    procedure CarregarChange;
    procedure CarregarChangeSetDoisArquivos;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CarregouAutor;
    [Test]
    procedure CarregouDescricao;
    [Test]
    procedure CarregouUmArquivo;
    [Test]
    procedure CarregouDoisArquivos;
  end;

implementation

uses
  System.IOUtils, System.SysUtils, System.Classes,
  Vigilante.Infra.ChangeSetItem.JSONDataAdapter, Teste.ChangeSet.JSONData;

procedure TChangeSetItemAdapterJSONTest.Setup;
begin
  CarregarChange;
end;

procedure TChangeSetItemAdapterJSONTest.TearDown;
begin
  FreeAndNil(FChangeSetItem)
end;

procedure TChangeSetItemAdapterJSONTest.CarregouDescricao;
const
  DESCRICAO =
    'Descrição do commit';
begin
  Assert.AreEqual(DESCRICAO, FAdapter.DESCRICAO);
end;

procedure TChangeSetItemAdapterJSONTest.CarregouDoisArquivos;
const
  ARQUIVO_CHANGESET1 = '/src/Classes/nomeDoArquivo.pas';
  ARQUIVO_CHANGESET2 = '/src/Classes/nomeDoArquivo2.pas';
begin
  CarregarChangeSetDoisArquivos;
  Assert.AreEqual(2, Length(FAdapter.Arquivos));
  Assert.AreEqual(ARQUIVO_CHANGESET1, FAdapter.Arquivos[0]);
  Assert.AreEqual(ARQUIVO_CHANGESET2, FAdapter.Arquivos[1]);
end;

procedure TChangeSetItemAdapterJSONTest.CarregouUmArquivo;
const
  ARQUIVO_CHANGESET = '/src/Classes/nomeDoArquivo.pas';
begin
  Assert.AreEqual(1, Length(FAdapter.Arquivos));
  Assert.AreEqual(ARQUIVO_CHANGESET, FAdapter.Arquivos[0]);
end;

procedure TChangeSetItemAdapterJSONTest.CarregarChange;
begin
  if Assigned(FChangeSetItem) then
    FreeAndNil(FChangeSetItem);

  FChangeSetItem := TChangeSetJSONData.PegarChangeSetItem;
  FAdapter := TChangeSetItemAdapterJSON.Create(FChangeSetItem);
end;

procedure TChangeSetItemAdapterJSONTest.CarregarChangeSetDoisArquivos;
begin
  if Assigned(FChangeSetItem) then
    FreeAndNil(FChangeSetItem);

  FChangeSetItem := TChangeSetJSONData.PegarChangeSetItemDoisArquivos;
  FAdapter := TChangeSetItemAdapterJSON.Create(FChangeSetItem);
end;

procedure TChangeSetItemAdapterJSONTest.CarregouAutor;
begin
  Assert.AreEqual('Jose da Silva Sauro', FAdapter.Autor);
end;

initialization

TDUnitX.RegisterTestFixture(TChangeSetItemAdapterJSONTest);

end.
