unit Vigilante.Aplicacao.SituacaoBuild;

interface

type
  TSituacaoBuild = (sbUnknow, sbProgresso, sbFalhouInfra, sbAbortado, sbFalhou,
    sbSucesso);
  TSituacaoBuildSet = set of TSituacaoBuild;

  TSituacaoHelper = record helper for TSituacaoBuild
    class function Parse(const AValue: string): TSituacaoBuild; overload;
      static; inline;
    class function Parse(const AValue: integer): TSituacaoBuild; overload;
      static; inline;
    function AsInteger: integer; inline;
    function AsString: string; inline;
    function Equals(const ASituacao: TSituacaoBuild): boolean; inline;
  end;

const
  SITUACOES_NOTIFICAVEIS: TSituacaoBuildSet = [sbSucesso, sbFalhou,
    sbFalhouInfra, sbAbortado];

implementation

uses
  System.SysUtils, System.TypInfo;

function TSituacaoHelper.AsInteger: integer;
begin
  result := Ord(Self);
end;

class function TSituacaoHelper.Parse(const AValue: string): TSituacaoBuild;
var
  _situacao: string;
begin
  _situacao := AValue.ToUpper;

  result := sbUnknow;

  if _situacao.Equals('SUCCESS') then
    Exit(sbSucesso);

  if _situacao.Equals('FAILURE') then
    Exit(sbFalhou);

  if _situacao.Equals('ABORTED') then
    Exit(sbAbortado);

end;

function TSituacaoHelper.AsString: string;
begin
  case Self of
    sbUnknow:
      result := 'Não informado';
    sbProgresso:
      result := 'Em progresso';
    sbFalhouInfra:
      result := 'Falha de infra';
    sbAbortado:
      result := 'Abortado';
    sbFalhou:
      result := 'Falhou';
    sbSucesso:
      result := 'Sucesso';
  end;
end;

function TSituacaoHelper.Equals(const ASituacao: TSituacaoBuild): boolean;
begin
  result := Self.AsInteger = ASituacao.AsInteger;
end;

class function TSituacaoHelper.Parse(const AValue: integer): TSituacaoBuild;
begin
  result := TSituacaoBuild(AValue);
end;

end.
