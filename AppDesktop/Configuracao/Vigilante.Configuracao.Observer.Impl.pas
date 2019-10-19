unit Vigilante.Configuracao.Observer.Impl;

interface

uses
  System.Generics.Collections, Vigilante.Configuracao.Observer,
  Vigilante.Configuracao;

type
  TConfiguracaoSubject = class(TInterfacedObject, IConfiguracaoSubject)
  private
    FListaObserver: TList<IConfiguracaoObserver>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Adicionar(const AConfiguracaoObserver: IConfiguracaoObserver);
    procedure Notificar(const AConfiguracao: IConfiguracao);
    procedure Remover(const AConfiguracaoObserver: IConfiguracaoObserver);
  end;

implementation

constructor TConfiguracaoSubject.Create;
begin
  FListaObserver := TList<IConfiguracaoObserver>.Create;
end;

destructor TConfiguracaoSubject.Destroy;
begin
  FListaObserver.Free;
  inherited;
end;

procedure TConfiguracaoSubject.Adicionar(
  const AConfiguracaoObserver: IConfiguracaoObserver);
begin
  if FListaObserver.Contains(AConfiguracaoObserver) then
    Exit;
  FListaObserver.Add(AConfiguracaoObserver);
end;

procedure TConfiguracaoSubject.Notificar(const AConfiguracao: IConfiguracao);
var
  _observer: IConfiguracaoObserver;
begin
  for _observer in FListaObserver do
    _observer.ConfiguracoesAlteradas(AConfiguracao);
end;

procedure TConfiguracaoSubject.Remover(
  const AConfiguracaoObserver: IConfiguracaoObserver);
begin
  if not FListaObserver.Contains(AConfiguracaoObserver) then
    Exit;
  FListaObserver.Remove(AConfiguracaoObserver);
end;

end.
