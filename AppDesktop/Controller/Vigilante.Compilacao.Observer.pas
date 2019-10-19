unit Vigilante.Compilacao.Observer;

interface

uses
  Vigilante.Compilacao.Model;

type
  ICompilacaoObserver = interface(IInterface)
    ['{E02F4230-5052-4C3F-BC3B-719F9CC620A2}']
    procedure NovaAtualizacao(const ACompilacao: ICompilacaoModel);
  end;

  ICompilacaoSubject = interface(IInterface)
    ['{7101ECE2-303D-40C5-83A6-52BFD3D92E3E}']
    procedure Adicionar(const ACompilacaoObserver: ICompilacaoObserver);
    procedure Remover(const ACompilacaoObserver: ICompilacaoObserver);
    procedure Notificar(const ACompilacao: ICompilacaoModel);
  end;

implementation

end.
