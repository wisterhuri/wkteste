object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'TesteWK - Pedidos'
  ClientHeight = 417
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 450
    Height = 88
    Align = alTop
    Caption = 'Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 449
    object Label2: TLabel
      Left = 11
      Top = 15
      Width = 38
      Height = 15
      Caption = 'C'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 64
      Top = 15
      Width = 34
      Height = 15
      Caption = 'Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbxCliente: TComboBox
      Left = 64
      Top = 32
      Width = 369
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object edtCodigoCliente: TEdit
      Left = 10
      Top = 32
      Width = 48
      Height = 22
      TabOrder = 0
      OnChange = edtCodigoClienteChange
      OnExit = edtCodigoClienteExit
      OnKeyPress = edtCodigoClienteKeyPress
    end
    object btnCarregar: TButton
      Left = 11
      Top = 58
      Width = 110
      Height = 25
      Caption = 'Carregar Pedido'
      TabOrder = 2
      OnClick = btnCarregarClick
    end
    object btnCancelar: TButton
      Left = 127
      Top = 58
      Width = 110
      Height = 25
      Caption = 'Cancelar Pedido'
      TabOrder = 3
      OnClick = btnCancelarClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 88
    Width = 450
    Height = 125
    Align = alTop
    Caption = 'Produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 96
    ExplicitWidth = 449
    object Label1: TLabel
      Left = 9
      Top = 24
      Width = 38
      Height = 15
      Caption = 'C'#243'digo'
    end
    object lblDescricaoProduto: TLabel
      Left = 61
      Top = 45
      Width = 370
      Height = 15
      AutoSize = False
    end
    object Label3: TLabel
      Left = 9
      Top = 64
      Width = 21
      Height = 15
      Caption = 'Qtd'
    end
    object Label4: TLabel
      Left = 54
      Top = 64
      Width = 28
      Height = 15
      Caption = 'Valor'
    end
    object Bevel1: TBevel
      Left = 53
      Top = 42
      Width = 379
      Height = 23
    end
    object edtCodigoProduto: TEdit
      Left = 9
      Top = 42
      Width = 39
      Height = 23
      TabOrder = 0
      OnExit = edtCodigoProdutoExit
    end
    object edtQuantidade: TEdit
      Left = 9
      Top = 82
      Width = 39
      Height = 23
      TabOrder = 2
    end
    object edtValor: TEdit
      Left = 54
      Top = 82
      Width = 83
      Height = 23
      TabOrder = 3
    end
    object Button1: TButton
      Left = 356
      Top = 89
      Width = 75
      Height = 25
      Caption = '&Inserir'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 213
    Width = 450
    Height = 141
    Align = alTop
    DataSource = dsProdutos
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo'
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Title.Caption = 'Descri'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Width = 168
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'quantidade'
        Title.Caption = 'Qtd.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vlr_unitario'
        Title.Caption = 'Vlr. Unit'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vlr_total'
        Title.Caption = 'Vlr. Total'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Visible = True
      end>
  end
  object Button2: TButton
    Left = 182
    Top = 360
    Width = 89
    Height = 31
    Caption = 'Gravar Pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 398
    Width = 450
    Height = 19
    Panels = <
      item
        Text = 'Valor total do pedido R$ 0,00'
        Width = 50
      end>
    ExplicitTop = 413
    ExplicitWidth = 469
  end
  object cdsProdutos: TClientDataSet
    PersistDataPacket.Data = {
      810000009619E0BD010000001800000005000000000003000000810006636F64
      69676F04000100000000000944657363726963616F0100490000000100055749
      4454480200020064000A7175616E74696461646504000100000000000C766C72
      5F756E69746172696F080004000000000009766C725F746F74616C0800040000
      0000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 88
    object cdsProdutoscodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cdsProdutosDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object cdsProdutosquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object cdsProdutosvlr_unitario: TFloatField
      FieldName = 'vlr_unitario'
      currency = True
    end
    object cdsProdutosvlr_total: TFloatField
      FieldName = 'vlr_total'
      currency = True
    end
  end
  object dsProdutos: TDataSource
    AutoEdit = False
    DataSet = cdsProdutos
    Left = 400
    Top = 88
  end
end
