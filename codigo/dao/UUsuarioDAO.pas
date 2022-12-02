unit UUsuarioDAO;

interface

uses
  UPessoaDAO, UUsuario, FireDAC.Comp.Client, System.SysUtils, System.Generics.Collections;

type
  TUsuarioDAO = class
  private

  protected

  public
    function getPessoaID: integer;
    function BuscarUsuarioPorLoginSenha(PLogin, PSenha: String): TUsuario;
    procedure InserirUsuario(PUsuario: TUsuario);
    function BuscasTodosUsuarios: TList<TUsuario>;

  end;

implementation

{ TUsuarioDAO }

uses UdmRavin, UPessoa;

function TUsuarioDAO.BuscarUsuarioPorLoginSenha(PLogin, PSenha: String)
  : TUsuario;
var
  LQuery: TFDQuery;
  LUsuario: TUsuario;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'Select * from usuario ' +
    'where login = :login and senha = :senha ';
  LQuery.ParamByName('login').AsString := PLogin;
  LQuery.ParamByName('senha').AsString := PSenha;
  LQuery.Open();

  LUsuario := nil; // Para não haver sujeira na merória

  if not LQuery.IsEmpty then // Verifica se o LQuery retornou algo
  begin
    LUsuario := TUsuario.Create();
    LUsuario.id := LQuery.FieldByName('id').AsInteger;
    LUsuario.login := LQuery.FieldByName('login').AsString;
    LUsuario.senha := LQuery.FieldByName('senha').AsString;
    LUsuario.pessoaId := LQuery.FieldByName('pessoaId').AsInteger;
    LUsuario.criadoEm := LQuery.FieldByName('criadoEm').AsDateTime;
    LUsuario.criadoPor := LQuery.FieldByName('criadoPor').AsString;
    LUsuario.alteradoEm := LQuery.FieldByName('alteradoEm').AsDateTime;
    LUsuario.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;
  end;

  LQuery.Close();
  FreeAndNil(LQuery);
  Result := LUsuario;

end;

function TUsuarioDAO.BuscasTodosUsuarios: TList<TUsuario>;
var
  LLista: TList<TUsuario>;
  LUsuario: TUsuario;
  LQuery: TFDQuery;
begin
  LLista:= TList<TUsuario>.Create;
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'Select * from usuario';
  LQuery.Open;
  LQuery.First;

  while not LQuery.Eof do begin
    LUsuario := TUsuario.Create;
    LUsuario.id := LQuery.FieldByName('id').AsInteger;
    LUsuario.login := LQuery.FieldByName('login').AsString;
    LUsuario.senha := LQuery.FieldByName('senha').AsString;
    LUsuario.pessoaId := LQuery.FieldByName('pessoaId').AsInteger;
    LUsuario.criadoEm := LQuery.FieldByName('criadoEm').AsDateTime;
    LUsuario.criadoPor := LQuery.FieldByName('criadoPor').AsString;
    LUsuario.alteradoEm := LQuery.FieldByName('alteradoEm').AsDateTime;
    LUsuario.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;
    LLista.Add(LUsuario);
    LQuery.Next;
  end;
  LQuery.Close();
  FreeAndNil(LQuery);
  Result := LLista;
end;

function TUsuarioDAO.getPessoaID: integer;
var
  xPessoaDAO: TPessoaDAO;
  xPessoa: TPessoa;
  xID: integer;
begin
  xPessoaDao := TPessoaDao.Create;
  xID := 0;
  try
    xPessoa := xPessoaDAO.BuscarUltimaPessoaInserida;
    xID := xPessoa.id;
    freeAndNil(xPessoa);
  finally
    freeAndNil(xPessoaDAO);
    Result := xID
  end;
end;

procedure TUsuarioDAO.InserirUsuario(PUsuario: TUsuario);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  with LQuery do
  begin
    Connection := dmRavin.cnxBancoDeDados;
    SQL.Add('INSERT INTO usuario ');
    SQL.Add(' (login,  senha,  pessoaId, criadoEm, ');
    SQL.Add('  criadoPor, alteradoEm, alteradoPor) ');
    SQL.Add('  VALUES (:login, :senha, :pessoaid, :criadoEm,  ');
    SQL.Add(' :criadoPor, :alteradoEm, :alteradoPor) ');

    ParamByName('login').AsString := PUsuario.login;
    ParamByName('senha').AsString := PUsuario.senha;
    ParamByName('pessoaId').AsInteger := PUsuario.pessoaId;
    ParamByName('criadoEm').AsDateTime := PUsuario.criadoEm;
    ParamByName('criadoPor').AsString := PUsuario.criadoPor;
    ParamByName('alteradoEm').AsDateTime := PUsuario.alteradoEm;
    ParamByName('alteradoPor').AsString := PUsuario.alteradoPor;
    ExecSQL();
  end;
  FreeAndNil(LQuery);
end;

end.
