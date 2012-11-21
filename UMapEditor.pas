unit UMapEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, ADODB;

type
  TForm1 = class(TForm)
    leLevel: TLabeledEdit;
    lePoleID: TLabeledEdit;
    leStartSpeed: TLabeledEdit;
    leStartLength: TLabeledEdit;
    leEndLength: TLabeledEdit;
    leSpeedUpInterval: TLabeledEdit;
    GroupBox1: TGroupBox;
    udLevel: TUpDown;
    udPoleID: TUpDown;
    udStartSpeed: TUpDown;
    udSpeedUpinterval: TUpDown;
    udStartLength: TUpDown;
    udEndLength: TUpDown;
    pnl: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    adoConnection: TADOConnection;
    adotblLevels: TADOTable;
    adotblPoles: TADOTable;
    adotblLevelslevel_id: TAutoIncField;
    adotblLevelsstart_speed: TSmallintField;
    adotblLevelsstart_length: TIntegerField;
    adotblLevelsend_length: TIntegerField;
    adotblLevelspole_id: TIntegerField;
    adotblLevelsspeedup_interval: TIntegerField;
    adotblPolescell_id: TAutoIncField;
    adotblPolespole_id: TIntegerField;
    adotblPolesX: TWordField;
    adotblPolesY: TWordField;
    adotblPolestype: TWordField;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ShapeClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Field: array [1..50,1..50] of TShape;

implementation

{$R *.dfm}

procedure Colorize(Sender: TShape);
begin
  case Sender.Tag of
    0: Sender.Brush.Color := clWhite;
    1: Sender.Brush.Color := clGreen;
    2: Sender.Brush.Color := clSkyBlue;
    3: Sender.Brush.Color := clBackground;
    4: Sender.Brush.Color := clBlue;
    5: Sender.Brush.Color := clYellow;
    6: Sender.Brush.Color := clFuchsia;
    7: Sender.Brush.Color := clRed;
    255: Sender.Brush.Color := clBlack;
  end;
end;

procedure ClearField();
var
  i: Integer;
  j: Integer;
begin
  for i := 1 to 50 do begin
    for j := 1 to 50 do begin
      Field[i,j].Tag := 0;
      Colorize(Field[i,j]);
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
   i: Integer;
   j: Integer;
begin
  for i := 1 to 50 do begin
    for j := 1 to 50 do begin
      Field[i,j] := TShape.Create(pnl);
      Field[i,j].Parent := pnl;
      Field[i,j].Left := (i - 1) * 10;
      Field[i,j].Top := (j - 1) * 10;
      Field[i,j].Width := 10;
      Field[i,j].Height := 10;
      Field[i,j].Enabled := true;
      Field[i,j].Tag := 0;
      Field[i,j].OnMouseDown := ShapeClick;
      Colorize(Field[i,j]);
      Field[i,j].Show();
    end;
  end;
end;

procedure TForm1.ShapeClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then begin
    if TShape(Sender).Tag = 255 then
      TShape(Sender).Tag := 0
    else
      TShape(Sender).Tag := 255;
  end else begin
    if TShape(Sender).Tag < 7 then
      TShape(Sender).Tag := TShape(Sender).Tag + 1
    else
      TShape(Sender).Tag := 0;
  end;
  Colorize(TShape(Sender));
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
  with adotblLevels do begin
    Open();
    if not Locate('level_id', udLevel.Position, []) then
      Append()
    else
      Edit();
    FieldByName('level_id').AsInteger := udLevel.Position;
    FieldByName('start_speed').AsInteger := udStartSpeed.Position;
    FieldByName('start_length').AsInteger := udStartLength.Position;
    FieldByName('end_length').AsInteger := udEndLength.Position;
    FieldByName('pole_id').AsInteger := udPoleID.Position;
    FieldByName('speedup_interval').AsInteger := udSpeedUpinterval.Position * 1000;
    Post();
    Close();
  end;
  with adotblPoles do begin
    Open();
    Filter := 'pole_id = ' + lePoleID.Text;
    Filtered := true;
    if Locate('pole_id', udPoleID.Position, []) then
      while not EOF do
        Delete();
    for i := 1 to 50 do begin
      for j := 1 to 50 do begin
        if Field[i,j].Tag <> 0 then begin
          Insert();
          FieldByName('pole_id').AsInteger := udPoleID.Position;
          FieldByName('X').AsInteger := i;
          FieldByName('Y').AsInteger := j;
          FieldByName('type').AsInteger := Field[i,j].Tag;
        end;
      end;
    end;
    Post();
    Close();
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  ClearField();
  with adotblLevels do begin
    Open();
    if Locate('level_id', udLevel.Position, []) then begin
      udLevel.Position := FieldByName('level_id').AsInteger;
      udStartSpeed.Position := FieldByName('start_speed').AsInteger;
      udStartLength.Position := FieldByName('start_length').AsInteger;
      udEndLength.Position := FieldByName('end_length').AsInteger;
      udPoleID.Position := FieldByName('pole_id').AsInteger;
      udSpeedUpinterval.Position := FieldByName('speedup_interval').AsInteger div 1000;
    end;
    Close();
  end;
  with adotblPoles do begin
    Open();
    Filter := 'pole_id = ' + lePoleID.Text;
    Filtered := true;
    if Locate('pole_id', udPoleID.Position, []) then begin
      while not EOF do begin
        Field[FieldByName('X').AsInteger, FieldByName('Y').AsInteger].Tag := FieldByName('type').AsInteger;
        Colorize(Field[FieldByName('X').AsInteger, FieldByName('Y').AsInteger]);
        Next();
      end;
    end;
    Close();
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ClearField();
end;

end.
