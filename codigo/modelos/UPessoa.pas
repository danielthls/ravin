unit UPessoa;

interface

type

TPessoa = class
  private
  fId: Integer;
  fNome: String;
  fTipoPessoa: String;
  fCpf: string;
  fTelefone: integer;
  fAtivo: integer;
  fCriadoEm: TDateTime;
  fCriadoPor: String;
  fAlteradoEm: TDateTime;
  fAlteradoPor: String;
  fDataNascimento: TDate;
  fEmail: String;
    function getAlteradoEm: TDateTime;
    function getAlteradoPor: String;
    function getAtivo: integer;
    function getCPF: string;
    function getCriadoEm: TDateTime;
    function getCriadoPor: string;
    function getId: integer;
    function getNome: string;
    function getTelefone: integer;
    function getTipoPessoa: String;
    procedure setAlteradoEm(const Value: TDateTime);
    procedure setAlteradoPor(const Value: String);
    procedure setAtivo(const Value: integer);
    procedure setCPF(const Value: string);
    procedure setCriadoEm(const Value: TDateTime);
    procedure setCriadoPor(const Value: string);
    procedure setId(const Value: integer);
    procedure setNome(const Value: string);
    procedure setTelefone(const Value: integer);
    procedure setTipoPessoa(const Value: String);
    function getDataNascimento: TDate;
    function getEmail: String;
    procedure setDataNascimento(const Value: TDate);
    procedure setEmail(const Value: String);
  protected

  public
  property Id: integer read getId write setId;
  property Nome: string read getNome write setNome;
  property TipoPessoa: String read getTipoPessoa write setTipoPessoa;
  property CPF: string read getCPF write setCPF;
  property Telefone: integer read getTelefone write setTelefone;
  property Ativo: integer read getAtivo write setAtivo;
  property CriadoEm: TDateTime read getCriadoEm write setCriadoEm;
  property CriadoPor: string read getCriadoPor write setCriadoPor;
  property AlteradoEm: TDateTime read getAlteradoEm write setAlteradoEm;
  property AlteradoPor: String read getAlteradoPor write setAlteradoPor;
  property DataNascimento: TDate read getDataNascimento write setDataNascimento;
  property Email: String read getEmail write setEmail;

end;

implementation

{ TPessoa }

function TPessoa.getAlteradoEm: TDateTime;
begin
  Result := fAlteradoEm;
end;

function TPessoa.getAlteradoPor: String;
begin
  Result := fAlteradoPor;
end;

function TPessoa.getAtivo: integer;
begin
  Result := fAtivo;
end;

function TPessoa.getCPF: string;
begin
  Result := fCPF;
end;

function TPessoa.getCriadoEm: TDateTime;
begin
  Result := fCriadoEm;
end;

function TPessoa.getCriadoPor: string;
begin
  Result := fCriadoPor;
end;

function TPessoa.getDataNascimento: TDate;
begin
  Result := fDataNascimento;
end;

function TPessoa.getEmail: String;
begin
  Result := fEmail;
end;

function TPessoa.getId: integer;
begin
  Result := fId;
end;

function TPessoa.getNome: string;
begin
  Result := fNome;
end;

function TPessoa.getTelefone: integer;
begin
  Result := fTelefone;
end;

function TPessoa.getTipoPessoa: String;
begin
  Result := fTipoPessoa;
end;

procedure TPessoa.setAlteradoEm(const Value: TDateTime);
begin
  fAlteradoEm := Value;
end;

procedure TPessoa.setAlteradoPor(const Value: String);
begin
  fAlteradoPor := Value;
end;

procedure TPessoa.setAtivo(const Value: integer);
begin
   fAtivo := Value;
end;

procedure TPessoa.setCPF(const Value: string);
begin
   fCPF := Value;
end;

procedure TPessoa.setCriadoEm(const Value: TDateTime);
begin
  fCriadoEm := Value;
end;

procedure TPessoa.setCriadoPor(const Value: string);
begin
  fCriadoPor := Value;
end;

procedure TPessoa.setDataNascimento(const Value: TDate);
begin
  fDataNascimento := Value;
end;

procedure TPessoa.setEmail(const Value: String);
begin
  fEmail := Value;
end;

procedure TPessoa.setId(const Value: integer);
begin
  fId := Value;
end;

procedure TPessoa.setNome(const Value: string);
begin
  fNome := Value;
end;

procedure TPessoa.setTelefone(const Value: integer);
begin
  fTelefone := Value;
end;

procedure TPessoa.setTipoPessoa(const Value: String);
begin
  fTipoPessoa := Value;
end;

end.
