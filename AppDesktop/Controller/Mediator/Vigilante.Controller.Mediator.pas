unit Vigilante.Controller.Mediator;

interface

uses
  Vigilante.Controller.Base, Module.ValueObject.URL;

type
  TTipoController = (tcBuild, tcCompilacao);

  IControllerMediator = interface(IInterface)
    ['{5853E4AA-2002-4A65-8452-B2F40693FD02}']
    procedure AdicionarController(const AController: IBaseController;
      const ATipoController: TTipoController);
    procedure RemoverController(const ATipoController: TTipoController);
    procedure AdicionarURL(const ATipoController: TTipoController;
      const AURL: IURL);
  end;

implementation

end.
