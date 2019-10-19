unit Vigilante.Infra.Compilacao.Repositorio.Impl;

interface

uses
  System.JSON, Vigilante.Compilacao.Repositorio, Vigilante.Compilacao.Model;

type
  TCompilacaoRepositorio = class(TInterfacedObject, ICompilacaoRepositorio)
  private
    function BuscarJSON(const AURL: string): TJSONObject;
  public
    function BuscarCompilacao(const AURL: string): ICompilacaoModel;
  end;

implementation

uses
  System.SysUtils, ContainerDI, Vigilante.Infra.Compilacao.Builder,
  Vigilante.Conexao.JSON;

function TCompilacaoRepositorio.BuscarCompilacao(const AURL: string): ICompilacaoModel;
var
  _json: TJSONObject;
  _compilacaoBuilder: ICompilacaoBuilder;
begin
  Result := nil;
  _json := BuscarJSON(AURL);
  if not Assigned(_json) then
    Exit;
  try
    _compilacaoBuilder := CDI.Resolve<ICompilacaoBuilder>([_json]);
    Result := _compilacaoBuilder.PegarCompilacao;
  finally
    FreeAndNil(_json);
  end;
end;

function TCompilacaoRepositorio.BuscarJSON(const AURL: string): TJSONObject;
var
  _conexaoJSON: IConexaoJSON;
begin
  _conexaoJSON := CDI.Resolve<IConexaoJSON>([AURL]);
  Result := _conexaoJSON.PegarCompilacao;
end;

end.
