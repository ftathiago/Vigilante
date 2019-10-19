unit Module.ValueObject.StringVO.Impl;

interface

uses
  Module.ValueObject.StringVO;

type
  TStringVO = class(TInterfacedObject, IStringVO)
  private
    FString: string;
  public
    constructor Create(const AString: string); virtual;
    function AsString: string;
  end;

implementation

function TStringVO.AsString: string;
begin
  Result := FString;
end;

constructor TStringVO.Create(const AString: string);
begin
  FString := AString;
end;

end.
