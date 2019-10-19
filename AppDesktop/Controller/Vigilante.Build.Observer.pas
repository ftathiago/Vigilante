unit Vigilante.Build.Observer;

interface

uses
  Vigilante.Build.Model;

type
  IBuildObserver = interface(IInterface)
    ['{E02F4230-5052-4C3F-BC3B-719F9CC620A2}']
    procedure NovaAtualizacao(const ABuild: IBuildModel);
  end;

  IBuildSubject = interface(IInterface)
    ['{7101ECE2-303D-40C5-83A6-52BFD3D92E3E}']
    procedure Adicionar(const ABuildObserver: IBuildObserver);
    procedure Remover(const ABuildObserver: IBuildObserver);
    procedure Notificar(const ABuild: IBuildModel);
  end;

implementation

end.
