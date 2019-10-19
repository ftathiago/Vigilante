unit Vigilante.Build.Model.Impl;

interface

uses
  Model.Base.Impl, Vigilante.Build.Model, Vigilante.Aplicacao.SituacaoBuild,
  Module.ValueObject.URL;

type
  TBuildModel = class(TModelBase, IBuildModel)
  private
    FNome: string;
    FURL: string;
    FSituacao: TSituacaoBuild;
    FBuilding: Boolean;
    FBuildAtual: integer;
    FUltimoBuildFalha: integer;
    FUltimoBuildSucesso: integer;
    FURLUltimoBuild: IURL;
  protected
    function GetBuilding: Boolean;
    function GetNome: string;
    function GetSituacao: TSituacaoBuild;
    function GetURL: string;
    function GetBuildAtual: integer;
    function GetUltimoBuildFalha: integer;
    function GetUltimoBuildSucesso: integer;
    function GetURLUltimoBuild: IURL;
  public
    constructor Create(const ANome: string; const AURL: string;
      const ASituacao: TSituacaoBuild; const ABuilding: Boolean;
      const ABuildAtual, AUltimoBuildFalha, AUltimoBuildSucesso: integer;
      const AURLUltimoBuild: IURL);
    function Equals(const BuildModel: IBuildModel): Boolean; reintroduce;
  end;

implementation

uses
  System.SysUtils;

constructor TBuildModel.Create(const ANome: string; const AURL: string;
  const ASituacao: TSituacaoBuild; const ABuilding: Boolean;
  const ABuildAtual, AUltimoBuildFalha, AUltimoBuildSucesso: integer;
  const AURLUltimoBuild: IURL);
begin
  FNome := ANome;
  FURL := AURL;
  FSituacao := ASituacao;
  FBuilding := ABuilding;
  FBuildAtual := ABuildAtual;
  FUltimoBuildFalha := AUltimoBuildFalha;
  FUltimoBuildSucesso := AUltimoBuildSucesso;
  FURLUltimoBuild := AURLUltimoBuild;
end;

function TBuildModel.Equals(const BuildModel: IBuildModel): Boolean;
begin
  Result := false;

  if not BuildModel.Nome.Equals(Self.FNome) then
    Exit;
  if BuildModel.BuildAtual <> Self.FBuildAtual then
    Exit;
  if BuildModel.UltimoBuildSucesso <> Self.FUltimoBuildSucesso then
    Exit;
  if BuildModel.UltimoBuildFalha <> Self.FUltimoBuildFalha then
    Exit;
  if not BuildModel.URLUltimoBuild.AsString.Equals(Self.FURLUltimoBuild.AsString)
  then
    Exit;
  if BuildModel.Situacao.AsInteger <> Self.GetSituacao.AsInteger then
    Exit;
  if BuildModel.Building <> Self.GetBuilding then
    Exit;
  if not BuildModel.Id.ToString.Equals(GetId.ToString) then
    Exit;

  Result := True;
end;

function TBuildModel.GetBuildAtual: integer;
begin
  Result := FBuildAtual;
end;

function TBuildModel.GetBuilding: Boolean;
begin
  Result := FBuilding;
end;

function TBuildModel.GetNome: string;
begin
  Result := FNome;
end;

function TBuildModel.GetSituacao: TSituacaoBuild;
begin
  Result := FSituacao;
end;

function TBuildModel.GetUltimoBuildFalha: integer;
begin
  Result := FUltimoBuildFalha;
end;

function TBuildModel.GetUltimoBuildSucesso: integer;
begin
  Result := FUltimoBuildSucesso;
end;

function TBuildModel.GetURL: string;
begin
  Result := FURL;
end;

function TBuildModel.GetURLUltimoBuild: IURL;
begin
  Result := FURLUltimoBuild;
end;

end.
