unit Model.Base.Intf;

interface

uses
  System.Classes;

type
  IModelBase = interface(IInterface)
    ['{3104E38B-CB32-405A-B44C-43775CA8AF73}']
    procedure DefinirID(const AID: TGUID);
    function GetId: TGUID;
    property Id: TGUID read GetId;
  end;

implementation

end.
