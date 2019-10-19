unit Vigilante.Controller.Build;

interface

uses
  Vigilante.Controller.Base, Vigilante.Build.Model, Vigilante.DataSet.Build,
  Vigilante.View.URLDialog;

type
  IBuildController = interface(IBaseController)
    ['{7FD5B485-8C31-421C-B27E-2231B37BFE86}']
    function GetDataSet: TBuildDataSet;
    procedure AdicionarOuAtualizar(const ABuild: IBuildModel);
    procedure TransformarEmCompilacao(const AID: TGUID);
    property DataSet: TBuildDataSet read GetDataSet;
  end;

implementation


end.
