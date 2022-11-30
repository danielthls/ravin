unit UResourceUtils;

interface

USES
  System.SysUtils, System.IOUtils, System.Classes;

type TResourceUtils = class(TObject)
  private

  protected

  public
  class function carregarArquivoResource(PNomeArquivo: String; PNomeAplicacao: String): String;
end;

implementation

{ TResourceUtils }

class function TResourceUtils.carregarArquivoResource(PNomeArquivo,
  PNomeAplicacao: String): String;
var
  LConteudoArquivo: TStringList;
  LCaminhoArquivo: String;
  LCaminhoPastaAplicacao: String;
  LConteudo: String;
begin
  LConteudoArquivo := TStringList.Create();
  try
    try
      LCaminhoPastaAplicacao := TPath.Combine(TPath.GetDocumentsPath, PNomeAplicacao);
      LCaminhoArquivo := TPath.Combine(LCaminhoPastaAplicacao, PNomeArquivo);

      LConteudoArquivo.LoadFromFile(LCaminhoArquivo);

      LConteudo := LConteudoArquivo.Text;
    except
      on E: Exception do
        raise Exception.Create('Erro ao carregar os arquivos de resource.' +
        'Arquivo: ' + PNomeArquivo);
    end
  finally
    LConteudoArquivo.Free;
  end;

  Result := LConteudo;
end;

end.
