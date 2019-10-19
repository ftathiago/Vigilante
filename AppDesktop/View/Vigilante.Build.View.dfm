object frmBuildView: TfrmBuildView
  Left = 0
  Top = 0
  Width = 985
  Height = 582
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Bevel1: TBevel
    Left = 0
    Top = 113
    Width = 985
    Height = 16
    Align = alTop
    Shape = bsSpacer
  end
  object pnlCliente: TPanel
    Left = 320
    Top = 129
    Width = 665
    Height = 333
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlCliente'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      665
      333)
    object BuildAtualLabel: TLabel
      Left = 14
      Top = 6
      Width = 91
      Height = 25
      Caption = 'Build atual'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object TDBText
      Left = 32
      Top = 30
      Width = 5
      Height = 25
      AutoSize = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 14
      Top = 70
      Width = 150
      Height = 17
      Caption = #218'ltimo build com sucesso'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object UltimoBuildSucesso: TDBText
      Left = 32
      Top = 86
      Width = 166
      Height = 25
      AutoSize = True
      DataField = 'UltimoBuildSucesso'
      DataSource = dtsDataSet
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 14
      Top = 126
      Width = 132
      Height = 17
      Caption = #218'ltimo build com falha'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object UltimoBuildFalha: TDBText
      Left = 32
      Top = 142
      Width = 143
      Height = 25
      AutoSize = True
      DataField = 'UltimoBuildFalha'
      DataSource = dtsDataSet
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblTransformarEmCompilacao: TLinkLabel
      Left = 32
      Top = 33
      Width = 165
      Height = 25
      Caption = '<a href="#">Enviar para compila'#231#227'o</a>'
      TabOrder = 3
      OnLinkClick = lblTransformarEmCompilacaoLinkClick
    end
    object DBCheckBox1: TDBCheckBox
      Left = 344
      Top = 67
      Width = 129
      Height = 17
      Caption = 'Atualizar build'
      DataField = 'Atualizar'
      DataSource = dtsDataSet
      TabOrder = 0
    end
    object DBCheckBox2: TDBCheckBox
      Left = 344
      Top = 85
      Width = 129
      Height = 17
      Caption = 'Notificar'
      DataField = 'Notificar'
      DataSource = dtsDataSet
      TabOrder = 1
    end
    object DBNavigator1: TDBNavigator
      Left = 344
      Top = 6
      Width = 282
      Height = 49
      DataSource = dtsDataSet
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete]
      Anchors = [akTop, akRight]
      TabOrder = 2
      OnClick = DBNavigator1Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 129
    Width = 320
    Height = 333
    Align = alLeft
    Color = 9424741
    DataSource = dtsDataSet
    Options = [dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'Nome'
        Width = 235
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BuildAtual'
        Width = 50
        Visible = True
      end>
  end
  inline frmSituacaoBuild1: TfrmSituacaoBuild
    Left = 0
    Top = 0
    Width = 985
    Height = 113
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 985
    inherited lblDescricao: TDBText
      Width = 848
      ExplicitWidth = 245
    end
    inherited pnlImagem: TPanel
      inherited imgProgresso: TActivityIndicator
        ExplicitWidth = 64
        ExplicitHeight = 64
      end
    end
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 462
    Width = 985
    Height = 120
    Align = alBottom
    DataSource = dtsDataSet
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -16
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Visible = False
  end
  object dtsDataSet: TDataSource
    OnDataChange = dtsDataSetDataChange
    Left = 656
    Top = 320
  end
  object ActionList1: TActionList
    Left = 472
    Top = 376
    object actMostrardados: TAction
      Caption = 'Mostrar dados'
      ShortCut = 49220
      OnExecute = actMostrardadosExecute
    end
  end
end
