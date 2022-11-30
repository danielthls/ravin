unit UfrmSplash;
interface
uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.DateUtils,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,
  UfrmLogomarca;
type
  TfrmSplash = class(TForm)
    pnlFundo: TPanel;
    tmrSplash: TTimer;
    frmLogo: TfrmLogo;
    procedure tmrSplashTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    Inicialized: Boolean;
    procedure InicializarAplicacao();
    procedure ShowPainelGestao;
    procedure ShowLogin;
    function PrazoLogin: boolean;


  public
    { Public declarations }
  end;
var
  frmSplash: TfrmSplash;
implementation
{$R *.dfm}
uses UfrmPainelGestao, UfrmLogin, UiniUtils, UFormUtils;
procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  Inicialized := false;
  tmrSplash.Enabled := false;
  tmrSplash.Interval := 1000;
end;
procedure TfrmSplash.FormPaint(Sender: TObject);
begin
  tmrSplash.Enabled := not Inicialized;
end;

procedure TfrmSplash.InicializarAplicacao;
var
  LLogado: String;
begin
  LLogado := TIniUtils.lerPropriedade(TSECAO.INFORMACOES_GERAIS,
    TPROPRIEDADE.LOGADO);
  if (LLogado = TIniUtils.VALOR_VERDADEIRO) and (PrazoLogin) then
    showPainelGestao
  else
    showLogin;
end;


function TfrmSplash.PrazoLogin: boolean;
const NUMERO_MAXIMO_DIAS_LOGIN: Integer = 5;
var
  xDiaString: String;
  xDiaLogin: tDateTime;
  xPrazoLogin: tDateTime;
begin
  xDiaString := TIniUtils.lerPropriedade(TSECAO.LOGIN,TPROPRIEDADE.ULTIMO_LOGIN);
  try
    xDiaLogin := StrToDateTime(xDiaString);
  except
    on E: Exception do
    begin
      Result:= False;
      Exit;
    end;
  end;
  xPrazoLogin := incDay(xDiaLogin, NUMERO_MAXIMO_DIAS_LOGIN);
  if now < xPrazoLogin then
    Result := True
  else
    Result := False;

end;

procedure TfrmSplash.tmrSplashTimer(Sender: TObject);
begin
  tmrSplash.Enabled := false;
  if not Inicialized then
  begin
    Inicialized := true;
    InicializarAplicacao();
  end;
end;

procedure TfrmSplash.ShowLogin;
begin
if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;
  TFormUtils.SetarFormPrincipal(frmLogin);
  frmLogin.Show();
  Close;
end;

procedure TfrmSplash.ShowPainelGestao;
begin
if not Assigned(frmPainelGestao) then
  begin
    Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
  end;
  TFormUtils.SetarFormPrincipal(frmPainelGestao);
  frmPainelGestao.Show();
  Close;
end;

end.

