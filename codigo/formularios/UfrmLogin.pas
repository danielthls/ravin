unit UfrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, UfrmItemMenu,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, UfrmBotaozao;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

end.
