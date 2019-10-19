unit Vigilante.Controller.DI;

interface

uses
  ContainerDI.Base, ContainerDI.Base.Impl;

type
  TControllerDI = class(TContainerDI)
  public
    class function New: IContainerDI;
    procedure Build; override;
  end;

implementation

uses
  ContainerDI,
  Vigilante.View.BuildURLDialog;

procedure TControllerDI.Build;
begin
end;

class function TControllerDI.New: IContainerDI;
begin
  Result := Create;
end;

end.
