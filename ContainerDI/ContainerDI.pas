unit ContainerDI;

interface

uses
  Spring.Container;

procedure DefinirContainerDI(const AContainerDI: TContainer);

function CDI: TContainer;

implementation

uses
  System.SysUtils;

var
  _ContainerDI: TContainer;

procedure DefinirContainerDI(const AContainerDI: TContainer);
begin
  if Assigned(_ContainerDI) then
    FreeAndNil(_ContainerDI);
  _ContainerDI := AContainerDI;
end;

function CDI: TContainer;
begin
  Result := _ContainerDI;
end;

initialization

finalization

if Assigned(_ContainerDI) then
  FreeAndNil(_ContainerDI);

end.
