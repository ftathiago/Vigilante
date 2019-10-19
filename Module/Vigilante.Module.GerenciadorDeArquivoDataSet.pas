unit Vigilante.Module.GerenciadorDeArquivoDataSet;

interface

uses
  System.SysUtils;

type
  IGerenciadorDeArquivoDataSet = interface(IInterface)
    ['{9E9676A3-7484-49AA-9502-19304CF15045}']
    procedure SalvarArquivo(const ANomeArquivo: TFileName);
    function CarregarArquivo(const ANomeArquivo: TFileName):boolean;
  end;

implementation

end.
