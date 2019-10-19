unit Vigilante.Controller.Compilacao.Impl;

interface

uses
  System.Generics.Collections, Data.DB, FireDac.Comp.Client, Vigilante.Compilacao.Model,
  Vigilante.Controller.Compilacao, Vigilante.Compilacao.Observer,
  Vigilante.DataSet.Compilacao, Vigilante.View.URLDialog,
  Vigilante.Controller.Base.Impl, Module.ValueObject.URL,
  Module.DataSet.VigilanteBase, Vigilante.Controller.Mediator;

type
  TCompilacaoController = class(TControllerBase<ICompilacaoModel>, ICompilacaoController)
  private
    FDataSet: TCompilacaoDataSet;
    FMediator: IControllerMediator;
    procedure CarregarDadosCompilacao;
    procedure SalvarDadosBuild;
  protected
    function GetDataSet: TCompilacaoDataSet;
    function GetDataSetInterno: TVigilanteDataSetBase<ICompilacaoModel>; override;
  public
    constructor Create(const AMediator: IControllerMediator);
    destructor Destroy; override;
    procedure BuscarAtualizacoes; override;
    procedure AdicionarOuAtualizar(const ACompilacao: ICompilacaoModel);
    procedure VisualizadoPeloUsuario(const AID: TGUID); override;
    function PodeNotificarUsuario(const AID: TGUID): boolean; override;
    property DataSet: TCompilacaoDataSet read FDataSet;
  end;

implementation

{ TBuildController }

uses
  System.SysUtils, System.Classes, System.Threading, ContainerDI,
  Vigilante.Compilacao.Service, Vigilante.Aplicacao.SituacaoBuild,
  Vigilante.Build.Observer.Impl, Vigilante.Compilacao.Observer.Impl,
  Vigilante.Module.GerenciadorDeArquivoDataSet;

constructor TCompilacaoController.Create(const AMediator: IControllerMediator);
begin
  FDataSet := TCompilacaoDataSet.Create(nil);
  CarregarDadosCompilacao;
  FMediator := AMediator;
  FMediator.AdicionarController(Self, tcCompilacao);
end;

destructor TCompilacaoController.Destroy;
begin
  SalvarDadosBuild;
  FreeAndNil(FDataSet);
  FMediator.RemoverController(tcCompilacao);
  inherited;
end;

procedure TCompilacaoController.CarregarDadosCompilacao;
var
  _gerenciadorArquivosDataSet: IGerenciadorDeArquivoDataSet;
begin
  _gerenciadorArquivosDataSet := CDI.Resolve<IGerenciadorDeArquivoDataSet>([DataSet]);
  if not _gerenciadorArquivosDataSet.CarregarArquivo(QualifiedClassName) then
    DataSet.CreateDataSet;
end;

procedure TCompilacaoController.SalvarDadosBuild;
var
  _gerenciadorArquivosDataSet: IGerenciadorDeArquivoDataSet;
begin
  _gerenciadorArquivosDataSet := CDI.Resolve<IGerenciadorDeArquivoDataSet>([DataSet]);
  _gerenciadorArquivosDataSet.SalvarArquivo(QualifiedClassName);
end;

procedure TCompilacaoController.VisualizadoPeloUsuario(const AID: TGUID);
begin
  inherited;
  if not DataSet.LocalizarPorID(AID) then
    Exit;
  DataSet.Edit;
  DataSet.Atualizar := False;
  DataSet.Post;
end;

procedure TCompilacaoController.AdicionarOuAtualizar(const ACompilacao: ICompilacaoModel);
begin
  DataSet.Importar(ACompilacao);
end;

procedure TCompilacaoController.BuscarAtualizacoes;
var
  _service: ICompilacaoService;
  _dataSet: TCompilacaoDataSet;
  _compilacao: ICompilacaoModel;
  _compilacaoOriginal: ICompilacaoModel;
begin
  inherited;
  if DataSet.IsEmpty then
    Exit;

  if DataSet.State in dsEditModes then
    Exit;

  _dataSet := TCompilacaoDataSet.Create(nil);
  try
    _dataSet.CloneCursor(DataSet);
    _dataSet.ApenasAtualizaveis();
    _dataSet.First;
    while not _dataSet.Eof do
    begin
      _service := CDI.Resolve<ICompilacaoService>;
      _compilacaoOriginal := _dataSet.ExportarRegistro;
      _compilacao := _service.AtualizarCompilacao(_compilacaoOriginal);
      if not Assigned(_compilacao) then
        Exit;

      if not _compilacaoOriginal.Equals(_compilacao) then
        _dataSet.Importar(_compilacao);
      _dataSet.Next;
    end;
  finally
    FreeAndNil(_dataSet);
  end;
end;

function TCompilacaoController.PodeNotificarUsuario(const AID: TGUID): boolean;
begin
  Result := False;
  if not inherited then
    Exit;

  Result := DataSet.Atualizar;
end;

function TCompilacaoController.GetDataSet: TCompilacaoDataSet;
begin
  Result := FDataSet;
end;

function TCompilacaoController.GetDataSetInterno: TVigilanteDataSetBase<ICompilacaoModel>;
begin
  Result := GetDataSet;
end;

end.
