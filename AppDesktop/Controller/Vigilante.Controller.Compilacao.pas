unit Vigilante.Controller.Compilacao;

interface

uses
  Data.DB,  Vigilante.Controller.Base, Vigilante.Compilacao.Model, Vigilante.DataSet.Compilacao;

type
  ICompilacaoController = interface(IBaseController)
    ['{B77A1AF0-B51E-4EF0-8978-4C5E1DB7ED3F}']
    function GetDataSet: TCompilacaoDataSet;
    procedure AdicionarOuAtualizar(const ACompilacao: ICompilacaoModel);
    property DataSet: TCompilacaoDataSet read GetDataSet;
  end;

implementation

end.
