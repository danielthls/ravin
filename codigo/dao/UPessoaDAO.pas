unit UPessoaDAO;

interface

uses

UPessoa, FireDAC.Comp.Client, System.SysUtils, System.Generics.Collections;

type
TPessoaDAO = class
  private

  protected

  public
  procedure InserirPessoa(PPessoa: TPessoa);
  function BuscarTodasAsPessoas: TList<TPessoa>;

end;

implementation

uses
  UdmRavin;

{ TPessoaDAO }

function TPessoaDAO.BuscarTodasAsPessoas: TList<TPessoa>;
var
  xLista: TList<TPessoa>;
  xPessoa: TPessoa;
  xQuery: TFDQuery;
begin
  xQuery := nil;
  xQuery.Connection := dmRavin.cnxBancoDeDados;
  xQuery.SQL.Text := 'Select * from pessoa';
  xQuery.Open;
  xQuery.First;
  while not xQuery.Eof do begin
    xPessoa := xPessoa.Create;
    xPessoa.id := xQuery.FieldByName('id').AsInteger;
    xPessoa.nome := xQuery.FieldByName('nome').AsString;
    xPessoa.tipoPessoa := xQuery.FieldByName('tipoPessoa').AsString;
    xPessoa.cpf := xQuery.FieldByName('cpf').AsInteger;
    xPessoa.telefone := xQuery.FieldByName('telefone').AsInteger;
    xPessoa.ativo := xQuery.FieldByName('ativo').AsInteger;
    xPessoa.criadoEm := xQuery.FieldByName('criadoEm').AsDateTime;
    xPessoa.criadoPor := xQuery.FieldByName('criadoPor').AsString;
    xPessoa.alteradoEm := xQuery.FieldByName('alteradoEm').AsDateTime;
    xPessoa.alteradoPor := xQuery.FieldByName('alteradoPor').AsString;
    xLista.Add(xPessoa);
    xQuery.Next;
  end;
  xQuery.Close();
  FreeAndNil(xQuery);
  Result := xLista;
end;

procedure TPessoaDAO.InserirPessoa(PPessoa: TPessoa);
var
  xQuery: TFDQuery;
begin
  xQuery := nil;
  with xQuery do
  begin
    xQuery.SQL.Text := 'INSERT INTO pessoa' +
      'nome, tipoPessoa, cpf, telefone, ativo, criadoEm, CriadoPor, AlteradoEm, AlteradoPor' +
      'VALUES (:nome, :tipoPessoa, :cpf, :telefone, :ativo, :criadoEm, :CriadoPor, :AlteradoEm, :AlteradoPor)';

    ParamByName('nome').AsString := PPessoa.nome;
    ParamByName('tipoPessoa').AsString := PPessoa.tipoPessoa;
    ParamByName('cpf').AsInteger := PPessoa.cpf;
    ParamByName('telefone').AsInteger := PPessoa.telefone;
    ParamByName('ativo').AsInteger := PPessoa.ativo;
    ParamByName('criadoEm').AsDateTime := PPessoa.criadoEm;
    ParamByName('criadoPor').AsString := PPessoa.criadoPor;
    ParamByName('alteradoEm').AsDateTime := PPessoa.alteradoEm;
    ParamByName('alteradoPor').AsString := PPessoa.alteradoPor;
    ExecSQL();
  end;
  freeAndNil(xQuery);
end;

end.
