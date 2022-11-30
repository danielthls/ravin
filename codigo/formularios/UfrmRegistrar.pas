unit UfrmRegistrar;

interface

uses
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.MaskUtils,

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
  Uusuario, UfrmLogin, Winapi.Windows; // , UfrmAutenticar;

{$R *.dfm}

procedure TfrmRegistrar.edtCpfExit(Sender: TObject);
begin
  edtCpf.text := FormatMaskText('000\.000\.000\-00;0;', edtCpf.text);
end;

procedure TfrmRegistrar.edtCpfKeyPress(Sender: TObject; var Key: Char);
begin
  if not ( key in ['0'..'9']) then
    key := #0;
end;

procedure TfrmRegistrar.frmBotaoPrimarioRegistrarspbBotaoPrimarioClick
  (Sender: TObject);
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
      LUsuario.senha := edtLogin.Text;
      LUsuario.pessoaId := 1;
      LUsuario.criadoem := now;
      LUsuario.criadopor := edtLogin.Text;
      LUsuario.alteradoem := now;
      LUsuario.alteradopor := edtLogin.Text;

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
     if Assigned(LDao) then
      FreeAndNil(LUsuario)
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
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := NovoMainForm;
end;



end.
