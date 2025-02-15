unit UfrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, UfrmItemMenu,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, UfrmBotaozao, UUsuarioDAO;

type
  TfrmLogin = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    frmBotao1: TfrmBotao;
    Label3: TLabel;
    lblRegistrar: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure frmBotao1SpdBtnButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure lblRegistrarClick(Sender: TObject);
  private
    { Private declarations }
    procedure RegistrarHora;
    procedure abrirRegistrar;
    procedure autenticar;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  UfrmPainelGestao, Uusuario, UfrmRegistrar, UiniUtils, UFormUtils;

{$R *.dfm}

procedure TfrmLogin.abrirRegistrar;
begin
    if not Assigned(frmRegistrar) then
  begin
    Application.CreateForm(TfrmRegistrar, frmRegistrar);
  end;

  TFormUtils.SetarFormPrincipal(frmRegistrar);
  frmRegistrar.Show();

  Close();
end;

procedure TfrmLogin.autenticar;
var
  LDao: TUsuarioDao;
  LUsuario: TUsuario;

  LLogin: String;
  LSenha: String;
begin
  LDao := TUsuarioDao.Create;

  try
    LLogin := edtLogin.Text;
    LSenha := edtSenha.Text;

    LUsuario := LDao.BuscarUsuarioPorLoginSenha(LLogin, Lsenha);

    if Assigned(LUsuario) then
    begin
      TIniUtils.gravarPropriedade(
      TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO, TIniUtils.VALOR_VERDADEIRO);

      if not Assigned(frmPainelGestao) then
      begin
        Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
      end;


      frmPainelGestao.Show();
      TFormUtils.SetarFormPrincipal(frmPainelGestao);

      freeAndNil(LUsuario);

      RegistrarHora;

      edtLogin.Text := '';
      edtSenha.Text := '';

      Close();
    end
    else
    begin
      showMessage('Login e/ou senha inválidos');
    end;
  finally
    FreeAndNil(LDao);
  end;


end;

procedure TfrmLogin.Button1Click(Sender: TObject);
var
  LUsuario: TUsuario;
  LDao: TUsuarioDao;
begin
  LUsuario := TUsuario.Create();
  LUsuario.login := 'teste';
  LUsuario.senha := '1234';
  LUsuario.pessoaId := 1;
  LUsuario.criadoEm := now();
  LUsuario.criadoPor := 'joaozinho';
  LUsuario.alteradoEm := now();
  LUsuario.alteradoPor := 'marcio';

  LDao := TUsuarioDao.create();
  LDao.InserirUsuario(LUsuario);

  FreeAndNil(LUsuario);
  FreeAndNil(LDao);
end;

procedure TfrmLogin.frmBotao1SpdBtnButtonClick(Sender: TObject);
begin
  Autenticar;
end;

procedure TfrmLogin.lblRegistrarClick(Sender: TObject);
begin
  abrirRegistrar;
end;

procedure TfrmLogin.RegistrarHora;
begin
  TIniUtils.gravarPropriedade(
      TSECAO.LOGIN, TPROPRIEDADE.PESSOA, edtLogin.text);
  TIniUtils.gravarPropriedade(
      TSECAO.LOGIN, TPROPRIEDADE.ULTIMO_LOGIN, DateTimeToStr(now));
end;

end.
