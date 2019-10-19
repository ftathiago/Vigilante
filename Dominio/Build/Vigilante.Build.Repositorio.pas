unit Vigilante.Build.Repositorio;

interface

uses
  Vigilante.Build.Model;

type
  IBuildRepositorio = interface(IInterface)
    ['{63C86F1E-E246-465F-A67C-2E6D8792E407}']
    function BuscarBuild(const AURL: string): IBuildModel;
  end;

implementation

end.
