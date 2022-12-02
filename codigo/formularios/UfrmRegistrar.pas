unit UfrmRegistrar;

interface

uses
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,

  FireDAC.Phys.MySQLWrapper,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UfrmBotaoPrimario,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, System.Actions, Vcl.ActnList, Vcl.ExtActns, Vcl.Mask;

type
  TfrmRegistrar = class(TForm)
    imgFundo: TImage;
    pnlRegistrar: TPanel;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistrar: TLabel;
    lblTituloAutenticar: TLabel;
    lblSubTituloAutenticar: TLabel;
    edtNome: TEdit;
    frmBotaoPrimarioRegistrar: TfrmBotaoPrimario;
    edtLogin: TEdit;
    edtSenha: TEdit;
    edtConfirmarSenha: TEdit;
    edtCpf: TEdit;
    procedure lblSubTituloAutenticarClick(Sender: TObject);
    procedure frmBotaoPrimarioRegistrarspbBotaoPrimarioClick(Sender: TObject);
    procedure edtCpfExit(Sender: TObject);
    procedure edtCpfKeyPress(Sender: TObject; var Key: Char);
    procedure adicionaUsuario;
    procedure adicionaPessoa;
    procedure abrirLogin;



  private
    { Private declarations }
    procedure SetMainForm(NovoMainForm: TForm);
  public
    { Public declarations }
  end;

var
  frmRegistrar: TfrmRegistrar;

implementation

uses
  UusuarioDao,
  Uusuario, UfrmLogin, Winapi.Windows, UPessoa, UPessoaDAO, UValidadorUsuario,
  UValidadorPessoa, UFormUtils; // , UfrmAutenticar;

{$R *.dfm}

procedure TfrmRegistrar.abrirLogin;
begin
    if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;

  TFormUtils.SetarFormPrincipal(frmLogin);
  frmLogin.Show();

  Close();
end;

procedure TfrmRegistrar.adicionaPessoa;
const
  funcionario: string = 'F';
  ativo: integer = 1;
var
  xCPF: String;
  xPessoa: TPessoa;
  xDAO: TPessoaDAO;
begin
  try
    try
      edtCPF.text := TValidadorPessoa.mascaraCPF(edtCPF.text);
      TValidadorPessoa.contaCaracteresCPF(edtCPF.text);

      xPessoa := TPessoa.Create;
      xPessoa.nome := edtNome.text;
      xPessoa.tipoPessoa := funcionario;
      xPessoa.CPF := TValidadorPessoa.trimCPF(edtCPF.text);
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
      on E: EMySQLNativeException do
      begin
        //ShowMessage(e.message);
        ShowMessage('Erro ao inserir pessoa no banco');
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
end;

procedure TfrmRegistrar.adicionaUsuario;
var
  LUsuario: TUsuario;
  LDao: TUsuarioDao;
begin
  { Ler os valores dos campos
    Criar o objeto do usuário
    Setar os valores
    Criar um DAO
    Chamar o método para salvar o usuário }
  try
    try
      LUsuario := TUsuario.Create;
      LUsuario.login := edtLogin.Text;
      LUsuario.senha := edtSenha.Text;
      LUsuario.pessoaId := LDao.getPessoaID;
      LUsuario.criadoem := now;
      LUsuario.criadopor := edtNome.Text;
      LUsuario.alteradoem := now;
      LUsuario.alteradopor := edtNome.Text;

      TValidadorUsuario.Validar(LUsuario,edtConfirmarSenha.text);
      LDao := TUsuarioDao.Create;
      LDao.InserirUsuario(LUsuario);
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
    FreeAndNil(LUsuario);
    if Assigned(LDao) then
      FreeAndNil(LDao);
  end;
end;



procedure TfrmRegistrar.edtCpfExit(Sender: TObject);
begin
  edtCPF.text := TValidadorPessoa.mascaraCPF(edtCPF.text);
end;

procedure TfrmRegistrar.edtCpfKeyPress(Sender: TObject; var Key: Char);
begin
  if not ( (key in ['0'..'9']) or (key = #8)) then
    key := #0;
end;

procedure TfrmRegistrar.frmBotaoPrimarioRegistrarspbBotaoPrimarioClick
  (Sender: TObject);

begin
  try
    //continua executando mesmo com erro
    adicionaPessoa;
    adicionaUsuario;
    abrirLogin;
  except
    on E: EMySQLNativeException do
    begin
      ShowMessage('Erro ao inserir o usuário no banco');
    end;
    on E: Exception do
    begin
      ShowMessage(e.message);
    end;
  end;
end;

procedure TfrmRegistrar.lblSubTituloAutenticarClick(Sender: TObject);
begin
  if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;

  SetMainForm(frmLogin);
  frmLogin.Show();

  Close();
end;



procedure TfrmRegistrar.SetMainForm(NovoMainForm: TForm);
begin

end;

end.
