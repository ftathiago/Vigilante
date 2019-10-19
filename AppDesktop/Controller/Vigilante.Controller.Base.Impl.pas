unit Vigilante.Controller.Base.Impl;

interface

uses
  Vigilante.Controller.Base, Module.ValueObject.URL, Module.DataSet.VigilanteBase,
  Vigilante.Aplicacao.ModelBase;

type
  TControllerBase<T: IVigilanteModelBase> = class abstract(TInterfacedObject, IBaseController)
  protected
    function GetDataSetInterno: TVigilanteDataSetBase<T>; virtual; abstract;
  public
    procedure AdicionarNovaURL(const AURL: IURL); virtual;
    procedure BuscarAtualizacoes; virtual; abstract;
    function PodeNotificarUsuario(const AID: TGUID): boolean; virtual;
    procedure VisualizadoPeloUsuario(const AID: TGUID); virtual;
  end;

implementation

uses
  Data.DB;

{ TControllerBase }

procedure TControllerBase<T>.AdicionarNovaURL(const AURL: IURL);
begin
  if GetDataSetInterno.State in dsEditModes then
    GetDataSetInterno.Cancel;
  GetDataSetInterno.Insert;
  GetDataSetInterno.URL := AURL.AsString;
  GetDataSetInterno.Post;
end;

function TControllerBase<T>.PodeNotificarUsuario(const AID: TGUID): boolean;
begin
  Result := False;
  if GetDataSetInterno.LocalizarPorID(AID) then
    Result := GetDataSetInterno.Notificar;
end;

procedure TControllerBase<T>.VisualizadoPeloUsuario(const AID: TGUID);
begin
  if not GetDataSetInterno.LocalizarPorID(AID) then
    Exit;
  GetDataSetInterno.Edit;
  GetDataSetInterno.Notificar := False;
  GetDataSetInterno.Post;
end;

end.
