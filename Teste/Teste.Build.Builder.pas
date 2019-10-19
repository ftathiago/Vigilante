unit Teste.Build.Builder;

interface

uses
  DUnitX.TestFramework, System.JSON, Vigilante.Compilacao.Model;

type

  [TestFixture]
  TBuildBuilderTest = class
  private
    FJson: TJsonObject;
    FBuild: ICompilacaoModel;
    procedure CarregarJSONDoArquivo;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure ImportaComSucesso;
  end;

implementation

uses
  System.Classes, System.IOUtils, System.SysUtils,
  Vigilante.Infra.Compilacao.Builder, Vigilante.Infra.Compilacao.Builder.Impl;

procedure TBuildBuilderTest.Setup;
var
  _compilacaoBuilder: ICompilacaoBuilder;
begin
  CarregarJSONDoArquivo;
  _compilacaoBuilder := TCompilacaoBuilder.Create(FJson);
  FBuild := _compilacaoBuilder.PegarCompilacao;
end;

procedure TBuildBuilderTest.TearDown;
begin
  FJson.Free;
end;

procedure TBuildBuilderTest.CarregarJSONDoArquivo;
var
  _arquivoJson: TStringList;
begin
  if not TFile.Exists('build.json') then
    raise Exception.Create('O arquivo build.json não foi encontrado!');
  _arquivoJson := TStringList.Create;
  try
    _arquivoJson.LoadFromFile('build.json');
    FJson := TJsonObject.ParseJSONValue(_arquivoJson.Text) as TJsonObject;
  finally
    _arquivoJson.Free;
  end;
end;

procedure TBuildBuilderTest.ImportaComSucesso;
begin
  Assert.AreEqual('build-simulado #725', FBuild.Nome);
end;

initialization

TDUnitX.RegisterTestFixture(TBuildBuilderTest);

end.
