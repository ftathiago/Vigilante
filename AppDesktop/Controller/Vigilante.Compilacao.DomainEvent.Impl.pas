unit Vigilante.Compilacao.DomainEvent.Impl;

interface

uses
  Vigilante.Compilacao.Model, Vigilante.Compilacao.Event;

type
  TCompilacaoDomainEvent = class(TInterfacedObject, ICompilacaoEvent)
  public
    procedure Notificar(const ACompilacaoModel: ICompilacaoModel);
  end;

implementation

uses
  ContainerDI, Vigilante.Compilacao.Observer;

procedure TCompilacaoDomainEvent.Notificar(const ACompilacaoModel: ICompilacaoModel);
var
  _observer: ICompilacaoSubject;
begin
  _observer := CDI.Resolve<ICompilacaoSubject>;
  _observer.Notificar(ACompilacaoModel);
end;

end.
