unit Vigilante.View.URLDialog;

interface

uses
  Module.ValueObject.URL;

type
  IURLDialog = interface(IInterface)
    ['{71A3B83A-172E-431E-BDDD-F10A14101B9A}']
    function GetLabelURL: string;
    function GetURLInformada: IURL;
    procedure SetLabelURL(const Value: string);
    procedure SetURLInformada(const Value: IURL);
    function Executar: boolean;
    property LabelURL: string read GetLabelURL write SetLabelURL;
    property URLInformada: IURL read GetURLInformada write SetURLInformada;
  end;

implementation

end.
