unit Teste.ValueObject.URL;

interface

uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TURLTest = class
  public
    [Test]
    procedure TestarURLRetiraCaracteresEspeciais;
  end;

implementation

{ TURLTest }

uses
  Module.ValueObject.URL.Impl, Module.ValueObject.URL;

procedure TURLTest.TestarURLRetiraCaracteresEspeciais;
var
  _url: IURL;
begin
  _url := TURL.Create('http:/%20teste');
  Assert.AreEqual('http:/ teste', _url.AsString);
end;

initialization

TDUnitX.RegisterTestFixture(TURLTest);

end.
