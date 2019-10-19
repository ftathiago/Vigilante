unit Vigilante.Compilacao.Service;

interface

uses
  Vigilante.Compilacao.Model;

type
  ICompilacaoService = interface(IInterface)
    ['{24B4FC29-E395-4CD9-BCC3-C6615548AD3E}']
    function AtualizarCompilacao(const ACompilacaoModel: ICompilacaoModel): ICompilacaoModel;
  end;

implementation



end.
