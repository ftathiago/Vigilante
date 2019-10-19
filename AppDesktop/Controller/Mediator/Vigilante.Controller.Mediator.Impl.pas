unit Vigilante.Controller.Mediator.Impl;

interface

uses
  System.Generics.Collections, Module.ValueObject.URL,
  Vigilante.Controller.Base, Vigilante.Controller.Mediator;

type
  TControllerMediator = class(TInterfacedObject, IControllerMediator)
  private
    FControllers: TDictionary<TTipoController, IBaseController>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarController(const AController: IBaseController;
      const ATipoController: TTipoController);
    procedure AdicionarURL(const ATipoController: TTipoController;
      const AURL: IURL);
    procedure RemoverController(const ATipoController: TTipoController);
  end;

implementation

uses
  System.SysUtils;

constructor TControllerMediator.Create;
begin
  FControllers := TDictionary<TTipoController, IBaseController>.Create;
end;

destructor TControllerMediator.Destroy;
begin
  FControllers.Clear;
  FreeAndNil(FControllers);
  inherited;
end;

procedure TControllerMediator.AdicionarController(
  const AController: IBaseController; const ATipoController: TTipoController);
begin
  FControllers.AddOrSetValue(ATipoController, AController);
end;

procedure TControllerMediator.AdicionarURL(
  const ATipoController: TTipoController; const AURL: IURL);
begin
  FControllers.Items[ATipoController].AdicionarNovaURL(AURL);
end;

procedure TControllerMediator.RemoverController(
  const ATipoController: TTipoController);
begin
  FControllers.Remove(ATipoController);
end;

end.
