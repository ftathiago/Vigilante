inherited frmPrincipal: TfrmPrincipal
  Caption = 'Vigilante'
  ClientHeight = 666
  ClientWidth = 1077
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 1093
  ExplicitHeight = 705
  PixelsPerInch = 96
  TextHeight = 21
  object pgcVisualizacoes: TPageControl
    Left = 0
    Top = 25
    Width = 1077
    Height = 641
    ActivePage = tbsBuild
    Align = alClient
    TabOrder = 0
    object tbsBuild: TTabSheet
      Caption = 'Build'
    end
    object tbsCompilacao: TTabSheet
      Caption = 'Compila'#231#227'o'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object tbsConfiguracoes: TTabSheet
      Caption = 'Configura'#231#245'es'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 1077
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Caption = 'pnlTopo'
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      1077
      25)
    object lblUltimaAtualizacao: TLabel
      Left = 696
      Top = 2
      Width = 282
      Height = 21
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = #218'ltima atualiza'#231#227'o: 00/00/0000 00:00:00'
    end
    object chkAtualizacaoAutomatica: TToggleSwitch
      Left = 984
      Top = 3
      Width = 78
      Height = 23
      Anchors = [akRight, akBottom]
      State = tssOn
      TabOrder = 0
      OnClick = chkAtualizacaoAutomaticaClick
    end
  end
  object TrayIcon: TTrayIcon
    PopupMenu = PopupMenu1
    Visible = True
    OnDblClick = TrayIconDblClick
    Left = 968
    Top = 320
  end
  object PopupMenu1: TPopupMenu
    Left = 896
    Top = 320
    object VigiarLink1: TMenuItem
      Action = actVigiarCompilacao
    end
    object VigiarBuild1: TMenuItem
      Action = actVigiarBuild
    end
  end
  object ActionList1: TActionList
    Left = 824
    Top = 320
    object actVigiarCompilacao: TAction
      Caption = 'Vigiar compila'#231#227'o...'
      OnExecute = actVigiarCompilacaoExecute
    end
    object actVigiarBuild: TAction
      Caption = 'Vigiar build...'
      OnExecute = actVigiarBuildExecute
    end
  end
  object NotificationCenter: TNotificationCenter
    OnReceiveLocalNotification = NotificationCenterReceiveLocalNotification
    Left = 640
    Top = 320
  end
  object ApplicationEvents: TApplicationEvents
    OnMinimize = ApplicationEventsMinimize
    OnRestore = ApplicationEventsRestore
    Left = 736
    Top = 320
  end
  object tmrBuscarAtualizacoes: TTimer
    Interval = 15000
    OnTimer = tmrBuscarAtualizacoesTimer
    Left = 528
    Top = 320
  end
end
