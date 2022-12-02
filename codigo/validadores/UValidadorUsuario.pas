unit UValidadorUsuario;

interface

uses
  Uusuario, system.StrUtils, system.Sysutils;

type
  TValidadorUsuario = class
  private

  protected

  public
    class procedure Validar(PUsuario: TUsuario; PSenhaConfirmacao: String);
  end;
  implementation

{ TValidadorUsuario }

class procedure TValidadorUsuario.Validar(PUsuario: TUsuario;
  PSenhaConfirmacao: String);
var
 I: Integer;
begin
  {
    Nome n�o pode ser vazio
    Login n�o pode ser vazio
    CPF~n�o pode ser vazio  - VALIDAR PESOSA
    Quantidade de caracteres do login - 4
    N�meros no CPF - VALIDAR PESSOA
    Nome n�o pode aceitar n�mero
    Validar caracteres especiais -
    CPF n�o pode ser vazio
    Senha = confirma��o de senha
    CPF � v�lido
  }

  if PUsuario.login.isEmpty then
  begin
    raise exception.Create('O campo login n�o pode estar vazio');
  end;

  if PUsuario.senha.isEmpty then
  begin
    raise exception.Create('O campo senha n�o pode estar vazio');
  end;

  if not(PUsuario.senha = PSenhaConfirmacao) then
  begin
    raise exception.Create('A senha e a confirma��o ' + 'devem ser iguais.');
  end;

  if PUsuario.login.Length < 4 then
  begin
    raise Exception.Create('O login deve ter no m�nimo 4 caracteres.');
  end;

  for I := 1 to PUsuario.login.Length do
  begin
    if not ((PUsuario.login[i] in ['0'..'9']) or
    ((PUsuario.login[i] in ['a'..'z']) or (PUsuario.login[i] in ['A'..'Z'])) or
    (PUsuario.login[i] = '_') or (PUsuario.login[i] = '.') or (PUsuario.login[i] = #0)) then
    begin
      raise Exception.Create('Login inv�lido, utilize apenas letras e n�meros');
    end;
  end;

end;

end.
