unit Vigilante.Infra.DI;

interface

uses
  ContainerDI.Base, ContainerDI.Base.Impl;

type
  TInfraDI = class(TContainerDI)
  public
    class function New: IContainerDI;
    procedure Build; override;
  end;

implementation

uses
  ContainerDI,
  Vigilante.Configuracao,
  Vigilante.Conexao.JSON.Arquivo.Impl, Vigilante.Conexao.JSON.Impl,
  Vigilante.Conexao.JSON;

procedure TInfraDI.Build;
begin
  if PegarConfiguracoes.SimularBuild then
    CDI.RegisterType<TConexaoArquivoJSON>.Implements<IConexaoJSON>
  else
    CDI.RegisterType<TConexaoJSON>.Implements<IConexaoJSON>;
end;

class function TInfraDI.New: IContainerDI;
begin
  Result := Create;
end;

end.
