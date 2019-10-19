unit Vigilante.Infra.Build.Builder.Impl;

interface

uses
  System.JSON, Vigilante.Build.Model, Vigilante.Infra.Build.Builder;

type
  TBuildBuilder = class(TInterfacedObject, IBuildBuilder)
  private
    FJSON: TJSONObject;
  public
    constructor Create(const AJSON: TJSONObject);
    function PegarBuild: IBuildModel;
  end;

implementation

uses
  ContainerDI, Vigilante.Build.Model.Impl, Vigilante.Infra.Build.JSONDataAdapter;

constructor TBuildBuilder.Create(const AJSON: TJSONObject);
begin
  FJSON := AJSON;
end;

function TBuildBuilder.PegarBuild: IBuildModel;
var
  _adapter: IBuildJSONDataAdapter;
begin
  _adapter := CDI.Resolve<IBuildJSONDataAdapter>([FJSON]);
  Result := TBuildModel.Create(_adapter.Nome, _adapter.URL, _adapter.Situacao,
    _adapter.Building, _adapter.BuildAtual, _adapter.UltimoBuildFalha,
    _adapter.UltimoBuildSucesso, _adapter.URLUltimoBuild);
end;

end.
