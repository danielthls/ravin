unit UdmRavin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs;

type
  TdmRavin = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
    procedure cnxBancoDeDadosAfterConnect(Sender: TObject);
  private
    { Private declarations }
    procedure CriarTabelas();
    procedure InserirDados();
  public
    { Public declarations }
  end;

var
  dmRavin: TdmRavin;

implementation

uses
  UResourceUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmRavin.cnxBancoDeDadosAfterConnect(Sender: TObject);
var
  LCriarBaseDados: Boolean;
begin
  LCriarBaseDados := not FileExists('C:\ProgramData\MySQL\' +
                                    'MySQL Server 8.0\Data\ravin\pessoa.ibd');
  if LCriarBaseDados then
    begin
      CriarTabelas;
      InserirDados;
    end;
end;

procedure TdmRavin.cnxBancoDeDadosBeforeConnect(Sender: TObject);
var
  LCriarBaseDados: Boolean;
begin
  LCriarBaseDados := not FileExists('C:\ProgramData\MySQL\' +
                                    'MySQL Server 8.0\Data\ravin\pessoa.ibd');
  with cnxBancoDeDados do
  begin
    Params.Values['Server'] := 'localhost';
    Params.Values['User_Name'] := 'root';
    Params.Values['Password'] := 'root';
    Params.Values['DriverId'] := 'MySQL';
    Params.Values['Port'] := '3306';

    if not LCriarBaseDados then
      begin
        Params.Values['Database'] := 'ravin';
      end;
  end;

end;

procedure TdmRavin.CriarTabelas;
//var
  //LSqlArquivoScripts: TStringList;
  //LCaminhoArquivo: String;
  //COMPONENTE CRIADO EM TELA
  //LQuery: TFDQuery;
begin
  {*  COMO NÃO DEVE SER FEITO
  LSqlArquivoScripts := TStringList.Create;

  //LCaminhoArquivo := 'C:\Users\dtlsilva\Documents\ravin\database\createTable.sql';
  //LSqlArquivoScripts.LoadFromFile(LCaminhoArquivo);
  //cnxBancoDeDados.ExecSQL(LSqlArquivoScripts.Text);
  //FreeAndNil(LSqlArquivoScripts);


  //COMPONENTE CRIADO EM TELA
  //LQuery := TFDQuery.Create(Self);
  //LQuery.Connection := cnxBancoDeDados;
  //LQuery.SQL.Text := 'SELECT * FROM PESSOAS';*}
  try
    cnxBancoDeDados.ExecSQL(TResourceUtils.carregarArquivoResource('createTable.sql','ravin teste'));
  except
   on E: Exception do
    ShowMessage(E.Message);

  end;
end;

procedure TdmRavin.DataModuleCreate(Sender: TObject);
begin
  if not cnxBancoDeDados.Connected then
    begin
      cnxBancoDeDados.Connected := true;
    end;
end;

procedure TdmRavin.InserirDados;
var
  LSqlArquivoScripts: TStringList;
  LCaminhoArquivo: String;
begin
  LSqlArquivoScripts := TStringList.Create;
  LCaminhoArquivo := 'C:\Users\dtlsilva\Documents\ravin\database\inserts.sql';
  LSqlArquivoScripts.LoadFromFile(LCaminhoArquivo);

  //Trye e pressionar TAB cria automaticamente
  try
    cnxBancoDeDados.StartTransaction;
    cnxBancoDeDados.ExecSQL(TResourceUtils.carregarArquivoResource('createTable.sql','ravin teste'));
    cnxBancoDeDados.Commit;
  except
    on E: Exception do Begin
      cnxBancoDeDados.Rollback;
      ShowMessage('Não foi possível concluir o processo!');
    End;
  end;

  FreeAndNil(LSqlArquivoScripts);
end;

end.
