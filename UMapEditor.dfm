object Form1: TForm1
  Left = 196
  Top = 119
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 540
  ClientWidth = 664
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object leLevel: TLabeledEdit
    Left = 16
    Top = 24
    Width = 106
    Height = 21
    EditLabel.Width = 44
    EditLabel.Height = 13
    EditLabel.Caption = #1059#1088#1086#1074#1077#1085#1100
    TabOrder = 0
    Text = '1'
  end
  object lePoleID: TLabeledEdit
    Left = 16
    Top = 100
    Width = 106
    Height = 21
    EditLabel.Width = 68
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099
    TabOrder = 1
    Text = '1'
  end
  object leStartSpeed: TLabeledEdit
    Left = 16
    Top = 140
    Width = 106
    Height = 21
    EditLabel.Width = 105
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1089#1082#1086#1088#1086#1089#1090#1100
    TabOrder = 2
    Text = '1'
  end
  object leStartLength: TLabeledEdit
    Left = 16
    Top = 220
    Width = 106
    Height = 21
    EditLabel.Width = 117
    EditLabel.Height = 13
    EditLabel.Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1083#1080#1085#1072' '#1079#1084#1077#1080
    TabOrder = 3
    Text = '3'
  end
  object leEndLength: TLabeledEdit
    Left = 16
    Top = 260
    Width = 106
    Height = 21
    EditLabel.Width = 110
    EditLabel.Height = 13
    EditLabel.Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1083#1080#1085#1072' '#1079#1084#1077#1080
    TabOrder = 4
    Text = '5'
  end
  object leSpeedUpInterval: TLabeledEdit
    Left = 16
    Top = 180
    Width = 106
    Height = 21
    EditLabel.Width = 120
    EditLabel.Height = 13
    EditLabel.Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1091#1089#1082#1086#1088#1077#1085#1080#1081' ('#1089')'
    TabOrder = 5
    Text = '60'
  end
  object GroupBox1: TGroupBox
    Left = 144
    Top = 8
    Width = 513
    Height = 522
    Caption = #1048#1075#1088#1086#1074#1086#1077' '#1087#1086#1083#1077
    TabOrder = 6
    object pnl: TPanel
      Left = 6
      Top = 16
      Width = 500
      Height = 500
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 0
    end
  end
  object udLevel: TUpDown
    Left = 122
    Top = 24
    Width = 16
    Height = 21
    Associate = leLevel
    Min = 1
    Position = 1
    TabOrder = 7
  end
  object udPoleID: TUpDown
    Left = 122
    Top = 100
    Width = 16
    Height = 21
    Associate = lePoleID
    Min = 1
    Position = 1
    TabOrder = 8
  end
  object udStartSpeed: TUpDown
    Left = 122
    Top = 140
    Width = 16
    Height = 21
    Associate = leStartSpeed
    Min = 1
    Max = 18
    Position = 1
    TabOrder = 9
  end
  object udSpeedUpinterval: TUpDown
    Left = 122
    Top = 180
    Width = 16
    Height = 21
    Associate = leSpeedUpInterval
    Min = 1
    Max = 32767
    Position = 60
    TabOrder = 10
  end
  object udStartLength: TUpDown
    Left = 122
    Top = 220
    Width = 16
    Height = 21
    Associate = leStartLength
    Min = 3
    Max = 1000
    Position = 3
    TabOrder = 11
  end
  object udEndLength: TUpDown
    Left = 122
    Top = 260
    Width = 16
    Height = 21
    Associate = leEndLength
    Min = 4
    Max = 10000
    Position = 5
    TabOrder = 12
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 56
    Width = 121
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1091#1088#1086#1074#1077#1085#1100
    TabOrder = 13
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 16
    Top = 296
    Width = 121
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1091#1088#1086#1074#1077#1085#1100
    TabOrder = 14
    OnClick = BitBtn2Click
  end
  object Button1: TButton
    Left = 16
    Top = 504
    Width = 121
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1077
    TabOrder = 15
    OnClick = Button1Click
  end
  object adoConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=SnkDB.mdb;Persist S' +
      'ecurity Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 16
    Top = 328
  end
  object adotblLevels: TADOTable
    Connection = adoConnection
    TableName = 'Levels'
    Left = 48
    Top = 328
    object adotblLevelslevel_id: TAutoIncField
      FieldName = 'level_id'
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
  object adotblPoles: TADOTable
    Connection = adoConnection
    TableName = 'Poles'
    Left = 80
    Top = 328
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
end
