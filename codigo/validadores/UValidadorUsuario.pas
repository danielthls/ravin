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
    Nome não pode ser vazio
    Login não pode ser vazio
    CPF~não pode ser vazio  - VALIDAR PESOSA
    Quantidade de caracteres do login - 4
    Números no CPF - VALIDAR PESSOA
    Nome não pode aceitar número
    Validar caracteres especiais -
    CPF não pode ser vazio
    Senha = confirmação de senha
    CPF é válido
  }

  if PUsuario.login.isEmpty then
  begin
    raise exception.Create('O campo login não pode estar vazio');
  end;

  if PUsuario.senha.isEmpty then
  begin
    raise exception.Create('O campo senha não pode estar vazio');
  end;

  if not(PUsuario.senha = PSenhaConfirmacao) then
  begin
    raise exception.Create('A senha e a confirmação ' + 'devem ser iguais.');
  end;

  if PUsuario.login.Length < 4 then
  begin
    raise Exception.Create('O login deve ter no mínimo 4 caracteres.');
  end;

  for I := 1 to PUsuario.login.Length do
  begin
    if not ((PUsuario.login[i] in ['0'..'9']) or
    ((PUsuario.login[i] in ['a'..'z']) or (PUsuario.login[i] in ['A'..'Z'])) or
    (PUsuario.login[i] = '_') or (PUsuario.login[i] = '.') or (PUsuario.login[i] = #0)) then
    begin
      raise Exception.Create('Login inválido, utilize apenas letras e números');
    end;
  end;

end;

end.
