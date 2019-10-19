unit Vigilante.Configuracao;

interface

type
{$M+}
  IConfiguracao = interface(IInterface)
    ['{DA70BB30-F87D-4E5E-BFEA-24BD01F871E5}']
    function GetSimularBuild: boolean;
    function GetAtualizacoesAutomaticas: boolean;
    function GetAtualizacoesIntervalo: integer;
    procedure SetSimularBuild(const Value: boolean);
    procedure SetAtualizacoesAutomaticas(const Value: boolean);
    procedure SetAtualizacoesIntervalo(const Value: integer);
    procedure CarregarConfiguracoes;
    procedure PersistirConfiguracoes;
    property SimularBuild: boolean read GetSimularBuild write SetSimularBuild;
    property AtualizacoesAutomaticas: boolean read GetAtualizacoesAutomaticas write SetAtualizacoesAutomaticas;
    property AtualizacoesIntervalo: integer read GetAtualizacoesIntervalo write SetAtualizacoesIntervalo;
  end;

function PegarConfiguracoes: IConfiguracao;
procedure DefinirConfiguracoes(const AConfiguracao: IConfiguracao);

implementation

var
  _Configuracoes: IConfiguracao;

function PegarConfiguracoes: IConfiguracao;
begin
  Result := _Configuracoes;
end;

procedure DefinirConfiguracoes(const AConfiguracao: IConfiguracao);
begin
  _Configuracoes := AConfiguracao;
end;

end.
