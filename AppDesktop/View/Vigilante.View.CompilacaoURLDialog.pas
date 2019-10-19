unit Vigilante.View.CompilacaoURLDialog;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vigilante.View.URLDialog,
  Vigilante.View.URLDialog.Impl;

type
  ICompilacaoURLDialog = interface(IURLDialog)
    ['{F1EF9BC6-E9FC-4ACC-A974-4E7941CB7A54}']
  end;

  TCompilacaoURLDialog = class(TURLDialogController, ICompilacaoURLDialog)
  public
    procedure AfterConstruction; override;

  end;

implementation


{ TCompilacaoURLDialog }

procedure TCompilacaoURLDialog.AfterConstruction;
begin
  inherited;
  SetLabelURL('Informe a URL do Compilacao');
  GetURLDialog.Caption := 'Compilacao';
end;

end.
