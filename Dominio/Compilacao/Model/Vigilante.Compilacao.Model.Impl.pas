unit Vigilante.Compilacao.Model.Impl;

interface

uses
  System.Generics.Collections, Model.Base.Impl, Vigilante.Aplicacao.SituacaoBuild,
  Vigilante.ChangeSetItem.Model, Module.ValueObject.URL, Vigilante.Compilacao.Model;

type
  TCompilacaoModel = class(TModelBase, ICompilacaoModel)
  private
    FNumero: integer;
    FChangeSet: TObjectList<TChangeSetItem>;
    FSituacao: TSituacaoBuild;
    FURL: IURL;
    FBuilding: boolean;
    FNome: string;
  protected
    function GetChangeSet: TObjectList<TChangeSetItem>;
    function GetNome: string;
    function GetNumero: integer;
    function GetSituacao: TSituacaoBuild;
    function GetURL: string;
    function GetBuilding: boolean;
  public
    constructor Create(const ANumero: integer; const ANome: string;
      const AURL: IURL; const ASituacao: TSituacaoBuild;
      const ABuilding: boolean; const AChangeSet: TArray<TChangeSetItem>);
    destructor Destroy; override;
    function Equals(const ACompilacaoModel: ICompilacaoModel): boolean; reintroduce;
  end;

implementation

uses
  System.SysUtils, System.StrUtils;

constructor TCompilacaoModel.Create(const ANumero: integer; const ANome: string;
  const AURL: IURL; const ASituacao: TSituacaoBuild; 
  const ABuilding: boolean; const AChangeSet: TArray<TChangeSetItem>);
var
  i: integer;
begin
  inherited Create;
  FChangeSet := TObjectList<TChangeSetItem>.Create;
  FNumero := ANumero;
  FNome := ANome;
  FURL := AURL;
  FSituacao := ASituacao;
  FBuilding := ABuilding;
  if not Assigned(AChangeSet) then
    Exit;
  for i := 0 to Length(AChangeSet) - 1 do
    FChangeSet.Add(AChangeSet[i]);
end;

destructor TCompilacaoModel.Destroy;
begin
  FreeAndNil(FChangeSet);  
  inherited;
end;

function TCompilacaoModel.Equals(
  const ACompilacaoModel: ICompilacaoModel): boolean;
begin
  Result := false;

  if not ACompilacaoModel.Numero = Self.FNumero then
    Exit;

  if not ACompilacaoModel.Nome.Equals(Self.FNome) then
    Exit;
  if not ACompilacaoModel.URL.Equals(Self.FURL.AsString) then
    Exit;
  if not ACompilacaoModel.Situacao.Equals(Self.FSituacao) then
    Exit;
  if not ACompilacaoModel.Building = Self.FBuilding then
    Exit;

  if not ACompilacaoModel.Id.ToString.Equals(GetId.ToString) then
    Exit;

  Result := True;
end;

function TCompilacaoModel.GetChangeSet: TObjectList<TChangeSetItem>;
begin
  Result := FChangeSet;
end;

function TCompilacaoModel.GetNome: string;
begin
  Result := FNome;
end;

function TCompilacaoModel.GetNumero: integer;
begin
  Result := FNumero;
end;

function TCompilacaoModel.GetSituacao: TSituacaoBuild;
begin
  Result := FSituacao;
end;

function TCompilacaoModel.GetURL: string;
begin
  Result := FURL.AsString;
end;

function TCompilacaoModel.GetBuilding: boolean;
begin
  Result := FBuilding;
end;

end.
