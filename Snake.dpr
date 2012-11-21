program Snake;

uses
  Forms,
  Controls,
  Main in 'Main.pas' {Form1},
  USnake in 'USnake.pas',
  UfmLogin in 'UfmLogin.pas' {fmLogin},
  Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfmLogin, fmLogin);
  Application.CreateForm(TForm2, Form2);
  if fmLogin.ShowModal() = mrOk then
    Form1.NewGame(fmLogin.leLogin.Text, fmLogin.lePassword.Text)
  else
    Application.Terminate;
  Application.Run;
end.
