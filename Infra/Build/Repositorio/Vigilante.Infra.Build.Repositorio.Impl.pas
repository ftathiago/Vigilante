unit Vigilante.Infra.Build.Repositorio.Impl;

interface

uses
  System.JSON, Vigilante.Build.Repositorio, Vigilante.Build.Model;

type
  TBuildRepositorio = class(TInterfacedObject, IBuildRepositorio)
  private
    function BuscarJSON(const AURL: string): TJSONObject;
    function TratarURL(const AURL: string): string;
  public
    function BuscarBuild(const AURL: string): IBuildModel;
  end;

implementation

uses
  System.SysUtils, ContainerDI, Vigilante.Infra.Build.Builder,
  Vigilante.Conexao.JSON;

function TBuildRepositorio.BuscarBuild(const AURL: string): IBuildModel;
var
  _json: TJSONObject;
  _buildBuilder: IBuildBuilder;
begin
  Result := nil;
  _json := BuscarJSON(AURL);
  if not Assigned(_json) then
    Exit;
  try
    _buildBuilder := CDI.Resolve<IBuildBuilder>([_json]);
    Result := _buildBuilder.PegarBuild;
  finally
    FreeAndNil(_json);
  end;
end;

function TBuildRepositorio.BuscarJSON(const AURL: string): TJSONObject;
var
  _conexaoJSON: IConexaoJSON;
  _url: string;
begin
  _url := TratarURL(AURL);
  _conexaoJSON := CDI.Resolve<IConexaoJSON>([_url]);
  Result := _conexaoJSON.PegarBuild;
end;

function TBuildRepositorio.TratarURL(const AURL: string): string;
begin
  Result := AURL;
  if not AURL.EndsWith('api/json', True) then
    Result := AURL + '/api/json';
end;

end.
