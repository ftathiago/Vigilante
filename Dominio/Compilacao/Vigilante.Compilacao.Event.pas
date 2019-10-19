unit Vigilante.Compilacao.Event;

interface

uses
  Vigilante.Compilacao.Model;

type
  ICompilacaoEvent = interface(IInterface)
    ['{C9FB6C70-1897-46C0-9126-92057AAF3706}']
    procedure Notificar(const ACompilacaoModel: ICompilacaoModel);
  end;

implementation

end.
