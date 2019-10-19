unit Vigilante.Infra.Compilacao.Builder.Impl;

interface

uses
  Vigilante.Infra.Compilacao.Builder, Vigilante.Compilacao.Model, System.JSON,
  Vigilante.Infra.Compilacao.JSONDataAdapter;

type
  TCompilacaoBuilder = class(TInterfacedObject, ICompilacaoBuilder)
  private
    FJSON: TJSONObject;
  public
    constructor Create(const AJson: TJSONObject);
    function PegarCompilacao: ICompilacaoModel;
  end;

implementation

uses
  Vigilante.Compilacao.Model.Impl, Vigilante.Infra.Compilacao.DataAdapter, Module.ValueObject.URL,
  Module.ValueObject.URL.Impl;

constructor TCompilacaoBuilder.Create(const AJson: TJSONObject);
begin
  FJSON := AJson;
end;

function TCompilacaoBuilder.PegarCompilacao: ICompilacaoModel;
var
  _compilacao: ICompilacaoModel;
  _adapter: ICompilacaoAdapter;
begin
  _adapter := TCompilacaoJSONDataAdapter.Create(FJSON);

  _compilacao := TCompilacaoModel.Create(_adapter.Numero, _adapter.Nome,
    TURL.Create(_adapter.URL), _adapter.Situacao, _adapter.Building, _adapter.ChangesSet);

  Result := _compilacao;
end;

end.
