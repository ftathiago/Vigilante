unit Vigilante.Compilacao.Model;
{$M+}

interface

uses
  System.Generics.Collections, Module.ValueObject.URL,
  Vigilante.Aplicacao.SituacaoBuild, Vigilante.ChangeSetItem.Model,
  Vigilante.Aplicacao.ModelBase;

type

  ICompilacaoModel = interface(IVigilanteModelBase)
    ['{91DCE211-D41D-4BB8-96E8-4DA35C4EC555}']
    function GetChangeSet: TObjectList<TChangeSetItem>;
    function GetNumero: integer;
    function Equals(const CompilacaoModel: ICompilacaoModel): boolean;
    property Numero: integer read GetNumero;
    property ChangeSet: TObjectList<TChangeSetItem> read GetChangeSet;
  end;

implementation

end.
