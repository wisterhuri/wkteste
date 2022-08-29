unit unPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Datasnap.DBClient, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    cbxCliente: TComboBox;
    GroupBox2: TGroupBox;
    edtCodigoProduto: TEdit;
    Label1: TLabel;
    lblDescricaoProduto: TLabel;
    Label3: TLabel;
    edtQuantidade: TEdit;
    edtValor: TEdit;
    Label4: TLabel;
    Button1: TButton;
    cdsProdutos: TClientDataSet;
    cdsProdutoscodigo: TIntegerField;
    cdsProdutosDescricao: TStringField;
    cdsProdutosquantidade: TIntegerField;
    cdsProdutosvlr_unitario: TFloatField;
    cdsProdutosvlr_total: TFloatField;
    dsProdutos: TDataSource;
    DBGrid1: TDBGrid;
    Button2: TButton;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    edtCodigoCliente: TEdit;
    Label5: TLabel;
    btnCarregar: TButton;
    btnCancelar: TButton;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure AtualizaTotalPedido;
    function BuscaNomeCliente(vCodigo:Integer): String ;
    function BuscaValorTotal : Currency ;
    { Private declarations }
  public
    { Public declarations }
    procedure CarregarComboCliente;
  end;

  TCliente = class
  private
    FCodigo: Integer;
    FNome: string;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Nome: string read FNome write FNome;
  end;

  TProduto = class
  private
    FPreco_Venda: Double;
    FDescricao: string;
    FCodigo: Integer;
    public
      property Codigo: Integer read FCodigo write FCodigo;
      property Descricao: string read FDescricao write FDescricao;
      property Preco_Venda: Double read FPreco_Venda write FPreco_Venda;
      procedure CarregaProduto(ACodigo:Integer);
      procedure AtualizaTotal;
  end;



var
  Form1: TForm1;
  ModoEdicao: Boolean;

implementation

uses
  uDm_Principal;

{$R *.dfm}

{ TCliente }

procedure TForm1.btnCancelarClick(Sender: TObject);
var
  nPedido:String;
  fdq: TFDQuery;
  Total_Pedido:Double;
begin
  InputQuery('Carregar pedido','Informe o número do pedido para cancelar',nPedido);
  if nPedido<>'' then
  begin
    fdq := TFDQuery.Create(Application);
    with fdq do
    begin
      Connection := DM_Principal.FDBanco;
      SQL.Add('DELETE FROM PEDIDOS_PRODUTOS WHERE NUMERO_PEDIDO='+nPedido+';');
      SQL.Add('DELETE FROM PEDIDOS_DADOS_GERAIS WHERE NUMEROPEDIDO='+nPedido+';');
      ExecSQL;

      MessageBox(Handle, 'Pedido cancelado', 'Informação', MB_OK +
        MB_ICONINFORMATION + MB_DEFBUTTON2);


    end;
    FreeAndNil(fdq);
    StatusBar1.Panels[0].Text := 'Valor total do pedido: R$ 0,00';
  end;
end;

procedure TForm1.btnCarregarClick(Sender: TObject);
var
  nPedido:String;
  fdq: TFDQuery;
  Total_Pedido:Double;
begin
  InputQuery('Carregar pedido','Informe o número do pedido para carregar',nPedido);
  if nPedido<>'' then
  begin
    fdq := TFDQuery.Create(Application);
    with fdq do
    begin
      Connection := DM_Principal.FDBanco;
      SQL.Add('SELECT pedidos_produtos.*,pedidos_dados_gerais.*,produtos.*,clientes.* FROM pedidos_produtos');
      sql.Add('INNER JOIN produtos ON produtos.CODIGO = pedidos_produtos.CODIGO_PRODUTO');
      SQL.Add('INNER JOIN pedidos_dados_gerais ON pedidos_dados_gerais.NUMEROPEDIDO=pedidos_produtos.NUMERO_PEDIDO AND pedidos_dados_gerais.NUMEROPEDIDO='+nPedido);
      SQL.Add('INNER JOIN clientes ON clientes.CODIGO = pedidos_dados_gerais.CODIGO_CLIENTE');
      Open;

      if NOT IsEmpty then
      begin
        edtCodigoCliente.Text:=FieldByName('CODIGO_CLIENTE').AsString;
        cbxCliente.ItemIndex := cbxCliente.Items.IndexOf(FieldByName('NOME').AsString);


        while (cdsProdutos.Eof) and (cdsProdutos.RecordCount > 0)do
        begin
          cdsProdutos.Delete;
        end;

        while not Eof do
        begin
          cdsProdutos.Append;
          cdsProdutoscodigo.AsInteger := FieldByName('CODIGO').AsInteger;
          cdsProdutosDescricao.AsString := FieldByName('DESCRICAO').AsString;
          cdsProdutosquantidade.AsInteger := FieldByName('QUANTIDADE').AsInteger;
          cdsProdutosvlr_unitario.AsFloat := FieldByName('VLR_UNITARIO').AsFloat;
          cdsProdutosvlr_total.AsFloat := FieldByName('VALOR_TOTAL').AsFloat;
          Total_Pedido := Total_Pedido + cdsProdutosvlr_total.AsFloat;
          cdsProdutos.Post;
          Next;
        end;
      end
      else
        MessageBox(Handle, 'Pedido não localizado', 'Informação', MB_OK +
          MB_ICONINFORMATION + MB_DEFBUTTON2);
    end;

    FreeAndNil(fdq);
    StatusBar1.Panels[0].Text := 'Valor total do pedido: R$ '+FormatFloat('#.00',Total_Pedido);
  end;
end;

function TForm1.BuscaNomeCliente(vCodigo: Integer): string;
var
  vSql : String ;
begin
  vSql := 'Select nome from clientes where codigo = '+IntToStr(vCodigo) ;
  DM_Principal.FDAux.Close ;
  DM_Principal.FDAux.SQL.Text := vSql ;
  DM_Principal.FDAux.Open ;

  if DM_Principal.FDAux.IsEmpty then
    result := ''
  else
    result := DM_Principal.FDAux.FieldByName('nome').AsString ;
end;

function TForm1.BuscaValorTotal: Currency;
var
  vTotal : Currency ;
begin
  vTotal := 0 ;
  cdsProdutos.First ;
  cdsProdutos.DisableControls ;
  while not cdsProdutos.Eof do
  begin
    vTotal := vTotal + cdsProdutosvlr_total.AsCurrency ;
    cdsProdutos.Next ;
  end;
  Result := vTotal ;
  cdsProdutos.EnableControls ;
  cdsProdutos.First ;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if edtCodigoProduto.Text = '' then
  begin
    ShowMessage('Por favor inserir um produto !!!.');
    edtCodigoProduto.SetFocus ;
    exit;
  end;

  if edtQuantidade.Text = '' then
  begin
    ShowMessage('Por favor inserir uma quantidade para o produto !!!.');
    edtQuantidade.SetFocus ;
    exit;
  end;

  if edtValor.Text = '' then
  begin
    ShowMessage('Por favor inserir um valor para o produto !!!.');
    edtValor.SetFocus ;
    exit;
  end;


  if ModoEdicao = true then
  begin
    cdsProdutos.Edit;
    cdsProdutosquantidade.AsInteger := StrToInt(edtQuantidade.Text);
    cdsProdutosvlr_unitario.AsFloat := StrToFloat(edtValor.Text);
    cdsProdutosvlr_total.AsFloat := cdsProdutosquantidade.AsInteger * cdsProdutosvlr_unitario.AsFloat;
    cdsProdutos.Post;
    ModoEdicao := False;

  end
  else
  begin
    cdsProdutos.Append;
    cdsProdutoscodigo.AsInteger := StrToInt(edtCodigoProduto.Text);
    cdsProdutosDescricao.AsString := lblDescricaoProduto.Caption;
    cdsProdutosquantidade.AsInteger := StrToInt(edtQuantidade.Text);
    cdsProdutosvlr_unitario.AsFloat := StrToFloat(edtValor.Text);
    cdsProdutosvlr_total.AsFloat := cdsProdutosquantidade.AsInteger * cdsProdutosvlr_unitario.AsFloat;
    cdsProdutos.Post;
  end;
  AtualizaTotalPedido;

  //Limpa os campos
  edtCodigoProduto.Clear ;
  edtQuantidade.Clear ;
  edtValor.Clear ;
  lblDescricaoProduto.Caption := '' ;
  edtCodigoProduto.Enabled := True ;
  edtCodigoProduto.SetFocus ;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  cliente: TCliente;
  fdq: TFDQuery;
  nPedido:Integer;
begin
  if cbxCliente.Text <> '' then
  begin
    cliente := TCliente.Create;
    fdq := TFDQuery.Create(Application);
    with fdq do
    begin
      Connection := DM_Principal.FDBanco;
      sql.Add('SELECT COALESCE(max(NUMEROPEDIDO),0) +1 as npedido FROM pedidos_dados_gerais');
      Open;
      nPedido := FieldByName('npedido').AsInteger;
      Close;

      sql.Clear;
      SQL.Add('INSERT INTO PEDIDOS_DADOS_GERAIS (NUMEROPEDIDO,DATAEMISSAO,CODIGO_CLIENTE,VALOR_TOTAL)');
      SQL.Add('VALUES');
      SQL.Add('('+IntToStr(nPedido)+',');
      sql.Add('CURRENT_DATE,');
      SQL.Add(IntToStr(Tcliente(cbxCliente.Items.Objects[cbxCliente.items.IndexOf(cbxCliente.Text)]).Codigo)+',');
      SQL.Add(CurrToStr(BuscaValorTotal)+')');
      ExecSQL;

      cdsProdutos.First;
      while not cdsProdutos.Eof do
      begin
          SQL.Clear;
          SQL.Add('INSERT INTO PEDIDOS_PRODUTOS (NUMERO_PEDIDO,CODIGO_PRODUTO,QUANTIDADE,VLR_UNITARIO,VLR_TOTAL)');
          SQL.Add('VALUES');
          SQL.Add('('+IntToStr(nPedido)+',');
          SQL.Add(cdsProdutoscodigo.AsString+',');
          SQL.Add(cdsProdutosquantidade.AsString+',');
          SQL.Add(cdsProdutosvlr_unitario.AsString+',');
          SQL.Add('QUANTIDADE * VLR_UNITARIO)');
          ExecSQL;
          cdsProdutos.Next;
      end;

    end;
    FreeAndNil(cliente);
    FreeAndNil(fdq);

    //Limpa os campos
    edtCodigoCliente.Clear;
    cbxCliente.Text := '' ;
    edtCodigoProduto.Clear ;
    edtQuantidade.Clear ;
    edtValor.Clear ;
    lblDescricaoProduto.Caption := '' ;
    edtCodigoProduto.Enabled := True ;
    edtCodigoProduto.SetFocus ;
    cdsProdutos.EmptyDataSet ;
  end
  else
    MessageBox(Handle, 'Selecione o cliente', 'Atenção', MB_OK +
      MB_ICONWARNING + MB_DEFBUTTON2);

end;

procedure TForm1.CarregarComboCliente;
var
  fdq: TFDQuery;
  cliente: TCliente;
begin
  fdq := TFDQuery.Create(Application);
  with fdq do
  begin
    Connection := DM_Principal.FDBanco;
    SQL.Add('SELECT CODIGO,NOME FROM CLIENTES ORDER BY NOME');
    Open;

    while not eof do
    begin
      cliente := TCliente.Create;
      with cliente do
      begin
        Codigo := fdq.FieldByName('codigo').AsInteger;
        Nome := fdq.FieldByName('nome').AsString;
      end;

      cbxCliente.Items.AddObject(Cliente.Nome,cliente);

      Next;
    end;
  end;

  FreeAndNil(fdq);

end;

procedure TForm1.AtualizaTotalPedido;
var
  vlr_Pedido:Double;
begin
  vlr_Pedido := 0;
  cdsProdutos.First;
  while not cdsProdutos.Eof do
  begin
    vlr_Pedido := vlr_Pedido + cdsProdutosvlr_total.AsFloat;
    cdsProdutos.Next;
  end;
  StatusBar1.Panels[0].Text := 'Valor total do pedido: R$ ' + FormatFloat('#.00', vlr_Pedido);
end;

procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if cdsProdutos.RecordCount > 0  then
  begin
    if key = VK_RETURN then
    begin
      ModoEdicao := True;
      edtCodigoProduto.Text := cdsProdutoscodigo.AsString;
      edtCodigoProduto.Enabled := False ;
      edtQuantidade.Text := cdsProdutosquantidade.AsString;
      edtCodigoProdutoExit(edtCodigoProduto);
    end;

    if Key = VK_DELETE then
    case MessageBox(Handle, 'Deseja apagar o produto do pedido ?',
      'Confirmação', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) of
      IDYES:
        begin
          cdsProdutos.Delete;
          AtualizaTotalPedido;
        end;
    end;

  end;


end;

procedure TForm1.edtCodigoClienteChange(Sender: TObject);
begin
  btnCarregar.Visible := Trim(edtCodigoCliente.Text)='';
  btnCancelar.Visible := Trim(edtCodigoCliente.Text)='';
end;

procedure TForm1.edtCodigoClienteExit(Sender: TObject);
begin
  if edtCodigoCliente.Text <> '' then
    cbxCliente.Text := BuscaNomeCliente(StrToInt(edtCodigoCliente.Text))
  else
    cbxCliente.ItemIndex := -1 ;

end;

procedure TForm1.edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
   key := #0;
end;

procedure TForm1.edtCodigoProdutoExit(Sender: TObject);
var
  produto: TProduto;
begin
  if edtCodigoProduto.Text <> '' then
  begin
    try
      produto := TProduto.Create;
      produto.Codigo := StrToInt(edtCodigoProduto.Text);
      produto.CarregaProduto(produto.Codigo);

      lblDescricaoProduto.Caption := produto.Descricao;
      edtValor.Text := FormatFloat('#.00', produto.Preco_Venda);
      edtQuantidade.SetFocus;

      FreeAndNil(produto);
    except
      Application.MessageBox('Erro ao carregar produto', 'Erro', MB_OK +
        MB_ICONSTOP + MB_DEFBUTTON2);
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CarregarComboCliente;
  ModoEdicao := False;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    perform(WM_NEXTDLGCTL,0,0);
end;

{ TProduto }

procedure TProduto.AtualizaTotal;
begin

end;

procedure TProduto.CarregaProduto(ACodigo: Integer);
var
  fdq: TFDQuery;
begin
  fdq := TFDQuery.Create(Application);
  with fdq do
  begin
    Connection := DM_Principal.FDBanco;
    SQL.Add('SELECT * FROM PRODUTOS WHERE CODIGO='+IntToStr(ACodigo));
    Open;

    if not IsEmpty then
    begin
      Codigo := FieldByName('CODIGO').AsInteger;
      Descricao := FieldByName('DESCRICAO').AsString;
      Preco_Venda := FieldByName('PRECO_VENDA').AsFloat;
    end;

  end;

  FreeAndNil(fdq);

end;

end.
