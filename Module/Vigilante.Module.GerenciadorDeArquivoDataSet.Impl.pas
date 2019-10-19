unit Vigilante.Module.GerenciadorDeArquivoDataSet.Impl;

interface

uses
  System.SysUtils, FireDac.Comp.Client, FireDac.Stan.StorageXML,
  Vigilante.Module.GerenciadorDeArquivoDataSet;

type
  TGerenciadorDeArquivoDataSet = class(TInterfacedObject, IGerenciadorDeArquivoDataSet)
  private
    FDataSet: TFDMemTable;
    function PodeCarregarDiretoDoArquivo(const ADataSetTemp: TFDMemTable): boolean;
    procedure CarregamentoAlternativo(
      const ADataSetTemp: TFDMemTable);
    function FormatarNomeDoArquivo(const ANomeArquivo: TFileName): TFileName;
    procedure MesclarComDataSet(const ADataSetTemp: TFDMemTable);
  public
    constructor Create(const ADataSet: TFDMemTable);
    function CarregarArquivo(const ANomeArquivo: TFileName): boolean;
    procedure SalvarArquivo(const ANomeArquivo: TFileName);
  end;

implementation

uses
  System.IOUtils, Data.DB, FireDac.Stan.Intf, FireDac.Comp.DataSet;

constructor TGerenciadorDeArquivoDataSet.Create(const ADataSet: TFDMemTable);
begin
  FDataSet := ADataSet;
end;

function TGerenciadorDeArquivoDataSet.CarregarArquivo(
  const ANomeArquivo: TFileName): boolean;
var
  _dataTemp: TFDMemTable;
  _nomeArquivo: TFileName;
begin
  Result := False;
  _nomeArquivo := FormatarNomeDoArquivo(ANomeArquivo);
  if not TFile.Exists(_nomeArquivo) then
    Exit;
  FDataSet.CreateDataSet;
  _dataTemp := TFDMemTable.Create(Nil);
  try
    _dataTemp.LoadFromFile(_nomeArquivo, sfXML);
    if PodeCarregarDiretoDoArquivo(_dataTemp) then
    begin
      FDataSet.LoadFromFile(_nomeArquivo, sfXML);
      Result := True;
      Exit;
    end;
    CarregamentoAlternativo(_dataTemp);
    Result := True;
  finally
    FreeAndNil(_dataTemp);
  end;
end;

function TGerenciadorDeArquivoDataSet.FormatarNomeDoArquivo(
  const ANomeArquivo: TFileName): TFileName;
const
  NOME_ARQUIVO = '%s\%s';
var
  _path: TFileName;
  _pathPreDefinido: boolean;
begin
  _pathPreDefinido := not ExtractFilePath(ANomeArquivo).Trim.IsEmpty;
  if _pathPreDefinido then
    Exit(ANomeArquivo);

  _path := ExtractFilePath(ParamStr(0));
  _path := ExcludeTrailingPathDelimiter(_path);
  Result := Format(NOME_ARQUIVO, [_path, ANomeArquivo]);
end;

function TGerenciadorDeArquivoDataSet.PodeCarregarDiretoDoArquivo(
  const ADataSetTemp: TFDMemTable): boolean;
var
  _campo: TField;
begin
  Result := False;
  if ADataSetTemp.FieldCount <> FDataSet.FieldCount then
    Exit;

  for _campo in FDataSet.Fields do
  begin
    if not Assigned(ADataSetTemp.FindField(_campo.FieldName)) then
      Exit;
  end;

  Result := True;
end;

procedure TGerenciadorDeArquivoDataSet.CarregamentoAlternativo(
  const ADataSetTemp: TFDMemTable);
begin
  ADataSetTemp.First;
  while not ADataSetTemp.Eof do
  begin
    MesclarComDataSet(ADataSetTemp);
    ADataSetTemp.Next;
  end;
end;

procedure TGerenciadorDeArquivoDataSet.MesclarComDataSet(
  const ADataSetTemp: TFDMemTable);
var
  _campo: TField;
begin
  FDataSet.Insert;
  for _campo in ADataSetTemp.Fields do
    FDataSet.FieldByName(_campo.FieldName).Value := _campo.Value;
  FDataSet.Post;
end;

procedure TGerenciadorDeArquivoDataSet.SalvarArquivo(
  const ANomeArquivo: TFileName);
var
  _nomeArquivo: string;
begin
  _nomeArquivo := FormatarNomeDoArquivo(ANomeArquivo);
  FDataSet.MergeChangeLog;
  FDataSet.SaveToFile(_nomeArquivo, sfXML);
end;

end.
