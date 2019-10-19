unit Vigilante.Build.Service;

interface

uses
  Vigilante.Build.Model;

type
  IBuildService = interface(IInterface)
    ['{938B103A-E58B-438C-A0EB-D2E295E25FAA}']
    function AtualizarBuild(const BuildModel: IBuildModel): IBuildModel;
  end;

implementation

end.
