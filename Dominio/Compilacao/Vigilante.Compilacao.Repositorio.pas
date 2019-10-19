unit Vigilante.Compilacao.Repositorio;

interface

uses
  Vigilante.Compilacao.Model;

type
  ICompilacaoRepositorio = interface(IInterface)
    ['{CE9FAAF3-34F5-4FBC-A40A-8D2E46136071}']
    function BuscarCompilacao(const AURL: string): ICompilacaoModel;
  end;

implementation

end.
