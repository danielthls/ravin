object frmUsuariosTeste: TfrmUsuariosTeste
  Left = 0
  Top = 0
  Caption = 'frmUsuariosTeste'
  ClientHeight = 515
  ClientWidth = 661
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MMUsuarios: TMemo
    Left = 8
    Top = 16
    Width = 645
    Height = 337
    TabOrder = 0
  end
  object BTNListarUsuario: TButton
    Left = 296
    Top = 416
    Width = 97
    Height = 25
    Caption = 'Listar Usuario'
    TabOrder = 1
    OnClick = BTNListarUsuarioClick
  end
end
