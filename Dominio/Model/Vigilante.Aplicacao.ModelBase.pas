unit Vigilante.Aplicacao.ModelBase;

interface

uses
  Model.Base.Intf, Vigilante.Aplicacao.SituacaoBuild;

type
  IVigilanteModelBase = interface(IModelBase)
    ['{C969D34B-D0A3-4050-9F09-6FCF9A1B8A8A}']
    function GetNome: string;
    function GetURL: string;
    function GetSituacao: TSituacaoBuild;
    function GetBuilding: boolean;
    property Nome: string read GetNome;
    property URL: string read GetURL;
    property Situacao: TSituacaoBuild read GetSituacao;
    property Building: boolean read GetBuilding;
  end;

implementation

end.
