unit Vigilante.Infra.Build.JSONDataAdapter;

interface

uses
  Vigilante.Aplicacao.SituacaoBuild, Vigilante.Build.Model, Module.ValueObject.URL;

type
  IBuildJSONDataAdapter = interface(IInterface)
    ['{8B2C90E7-4B1A-4A49-9878-F249046D2488}']
    function GetNome: string;
    function GetURL: string;
    function GetSituacao: TSituacaoBuild;
    function GetBuilding: boolean;
    function GetBuildAtual: integer;
    function GetUltimoBuildFalha: integer;
    function GetUltimoBuildSucesso: integer;
    function GetURLUltimoBuild: IURL;
    property Nome: string read GetNome;
    property URL: string read GetURL;
    property Situacao: TSituacaoBuild read GetSituacao;
    property Building: boolean read GetBuilding;
    property BuildAtual: integer read GetBuildAtual;
    property UltimoBuildSucesso: integer read GetUltimoBuildSucesso;
    property UltimoBuildFalha: integer read GetUltimoBuildFalha;
    property URLUltimoBuild: IURL read GetURLUltimoBuild;
  end;

implementation

end.
