program TesteWK;

uses
  Vcl.Forms,
  unPrincipal in 'unPrincipal.pas' {Form1},
  uDm_Principal in 'uDm_Principal.pas' {DM_Principal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM_Principal, DM_Principal);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
