object Form1: TForm1
  Left = 454
  Top = 284
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 519
  ClientWidth = 501
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  DesignSize = (
    501
    519)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 500
    Height = 500
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 500
    Width = 501
    Height = 19
    Panels = <
      item
        Bevel = pbNone
        Text = #1057#1095#1105#1090':'
        Width = 30
      end
      item
        Bevel = pbNone
        Text = '0'
        Width = 100
      end
      item
        Bevel = pbNone
        Text = #1057#1082#1086#1088#1086#1089#1090#1100':'
        Width = 60
      end
      item
        Bevel = pbNone
        Text = '0'
        Width = 50
      end
      item
        Bevel = pbNone
        Text = #1059#1088#1086#1074#1077#1085#1100':'
        Width = 55
      end
      item
        Bevel = pbNone
        Text = '0'
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 2
    Width = 505
    Height = 503
    Anchors = []
    BevelOuter = bvNone
    TabOrder = 1
    object lblScreenMessage: TLabel
      Left = 0
      Top = 176
      Width = 489
      Height = 109
      Alignment = taCenter
      AutoSize = False
      Caption = #1059#1088#1086#1074#1077#1085#1100' 1'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Button1: TButton
      Left = 208
      Top = 291
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object MainMenu1: TMainMenu
    object N1: TMenuItem
      Caption = #1048#1075#1088#1072
      object N2: TMenuItem
        Caption = #1053#1086#1074#1072#1103' '#1080#1075#1088#1072
        Hint = 'F2'
        ShortCut = 113
        OnClick = N2Click
      end
      object N4: TMenuItem
        Caption = #1055#1072#1091#1079#1072
        Hint = 'P, Pause'
      end
      object N3: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = N3Click
      end
    end
    object N5: TMenuItem
      Caption = #1056#1077#1082#1086#1088#1076#1099
      OnClick = N5Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 32
  end
  object adotblPlayers: TADOTable
    Connection = ADOConnection1
    TableName = 'Players'
    Left = 64
    object adotblPlayersplayer_id: TAutoIncField
      FieldName = 'player_id'
      ReadOnly = True
    end
    object adotblPlayerslogin: TWideStringField
      FieldName = 'login'
      Size = 255
    end
    object adotblPlayerspassword: TWideStringField
      FieldName = 'password'
      Size = 255
    end
    object adotblPlayerslevel: TIntegerField
      FieldName = 'level'
    end
    object adotblPlayersscore: TIntegerField
      FieldName = 'score'
    end
    object adotblPlayersspeed: TIntegerField
      FieldName = 'speed'
    end
    object adotblPlayersdate_last: TDateTimeField
      FieldName = 'date_last'
    end
    object adotblPlayerstime_last: TDateTimeField
      FieldName = 'time_last'
    end
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=SnkDB.mdb;Persist S' +
      'ecurity Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 96
  end
  object adotblLevels: TADOTable
    Connection = ADOConnection1
    TableName = 'Levels'
    Left = 64
    Top = 32
    object adotblLevelslevel_id: TAutoIncField
      FieldName = 'level_id'
      ReadOnly = True
    end
    object adotblLevelsstart_speed: TSmallintField
      FieldName = 'start_speed'
    end
    object adotblLevelsstart_length: TIntegerField
      FieldName = 'start_length'
    end
    object adotblLevelsend_length: TIntegerField
      FieldName = 'end_length'
    end
    object adotblLevelspole_id: TIntegerField
      FieldName = 'pole_id'
    end
    object adotblLevelsspeedup_interval: TIntegerField
      FieldName = 'speedup_interval'
    end
  end
  object TimerSpeedUp: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TimerSpeedUpTimer
    Left = 32
    Top = 32
  end
  object adotblPoles: TADOTable
    Connection = ADOConnection1
    CursorType = ctDynamic
    IndexFieldNames = 'pole_id'
    TableName = 'Poles'
    Left = 64
    Top = 64
    object adotblPolescell_id: TAutoIncField
      FieldName = 'cell_id'
      ReadOnly = True
    end
    object adotblPolespole_id: TIntegerField
      FieldName = 'pole_id'
    end
    object adotblPolesX: TWordField
      FieldName = 'X'
    end
    object adotblPolesY: TWordField
      FieldName = 'Y'
    end
    object adotblPolestype: TWordField
      FieldName = 'type'
    end
  end
  object adotblChampions: TADOTable
    Connection = ADOConnection1
    TableName = 'Champions'
    Left = 64
    Top = 96
    object adotblChampionslogin: TWideStringField
      FieldName = 'login'
      Size = 255
    end
    object adotblChampionspassword: TWideStringField
      FieldName = 'password'
      Size = 255
    end
    object adotblChampionslevel: TWordField
      FieldName = 'level'
    end
    object adotblChampionsscore: TIntegerField
      FieldName = 'score'
    end
    object adotblChampionsrecord_date: TDateTimeField
      FieldName = 'record_date'
    end
    object adotblChampionsrecord_time: TDateTimeField
      FieldName = 'record_time'
    end
  end
end
