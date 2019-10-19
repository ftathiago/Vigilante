unit Vigilante.Aplicacao.DI;

interface

uses
  System.Generics.Collections, ContainerDI.Base, ContainerDI.Base.Impl;

type
  TAplicacaoDI = class(TContainerDI)
  public
    class function New: IContainerDI;
    procedure Build; override;
  end;

implementation

uses
  System.SysUtils, ContainerDI,
  Vigilante.Compilacao.DI,
  Vigilante.Build.DI,
  Module.ValueObject.URL.Impl, Module.ValueObject.URL,
  Vigilante.Module.GerenciadorDeArquivoDataSet.Impl, Vigilante.Module.GerenciadorDeArquivoDataSet,
  Vigilante.Controller.Mediator, Vigilante.Controller.Mediator.Impl,
  Vigilante.Controller.Configuracao, Vigilante.Controller.Configuracao.Impl;

procedure TAplicacaoDI.Build;
begin
  CDI.RegisterType<TURL>.Implements<IURL>;
  CDI.RegisterType<TControllerMediator>.Implements<IControllerMediator>.AsSingleton;
  CDI.RegisterType<TConfiguracaoController>.Implements<IConfiguracaoController>;
  CDI.RegisterType<TGerenciadorDeArquivoDataSet>.Implements<IGerenciadorDeArquivoDataSet>;
  TCompilacaoDI.New.Build;
  TBuildDI.New.Build;
end;

class function TAplicacaoDI.New: IContainerDI;
begin
  Result := Create;
end;

end.
