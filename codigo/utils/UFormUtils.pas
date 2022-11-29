unit UFormUtils;

interface

uses
system.SysUtils, System.Classes, System.Variants, VCL.Forms;

type

  TFormUtils = class
  private

  public

  class procedure SetarFormPrincipal(NewMainForm: TForm);

  end;

implementation

{ TFormUtils }

class procedure TFormUtils.SetarFormPrincipal(NewMainForm: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := NewMainForm;
end;

end.
