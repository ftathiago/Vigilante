unit Teste.Build.JSONData;

interface

uses
  System.SysUtils, System.JSON;

type
  TJSONBuildMock = class
    class function CarregarArquivo(const FileName: TFileName): string;
    class function CarregarJSONDoArquivo<T: TJSONValue>(const FileName: TFileName): T;
  end;

const
  ARQUIVO_JSON_SUCESSO = 'build.json';
  ARQUIVO_JSON_FALHA = 'build-failure.json';
  ARQUIVO_JSON_BUILDING = 'build-building.json';
  ARQUIVO_JSON_BUILDING_NULL = 'build_buildingNull.json';
  ARQUIVO_JSON_CHANGESET_VAZIO = 'build-sem-changeset-vazio.json';
  ARQUIVO_JSON_CHANGESET_NULL = 'build-sem-changeset-null.json';
  ARQUIVO_JSON_CHANGESET_NAOEXISTE = 'build-sem-changeset.json';
  ARQUIVO_JSON_CHANGESETITEM_NULL = 'build-changeSetItemNull.json';
  ARQUIVO_JSON_CHANGESETITEM_VAZIO = 'build-changeSetItem-vazio.json';
  ARQUIVO_JSON_CHANGESETITEM_NAOEXISTE = 'build-changeSetItem-naoexiste.json';
  ARQUIVO_BUILD = 'maquina.json';
  ARQUIVO_BUILD_COMPILANDO = 'simulado\build-compilando.json';
  ARQUIVO_BUILDPARADO_ULTIMOOK = 'simulado\build-parado-ultimoOK.json';
implementation

uses
  System.Classes, System.IOUtils;

class function TJSONBuildMock.CarregarArquivo(
  const FileName: TFileName): string;
var
  _arquivoJson: TStringList;
begin
  if not TFile.Exists(FileName) then
    raise EFileNotFoundException.CreateFmt('O arquivo %s não foi encontrado!', [FileName]);
  _arquivoJson := TStringList.Create;
  try
    _arquivoJson.LoadFromFile(FileName);
    Result := _arquivoJson.Text;
  finally
    _arquivoJson.Free;
  end;
end;

class function TJSONBuildMock.CarregarJSONDoArquivo<T>(
  const FileName: TFileName): T;
begin
  Result := TJSONObject.ParseJSONValue(CarregarArquivo(FileName)) as T;
end;


end.
