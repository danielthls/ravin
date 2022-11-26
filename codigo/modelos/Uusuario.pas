unit Uusuario;

interface

type TUsuario = class
  private
  Fid: Integer;
  fLogin: string;
  fSenha: String;
  fPessoaId: integer;
  fCriadoEm: tDateTime;
  fCriadoPor: String;
  fAlteradoEm: TDateTime;
  fAlteradoPor: String;
  protected

  public
  property id: integer read fid write fid;
  property login: string read fLogin write fLogin;
  property senha: string read fSenha write fSenha;
  property pessoaId: integer read fPessoaId write fPessoaId;
  property criadoEm: TDateTime read fCriadoEm write fCriadoEm;
  property criadoPor: String read fCriadoPor write fCriadoPor;
  property alteradoEm: TDateTime read fAlteradoEm write fAlteradoEm;
  property alteradoPor: String read fAlteradoPor write fAlteradoPor;


end;

implementation

end.
