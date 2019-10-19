unit ContainerDI.Base.Impl;

interface

uses
  System.Generics.Collections, ContainerDI.Base;

type
  TContainerDI = class(TInterfacedObject, IContainerDI)
  private
    FContainerDI: TList<IContainerDI>;
  public
    constructor Create;
    class function New: IContainerDI;
    destructor Destroy; override;
    function Adicionar(const ADIConfig: IContainerDI): IContainerDI;
    procedure Build; virtual;
  end;

implementation

uses
  System.SysUtils, ContainerDI;

class function TContainerDI.New: IContainerDI;
begin
  Result := Create;
end;

constructor TContainerDI.Create;
begin
  FContainerDI := TList<IContainerDI>.Create;
end;

destructor TContainerDI.Destroy;
begin
  FreeAndNil(FContainerDI);
  inherited;
end;

function TContainerDI.Adicionar(
  const ADIConfig: IContainerDI): IContainerDI;
begin
  Result := Self;
  if FContainerDI.Contains(ADIConfig) then
    Exit;
  FContainerDI.Add(ADIConfig);
end;

procedure TContainerDI.Build;
var
  _configDI: IContainerDI;
begin
  for _configDI in FContainerDI do
    _configDI.Build;
  CDI.Build;
end;

end.
