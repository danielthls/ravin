unit UfrmCadastroCliente;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  FireDAC.Phys.MySQLWrapper,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.WinXCtrls,
  UfrmBotaoPrimario,

  UfrmBotaoExcluir,
  UfrmBotaoCancelar;

type
  TfrmCadastroCliente = class(TForm)
    pnlCadastroCliente: TPanel;
    lblCadastroCliente: TLabel;
    edtNome: TEdit;
    edtTelefone: TEdit;
    mskCpf: TMaskEdit;
    dtpDataNascimento: TDateTimePicker;
    lblInformacoesGerenciais: TfrmBotaoPrimario;
    frmBotaoCancelar: TfrmBotaoCancelar;
    frmBotaoExcluir: TfrmBotaoExcluir;
    procedure lblInformacoesGerenciaisspbBotaoPrimarioClick(Sender: TObject);
    procedure frmBotaoCancelarspbBotaoCancelarClick(Sender: TObject);
    procedure frmBotaoExcluirspbBotaoExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    xSalvo: boolean;
    procedure confirmaExclusao;
    procedure excluiRegistro(pId: integer);
    procedure resetaCampos;
    function buscarCriadoPor: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses
  UPessoaDAO, UPessoa, UValidadorPessoa, UiniUtils, Uusuario, UUsuarioDAO;

{$R *.dfm}

function TfrmCadastroCliente.buscarCriadoPor: string;
var
  xUsuarioDAO : TUsuarioDAO;
  xPessoaDAO : TPessoaDAO;
  xPessoa: TPessoa;
begin

end;

procedure TfrmCadastroCliente.confirmaExclusao;
var
  xConfirma: integer;
begin
  xConfirma := MessageDlg('Deseja excluir o registro?', TMsgDlgType.mtWarning,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0);
  if xConfirma = mrYes then
  begin
    ShowMessage('Registro excluído com sucesso');
    Close;
  end;
end;

procedure TfrmCadastroCliente.excluiRegistro(pId: integer);
var
  xDAO : TPessoaDAO;
  xPessoa : TPessoa;
begin
  xDAO := TPessoaDAO.Create;
  xPessoa := xDAO.BuscarUltimaPessoaInserida;
  xDAO.ExcluirPessoa(xPessoa.Id);
  freeAndNil(xPessoa);
  freeAndNil(xDAO);
  resetaCampos;
end;

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
begin
  xSalvo := false;
end;

procedure TfrmCadastroCliente.frmBotaoCancelarspbBotaoCancelarClick(
  Sender: TObject);
begin
  close;
end;

procedure TfrmCadastroCliente.frmBotaoExcluirspbBotaoExcluirClick(
  Sender: TObject);
begin
  confirmaExclusao;
end;

procedure TfrmCadastroCliente.lblInformacoesGerenciaisspbBotaoPrimarioClick(
  Sender: TObject);
const
  cliente: String = 'F';
  ativo: integer = 1;
var
  xDAO : TPessoaDAO;
  xPessoa : TPessoa;
  xCriadoAlteradoPor: String;
begin
  try
    try
      xCriadoAlteradoPor := TUsuarioDAO.buscarUsuarioPorLogin(TIniUtils.lerPropriedade(TSECAO.LOGIN, TPROPRIEDADE.PESSOA));

      xPessoa := TPessoa.Create;
      xPessoa.Nome := edtNome.Text;
      xPessoa.tipoPessoa := cliente;
      xPessoa.CPF := TValidadorPessoa.trimCPF(mskCPF.text);
      xPessoa.Ativo := Ativo;
      xPessoa.CriadoEm := now;
      xPessoa.CriadoPor := edtNome.text;
      xPessoa.AlteradoEm := now;
      xPessoa.AlteradoPor := edtNome.text;

      TValidadorPessoa.ValidarNome(xPessoa.nome);
      TValidadorPessoa.ValidarCPF(xPessoa.CPF);

      xDAO := TPessoaDAO.Create;
      xDAO.InserirPessoa(xPessoa);
    except
      on E: EMySQLNativeException do begin
        ShowMessage('Erro ao inserir o usuário no banco');
      end;
      on E: Exception do
      begin
        ShowMessage(e.message);
      end;
    end;
  finally
    FreeAndNil(xPessoa);
    if Assigned(xDao) then
      FreeAndNil(xDao);
  end;

  showMessage('Cliente cadastrado com sucesso');
end;

procedure TfrmCadastroCliente.resetaCampos;
begin
  edtNome.Text := '';
  edtTelefone.Text := '';
  dtpDataNascimento.date := now;
  mskCPF.text := '';
end;

end.
