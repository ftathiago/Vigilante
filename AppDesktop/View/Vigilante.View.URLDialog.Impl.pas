unit Vigilante.View.URLDialog.Impl;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Module.View.FormBase, Vcl.StdCtrls,
  Vigilante.View.URLDialog, Module.ValueObject.URL;

type
  TURLDialog = class(TFormBase)
    edtURLInformada: TEdit;
    lblLabelURL: TLabel;
    btnOk: TButton;
    btnCancelar: TButton;
  protected
    function GetLabelURL: string;
    function GetURLInformada: string;
    procedure SetLabelURL(const Value: string);
    procedure SetURLInformada(const Value: string);
  public
    function Executar: boolean;
    property LabelURL: string read GetLabelURL write SetLabelURL;
    property URLInformada: string read GetURLInformada write SetURLInformada;
  end;

  TURLDialogController = class(TInterfacedObject, IURLDialog)
  private
    FURLDialog: TURLDialog;
    procedure DestruirFormInterno;
  protected
    procedure SetURLDialog(const URLDialog: TURLDialog);
    function GetURLDialog: TURLDialog;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Executar: boolean;
    function GetLabelURL: string;
    function GetURLInformada: IURL;
    procedure SetLabelURL(const Value: string);
    procedure SetURLInformada(const Value: IURL);
  end;

implementation

{$R *.dfm}


uses
  ContainerDI;

constructor TURLDialogController.Create;
begin
  SetURLDialog(TURLDialog.Create(nil));
end;

destructor TURLDialogController.Destroy;
begin
  DestruirFormInterno;
  inherited;
end;

procedure TURLDialogController.DestruirFormInterno;
begin
  FreeAndNil(FURLDialog);
end;

function TURLDialogController.Executar: boolean;
begin
  Result := GetURLDialog.ShowModal = mrOk;
end;

function TURLDialogController.GetLabelURL: string;
begin
  Result := FURLDialog.GetLabelURL;
end;

function TURLDialogController.GetURLDialog: TURLDialog;
begin
  Result := FURLDialog;
end;

function TURLDialogController.GetURLInformada: IURL;
begin
  Result := CDI.Resolve<IURL>([FURLDialog.GetURLInformada]);
end;

procedure TURLDialogController.SetLabelURL(const Value: string);
begin
  FURLDialog.SetLabelURL(Value);
end;

procedure TURLDialogController.SetURLDialog(const URLDialog: TURLDialog);
begin
  if Assigned(FURLDialog) then
    DestruirFormInterno;
  FURLDialog := URLDialog;
end;

procedure TURLDialogController.SetURLInformada(const Value: IURL);
begin
  FURLDialog.SetURLInformada(Value.AsString);
end;

{ TURLDialog }

function TURLDialog.Executar: boolean;
begin
  Result := ShowModal = mrOk;
end;

function TURLDialog.GetLabelURL: string;
begin
  Result := lblLabelURL.Caption;
end;

function TURLDialog.GetURLInformada: string;
begin
  Result := edtURLInformada.Text;
end;

procedure TURLDialog.SetLabelURL(const Value: string);
begin
  lblLabelURL.Caption := Value;
end;

procedure TURLDialog.SetURLInformada(const Value: string);
begin
  edtURLInformada.Text := Value;
end;

end.
