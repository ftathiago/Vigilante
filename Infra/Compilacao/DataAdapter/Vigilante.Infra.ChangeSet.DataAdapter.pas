unit Vigilante.Infra.ChangeSet.DataAdapter;

interface

uses
  Vigilante.ChangeSetItem.Model;

type
  IChangeSetAdapter = interface(IInterface)
    ['{1BE1D4F1-C2D2-4A5E-82DD-C7050C8BEE43}']
    function PegarChangesSet: TArray<TChangeSetItem>;
  end;

implementation

end.
