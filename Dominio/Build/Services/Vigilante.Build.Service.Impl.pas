unit Vigilante.Build.Service.Impl;

interface

uses
  System.JSON, Vigilante.Build.Service, Vigilante.Build.Model,
  Vigilante.Build.Repositorio, Vigilante.Build.Event;

type
  TBuildService = class(TInterfacedObject, IBuildService)
  private
    FBuildRepositorio: IBuildRepositorio;
    FBuildEvent: IBuildEvent;
    function TratarURL(const AURL: string): string;
  protected
    procedure LancarEvento(const ABuildModel: IBuildModel);
  public
    constructor Create(const BuildRepositorio: IBuildRepositorio;
      const BuildEvent: IBuildEvent);
    function AtualizarBuild(const BuildModel: IBuildModel): IBuildModel;
  end;

implementation

uses
  System.SysUtils, System.StrUtils, ContainerDI;

constructor TBuildService.Create(const BuildRepositorio: IBuildRepositorio;
  const BuildEvent: IBuildEvent);
begin
  FBuildRepositorio := BuildRepositorio;
  FBuildEvent := BuildEvent;
end;

function TBuildService.AtualizarBuild(const BuildModel: IBuildModel)
  : IBuildModel;
var
  _url: string;
  _novoBuild: IBuildModel;
begin
  Result := nil;
  _url := BuildModel.URL;
  _url := TratarURL(_url);
  _novoBuild := FBuildRepositorio.BuscarBuild(_url);

  if not Assigned(_novoBuild) then
    Exit;

  _novoBuild.DefinirID(BuildModel.Id);

  if not _novoBuild.Equals(BuildModel) then
    LancarEvento(_novoBuild);

  Result := _novoBuild;
end;

procedure TBuildService.LancarEvento(const ABuildModel: IBuildModel);
begin
  if not Assigned(FBuildEvent) then
    Exit;
  FBuildEvent.Notificar(ABuildModel);
end;

function TBuildService.TratarURL(const AURL: string): string;
begin
  Result := AURL;
  if not AURL.EndsWith('api/json', True) then
    Result := AURL + '/api/json';
end;

end.
