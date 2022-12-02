unit UValidadorPessoa;

interface

uses
UPessoa, system.StrUtils, system.Sysutils, vcl.Dialogs, System.MaskUtils;

type

  TValidadorPessoa = class
  private

  public

  class procedure ValidarCliente(PPessoa: TPessoa);
  class procedure ValidarNome(PNome:String);
  class procedure ValidarCPF(PCPF: string);
  class function trimCPF(PCPF: string): string;
  class procedure contaCaracteresCPF(PCPF: string);
  class function mascaraCPF(PCPF: string): string;

  end;

implementation

{ TValidadorPessoa }

class procedure TValidadorPessoa.ValidarCliente(PPessoa: TPessoa);
begin

  ValidarNome(PPessoa.Nome);
  ValidarCPF(PPessoa.CPF);

  


end;

class procedure TValidadorPessoa.ValidarCPF(PCPF: string);
const
  erro: string = 'CPF inválido.';
var
  aValida, dig10, dig11: string;
  s, i, r, peso: integer;
begin

// length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
  aValida := {intToStr}(PCPF);
  if ((aValida = '00000000000') or (aValida = '11111111111') or
      (aValida = '22222222222') or (aValida = '33333333333') or
      (aValida = '44444444444') or (aValida = '55555555555') or
      (aValida = '66666666666') or (aValida = '77777777777') or
      (aValida = '88888888888') or (aValida = '99999999999') or
      (length(aValida) <> 11))
     then
  begin
    raise Exception.Create(erro);
  end;

// try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
// StrToInt converte o i-ésimo caractere do aValida em um número
      s := s + (StrToInt(aValida[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(aValida[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if not ((dig10 = aValida[10]) and (dig11 = aValida[11])) then
      raise Exception.Create(erro);        

  except
    raise Exception.Create(erro);
  end;
end;


class procedure TValidadorPessoa.ValidarNome(PNome: String);
var
  I: Integer;
begin
  if (PNome = '') then
    raise exception.Create('O campo nome não pode estar vazio');

  for I := 0 to PNome.Length do
  begin
    if not ((PNome[i] = #0) or ((PNome[i] in ['a'..'z']) or (PNome[i] in ['A'..'Z'])))then
    begin
      raise Exception.Create('Nome inválido, utilize apenas letras.');
      //ShowMessage(PNome[i]);
    end;
  end;

end;

class function TValidadorPessoa.trimCPF(PCPF: string): string;
var
  I: Integer;
  xTrimado: string;
begin
  xTrimado := '';
  for I := 0 to PCPF.Length do
  begin
    if (PCPF[I] in ['0'..'9']) then
    begin
      xTrimado := xTrimado + PCPF[I];
    end;
  end;
  Result := xTrimado;
end;

class procedure TValidadorPessoa.contaCaracteresCPF(PCPF: string);
begin
  if PCPF = '' then
    raise Exception.Create('Campo CPF vazio. Insira CPF válido.');
  if PCPF.length < 14 then
    raise Exception.Create('CPF incompleto. Insira CPF válido.');
end;

class function TValidadorPessoa.mascaraCPF(PCPF: string): string;
var
  xText: string;
begin
  try
    if PCPF.Length <> 14 then
    begin

      xText := trim(PCPF);
      if xText.length = 11 then
        PCPF := FormatMaskText('000\.000\.000\-00;0;', PCPF);
    end;
  finally
    Result := PCPF;
  end;
end;

end.
