unit Vigilante.Controller.Configuracao.Impl;

interface

uses
  System.Rtti, Vigilante.Controller.Configuracao, Vigilante.Configuracao;

type
  TConfiguracaoController = class(TInterfacedObject, IConfiguracaoController)
  private
  public
    procedure CarregarConfiguracoes(const AOrigem: IConfiguracao;
      const ADestino: IConfiguracao);
    procedure PersistirAlteracoes(const AConfiguracao: IConfiguracao);
    procedure ConfiguracoesAlteradas(const AConfiguracao: IConfiguracao);
  end;

implementation

uses
  Vigilante.Configuracao.Impl;

procedure TConfiguracaoController.CarregarConfiguracoes(const AOrigem,
  ADestino: IConfiguracao);
begin
  ADestino.SimularBuild := AOrigem.SimularBuild;
  ADestino.AtualizacoesAutomaticas := AOrigem.AtualizacoesAutomaticas;
  ADestino.AtualizacoesIntervalo  := AOrigem.AtualizacoesIntervalo;
end;

procedure TConfiguracaoController.ConfiguracoesAlteradas(
  const AConfiguracao: IConfiguracao);
begin

end;

procedure TConfiguracaoController.PersistirAlteracoes(
  const AConfiguracao: IConfiguracao);
begin
  PegarConfiguracoes.SimularBuild := AConfiguracao.SimularBuild;
  PegarConfiguracoes.AtualizacoesAutomaticas := AConfiguracao.AtualizacoesAutomaticas;
  PegarConfiguracoes.AtualizacoesIntervalo := AConfiguracao.AtualizacoesIntervalo;
  PegarConfiguracoes.PersistirConfiguracoes;
end;

end.
