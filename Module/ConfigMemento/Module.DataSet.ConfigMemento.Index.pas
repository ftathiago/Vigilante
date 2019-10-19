unit Module.DataSet.ConfigMemento.Index;

interface

uses
  FireDac.Comp.Client, Module.DataSet.ConfigMemento;

type
  TConfigIndex = class(TInterfacedObject, IInterface)
  private
    FIndexActive: boolean;
    FIndexName: string;
    FDataSet: TFDMemTable;
  public
    constructor Create(const ADataSet: TFDMemTable);
    destructor Destroy; override;
  end;

implementation

{ TConfigIndex }

constructor TConfigIndex.Create(const ADataSet: TFDMemTable);
begin
  FDataSet := ADataSet;
  FIndexName := FDataSet.IndexName;
  FIndexActive := FDataSet.IndexesActive;
end;

destructor TConfigIndex.Destroy;
begin
  FDataSet.IndexName := FIndexName;
  FDataSet.IndexesActive := FIndexActive;
  inherited;
end;

end.
