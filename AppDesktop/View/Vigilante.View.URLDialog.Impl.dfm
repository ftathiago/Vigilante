inherited URLDialog: TURLDialog
  ActiveControl = edtURLInformada
  BorderStyle = bsDialog
  Caption = 'Informe a URL'
  ClientHeight = 139
  ClientWidth = 560
  Position = poOwnerFormCenter
  ExplicitWidth = 566
  ExplicitHeight = 168
  PixelsPerInch = 96
  TextHeight = 21
  object lblLabelURL: TLabel
    Left = 24
    Top = 21
    Width = 100
    Height = 21
    Caption = 'Informe a URL'
  end
  object edtURLInformada: TEdit
    Left = 24
    Top = 48
    Width = 497
    Height = 29
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 400
    Top = 83
    Width = 121
    Height = 39
    Caption = '&Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancelar: TButton
    Left = 249
    Top = 83
    Width = 121
    Height = 39
    Caption = '&Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
end
