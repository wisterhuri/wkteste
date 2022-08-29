object DM_Principal: TDM_Principal
  OnCreate = DataModuleCreate
  Height = 160
  Width = 303
  PixelsPerInch = 96
  object FDBanco: TFDConnection
    Params.Strings = (
      'Server=127.0.0.1'
      'Password=root123'
      'Database=wkteste'
      'User_Name=root'
      'CharacterSet=utf8'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 136
    Top = 24
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Gestor\libmySQL.dll'
    Left = 136
    Top = 88
  end
  object FDAux: TFDQuery
    Connection = FDBanco
    Left = 216
    Top = 24
  end
end
