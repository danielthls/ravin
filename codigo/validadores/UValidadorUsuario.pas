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
    Nome n�o pode ser vazio
    Login n�o pode ser vazio
    CPF~n�o pode ser vazio
    Quantidade de caracteres do login
    N�meros no CPF
    Nome n�o pode aceitar n�mero
    Validar caracteres especiais
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
end;

end.
