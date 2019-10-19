unit Vigilante.Compilacao.DI;

interface

uses
  ContainerDI.Base.Impl, ContainerDI.Base;

type
  TCompilacaoDI = class(TContainerDI)
  public
    class function New: IContainerDI;
    procedure Build; override;
  end;

implementation

uses
  ContainerDI,
  Vigilante.Compilacao.View,
  Vigilante.View.URLDialog.Impl, Vigilante.View.CompilacaoURLDialog,
  Vigilante.Compilacao.Service, Vigilante.Compilacao.Service.Impl,
  Vigilante.Controller.Compilacao, Vigilante.Controller.Compilacao.Impl,
  Vigilante.Compilacao.Observer, Vigilante.Compilacao.Observer.Impl,
  Vigilante.Compilacao.Event, Vigilante.Compilacao.DomainEvent.Impl,
  Vigilante.Compilacao.Repositorio, Vigilante.Infra.Compilacao.Repositorio.Impl,
  Vigilante.Infra.Compilacao.Builder, Vigilante.Infra.Compilacao.Builder.Impl,
  Vigilante.Infra.Compilacao.DataAdapter, Vigilante.Infra.Compilacao.JSONDataAdapter;

procedure TCompilacaoDI.Build;
begin
  CDI.RegisterType<TCompilacaoService>.Implements<ICompilacaoService>;
  CDI.RegisterType<TCompilacaoURLDialog>.Implements<ICompilacaoURLDialog>('ICompilacaoURLDialog');
  CDI.RegisterType<TfrmCompilacaoView, TfrmCompilacaoView>;
  CDI.RegisterType<TCompilacaoSubject>.Implements<ICompilacaoSubject>.AsSingleton;
  CDI.RegisterType<TCompilacaoController>.Implements<ICompilacaoController>;
  CDI.RegisterType<TCompilacaoDomainEvent>.Implements<ICompilacaoEvent>;
  CDI.RegisterType<TCompilacaoJSONDataAdapter>.Implements<ICompilacaoAdapter>;
  CDI.RegisterType<TCompilacaoBuilder>.Implements<ICompilacaoBuilder>;
  CDI.RegisterType<TCompilacaoRepositorio>.Implements<ICompilacaoRepositorio>;
end;

class function TCompilacaoDI.New: IContainerDI;
begin
  Result := Create;
end;

end.
