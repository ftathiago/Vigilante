unit Vigilante.Infra.Compilacao.Builder;

interface

uses Vigilante.Compilacao.Model;

type
  ICompilacaoBuilder = interface(IInterface)
    ['{45F3CA8A-387E-4F1F-8507-B0BDE0AB7A56}']
    function PegarCompilacao: ICompilacaoModel;
  end;

implementation

end.
