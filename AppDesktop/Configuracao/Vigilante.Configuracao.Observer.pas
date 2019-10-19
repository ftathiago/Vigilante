unit Vigilante.Configuracao.Observer;

interface

uses
  Vigilante.Configuracao;

type
  IConfiguracaoObserver = interface(IInterface)
    ['{E02F4230-5052-4C3F-BC3B-719F9CC620A2}']
    procedure ConfiguracoesAlteradas(const AConfiguracao: IConfiguracao);
  end;

  IConfiguracaoSubject = interface(IInterface)
    ['{7101ECE2-303D-40C5-83A6-52BFD3D92E3E}']
    procedure Adicionar(const AConfiguracaoObserver: IConfiguracaoObserver);
    procedure Remover(const AConfiguracaoObserver: IConfiguracaoObserver);
    procedure Notificar(const AConfiguracao: IConfiguracao);
  end;

implementation

end.
