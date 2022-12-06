unit UfrmListaClientes;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Generics.Collections,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.StdCtrls,

  UfrmCadastroCliente,
  UfrmBotaoPrimario,
  UfrmBotaoCancelar, Vcl.ExtCtrls;

type
  TfrmListaClientes = class(TForm)
    frmBotaoPrimario: TfrmBotaoPrimario;
    frmBotaoCancelar: TfrmBotaoCancelar;
    lvwClientes: TListView;
    Shape1: TShape;
    Shape2: TShape;
    Shape5: TShape;
    lblInformacoesGerenciais: TLabel;
    pnlListaClientes: TPanel;
    lblListaClientesTitulo: TLabel;
    Button1: TButton;
    procedure frmBotaoPrimariospbBotaoPrimarioClick(Sender: TObject);
    procedure frmBotaoCancelarspbBotaoCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);



  private
    { Private declarations }
    procedure listarClientes;
    function clienteAtivo(PAtivo: integer): string;
  public
    { Public declarations }
  end;

var
  frmListaClientes: TfrmListaClientes;

implementation

uses
  UPessoaDAO, UPessoa, UValidadorPessoa;

{$R *.dfm}

procedure TfrmListaClientes.Button1Click(Sender: TObject);
begin
  listarClientes;
end;

function TfrmListaClientes.clienteAtivo(PAtivo: integer): string;
begin
  if PAtivo = 0 then
    Result := 'Inativo'
  else
    Result := 'Ativo';
end;

procedure TfrmListaClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  lvwClientes.Clear;
end;

procedure TfrmListaClientes.FormShow(Sender: TObject);
begin
  listarClientes;
end;

procedure TfrmListaClientes.frmBotaoCancelarspbBotaoCancelarClick(
  Sender: TObject);
begin
  close;
end;

procedure TfrmListaClientes.frmBotaoPrimariospbBotaoPrimarioClick
  (Sender: TObject);
begin

   if (not Assigned(frmCadastroCliente)) then
  begin
    Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);
  end;
  frmCadastroCliente.show();
end;

procedure TfrmListaClientes.listarClientes;
var
  xDAO: TPessoaDAO;
  xLista: TList<TPessoa>;
  i: Integer;
  xItem: TListItem;
begin
  if lvwClientes.items.count = 0  then
  begin
    xDAO := TPessoaDAO.Create;
    xLista:= xDAO.BuscarTodosOsClientes;
    for I := 0 to xLista.Count - 1 do
    begin
      xItem := lvwClientes.items.Add;
      xItem.Caption := xLista[i].nome;
      xItem.SubItems.Add(TValidadorPessoa.mascaraCPF(xLista[i].CPF));
      xItem.SubItems.Add(intToStr(xLista[i].telefone));
      xItem.SubItems.Add(clienteAtivo(xLista[i].ativo));
      freeAndNil(xLista[i]);
    end;
    freeAndNil(xDAO);
    freeAndNil(xLista);
  end;
end;

end.
