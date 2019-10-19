unit Vigilante.Infra.Build.Builder;

interface

uses
  Vigilante.Build.Model;

type
  IBuildBuilder = interface(IInterface)
    ['{63082ACF-E23B-432B-B501-000430300CF2}']
    function PegarBuild: IBuildModel;
  end;

implementation

end.
