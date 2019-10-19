unit Vigilante.Compilacao.Service.Impl;

interface

uses
  System.StrUtils, System.JSON, System.SysUtils, Vigilante.Compilacao.Service,
  Vigilante.Compilacao.Model, Vigilante.Compilacao.Repositorio,
  Vigilante.Compilacao.Event;

type
  TCompilacaoService = class(TInterfacedObject, ICompilacaoService)
  private
    FCompilacaoEvent: ICompilacaoEvent;
    FCompilacaoRepositorio: ICompilacaoRepositorio;
    function TratarURL(const AURL: string): string;
    function PegarRepositorio: ICompilacaoRepositorio;
    procedure LancarEvento(const ACompilacaoModel: ICompilacaoModel);
  public
    constructor Create(const ACompilacaoRepositorio: ICompilacaoRepositorio;
      const ACompilacaoEvent: ICompilacaoEvent);
    function AtualizarCompilacao(const ACompilacaoModel: ICompilacaoModel)
      : ICompilacaoModel;
  end;

implementation

uses
  ContainerDI;

constructor TCompilacaoService.Create(const ACompilacaoRepositorio
  : ICompilacaoRepositorio; const ACompilacaoEvent: ICompilacaoEvent);
begin
  FCompilacaoRepositorio := ACompilacaoRepositorio;
  FCompilacaoEvent := ACompilacaoEvent;
end;

function TCompilacaoService.AtualizarCompilacao(const ACompilacaoModel
  : ICompilacaoModel): ICompilacaoModel;
var
  _repositorio: ICompilacaoRepositorio;
  _url: string;
  _novaCompilacao: ICompilacaoModel;
begin
  Result := nil;
  _repositorio := PegarRepositorio;
  _url := ACompilacaoModel.URL;
  _url := TratarURL(_url);
  _novaCompilacao := _repositorio.BuscarCompilacao(_url);

  if not Assigned(_novaCompilacao) then
    Exit;

  _novaCompilacao.DefinirID(ACompilacaoModel.Id);

  if not _novaCompilacao.Equals(ACompilacaoModel) then
    LancarEvento(_novaCompilacao);

  Result := _novaCompilacao;
end;

function TCompilacaoService.PegarRepositorio: ICompilacaoRepositorio;
begin
  Result := FCompilacaoRepositorio;
end;

procedure TCompilacaoService.LancarEvento(const ACompilacaoModel
  : ICompilacaoModel);
begin
  if not Assigned(FCompilacaoEvent) then
    Exit;
  FCompilacaoEvent.Notificar(ACompilacaoModel);
end;

function TCompilacaoService.TratarURL(const AURL: string): string;
begin
  Result := AURL;
  if not AURL.EndsWith('api/json', True) then
    Result := AURL + '/api/json';
end;

end.
