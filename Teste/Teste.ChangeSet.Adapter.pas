unit Teste.ChangeSet.Adapter;

interface

uses
  DUnitX.TestFramework, System.JSON, System.JSON.Readers,
  Vigilante.Infra.ChangeSet.DataAdapter;

type

  [TestFixture]
  TChangeSetAdapterJSONTest = class
  private
    FChangeSetItens: TJSONArray;
    FAdapter: IChangeSetAdapter;
    procedure CarregarChangeSetItens;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CarregouApenasUmChangeSet;
  end;

implementation

uses
  System.IOUtils, System.SysUtils, System.Classes,
  System.Generics.Collections, Vigilante.Infra.ChangeSet.JSONDataAdapter,
  Vigilante.Aplicacao.SituacaoBuild, Vigilante.ChangeSetItem.Model, Teste.ChangeSet.JSONData;

procedure TChangeSetAdapterJSONTest.Setup;
begin
  CarregarChangeSetItens;
end;

procedure TChangeSetAdapterJSONTest.TearDown;
begin
  FreeAndNil(FChangeSetItens)
end;

procedure TChangeSetAdapterJSONTest.CarregarChangeSetItens;
begin
  if Assigned(FChangeSetItens) then
    FreeAndNil(FChangeSetItens);

  FChangeSetItens := TChangeSetJSONData.Pegar;
  FAdapter := TChangeSetAdapterJSON.Create(FChangeSetItens);
end;

procedure TChangeSetAdapterJSONTest.CarregouApenasUmChangeSet;
const
  NOME = 'Jose da Silva Sauro';
  DESCRICAO: array of string = [
    'Descri��o do commit',
    'Descri��o do commit'];
  NOME_ARQUIVO = '/src/Classes/nomeDoArquivo.pas';
var
  _changeSet: TArray<TChangeSetItem>;
  _changeSetItem: TChangeSetItem;
  _passagem: integer;
begin
  _changeSet := FAdapter.PegarChangesSet;
  Assert.AreEqual(2, Length(_changeSet));
  _passagem := 0;
  for _changeSetItem in _changeSet do
  begin
    Assert.AreEqual(NOME, _changeSetItem.Autor);
    Assert.AreEqual(DESCRICAO[_passagem], _changeSetItem.Descricao);
    Assert.AreEqual(NOME_ARQUIVO, _changeSetItem.ArquivosAlterados.Text.Trim);
    inc(_passagem);
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TChangeSetAdapterJSONTest);

end.
