unit Module.DataSet.ConfigMemento.Filter;

interface

uses
  FireDac.Comp.Client, Module.DataSet.ConfigMemento;

type
  TConfigFilter = class(TInterfacedObject, IInterface)
  private
    FDataSet: TFDMemTable;
    FFilter: string;
    FFiltered: boolean;
  public
    constructor Create(const ADataSet: TFDMemTable);
    destructor Destroy; override;
  end;

implementation

{ TConfigFilter }

constructor TConfigFilter.Create(const ADataSet: TFDMemTable);
begin
  FDataSet := ADataSet;
  FFilter := FDataSet.Filter;
  FFiltered := FDataSet.Filtered;
end;

destructor TConfigFilter.Destroy;
begin
  FDataSet.Filter := FFilter;
  FDataSet.Filtered := FFiltered;
  inherited;
end;

end.
