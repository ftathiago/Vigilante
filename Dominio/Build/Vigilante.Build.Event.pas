unit Vigilante.Build.Event;

interface

uses
  Vigilante.Build.Model;

type
  IBuildEvent = interface(IInterface)
    ['{51417C97-A33E-4EF8-A6B7-B98B0748B258}']
    procedure Notificar(const ABuild: IBuildModel);
  end;

implementation

end.
