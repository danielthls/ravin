unit TESTE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UUsuarioDAO, System.Generics.Collections,UUsuario;

type
  TfrmUsuariosTeste = class(TForm)
    MMUsuarios: TMemo;
    BTNListarUsuario: TButton;
    procedure BTNListarUsuarioClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ListarUsuarios;
    { Public declarations }
  end;

var
  frmUsuariosTeste: TfrmUsuariosTeste;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfrmUsuariosTeste.BTNListarUsuarioClick(Sender: TObject);
begin
  ListarUsuarios;
end;

procedure TfrmUsuariosTeste.ListarUsuarios;
var
  xUsuarioDAO: TUsuarioDAO;
  xLista: TList<TUsuario>;
  i: Integer;
  xUsuario: string;
begin
  xUsuarioDAO := TUsuarioDAO.Create;
  xLista:= xUsuarioDAO.BuscasTodosUsuarios;

  for I := 0 to xLista.Count - 1 do
  begin
    xUsuario := xLista[i].login;
    mmUsuarios.lines.add(xUsuario);
    freeAndNil(xLista[i]);
  end;

  freeAndNil(xUsuarioDAO);
  freeAndNil(xLista);
end;

end.
