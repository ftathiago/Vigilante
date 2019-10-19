unit Vigilante.Controller.Build.Impl;

interface

uses
  System.SysUtils, Vigilante.Controller.Build, Vigilante.DataSet.Build,
  Vigilante.Build.Model, Vigilante.View.URLDialog,
  Vigilante.Controller.Base.Impl, Module.ValueObject.URL,
  Module.DataSet.VigilanteBase, Vigilante.Controller.Mediator;

type
  TBuildController = class(TControllerBase<IBuildModel>, IBuildController)
  private
    FDataSet: TBuildDataSet;
    FMediator: IControllerMediator;
    procedure SalvarDadosBuild;
    procedure CarregarDadosDoBuild;
  protected
    function GetDataSet: TBuildDataSet;
    procedure SetDataSet(const ADataSet: TBuildDataSet);
    function GetDataSetInterno: TVigilanteDataSetBase<IBuildModel>; override;
  public
    constructor Create(const AMediator: IControllerMediator);
    destructor Destroy; override;
    procedure AdicionarOuAtualizar(const ABuild: IBuildModel);
    procedure BuscarAtualizacoes; override;
    procedure TransformarEmCompilacao(const AID: TGUID);
    property DataSet: TBuildDataSet read GetDataSet;
  end;

implementation

uses
  System.Classes, System.Threading, Data.DB, ContainerDI,
  Vigilante.Build.Observer.Impl, Vigilante.Build.Observer,
  Vigilante.Build.Service, Vigilante.Module.GerenciadorDeArquivoDataSet;

constructor TBuildController.Create(const AMediator: IControllerMediator);
begin
  FDataSet := TBuildDataSet.Create(nil);
  CarregarDadosDoBuild;
  FMediator := AMediator;
  FMediator.AdicionarController(Self, tcBuild);
end;

destructor TBuildController.Destroy;
begin
  SalvarDadosBuild;
  FreeAndNil(FDataSet);
  FMediator.RemoverController(tcBuild);
  inherited;
end;

procedure TBuildController.CarregarDadosDoBuild;
var
  _gerenciadorArquivosDataSet: IGerenciadorDeArquivoDataSet;
begin
  _gerenciadorArquivosDataSet := CDI.Resolve<IGerenciadorDeArquivoDataSet>
    ([DataSet]);
  if not _gerenciadorArquivosDataSet.CarregarArquivo(QualifiedClassName) then
    DataSet.CreateDataSet;
end;

procedure TBuildController.SalvarDadosBuild;
var
  _gerenciadorArquivosDataSet: IGerenciadorDeArquivoDataSet;
begin
  _gerenciadorArquivosDataSet := CDI.Resolve<IGerenciadorDeArquivoDataSet>
    ([DataSet]);
  _gerenciadorArquivosDataSet.SalvarArquivo(QualifiedClassName);
end;

procedure TBuildController.AdicionarOuAtualizar(const ABuild: IBuildModel);
begin
  DataSet.Importar(ABuild);
end;

procedure TBuildController.BuscarAtualizacoes;
var
  _service: IBuildService;
  _dataTemp: TBuildDataSet;
  _buildOriginal: IBuildModel;
  _build: IBuildModel;
begin
  inherited;
  if DataSet.IsEmpty then
    Exit;
  if DataSet.State in dsEditModes then
    Exit;
  _dataTemp := TBuildDataSet.Create(nil);
  try
    _dataTemp.CloneCursor(DataSet);
    _dataTemp.ApenasAtualizaveis();
    _dataTemp.First;
    while not _dataTemp.Eof do
    begin
      _service := CDI.Resolve<IBuildService>;
      _buildOriginal := _dataTemp.ExportarRegistro;
      _build := _service.AtualizarBuild(_buildOriginal);
      if not Assigned(_build) then
        Exit;
      if not _buildOriginal.Equals(_build) then
        _dataTemp.Importar(_build);
      _dataTemp.Next;
    end;
  finally
    FreeAndNil(_dataTemp);
  end;
end;

function TBuildController.GetDataSet: TBuildDataSet;
begin
  Result := FDataSet;
end;

function TBuildController.GetDataSetInterno: TVigilanteDataSetBase<IBuildModel>;
begin
  Result := GetDataSet;
end;

procedure TBuildController.SetDataSet(const ADataSet: TBuildDataSet);
begin
  FDataSet := ADataSet;
end;

procedure TBuildController.TransformarEmCompilacao(const AID: TGUID);
var
  _urlBuild: string;
  _numeroCompilacao: integer;
  _urlCompilacao: string;
  _url: IURL;
begin
  if not DataSet.LocalizarPorID(AID) then
    Exit;
  _urlBuild := DataSet.URL;
  _numeroCompilacao := DataSet.UltimoBuild;
  _urlCompilacao := Format('%s/%d', [_urlBuild, _numeroCompilacao]);
  _url := CDI.Resolve<IURL>([_urlCompilacao]);
  FMediator.AdicionarURL(tcCompilacao, _url);
end;

end.
