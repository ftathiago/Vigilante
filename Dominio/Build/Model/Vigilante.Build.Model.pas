unit Vigilante.Build.Model;

interface

uses
  Vigilante.Aplicacao.ModelBase, Vigilante.Aplicacao.SituacaoBuild, Module.ValueObject.URL;

type
  IBuildModel = interface(IVigilanteModelBase)
    ['{A6BB46A1-78C3-4069-940E-F48071895246}']
    function GetBuildAtual: integer;
    function GetUltimoBuildSucesso: integer;
    function GetUltimoBuildFalha: integer;
    function GetURLUltimoBuild: IURL;
    function Equals(const BuildModel: IBuildModel): boolean;
    property BuildAtual: integer read GetBuildAtual;
    property UltimoBuildSucesso: integer read GetUltimoBuildSucesso;
    property UltimoBuildFalha: integer read GetUltimoBuildFalha;
    property URLUltimoBuild: IURL read GetURLUltimoBuild;
  end;

implementation

end.
