inherited frmConfiguracaoView: TfrmConfiguracaoView
  Width = 773
  Height = 609
  ExplicitWidth = 773
  ExplicitHeight = 609
  object Button1: TButton
    Left = 156
    Top = 208
    Width = 149
    Height = 49
    Caption = 'Gravar altera'#231#245'es'
    TabOrder = 2
    OnClick = Button1Click
  end
  object gpbAtualizacoesAutomaticas: TGroupBox
    Left = 27
    Top = 105
    Width = 278
    Height = 97
    Caption = ' Atualiza'#231#245'es autom'#225'ticas '
    TabOrder = 1
    object Label2: TLabel
      Left = -13
      Top = 58
      Width = 174
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Intervalo atualiza'#231#245'es:'
      WordWrap = True
    end
    object Label3: TLabel
      Left = 223
      Top = 58
      Width = 31
      Height = 21
      Alignment = taRightJustify
      Caption = 'segs'
      WordWrap = True
    end
    object chkAtualizacaoAutomatica: TToggleSwitch
      Left = 11
      Top = 29
      Width = 125
      Height = 23
      StateCaptions.CaptionOn = 'Ligado'
      StateCaptions.CaptionOff = 'Desligado'
      TabOrder = 0
    end
    object edtAtualizacaoIntervalo: TEdit
      Left = 167
      Top = 55
      Width = 50
      Height = 29
      BiDiMode = bdLeftToRight
      NumbersOnly = True
      ParentBiDiMode = False
      TabOrder = 1
      OnClick = edtAtualizacaoIntervaloClick
    end
  end
  object gpbOrigemDosDados: TGroupBox
    Left = 27
    Top = 9
    Width = 278
    Height = 90
    Caption = ' Origem dos dados '
    TabOrder = 0
    object chkSimulado: TToggleSwitch
      Left = 11
      Top = 40
      Width = 177
      Height = 23
      StateCaptions.CaptionOn = 'Dados simulados'
      StateCaptions.CaptionOff = 'Dados do Jenkins'
      TabOrder = 0
    end
  end
end
