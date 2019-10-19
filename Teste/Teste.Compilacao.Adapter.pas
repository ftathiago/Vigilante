unit Teste.Compilacao.Adapter;

interface

uses
  DUnitX.TestFramework, System.SysUtils, System.JSON, System.JSON.Readers,
  Vigilante.Infra.Compilacao.DataAdapter;

type

  [TestFixture]
  TCompilacaoJSONDataAdapterTest = class
  private
    FJson: TJSONObject;
    FAdapter: ICompilacaoAdapter;
    procedure CarregarAdapterBuild(const Arquivo: TFileName);
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure MapeouNumero;
    [Test]
    procedure MapeouNome;
    [Test]
    procedure MapeouSituacaoSucesso;
    [Test]
    procedure MapeouSituacaoFalha;
    [Test]
    procedure MapeouURL;
    [Test]
    procedure MapeouChangeSet;
    [Test]
    procedure JSONSemChangeSet;
    [Test]
    procedure JSONChangeSetNull;
    [Test]
    procedure JSONChangeSetVazio;
    [Test]
    procedure JSONChangeSetItemNull;
    [Test]
    procedure JSONChangeSetItemVazio;
    [Test]
    procedure JSONChangeSetItemNaoExiste;
    [Test]
    procedure MapeouBuildingTrue;
    [Test]
    procedure MapeouBuildingFalse;
    [Test]
    procedure MapeouBuidingNull;
  end;

implementation

uses
  System.IOUtils, System.Classes, Vigilante.Infra.Compilacao.JSONDataAdapter,
  Vigilante.Aplicacao.SituacaoBuild, Teste.Build.JSONData;

procedure TCompilacaoJSONDataAdapterTest.Setup;
begin

end;

procedure TCompilacaoJSONDataAdapterTest.TearDown;
begin
  if Assigned(FJson) then
    FreeAndNil(FJson);
end;


procedure TCompilacaoJSONDataAdapterTest.CarregarAdapterBuild(const Arquivo: TFileName);
begin
  if Assigned(FJson) then
    FreeAndNil(FJson);
  FJson := TJSONBuildMock.CarregarJSONDoArquivo<TJSONObject>(Arquivo);
  FAdapter := TCompilacaoJSONDataAdapter.Create(FJson);
end;

procedure TCompilacaoJSONDataAdapterTest.JSONChangeSetItemNaoExiste;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_CHANGESETITEM_NAOEXISTE);
  Assert.IsTrue(Length(FAdapter.ChangesSet)= 0);
end;

procedure TCompilacaoJSONDataAdapterTest.JSONChangeSetItemNull;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_CHANGESETITEM_NULL);
  Assert.IsTrue(Length(FAdapter.ChangesSet)= 0);
end;

procedure TCompilacaoJSONDataAdapterTest.JSONChangeSetItemVazio;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_CHANGESETITEM_VAZIO);
  Assert.IsTrue(Length(FAdapter.ChangesSet)= 0);
end;

procedure TCompilacaoJSONDataAdapterTest.JSONChangeSetNull;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_CHANGESET_NULL);
  Assert.IsTrue(Length(FAdapter.ChangesSet) = 0);
end;

procedure TCompilacaoJSONDataAdapterTest.JSONChangeSetVazio;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_CHANGESET_VAZIO);
  Assert.IsTrue(Length(FAdapter.ChangesSet) = 0);
end;

procedure TCompilacaoJSONDataAdapterTest.JSONSemChangeSet;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_CHANGESET_NAOEXISTE);
  Assert.IsTrue(Length(FAdapter.ChangesSet) = 0);
end;

procedure TCompilacaoJSONDataAdapterTest.MapeouBuidingNull;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_BUILDING_NULL);
  Assert.IsFalse(FAdapter.Building);
end;

procedure TCompilacaoJSONDataAdapterTest.MapeouBuildingFalse;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_SUCESSO);
  Assert.IsFalse(FAdapter.Building);
end;

procedure TCompilacaoJSONDataAdapterTest.MapeouBuildingTrue;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_BUILDING);
  Assert.IsTrue(FAdapter.Building);
end;

procedure TCompilacaoJSONDataAdapterTest.MapeouChangeSet;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_SUCESSO);
  Assert.IsNotNull(FAdapter.ChangesSet, 'N�o foi criado ChangeSet');
  Assert.IsTrue(Length(FAdapter.ChangesSet) > 0);
end;

procedure TCompilacaoJSONDataAdapterTest.MapeouNome;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_SUCESSO);
  Assert.AreEqual('build-simulado #725', FAdapter.Nome);
end;

procedure TCompilacaoJSONDataAdapterTest.MapeouNumero;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_SUCESSO);
  Assert.AreEqual(725, FAdapter.Numero);
end;

procedure TCompilacaoJSONDataAdapterTest.MapeouSituacaoFalha;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_FALHA);
  Assert.AreEqual(sbFalhou, FAdapter.Situacao);
end;

procedure TCompilacaoJSONDataAdapterTest.MapeouSituacaoSucesso;
begin
  CarregarAdapterBuild(ARQUIVO_JSON_SUCESSO);
  Assert.AreEqual(sbSucesso, FAdapter.Situacao);
end;

procedure TCompilacaoJSONDataAdapterTest.MapeouURL;
const
  sURL_BUILD =
    'http://jenkins/view/equipe/versao/job/build-simulado/725/';
begin
  CarregarAdapterBuild(ARQUIVO_JSON_SUCESSO);
  Assert.AreEqual(sURL_BUILD, FAdapter.URL);
end;

initialization

TDUnitX.RegisterTestFixture(TCompilacaoJSONDataAdapterTest);

end.
