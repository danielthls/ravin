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
begin
  {
    Nome não pode ser vazio
    Login não pode ser vazio
    CPF~não pode ser vazio
    Quantidade de caracteres do login
    Números no CPF
    Nome não pode aceitar número
    Validar caracteres especiais
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
end;

end.
