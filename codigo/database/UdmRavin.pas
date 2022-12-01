unit UdmRavin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs, System.IOUtils;

type
  TdmRavin = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
    procedure cnxBancoDeDadosAfterConnect(Sender: TObject);
    procedure drvBancoDeDadosDriverCreated(Sender: TObject);
  private
    { Private declarations }
    procedure CriarTabelas();
    procedure InserirDados();
    procedure CarregaLib;
  public
    { Public declarations }
  end;

var
  dmRavin: TdmRavin;

implementation

uses
  UResourceUtils, UiniUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmRavin.CarregaLib;
//const Lib : string = 'libmysql.dll';
//const Pasta : string = 'ravin/bibliotecas';
var
  xLib : string;
  xPasta : String;
  xCaminhoPastaLib : string;
  xCaminhoLib : string;
begin
  xLib := TIniUtils.lerPropriedade(TSECAO.BANCO_DE_DADOS,
    TPROPRIEDADE.LIB);
  xPasta := TIniUtils.lerPropriedade(TSECAO.BANCO_DE_DADOS,
    TPROPRIEDADE.PASTA_LIB);
  xCaminhoPastaLib := TPath.Combine(TPath.GetDocumentsPath, xPasta);
  xCaminhoLib := TPath.Combine(xCaminhoPastaLib,xLib);
  drvBancoDeDados.VendorLib := xCaminhoLib;
end;

procedure TdmRavin.cnxBancoDeDadosAfterConnect(Sender: TObject);
var
  xCaminho : string;
  LCriarBaseDados: Boolean;
begin
   xCaminho := TIniUtils.lerPropriedade(TSECAO.CAMINHOSIBD,
    TPROPRIEDADE.PESSOA);  // Lê sessão CAMINHOSIBD propriedade PESSOA
  LCriarBaseDados := {not} FileExists(xCaminho);
  if not LCriarBaseDados then
    begin
      CriarTabelas;
      InserirDados;
    end;
end;

procedure TdmRavin.cnxBancoDeDadosBeforeConnect(Sender: TObject);
var
  LCriarBaseDados: Boolean;
  xServer:string;
  xUserName:string;
  xPassword:string;
  xDriverID:string;
  xPort:String;
  xDatabase:String;
  xCaminho: String;
begin
  xCaminho := TIniUtils.lerPropriedade(TSECAO.CAMINHOSIBD,
    TPROPRIEDADE.PESSOA);
  LCriarBaseDados := not FileExists(xCaminho);

  xServer := TIniUtils.lerPropriedade(TSECAO.BANCO_DE_DADOS,
    TPROPRIEDADE.SERVER);
  xUserName := TIniUtils.lerPropriedade(TSECAO.BANCO_DE_DADOS,
    TPROPRIEDADE.USER_NAME);
  xPassword := TIniUtils.lerPropriedade(TSECAO.BANCO_DE_DADOS,
    TPROPRIEDADE.PASSWORD);
  xDriverID := TIniUtils.lerPropriedade(TSECAO.BANCO_DE_DADOS,
    TPROPRIEDADE.DRIVER_ID);
  xPort := TIniUtils.lerPropriedade(TSECAO.BANCO_DE_DADOS,
    TPROPRIEDADE.PORT);
  xDatabase := TIniUtils.lerPropriedade(TSECAO.BANCO_DE_DADOS,
    TPROPRIEDADE.DATABASE);
  with cnxBancoDeDados do
  begin
    Params.Values['Server'] := xServer;
    Params.Values['User_Name'] := xUserName;
    Params.Values['Password'] := xPassword;
    Params.Values['DriverId'] := xDriverID;
    Params.Values['Port'] := xPort;

    if not LCriarBaseDados then
      begin
        Params.Values['Database'] := xDatabase;
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
  CarregaLib;//drvBancoDeDados.VendorLib := TResourceUtils.carregarArquivoResource('libmysql.dll','ravin/bibliotecas');
  if not cnxBancoDeDados.Connected then
    begin
      cnxBancoDeDados.Connected := true;
    end;
end;


procedure TdmRavin.drvBancoDeDadosDriverCreated(Sender: TObject);
begin
  //drvBancoDeDados.VendorLib := TResourceUtils.carregarArquivoResource('libmysql.dll','ravin/bibliotecas');
end;

procedure TdmRavin.InserirDados;
var
  LSqlArquivoScripts: TStringList;
  LCaminhoArquivo: String;
begin
  //LSqlArquivoScripts := TStringList.Create;
  //LCaminhoArquivo := 'C:\Users\Ultrabook Lenovo\Documents\ravin\database/inserts.sql';
  //LCaminhoArquivo := TResourceUtils.carregarArquivoResource('inserts.sql','ravin/database');
  //'C:\Users\Ultrabook Lenovo\Documents\ravin\database/inserts.sql';
  //'C:\Users\dtlsilva\Documents\ravin\database\inserts.sql';
  //LSqlArquivoScripts.LoadFromFile(TResourceUtils.carregarArquivoResource('inserts.sql','ravin/database'));

  //Trye e pressionar TAB cria automaticamente
  try
    //cnxBancoDeDados.StartTransaction;
    cnxBancoDeDados.ExecSQL(TResourceUtils.carregarArquivoResource('inserts.sql','ravin teste'));
    //cnxBancoDeDados.Commit;
  except
    on E: Exception do Begin
      cnxBancoDeDados.Rollback;
      ShowMessage('Não foi possível concluir o processo!');
    End;
  end;

  //FreeAndNil(LSqlArquivoScripts);
end;

end.
