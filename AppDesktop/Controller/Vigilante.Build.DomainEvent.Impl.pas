unit Vigilante.Build.DomainEvent.Impl;

interface

uses
  Vigilante.Build.Model, Vigilante.Build.Event;

type
  TBuildDomainEvent = class(TInterfacedObject, IBuildEvent)
  public
    procedure Notificar(const ABuild: IBuildModel);
  end;

implementation

uses
  ContainerDI, Vigilante.Build.Observer;

procedure TBuildDomainEvent.Notificar(const ABuild: IBuildModel);
var
  _observer: IBuildSubject;
begin
  _observer := CDI.Resolve<IBuildSubject>;
  _observer.Notificar(ABuild);
end;

end.
