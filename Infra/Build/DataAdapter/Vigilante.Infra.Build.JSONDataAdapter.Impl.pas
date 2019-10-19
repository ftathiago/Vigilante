unit Vigilante.Infra.Build.JSONDataAdapter.Impl;

interface

uses
  System.JSON, Vigilante.Infra.Build.JSONDataAdapter, Vigilante.Aplicacao.SituacaoBuild,
  Module.ValueObject.URL;

type
  TBuildJSONDataAdapter = class(TInterfacedObject, IBuildJSONDataAdapter)
  private
    FJSON: TJSONObject;
    FSituacaoBuild: TSituacaoBuild;
    FBuildZero: integer;
    FUltimoBuild: integer;
    FUltimoCompleto: integer;
    FUltimoEstavel: integer;
    FUltimoSucesso: integer;
    FUltimoInstavel: integer;
    FUltimoSemSucesso: integer;
    FUltimoFalhou: integer;
    FURLUltimoBuild: IURL;
    function TemValor(const AJSON: TJSONValue): boolean;
    procedure CarregarBuildZero;
    procedure CarregarUltimoBuild;
    procedure CarregarUltimo(const ANode: string; out ANumero: integer);
    function PegarNumeroDoBuild(const ABuild: TJSONObject): integer;
    procedure CarregarSituacao;
    procedure CarregarURLUltimoBuild;
  protected
    function GetBuilding: boolean;
    function GetNome: string;
    function GetSituacao: TSituacaoBuild;
    function GetURL: string;
    function GetBuildAtual: integer;
    function GetUltimoBuildFalha: integer;
    function GetUltimoBuildSucesso: integer;
    function GetURLUltimoBuild: IURL;
  public
    constructor Create(const AJSON: TJSONObject);
  end;

implementation

uses
  System.SysUtils, System.Generics.Collections, Module.ValueObject.URL.Impl;

constructor TBuildJSONDataAdapter.Create(const AJSON: TJSONObject);
begin
  FJSON := AJSON;
  CarregarBuildZero;
  CarregarUltimoBuild;
  CarregarSituacao;
  CarregarURLUltimoBuild;
end;

procedure TBuildJSONDataAdapter.CarregarBuildZero;
var
  _build: TJSONArray;
  _buildItem: TJSONObject;
begin
  _build := FJSON.GetValue('builds') as TJSONArray;
  _buildItem := _build.Items[0] as TJSONObject;
  if not TemValor(_buildItem) then
    Exit;

  FBuildZero := PegarNumeroDoBuild(_buildItem);
end;

procedure TBuildJSONDataAdapter.CarregarUltimoBuild;
begin
  CarregarUltimo('lastBuild', FUltimoBuild);
  CarregarUltimo('lastCompletedBuild', FUltimoCompleto);
  CarregarUltimo('lastFailedBuild', FUltimoFalhou);
  CarregarUltimo('lastStableBuild', FUltimoEstavel);
  CarregarUltimo('lastSuccessfulBuild', FUltimoSucesso);
  CarregarUltimo('lastUnstableBuild', FUltimoInstavel);
  CarregarUltimo('lastUnsuccessfulBuild', FUltimoSemSucesso);
end;

procedure TBuildJSONDataAdapter.CarregarURLUltimoBuild;
var
  _lastBuild: TJSONObject;
  _url: TJSONValue;
begin
  _lastBuild := FJSON.GetValue('lastBuild') as TJSONObject;
  if not TemValor(_lastBuild) then
    Exit;
  _url := _lastBuild.GetValue('url');
  if not TemValor(_url) then
    Exit;
  FURLUltimoBuild := TURL.Create(_url.Value);
end;

procedure TBuildJSONDataAdapter.CarregarUltimo(const ANode: string;
  out ANumero: integer);
var
  _node: TJSONValue;
begin
  ANumero := -1;
  _node := FJSON.GetValue(ANode);
  if not TemValor(_node) then
    Exit;
  ANumero := PegarNumeroDoBuild(_node as TJSONObject);
end;

function TBuildJSONDataAdapter.TemValor(const AJSON: TJSONValue): boolean;
begin
  Result := False;

  if not Assigned(AJSON) then
    Exit;

  if AJSON.Value.Equals('null') then
    Exit;

  Result := True;
end;

procedure TBuildJSONDataAdapter.CarregarSituacao;
var
  _buildSemSucesso: boolean;
  _buildCompletou: boolean;
  _buildSucesso: boolean;
  _buildFalha: boolean;
  _buildAbortado: boolean;
begin
  _buildCompletou := (FUltimoBuild = FUltimoCompleto);
  _buildSemSucesso := (FUltimoBuild = FUltimoSemSucesso);

  _buildFalha := _buildCompletou and _buildSemSucesso
    and (FUltimoBuild = FUltimoFalhou);

  _buildAbortado := _buildCompletou and _buildSemSucesso
    and (FUltimoBuild <> FUltimoFalhou);

  _buildSucesso := _buildCompletou and (FUltimoBuild = FUltimoEstavel)
    or (FUltimoBuild = FUltimoSucesso);

  if _buildSucesso then
  begin
    FSituacaoBuild := sbSucesso;
    Exit;
  end;

  if _buildFalha then
  begin
    FSituacaoBuild := sbFalhou;
    Exit;
  end;

  if _buildAbortado then
  begin
    FSituacaoBuild := sbAbortado;
    Exit;
  end;

  if not _buildCompletou then
  begin
    FSituacaoBuild := sbProgresso;
    Exit;
  end;

  FSituacaoBuild := sbUnknow;
end;

function TBuildJSONDataAdapter.PegarNumeroDoBuild(const ABuild: TJSONObject): integer;
var
  _number: TJSONValue;
begin
  Result := -1;

  _number := ABuild.GetValue('number');
  if not TemValor(_number) then
    Exit;
  Result := _number.AsType<integer>;
end;

function TBuildJSONDataAdapter.GetBuildAtual: integer;
begin
  Result := FBuildZero;
end;

function TBuildJSONDataAdapter.GetBuilding: boolean;
begin
  Result := FSituacaoBuild = sbProgresso;
end;

function TBuildJSONDataAdapter.GetNome: string;
begin
  Result := FJSON.GetValue('displayName').Value;
end;

function TBuildJSONDataAdapter.GetSituacao: TSituacaoBuild;
begin
  Result := FSituacaoBuild;
end;

function TBuildJSONDataAdapter.GetUltimoBuildFalha: integer;
begin
  Result := FUltimoFalhou;
end;

function TBuildJSONDataAdapter.GetUltimoBuildSucesso: integer;
begin
  Result := FUltimoSucesso;
end;

function TBuildJSONDataAdapter.GetURL: string;
begin
  Result := FJSON.GetValue('url').Value;
end;

function TBuildJSONDataAdapter.GetURLUltimoBuild: IURL;
begin
  Result := FURLUltimoBuild;
end;

end.
