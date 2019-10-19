unit Vigilante.Configuracao.Impl;

interface

uses
  System.SysUtils, Vigilante.Configuracao;

type
{$M+}
  TConfiguracao = class(TInterfacedObject, IConfiguracao)
  private
    FSimularBuild: boolean;
    FAtualizacoesAutomaticas: boolean;
    FAtualizacoesIntervalo: integer;
    function GetSimularBuild: boolean;
    function GetAtualizacoesAutomaticas: boolean;
    function GetAtualizacoesIntervalo: integer;
    procedure SetSimularBuild(const Value: boolean);
    procedure SetAtualizacoesAutomaticas(const Value: boolean);
    procedure SetAtualizacoesIntervalo(const Value: integer);
    function PegarPathArquivo: TFileName;
  public
    class function New: IConfiguracao;
    constructor Create;
    destructor Destroy; override;
    procedure CarregarConfiguracoes;
    procedure PersistirConfiguracoes;
  end;

implementation

uses
  System.IniFiles, Vigilante.Configuracao.Observer, ContainerDI;

const
  ARQUIVO_CONFIG = 'CONFIG.INI';

constructor TConfiguracao.Create;
begin
  CarregarConfiguracoes;
end;

destructor TConfiguracao.Destroy;
begin
  PersistirConfiguracoes;
  inherited;
end;

function TConfiguracao.GetAtualizacoesAutomaticas: boolean;
begin
  Result := FAtualizacoesAutomaticas and (FAtualizacoesIntervalo > 0);
end;

function TConfiguracao.GetAtualizacoesIntervalo: integer;
begin
  Result := FAtualizacoesIntervalo;
end;

function TConfiguracao.GetSimularBuild: boolean;
begin
  Result := FSimularBuild;
end;

class function TConfiguracao.New: IConfiguracao;
begin
  Result := Create;
end;

procedure TConfiguracao.CarregarConfiguracoes;
var
  _ini: TIniFile;
begin
  _ini := TIniFile.Create(PegarPathArquivo);
  try
    FSimularBuild := _ini.ReadBool('DADOS', 'SIMULADO', True);
    FAtualizacoesAutomaticas := _ini.ReadBool('ATUALIZACOES', 'LIGADO', True);
    FAtualizacoesIntervalo := _ini.ReadInteger('ATUALIZACOES', 'INTERVALO', 15000);
  finally
    _ini.Free;
  end;
end;

function TConfiguracao.PegarPathArquivo: TFileName;
var
  _caminho: TFileName;
begin
  _caminho := ExtractFilePath(ParamStr(0));
  _caminho := IncludeTrailingPathDelimiter(_caminho);
  Result := _caminho + '\' + ARQUIVO_CONFIG;
end;

procedure TConfiguracao.PersistirConfiguracoes;
var
  _ini: TIniFile;
begin
  _ini := TIniFile.Create(PegarPathArquivo);
  try
    _ini.WriteBool('DADOS', 'SIMULADO', FSimularBuild);
    _ini.WriteBool('ATUALIZACOES', 'LIGADO', FAtualizacoesAutomaticas);
    _ini.WriteInteger('ATUALIZACOES', 'INTERVALO', FAtualizacoesIntervalo);
  finally
    _ini.Free;
  end;
  CDI.Resolve<IConfiguracaoSubject>.Notificar(Self);
end;

procedure TConfiguracao.SetAtualizacoesAutomaticas(const Value: boolean);
begin
  FAtualizacoesAutomaticas := Value;
end;

procedure TConfiguracao.SetAtualizacoesIntervalo(const Value: integer);
begin
  FAtualizacoesIntervalo := Value;
end;

procedure TConfiguracao.SetSimularBuild(const Value: boolean);
begin
  FSimularBuild := Value;
end;

initialization

DefinirConfiguracoes(TConfiguracao.New);

end.
