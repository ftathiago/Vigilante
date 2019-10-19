unit Vigilante.DataSet.Build;

interface

uses
  System.Classes, System.Generics.Collections, Data.DB, FireDac.Comp.Client,
  Vigilante.Build.Model, Vigilante.ChangeSetItem.Model, Vigilante.Aplicacao.SituacaoBuild,
  Module.DataSet.VigilanteBase, Module.ValueObject.URL;

type
  TBuildDataSet = class(TVigilanteDataSetBase<IBuildModel>)
  private
    FBuildAtual: TField;
    FUltimoBuildFalha: TField;
    FUltimoBuildSucesso: TField;
    FURLUltimoBuild: TField;
    function GetUltimoBuild: integer;
    function GetUltimoBuildFalha: integer;
    function GetUltimoBuildSucesso: integer;
    function GetURLUltimoBuild: IURL;
  protected
    procedure MapearCampos; override;
    procedure CriarCampos; override;
    procedure ImportarDetalhes(const AModel: IBuildModel); override;
  public
    procedure ApenasAtualizaveis(const AFiltrar: boolean = true);
    procedure CreateDataSet; override;
    function ExportarRegistro: IBuildModel; override;
    property UltimoBuild: integer read GetUltimoBuild;
    property URLUltimoBuild: IURL read GetURLUltimoBuild;
    property UltimoBuildSucesso: integer read GetUltimoBuildSucesso;
    property UltimoBuildFalha: integer read GetUltimoBuildFalha;
  end;

implementation

uses
  System.SysUtils, Module.ValueObject.URL.Impl, Vigilante.Build.Model.Impl;

procedure TBuildDataSet.CriarCampos;
begin
  inherited;
  FieldDefs.Add('BuildAtual', ftInteger);
  FieldDefs.Add('UltimoBuildSucesso', ftInteger);
  FieldDefs.Add('UltimoBuildFalha', ftInteger);
  FieldDefs.Add('URLUltimoBuild', ftString, 500);
end;

function TBuildDataSet.ExportarRegistro: IBuildModel;
begin
  Result := TBuildModel.Create(Nome, URL, Situacao, Building,
    FBuildAtual.AsInteger, UltimoBuildFalha, UltimoBuildSucesso,
    URLUltimoBuild);
  Result.DefinirID(ID);
end;

procedure TBuildDataSet.CreateDataSet;
begin
  inherited;
  ConfigurarCampos;
  LogChanges := False;
end;

procedure TBuildDataSet.MapearCampos;
begin
  inherited;
  FBuildAtual := FindField('BuildAtual');
  FUltimoBuildSucesso := FindField('UltimoBuildSucesso');
  FUltimoBuildFalha := FindField('UltimoBuildFalha');
  FURLUltimoBuild := FindField('URLUltimoBuild');
end;

procedure TBuildDataSet.ImportarDetalhes(const AModel: IBuildModel);
begin
  inherited;
  FBuildAtual.AsInteger := AModel.BuildAtual;
  FUltimoBuildSucesso.AsInteger := AModel.UltimoBuildSucesso;
  FUltimoBuildFalha.AsInteger := AModel.UltimoBuildFalha;
  FURLUltimoBuild.AsString := AModel.URLUltimoBuild.AsString;
end;

procedure TBuildDataSet.ApenasAtualizaveis(const AFiltrar: boolean);
begin
  Filtered := AFiltrar;
  Filter := 'Atualizar = True or Atualizar is null';
  if not AFiltrar then
    Filter := EmptyStr;
end;

function TBuildDataSet.GetUltimoBuild: integer;
begin
  Result := FBuildAtual.AsInteger;
end;

function TBuildDataSet.GetUltimoBuildFalha: integer;
begin
  Result := FUltimoBuildFalha.AsInteger;
end;

function TBuildDataSet.GetUltimoBuildSucesso: integer;
begin
  Result := FUltimoBuildSucesso.AsInteger;
end;

function TBuildDataSet.GetURLUltimoBuild: IURL;
begin
  Result := TURL.Create(FURLUltimoBuild.AsString);
end;

end.
