unit Vigilante.Build.DI;

interface

uses
  ContainerDI.Base, ContainerDI.Base.Impl;

type
  TBuildDI = class(TContainerDI)
  public
    class function New: IContainerDI;
    procedure Build; override;
  end;

implementation

uses
  ContainerDI,
  Vigilante.Build.View,
  Vigilante.View.BuildURLDialog,
  Vigilante.Build.Service.Impl, Vigilante.Build.Service,
  Vigilante.Controller.Build, Vigilante.Controller.Build.Impl,
  Vigilante.Build.Observer, Vigilante.Build.Observer.Impl,
  Vigilante.Build.Event, Vigilante.Build.DomainEvent.Impl,
  Vigilante.Infra.Build.JSONDataAdapter, Vigilante.Infra.Build.JSONDataAdapter.Impl,
  Vigilante.Infra.Build.Builder, Vigilante.Infra.Build.Builder.Impl,
  Vigilante.Build.Repositorio, Vigilante.Infra.Build.Repositorio.Impl;

procedure TBuildDI.Build;
begin
  CDI.RegisterType<TBuildService>.Implements<IBuildService>;
  CDI.RegisterType<TBuildURLDialog>.Implements<IBuildURLDialog>('IBuildURLDialog');
  CDI.RegisterType<TfrmBuildView, TfrmBuildView>;
  CDI.RegisterType<TBuildSubject>.Implements<IBuildSubject>.AsSingleton;
  CDI.RegisterType<TBuildController>.Implements<IBuildController>;
  CDI.RegisterType<TBuildDomainEvent>.Implements<IBuildEvent>;
  CDI.RegisterType<TBuildJSONDataAdapter>.Implements<IBuildJSONDataAdapter>;
  CDI.RegisterType<TBuildBuilder>.Implements<IBuildBuilder>;
  CDI.RegisterType<TBuildRepositorio>.Implements<IBuildRepositorio>;
end;

class function TBuildDI.New: IContainerDI;
begin
  Result := Create;
end;

end.
