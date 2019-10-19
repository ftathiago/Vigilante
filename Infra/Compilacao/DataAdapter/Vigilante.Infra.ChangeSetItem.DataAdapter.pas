unit Vigilante.Infra.ChangeSetItem.DataAdapter;

interface

uses
  System.SysUtils, System.Classes;

type
  IChangeSetItemAdapter = Interface(IInterface)
    ['{E115CA1F-DF9A-49C5-A931-0EACF0BD7F20}']
    function GetAutor: string;
    function GetDescricao: string;
    function GetArquivos: TArray<TFileName>;
    property Autor: string read GetAutor;
    property Descricao: string read GetDescricao;
    property Arquivos: TArray<TFileName> read GetArquivos;
  end;

implementation

end.
