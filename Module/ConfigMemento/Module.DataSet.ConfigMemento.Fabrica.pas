unit Module.DataSet.ConfigMemento.Fabrica;

interface

uses
  FireDac.Comp.Client, Module.DataSet.ConfigMemento.ArmazenarConfiguracao,
  Module.DataSet.ConfigMemento;

type
  TCofigMementoFabrica = class
    class function PegarConfigMemento(const ADataSet: TFDMemTable;
      const AConfig: TArmazenarConfiguracao): IInterface;
  end;

implementation

{ TCofigMementoFabrica }

uses
  Module.DataSet.ConfigMemento.Index, Module.DataSet.ConfigMemento.Filter;

class function TCofigMementoFabrica.PegarConfigMemento(
  const ADataSet: TFDMemTable;
  const AConfig: TArmazenarConfiguracao): IInterface;
begin
  case AConfig of
    acIndex:
      Result := TConfigIndex.Create(ADataSet);
    acFilter:
      Result := TConfigFilter.Create(ADataSet);
  end;
end;

end.
