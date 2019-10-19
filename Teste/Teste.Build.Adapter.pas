unit Teste.Build.Adapter;

interface

uses
  DUnitX.TestFramework, System.JSON, Vigilante.Infra.Build.JSONDataAdapter;

type

  [TestFixture]
  TBuildJSONDataAdapterTest = class
  private
    FJson: TJsonObject;
    FBuildAdapter: IBuildJSONDataAdapter;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure CarregouNome;
    [Test]
    procedure CarregouBuilding;
  end;

implementation

uses
  System.Classes, System.IOUtils, System.SysUtils,
  Vigilante.Infra.Build.JSONDataAdapter.Impl, Teste.Build.JSONData;

procedure TBuildJSONDataAdapterTest.CarregouBuilding;
begin
  Assert.IsFalse(FBuildAdapter.Building);
end;

procedure TBuildJSONDataAdapterTest.CarregouNome;
 begin
  Assert.AreEqual('NOME-DA-VERSAO-COMPILACAO', FBuildAdapter.Nome);
end;

procedure TBuildJSONDataAdapterTest.Setup;
begin
  FJson := TJSONBuildMock.CarregarJSONDoArquivo<TJsonObject>(ARQUIVO_BUILDPARADO_ULTIMOOK);
  FBuildAdapter := TBuildJSONDataAdapter.Create(FJson);
end;

procedure TBuildJSONDataAdapterTest.TearDown;
begin
  FJson.Free;
end;

initialization

TDUnitX.RegisterTestFixture(TBuildJSONDataAdapterTest);

end.
