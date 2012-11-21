object fmLogin: TfmLogin
  Left = 376
  Top = 189
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'fmLogin'
  ClientHeight = 152
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 48
    Top = 8
    Width = 177
    Height = 105
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
    TabOrder = 0
    object leLogin: TLabeledEdit
      Left = 8
      Top = 32
      Width = 161
      Height = 21
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = #1051#1086#1075#1080#1085
      TabOrder = 0
    end
    object lePassword: TLabeledEdit
      Left = 8
      Top = 72
      Width = 161
      Height = 21
      EditLabel.Width = 38
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1072#1088#1086#1083#1100
      TabOrder = 1
    end
  end
  object BitBtn1: TBitBtn
    Left = 144
    Top = 120
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 56
    Top = 120
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
end
