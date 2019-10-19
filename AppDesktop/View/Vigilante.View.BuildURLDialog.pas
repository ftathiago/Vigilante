unit Vigilante.View.BuildURLDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vigilante.View.URLDialog,
  Vigilante.View.URLDialog.Impl;

type
  IBuildURLDialog = interface(IURLDialog)
    ['{F1EF9BC6-E9FC-4ACC-A974-4E7941CB7A54}']
  end;

  TBuildURLDialog = class(TURLDialogController, IBuildURLDialog)
  public
    procedure AfterConstruction; override;

  end;

implementation


{ TBuildURLDialog }

procedure TBuildURLDialog.AfterConstruction;
begin
  inherited;
  SetLabelURL('Informe a URL do Build');
  GetURLDialog.Caption := 'Build';
end;

end.
