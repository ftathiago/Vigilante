unit Vigilante.Controller.Base;

interface

uses
  Module.ValueObject.URL;

type
  IBaseController = interface(IInterface)
    ['{1298B18E-98D1-42C8-A613-3CB39BF0D30C}']
    procedure AdicionarNovaURL(const AURL: IURL);
    procedure VisualizadoPeloUsuario(const AID: TGUID);
    procedure BuscarAtualizacoes;
    function PodeNotificarUsuario(const AID: TGUID): boolean;
  end;

implementation

end.
