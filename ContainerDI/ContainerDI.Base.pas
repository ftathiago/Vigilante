unit ContainerDI.Base;

interface

type
  IContainerDI = interface(IInterface)
    ['{F712F258-BB13-4C68-BBFE-E73CB3B262FE}']
    function Adicionar(const ADIConfig: IContainerDI): IContainerDI;
    procedure Build;
  end;

implementation

end.

