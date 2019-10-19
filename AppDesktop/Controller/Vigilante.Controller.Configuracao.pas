unit Vigilante.Controller.Configuracao;

interface

uses
  Vigilante.Configuracao, Vigilante.Configuracao.Observer;

type
  IConfiguracaoController = interface(IConfiguracaoObserver)
    ['{6466A0BB-CBE7-4701-B461-802FEADE1C20}']
    procedure CarregarConfiguracoes(const AOrigem, ADestino: IConfiguracao);
    procedure PersistirAlteracoes(const AConfiguracao: IConfiguracao);
  end;

implementation

end.
