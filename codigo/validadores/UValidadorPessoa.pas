unit UValidadorPessoa;

interface

uses
UPessoa, system.StrUtils, system.Sysutils;

type

  TValidadorPessoa = class
  private

  public

  procedure Validar(PPessoa: TPessoa);
  function ValidarCPF(PPessoa: TPessoa): Boolean;

  end;

implementation

{ TValidadorPessoa }

procedure TValidadorPessoa.Validar(PPessoa: TPessoa);
begin
  if (PPessoa.Nome = '') then
    raise exception.Create('O campo login não pode estar vazio');


end;

function TValidadorPessoa.ValidarCPF(PPessoa: TPessoa): Boolean;
begin

end;

end.
