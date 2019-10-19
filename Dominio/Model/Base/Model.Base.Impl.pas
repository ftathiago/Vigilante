unit Model.Base.Impl;

interface

uses
  System.Classes, Model.Base.Intf;

type
  TModelBase = class(TInterfacedObject, IModelBase)
  private
    FGUID: TGUID;
  public
    constructor Create;
    function GetId: TGUID;
    procedure DefinirID(const AID: TGUID);
  end;

implementation

uses
  System.SysUtils;

constructor TModelBase.Create;
begin
  CreateGUID(FGUID)
end;

procedure TModelBase.DefinirID(const AID: TGUID);
begin
  FGUID := AID;
end;

function TModelBase.GetId: TGUID;
begin
  Result := FGUID;
end;

end.
