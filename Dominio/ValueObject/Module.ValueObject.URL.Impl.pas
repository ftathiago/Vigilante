unit Module.ValueObject.URL.Impl;

interface

uses
  IdURI, Module.ValueObject.StringVO.Impl, Module.ValueObject.URL;

type
  TURL = class(TStringVO, IURL)
  public
    constructor Create(const AURL: string); override;
  end;

implementation

constructor TURL.Create(const AURL: string);
begin
  inherited Create(AURL);
end;

end.
