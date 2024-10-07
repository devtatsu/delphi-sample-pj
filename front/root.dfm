object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Button1: TButton
    Left = 280
    Top = 232
    Width = 75
    Height = 25
    Caption = #23455#34892
    TabOrder = 0
    OnClick = Button1Click
  end
  object FDConnection1: TFDConnection
    Left = 8
    Top = 24
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 88
    Top = 24
  end
end
