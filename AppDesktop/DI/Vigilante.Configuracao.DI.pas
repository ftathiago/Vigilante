unit Vigilante.Configuracao.DI;

interface

uses
  ContainerDI.Base, ContainerDI.Base.Impl;

type
  TConfiguracaoDI = class(TContainerDI)
  public
    class function New: IContainerDI;
    procedure Build; override;
  end;

implementation

uses
  ContainerDI,
  Vigilante.Configuracao.View,
  Vigilante.Configuracao.Observer.Impl, Vigilante.Configuracao.Observer;

procedure TConfiguracaoDI.Build;
begin
  CDI.RegisterType<TConfiguracaoSubject>.Implements<IConfiguracaoSubject>.AsSingleton;
  CDI.RegisterType<TfrmConfiguracaoView, TfrmConfiguracaoView>;
end;

class function TConfiguracaoDI.New: IContainerDI;
begin
  Result := Create;
end;

end.
