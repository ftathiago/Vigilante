program Vigilante;

uses
  Vcl.Forms,
  WinApi.Windows,
  Vcl.Themes,
  Vcl.Styles,
  Spring.Container,
  ContainerDI,
  ContainerDI.Base,
  ContainerDI.Base.Impl,
  Vigilante.Configuracao,
  Module.View.FormBase in 'View\Module.View.FormBase.pas' {FormBase},
  Module.DataSet.VigilanteBase in 'DataSet\Module.DataSet.VigilanteBase.pas',
  Vigilante.DataSet.Compilacao in 'Controller\DataSet\Vigilante.DataSet.Compilacao.pas',
  Vigilante.DataSet.Build in 'Controller\DataSet\Vigilante.DataSet.Build.pas',
  Vigilante.Configuracao.Impl in 'Configuracao\Vigilante.Configuracao.Impl.pas',
  Vigilante.Configuracao.Observer in 'Configuracao\Vigilante.Configuracao.Observer.pas',
  Vigilante.Configuracao.Observer.Impl in 'Configuracao\Vigilante.Configuracao.Observer.Impl.pas',
  Vigilante.Configuracao.View in 'View\Vigilante.Configuracao.View.pas',
  Vigilante.Controller.Base.Impl in 'Controller\Vigilante.Controller.Base.Impl.pas',
  Vigilante.Controller.Base in 'Controller\Vigilante.Controller.Base.pas',
  Vigilante.Controller.Mediator in 'Controller\Mediator\Vigilante.Controller.Mediator.pas',
  Vigilante.Controller.Mediator.Impl in 'Controller\Mediator\Vigilante.Controller.Mediator.Impl.pas',
  Vigilante.Controller.Compilacao in 'Controller\Vigilante.Controller.Compilacao.pas',
  Vigilante.Controller.Compilacao.Impl in 'Controller\Vigilante.Controller.Compilacao.Impl.pas',
  Vigilante.Controller.Build in 'Controller\Vigilante.Controller.Build.pas',
  Vigilante.Controller.Build.Impl in 'Controller\Vigilante.Controller.Build.Impl.pas',
  Vigilante.Controller.Configuracao in 'Controller\Vigilante.Controller.Configuracao.pas',
  Vigilante.Controller.Configuracao.Impl in 'Controller\Vigilante.Controller.Configuracao.Impl.pas',
  Vigilante.Compilacao.Observer.Impl in 'Controller\Vigilante.Compilacao.Observer.Impl.pas',
  Vigilante.Compilacao.Observer in 'Controller\Vigilante.Compilacao.Observer.pas',
  Vigilante.Build.Observer.Impl in 'Controller\Vigilante.Build.Observer.Impl.pas',
  Vigilante.Build.Observer in 'Controller\Vigilante.Build.Observer.pas',
  Vigilante.Build.DomainEvent.Impl in 'Controller\Vigilante.Build.DomainEvent.Impl.pas',
  Vigilante.Build.View in 'View\Vigilante.Build.View.pas' {frmBuildView: TFrame},
  Vigilante.Compilacao.DomainEvent.Impl in 'Controller\Vigilante.Compilacao.DomainEvent.Impl.pas',
  Vigilante.Compilacao.View in 'View\Vigilante.Compilacao.View.pas' {frmCompilacaoView: TFrame},
  Vigilante.frmPrincipal in 'View\Vigilante.frmPrincipal.pas' {frmPrincipal},
  Vigilante.View.BuildURLDialog in 'View\Vigilante.View.BuildURLDialog.pas',
  Vigilante.View.CompilacaoURLDialog in 'View\Vigilante.View.CompilacaoURLDialog.pas',
  Vigilante.View.Component.SituacaoBuild in 'View\Vigilante.View.Component.SituacaoBuild.pas' {frmSituacaoBuild: TFrame},
  Vigilante.View.URLDialog.Impl in 'View\Vigilante.View.URLDialog.Impl.pas' {URLDialog},
  Vigilante.View.URLDialog in 'View\Vigilante.View.URLDialog.pas',
  Vigilante.View.Base in 'View\Vigilante.View.Base.pas' {ViewBase: TFrame},
  Vigilante.Aplicacao.DI in 'DI\Vigilante.Aplicacao.DI.pas',
  Vigilante.Build.DI in 'DI\Vigilante.Build.DI.pas',
  Vigilante.Compilacao.DI in 'DI\Vigilante.Compilacao.DI.pas',
  Vigilante.Configuracao.DI in 'DI\Vigilante.Configuracao.DI.pas',
  Vigilante.Controller.DI in 'DI\Vigilante.Controller.DI.pas',
  Vigilante.Infra.DI in 'DI\Vigilante.Infra.DI.pas';

{$R *.res}


procedure DI;
begin
  DefinirContainerDI(TContainer.Create);
  TContainerDI.New
    .Adicionar(TAplicacaoDI.New)
    .Adicionar(TInfraDI.New)
    .Adicionar(TConfiguracaoDI.New)
    .Adicionar(TControllerDI.New)
    .Build;
end;

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := False;
  DI;
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.Title := 'Vigilante';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  CDI.Resolve<IConfiguracaoSubject>.Notificar(PegarConfiguracoes);
  Application.Run;

end.
