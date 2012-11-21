unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, ComCtrls, DB, USnake, DBClient, ADODB, Math,
  StdCtrls;

type
  TSpeed = 1..18;

  TForm1 = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    adotblPlayers: TADOTable;
    ADOConnection1: TADOConnection;
    adotblPlayersplayer_id: TAutoIncField;
    adotblPlayerslogin: TWideStringField;
    adotblPlayerspassword: TWideStringField;
    adotblPlayerslevel: TIntegerField;
    adotblPlayersscore: TIntegerField;
    adotblPlayersspeed: TIntegerField;
    adotblPlayersdate_last: TDateTimeField;
    adotblPlayerstime_last: TDateTimeField;
    adotblLevels: TADOTable;
    adotblLevelslevel_id: TAutoIncField;
    adotblLevelsstart_speed: TSmallintField;
    adotblLevelsstart_length: TIntegerField;
    adotblLevelsend_length: TIntegerField;
    adotblLevelspole_id: TIntegerField;
    TimerSpeedUp: TTimer;
    adotblPoles: TADOTable;
    adotblPolescell_id: TAutoIncField;
    adotblPolespole_id: TIntegerField;
    adotblPolesX: TWordField;
    adotblPolesY: TWordField;
    adotblPolestype: TWordField;
    adotblLevelsspeedup_interval: TIntegerField;
    adotblChampions: TADOTable;
    adotblChampionslogin: TWideStringField;
    adotblChampionspassword: TWideStringField;
    adotblChampionslevel: TWordField;
    adotblChampionsscore: TIntegerField;
    adotblChampionsrecord_date: TDateTimeField;
    adotblChampionsrecord_time: TDateTimeField;
    N4: TMenuItem;
    N5: TMenuItem;
    lblScreenMessage: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    procedure NewGame(Login, Password: string);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TimerSpeedUpTimer(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button1Click2(Sender: TObject);
    procedure Button1Click3(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Snake: TSnake;
  Pole: TPole;
  Speed: TSpeed;
  Level: Integer;
  EndLength: Integer;
  UserName: string;
  UserPassword: string;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.NewGame(Login, Password: string);
var
  TempScore: Integer;
  TempStartLength: Integer;
  TempPoleID: Integer;
begin
  UserName := Login;
  UserPassword := Password;
  adotblPlayers.Open();
  if not adotblPlayers.Locate('login;password', VarArrayOf([Login, Password]), [loCaseInsensitive]) then begin
    Speed := 1;
    Level := 1;
    TempScore := 0;
    adotblPlayers.Insert();
    adotblPlayers.FieldByName('login').AsString := Login;
    adotblPlayers.FieldByName('password').AsString := Password;
    adotblPlayers.FieldByName('level').AsInteger := Level;
    adotblPlayers.FieldByName('score').AsInteger := TempScore;
    adotblPlayers.FieldByName('speed').AsInteger := Speed;
    adotblPlayers.FieldByName('date_last').AsDateTime := Date();
    adotblPlayers.FieldByName('time_last').AsDateTime := Time();
    adotblPlayers.Post();
  end else begin
    Speed := adotblPlayers.FieldByName('speed').AsInteger;
    Level := adotblPlayers.FieldByName('level').AsInteger;
    TempScore := adotblPlayers.FieldByName('score').AsInteger
  end;
  adotblPlayers.Close();

  adotblLevels.Open();
  if adotblLevels.Locate('level_id', Level, []) then begin
    Speed := max(Speed, adotblLevels.FieldByName('start_speed').AsInteger);
    TempPoleID := adotblLevels.FieldByName('pole_id').AsInteger;
    TempStartLength := adotblLevels.FieldByName('start_length').AsInteger;
    EndLength := adotblLevels.FieldByName('end_length').AsInteger;
    TimerSpeedUp.Interval := adotblLevels.FieldByName('speedup_interval').AsInteger;
  end else begin
    Level := 1;
    TempScore := 0;
    Speed := 1;
    TempPoleID := 1;
    TempStartLength := 5;
    EndLength := 10;
    TimerSpeedUp.Interval := 180000;
  end;
  adotblLevels.Close();

  Pole.Create(Image1, 50, 50);

  with adotblPoles do begin
    Open();
    Sort := 'pole_id ASC';
    Filter := 'pole_id = ' + IntToStr(TempPoleID);
    Filtered := true;
    First();
    while not EOF do begin
      if  (FieldByName('X').AsInteger <= 50)
      and (FieldByName('X').AsInteger >= 0)
      and (FieldByName('Y').AsInteger <= 50)
      and (FieldByName('Y').AsInteger >= 0)
      and (FieldByName('type').AsInteger > 0)
      and (FieldByName('type').AsInteger <= 255) then
        Pole.Pole[FieldByName('X').AsInteger, FieldByName('Y').AsInteger] := FieldByName('type').AsInteger;
      Next();
    end;
    Close();
  end;

  Snake.Create(25,50,TempStartLength,TempScore,1,clGreen,Pole);
  Button1.OnClick := Button1Click;
  lblScreenMessage.Caption := 'Óðîâåíü ' + IntToStr(Level) + ' ÑÒÀÐÒ';
  Panel1.Show();
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if not Snake.Move() then begin
    Timer1.Enabled := false;
    TimerSpeedUp.Enabled := false;
    lblScreenMessage.Caption := 'ÊÎÍÅÖ ÈÃÐÛ';
    with adotblChampions do begin
      MaxRecords := 10;
      Open();
      Sort := 'score ASC';
      First();
      MoveBy(10);
      if FieldByName('score').AsInteger <= Snake.Score then begin
        Append();
        FieldByName('login').AsString := UserName;
        FieldByName('password').AsString := UserPassword;
        FieldByName('level').AsInteger := Level;
        FieldByName('score').AsInteger := Snake.Score;
        FieldByName('record_date').AsDateTime := Date();
        FieldByName('record_time').AsDateTime := Time();
        Post();
        lblScreenMessage.Caption := lblScreenMessage.Caption + #13#10 + 'ÂÛ ÓÑÒÀÍÎÂÈËÈ ÐÅÊÎÐÄ ' + IntToStr(Snake.Score) + ' Î×ÊÎÂ!';
      end;
      Close();
    end;
    Button1.OnClick := Button1Click2;
    Panel1.Show();
    adotblPlayers.Open();
    if adotblPlayers.Locate('login;password', VarArrayOf([Username, UserPassword]), []) then begin
      adotblPlayers.Edit();
      adotblPlayers.FieldByName('level').AsInteger := 1;
      adotblPlayers.FieldByName('score').AsInteger := 0;
      adotblPlayers.FieldByName('speed').AsInteger := 1;
      adotblPlayers.FieldByName('date_last').AsDateTime := Date();
      adotblPlayers.FieldByName('time_last').AsDateTime := Time();
      adotblPlayers.Post();
    end;
    adotblPlayers.Close();
    exit;
  end;
  case Speed of
    1: Timer1.Interval := 150;
    2: Timer1.Interval := 143;
    3: Timer1.Interval := 136;
    4: Timer1.Interval := 129;
    5: Timer1.Interval := 122;
    6: Timer1.Interval := 115;
    7: Timer1.Interval := 108;
    8: Timer1.Interval := 101;
    9: Timer1.Interval := 94;
    10: Timer1.Interval := 87;
    11: Timer1.Interval := 80;
    12: Timer1.Interval := 73;
    13: Timer1.Interval := 66;
    14: Timer1.Interval := 59;
    15: Timer1.Interval := 52;
    16: Timer1.Interval := 45;
    17: Timer1.Interval := 38;
    18: Timer1.Interval := 31;
  end;
  StatusBar1.Panels[1].Text := IntToStr(Snake.Score);
  StatusBar1.Panels[3].Text := IntToStr(Speed);
  StatusBar1.Panels[5].Text := IntToStr(Level);
  if Snake.Len = EndLength then begin
    Timer1.Enabled := false;
    TimerSpeedUp.Enabled := false;
    Level := Level + 1;
    Speed := 1;
    adotblPlayers.Open();
    if adotblPlayers.Locate('login;password', VarArrayOf([Username, UserPassword]), []) then begin
      adotblPlayers.Edit();
      adotblPlayers.FieldByName('level').AsInteger := Level;
      adotblPlayers.FieldByName('score').AsInteger := Snake.Score;
      adotblPlayers.FieldByName('speed').AsInteger := Speed;
      adotblPlayers.FieldByName('date_last').AsDateTime := Date();
      adotblPlayers.FieldByName('time_last').AsDateTime := Time();
      adotblPlayers.Post();
    end else begin
      adotblPlayers.Insert();
      adotblPlayers.FieldByName('login').AsString := UserName;
      adotblPlayers.FieldByName('password').AsString := UserPassword;
      adotblPlayers.FieldByName('level').AsInteger := Level;
      adotblPlayers.FieldByName('score').AsInteger := Snake.Score;
      adotblPlayers.FieldByName('speed').AsInteger := Speed;
      adotblPlayers.FieldByName('date_last').AsDateTime := Date();
      adotblPlayers.FieldByName('time_last').AsDateTime := Time();
      adotblPlayers.Post();
    end;
    adotblPlayers.Close();

    Snake.Destroy();
    NewGame(Username, UserPassword);
  end;
  Snake.Draw();
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Form1.Caption:=IntToStr(key);
  case Key of
    37,65: if Snake.Direction <> 2 then Snake.SetDirection(0);
    38,87: if Snake.Direction <> 3 then Snake.SetDirection(1);
    39,68: if Snake.Direction <> 0 then Snake.SetDirection(2);
    40,83: if Snake.Direction <> 1 then Snake.SetDirection(3);
    80,19: begin
        Timer1.Enabled := not Timer1.Enabled;
        TimerSpeedUp.Enabled := Timer1.Enabled;
      end;
    78, 116: begin
        Timer1.Enabled := false;
        TimerSpeedUp.Enabled := false;
        Snake.Destroy;
        NewGame(Username, UserPassword);
      end;
  end;
end;

procedure TForm1.TimerSpeedUpTimer(Sender: TObject);
begin
  if Speed < 18 then Speed := Speed + 1
  else TimerSpeedUp.Enabled := false;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  TimerSpeedUp.Enabled := false;
  Snake.Destroy;
  NewGame(Username, UserPassword);
end;

procedure TForm1.N5Click(Sender: TObject);
var
  limit: Integer;
  i: Integer;
begin
  adotblChampions.Open();
  adotblChampions.Filtered := false;
  adotblChampions.Sort := 'score DESC';
  adotblChampions.First();
  Form2.StringGrid1.Cells[0,0] := 'Ëîãèí';
  Form2.StringGrid1.Cells[1,0] := 'Ñ÷¸ò';
  Form2.StringGrid1.Cells[2,0] := 'Óðîâåíü';
  Form2.StringGrid1.Cells[3,0] := 'Äàòà';
  Form2.StringGrid1.Cells[4,0] := 'Âðåìÿ';
  for i := 1 to 10 do begin
    Form2.StringGrid1.Cells[0,i] := adotblChampions.FieldByName('login').AsString;
    Form2.StringGrid1.Cells[1,i] := adotblChampions.FieldByName('score').AsString;
    Form2.StringGrid1.Cells[2,i] := adotblChampions.FieldByName('level').AsString;
    Form2.StringGrid1.Cells[3,i] := adotblChampions.FieldByName('record_date').AsString;
    Form2.StringGrid1.Cells[4,i] := TimeToStr(adotblChampions.FieldByName('record_time').AsDateTime);
    adotblChampions.Next();
  end;
  adotblChampions.Close();
  Form2.ShowModal();
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate();
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  if not Panel1.Visible then begin
    Timer1.Enabled := true;
    TimerSpeedUp.Enabled := Timer1.Enabled;
  end;
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin
  Timer1.Enabled := false;
  TimerSpeedUp.Enabled := Timer1.Enabled;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Panel1.Visible := false;
  Timer1.Enabled := true;
  TimerSpeedUp.Enabled := Timer1.Enabled;
end;

procedure TForm1.Button1Click2(Sender: TObject);
begin
  Button1.OnClick := Button1Click3;
  lblScreenMessage.Caption := 'ÍÀ×ÀÒÜ ÍÎÂÓÞ ÈÃÐÓ?';
end;

procedure TForm1.Button1Click3(Sender: TObject);
begin
  NewGame(UserName, UserPassword);
end;

end.
