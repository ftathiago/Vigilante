unit Vigilante.Conexao.JSON.Arquivo.Impl;

interface

uses
  System.Classes, System.JSON, Vigilante.Conexao.JSON;

type
  TConexaoArquivoJSON = class(TInterfacedObject, IConexaoJSON)
  public
    FArquivo: TStringList;
    FNomeArquivo: string;
  public
    constructor Create(const AURL: string);
    destructor Destroy; override;
    function PegarBuild: TJSONObject;
    function PegarCompilacao: TJSONObject;
    function PegarPipeline: TJSONObject;
  end;

implementation

{ TConexaoArquivoJSON }

uses
  System.IOUtils, System.SysUtils;

const
  COMPILACAO_SIMULADO = 'simulado\compilacao.json';
  BUILD_SIMULADO = 'simulado\%s';

constructor TConexaoArquivoJSON.Create(const AURL: string);
begin
  FArquivo := TStringList.Create;
  FNomeArquivo := AURL.Replace('/api/json','');
end;

destructor TConexaoArquivoJSON.Destroy;
begin
  FArquivo.Free;
end;

function TConexaoArquivoJSON.PegarBuild: TJSONObject;
var
  _arquivo:string;
begin
  Result := nil;
  _arquivo := Format(BUILD_SIMULADO,[FNomeArquivo]);
  if not TFile.Exists(_arquivo) then
    Exit;
  FArquivo.LoadFromFile(_arquivo);
  Result := TJSONObject.ParseJSONValue(FArquivo.Text) as TJSONObject;
end;

function TConexaoArquivoJSON.PegarCompilacao: TJSONObject;
begin
  Result := nil;
  if not TFile.Exists(COMPILACAO_SIMULADO) then
    Exit;
  FArquivo.LoadFromFile(COMPILACAO_SIMULADO);
  Result := TJSONObject.ParseJSONValue(FArquivo.Text) as TJSONObject;
end;

function TConexaoArquivoJSON.PegarPipeline: TJSONObject;
begin
  Result := nil;
end;

end.
