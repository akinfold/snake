unit UfmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfmLogin = class(TForm)
    GroupBox1: TGroupBox;
    leLogin: TLabeledEdit;
    lePassword: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLogin: TfmLogin;

implementation

uses Main;

{$R *.dfm}

procedure TfmLogin.BitBtn2Click(Sender: TObject);
begin
  if (leLogin.Text <> '') and (lePassword.Text <> '') then begin
    ModalResult := mrOk;
  end else begin
    ShowMessage('Пожалуйста введите логин и пароль!');
  end;
end;

procedure TfmLogin.BitBtn1Click(Sender: TObject);
begin
  Close();
end;

end.
