unit Vigilante.Conexao.JSON.Impl;

interface

uses
  System.JSON, Vigilante.Conexao.JSON, System.Net.HTTPClientComponent;

type
  TConexaoJSON = class(TInterfacedObject, IConexaoJSON)
  private
    FURL: string;
    FHttpClient: TNetHttpClient;
    function ConsultarAPI: TJSONObject;
  public
    constructor Create(const AURL: string);
    destructor Destroy; override;
    function PegarBuild: TJSONObject;
    function PegarCompilacao: TJSONObject;
    function PegarPipeline: TJSONObject;
  end;

implementation

uses
  System.Net.HttpClient, System.Classes, System.SysUtils, System.Threading;

const
  CONEXAO_OK = 200;
  NAO_IMPLEMENTADO = 'Método %s.%s não implementado';

constructor TConexaoJSON.Create(const AURL: string);
begin
  FURL := AURL;
  FHttpClient := TNetHttpClient.Create(nil);
end;

destructor TConexaoJSON.Destroy;
begin
  FreeAndNil(FHttpClient);
  inherited;
end;

function TConexaoJSON.PegarBuild: TJSONObject;
begin
  Result := ConsultarAPI;
end;

function TConexaoJSON.PegarCompilacao: TJSONObject;
begin
  Result := ConsultarAPI
end;

function TConexaoJSON.ConsultarAPI: TJSONObject;
var
  _response: IHTTPResponse;
  _content: string;
begin
  Result := nil;
  try
    _response := FHttpClient.Get(FURL);

    if _response.StatusCode <> CONEXAO_OK then
      Exit;

    _content := _response.ContentAsString();

    if _content.Trim.IsEmpty then
      Exit;
    Result := TJSONObject.ParseJSONValue(_content) as TJSONObject;
  except
    { TODO : Adicionar geração de Logs }
  end;
end;

function TConexaoJSON.PegarPipeline: TJSONObject;
begin
  raise ENotImplemented.CreateFmt(NAO_IMPLEMENTADO,
    [Self.QualifiedClassName, 'PegarPipeline']);
end;

end.
