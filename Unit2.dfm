object plein_ecran: Tplein_ecran
  Left = 224
  Top = 210
  BorderIcons = [biHelp]
  BorderStyle = bsNone
  Caption = 'Plein '#233'cran'
  ClientHeight = 613
  ClientWidth = 862
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Image_plein_ecran: TImage
    Left = 0
    Top = 0
    Width = 862
    Height = 613
    Align = alClient
    Center = True
    Proportional = True
    OnClick = Image_plein_ecranClick
  end
end
