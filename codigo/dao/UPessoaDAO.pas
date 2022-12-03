unit UPessoaDAO;

interface

uses

UUsuarioDAO, UPessoa, FireDAC.Comp.Client, System.SysUtils, System.Generics.Collections;

type
TPessoaDAO = class
  private

  protected

  public
  procedure InserirPessoa(PPessoa: TPessoa);
  function BuscarTodasAsPessoas: TList<TPessoa>;
  function BuscarTodosOsClientes: TList<TPessoa>;
  function BuscarPessoaPorID(PId: integer): TPessoa;
  function BuscarUltimaPessoaInserida: TPessoa;
  function PreencherTPessoa(PQuery: TFDQuery): TPessoa;
  procedure ExcluirPessoa(pID: Integer);
  function buscarFunctionarioPorLogin(
  //function BuscarUltimaPessoaInseridaB: Integer;

end;

implementation

uses
  UdmRavin;

{ TPessoaDAO }

function TPessoaDAO.BuscarPessoaPorID(PId: Integer): TPessoa;
var
  xQuery: TFDQuery;
  xPessoa: TPessoa;
begin
  xQuery := TFDQuery.Create(nil);
  xQuery.Connection := dmRavin.cnxBancoDeDados;
  xQuery.SQL.Text := 'Select * from pessoa ' +
    'where id = :id ';
  xQuery.ParamByName('id').AsInteger := PId;
  xQuery.Open();

  xPessoa := nil; // Para não haver sujeira na merória

  if not xQuery.IsEmpty then // Verifica se o LQuery retornou algo
  begin
    xPessoa := PreencherTPessoa(xQuery);
  end;

  xQuery.Close();
  FreeAndNil(xQuery);
  Result := xPessoa;


end;

function TPessoaDAO.BuscarTodasAsPessoas: TList<TPessoa>;
var
  xLista: TList<TPessoa>;
  xPessoa: TPessoa;
  xQuery: TFDQuery;
begin
  xLista := TList<TPessoa>.create;
  xQuery := TFDQuery.Create(nil);
  xQuery.Connection := dmRavin.cnxBancoDeDados;
  xQuery.SQL.Text := 'Select * from pessoa';
  xQuery.Open;
  xQuery.First;
  while not xQuery.Eof do begin
    xPessoa := PreencherTPessoa(xQuery);
    xQuery.Next;
  end;
  xQuery.Close();
  FreeAndNil(xQuery);
  Result := xLista;
end;

function TPessoaDAO.BuscarTodosOsClientes: TList<TPessoa>;
var
  xLista: TList<TPessoa>;
  xPessoa: TPessoa;
  xQuery: TFDQuery;
begin
  xLista := TList<TPessoa>.create;
  xQuery := TFDQuery.Create(nil);
  xQuery.Connection := dmRavin.cnxBancoDeDados;
  xQuery.SQL.Text := 'Select * from pessoa where tipoPessoa = "c"';
  xQuery.Open;
  xQuery.First;
  while not xQuery.Eof do begin
    xPessoa := PreencherTPessoa(xQuery);
    xQuery.Next;
    xLista.Add(xPessoa);
  end;
  xQuery.Close();
  FreeAndNil(xQuery);
  Result := xLista;
end;

function TPessoaDAO.BuscarUltimaPessoaInserida: TPessoa;
var
  xQuery: TFDQuery;
  xPessoa: TPessoa;
begin
  xQuery := TFDQuery.Create(nil);
  xQuery.Connection := dmRavin.cnxBancoDeDados;
  xQuery.SQL.Text := 'Select * from pessoa where id = (select max(id) from pessoa)';
  xQuery.Open();


  xPessoa := nil; // Para não haver sujeira na merória

  if not xQuery.IsEmpty then // Verifica se o xQuery retornou algo
  begin
    xPessoa := PreencherTPessoa(xQuery);
  end;

  xQuery.Close();
  FreeAndNil(xQuery);
  Result := xPessoa;

end;

procedure TPessoaDAO.ExcluirPessoa(pID: Integer);
var
  xQuery: TFDQuery;
begin
  xQuery := TFDQuery.Create(nil);
  with xQuery do
  begin
    Connection := dmRavin.cnxBancoDeDados;
    xQuery.SQL.Text := 'DELETE FROM pessoa WHERE id = ' + intToStr(pID);
    ExecSQL;
  end;
  freeAndNil(xQuery);
end;

procedure TPessoaDAO.InserirPessoa(PPessoa: TPessoa);
var
  xQuery: TFDQuery;
begin
  xQuery := TFDQuery.Create(nil);
  with xQuery do
  begin
    Connection := dmRavin.cnxBancoDeDados;
    xQuery.SQL.Text := 'INSERT INTO pessoa' +
      '(nome, tipoPessoa, cpf, telefone, ativo, criadoEm, CriadoPor, AlteradoEm, AlteradoPor, DataNascimento, Email)' +
      'VALUES (:nome, :tipoPessoa, :cpf, :telefone, :ativo, :criadoEm, :CriadoPor, :AlteradoEm, :AlteradoPor, :DataNascimento, :Email)';

    ParamByName('nome').AsString := PPessoa.nome;
    ParamByName('tipoPessoa').AsString := PPessoa.tipoPessoa;
    ParamByName('cpf').AsString := PPessoa.cpf;
    ParamByName('telefone').AsInteger := PPessoa.telefone;
    ParamByName('ativo').AsInteger := PPessoa.ativo;
    ParamByName('criadoEm').AsDateTime := PPessoa.criadoEm;
    ParamByName('criadoPor').AsString := PPessoa.criadoPor;
    ParamByName('alteradoEm').AsDateTime := PPessoa.alteradoEm;
    ParamByName('alteradoPor').AsString := PPessoa.alteradoPor;
    ParamByName('DataNascimento').AsDate := PPessoa.DataNascimento;
    ParamByName('email').AsString := PPessoa.email;
    ExecSQL();
  end;
  freeAndNil(xQuery);
end;

function TPessoaDAO.PreencherTPessoa(PQuery: TFDQuery): TPessoa;
var
  xPessoa: TPessoa;
begin
  xPessoa := TPessoa.Create;
  xPessoa.id := PQuery.FieldByName('id').AsInteger;
  xPessoa.nome := PQuery.FieldByName('nome').AsString;
  xPessoa.tipoPessoa := PQuery.FieldByName('tipoPessoa').AsString;
  xPessoa.cpf := PQuery.FieldByName('cpf').AsString;
  xPessoa.telefone := PQuery.FieldByName('telefone').AsInteger;
  xPessoa.ativo := PQuery.FieldByName('ativo').AsInteger;
  xPessoa.criadoEm := PQuery.FieldByName('criadoEm').AsDateTime;
  xPessoa.criadoPor := PQuery.FieldByName('criadoPor').AsString;
  xPessoa.alteradoEm := PQuery.FieldByName('alteradoEm').AsDateTime;
  xPessoa.alteradoPor := PQuery.FieldByName('alteradoPor').AsString;
  xPessoa.DataNascimento := PQuery.FieldByName('dataNascimento').AsDateTime;
  xPessoa.email := PQuery.FieldByName('email').AsString;
  Result := xPessoa;
end;

end.
