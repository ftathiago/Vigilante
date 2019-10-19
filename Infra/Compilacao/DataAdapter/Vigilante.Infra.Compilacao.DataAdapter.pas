unit Vigilante.Infra.Compilacao.DataAdapter;

interface

uses
  Vigilante.Aplicacao.SituacaoBuild, Vigilante.ChangeSetItem.Model;

type
  ICompilacaoAdapter = interface(IInterface)
    ['{0D898A67-AFC6-4FB8-ADCC-7F48FF017276}']
    function GetNumero: integer;
    function GetNome: string;
    function GetURL: string;
    function GetSituacao: TSituacaoBuild;
    function GetChangesSet: TArray<TChangeSetItem>;
    function GetBuilding: boolean;
    property Numero: integer read GetNumero;
    property Nome: string read GetNome;
    property URL: string read GetURL;
    property Situacao: TSituacaoBuild read GetSituacao;
    property Building: boolean read GetBuilding;
    property ChangesSet: TArray<TChangeSetItem> read GetChangesSet;
  end;

implementation

end.
