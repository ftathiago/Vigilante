unit Module.DataSet.ConfigMemento;

interface

uses
  System.Generics.Collections, FireDac.Comp.Client,
  Module.DataSet.ConfigMemento.ArmazenarConfiguracao;

type

  IConfigMemento = interface(IInterface)
    ['{8A9C1E4D-0A2B-44E3-BE3A-8DB31A46E870}']
    function GuardarConfig: IConfigMemento;
  end;

  TConfigMemento = class(TInterfacedObject, IConfigMemento)
  private
    FDataSet: TFDMemTable;
    FConfig: TArmazenarConfiguracaoSet;
    FListConfig: TList<IInterface>;
  public
    constructor Create(const ADataSet: TFDMemTable;
      const AConfig: TArmazenarConfiguracaoSet);
    destructor Destroy; override;
    function GuardarConfig: IConfigMemento;
  end;

implementation

uses
  System.SysUtils, Module.DataSet.ConfigMemento.Fabrica;

constructor TConfigMemento.Create(const ADataSet: TFDMemTable;
  const AConfig: TArmazenarConfiguracaoSet);
begin
  FDataSet := ADataSet;
  FConfig := AConfig;
  FListConfig := TList<IInterface>.Create;
end;

destructor TConfigMemento.Destroy;
begin
  FreeAndNil(FListConfig);
  inherited;
end;

function TConfigMemento.GuardarConfig: IConfigMemento;
var
  _config: TArmazenarConfiguracao;
begin
  for _config := Low(TArmazenarConfiguracao) to High(TArmazenarConfiguracao) do
  begin
    if _config in FConfig then
      FListConfig.Add(TCofigMementoFabrica.PegarConfigMemento(FDataSet, _config))
  end;
  Result := Self;
end;

end.
