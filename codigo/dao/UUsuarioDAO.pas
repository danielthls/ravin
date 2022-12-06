unit UUsuarioDAO;

interface

uses
  UPessoa, UPessoaDAO, UUsuario, FireDAC.Comp.Client, System.SysUtils, System.Generics.Collections;

type
  TUsuarioDAO = class
  private

  protected

  public
    function getPessoaID: integer;
    function BuscarUsuarioPorLoginSenha(PLogin, PSenha: String): TUsuario;
    procedure InserirUsuario(PUsuario: TUsuario);
    function BuscasTodosUsuarios: TList<TUsuario>;
    function BuscarUsuarioPorLogin(PLogin: string): TUsuario;
    class function PreencherTUsuario(PQuery: TFDQuery): TUsuario;
    function buscarFuncionarioPorLogin(PLogin: String): TPessoa;

  end;

implementation

{ TUsuarioDAO }

uses UdmRavin;

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
    LUsuario := PreencherTUsuario(LQuery);
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
    LUsuario := PreencherTUsuario(LQuery);
    LLista.Add(LUsuario);
    LQuery.Next;
  end;
  LQuery.Close();
  FreeAndNil(LQuery);
  Result := LLista;
end;

function TUsuarioDAO.buscarFuncionarioPorLogin(PLogin: String): TPessoa;
var
  xQuery : TFDQuery;
  xPessoa: TPessoa;
  xUsuario: TUsuario;
begin
  xQuery := TFDQuery.Create(nil);
  xQuery.Connection := dmRavin.cnxBancoDeDados;
  xUsuario := BuscarUsuarioPorLogin(PLogin);
  xQuery.SQL.Text := 'SELECT * FROM pessoa WHERE id = ' + intToStr(xUsuario.pessoaId);
  xQuery.Open;
  freeAndNil(xUsuario);
  if not xQuery.IsEmpty then
  begin
    xPessoa := TPessoaDAO.PreencherTPessoa(xQuery)
  end
  else
    raise Exception.Create('Erro. Usuário não cadastrado na tabela Pessoa');
  xQuery.Close;
  freeAndNil(xQuery);
  Result := xPessoa;
end;

function TUsuarioDAO.buscarUsuarioPorLogin(PLogin: string): TUsuario;
var
  xQuery: TFDQuery;
  xUsuario: TUsuario;
begin
  xQuery := TFDQuery.Create(nil);
  xQuery.Connection := dmRavin.cnxBancoDeDados;
  xQuery.SQL.Text := 'Select * from usuario ' +
    'where login = :login';
  xQuery.ParamByName('login').AsString := PLogin;
  xQuery.Open();

  xUsuario := nil; // Para não haver sujeira na merória

  if not xQuery.IsEmpty then // Verifica se o LQuery retornou algo
  begin
    xUsuario := PreencherTUsuario(XQuery);
  end;

  xQuery.Close();
  FreeAndNil(xQuery);
  Result := xUsuario;
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

class function TUsuarioDAO.PreencherTUsuario(PQuery: TFDQuery): TUsuario;
var
  xUsuario: TUsuario;
begin
  xUsuario := TUsuario.Create;
  xUsuario.id := PQuery.FieldByName('id').AsInteger;
  xUsuario.login := PQuery.FieldByName('login').AsString;
  xUsuario.senha := PQuery.FieldByName('senha').AsString;
  xUsuario.pessoaId := PQuery.FieldByName('pessoaId').AsInteger;
  xUsuario.criadoEm := PQuery.FieldByName('criadoEm').AsDateTime;
  xUsuario.criadoPor := PQuery.FieldByName('criadoPor').AsString;
  xUsuario.alteradoEm := PQuery.FieldByName('alteradoEm').AsDateTime;
  xUsuario.alteradoPor := PQuery.FieldByName('alteradoPor').AsString;
  Result := xUsuario;
end;

end.
