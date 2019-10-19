object frmCompilacaoView: TfrmCompilacaoView
  Left = 0
  Top = 0
  Width = 961
  Height = 469
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object pnlHeader: TPanel
    Left = 0
    Top = 113
    Width = 961
    Height = 64
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlHeader'
    ShowCaption = False
    TabOrder = 2
    DesignSize = (
      961
      64)
    object Label1: TLabel
      Left = 16
      Top = 37
      Width = 111
      Height = 21
      Caption = #218'lt. Atualiza'#231#227'o: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
    end
    object UltimaAtualizacao: TDBText
      Left = 128
      Top = 37
      Width = 119
      Height = 21
      AutoSize = True
      DataField = 'UltimaAtualizacao'
      DataSource = dtsBuild
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
    end
    object DBNavigator1: TDBNavigator
      Left = 656
      Top = 6
      Width = 282
      Height = 49
      DataSource = dtsBuild
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete]
      Anchors = [akTop, akRight]
      TabOrder = 0
      OnClick = DBNavigator1Click
    end
  end
  object pnlCliente: TPanel
    Left = 0
    Top = 177
    Width = 961
    Height = 292
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlCliente'
    ShowCaption = False
    TabOrder = 1
    object pgcView: TPageControl
      Left = 160
      Top = 0
      Width = 801
      Height = 292
      ActivePage = tbsArquivosModificados
      Align = alClient
      DoubleBuffered = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      OwnerDraw = True
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      object tbsArquivosModificados: TTabSheet
        Caption = 'Arquivos modificados'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 793
          Height = 256
          Align = alClient
          Caption = 'Panel2'
          TabOrder = 0
          object ChangeSet: TDBMemo
            Left = 1
            Top = 1
            Width = 791
            Height = 254
            Align = alClient
            DataField = 'ChangeSet'
            DataSource = dtsBuild
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
      object tbsDados: TTabSheet
        Caption = 'Visualizar dados'
        ImageIndex = 1
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DBGrid1: TDBGrid
          Left = 0
          Top = 0
          Width = 793
          Height = 256
          Align = alClient
          DataSource = dtsBuild
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -16
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
    end
    object dbgListaCompilacoes: TDBGrid
      Left = 0
      Top = 0
      Width = 160
      Height = 292
      Align = alLeft
      DataSource = dtsBuild
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -19
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDrawColumnCell = dbgListaCompilacoesDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Title.Caption = 'N'#250'mero'
          Width = 130
          Visible = True
        end>
    end
  end
  inline frmSituacaoBuild1: TfrmSituacaoBuild
    Left = 0
    Top = 0
    Width = 961
    Height = 113
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 961
    inherited lblDescricao: TDBText
      Width = 824
      ExplicitWidth = 824
    end
    inherited pnlImagem: TPanel
      inherited imgProgresso: TActivityIndicator
        ExplicitWidth = 64
        ExplicitHeight = 64
      end
    end
  end
  object dtsBuild: TDataSource
    Left = 744
    Top = 336
  end
  object ActionList1: TActionList
    Left = 552
    Top = 344
    object actMostrarDados: TAction
      Caption = 'mostrar dados'
      ShortCut = 49219
      OnExecute = actMostrarDadosExecute
    end
  end
end
