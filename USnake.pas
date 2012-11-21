unit USnake;

interface

uses ExtCtrls, Graphics, Types;

type
  PElement = ^TElement;
  TElement = record
    X: Integer;
    Y: Integer;
    Color: TColor;
    Prev: PElement;
    Next: PElement;
  end;

  TMap = array of array of Byte;

  TPole = object
    Image: TImage;
    Width: Integer;
    Height: Integer;
    ElementWidth: Integer;
    ElementHeight: Integer;
    ShowGrid: Boolean;
    Pole: TMap;

    constructor Create(_image: TImage; _width, _height: Integer);
    procedure Draw();
    procedure LoadMap(map: TMap);
    destructor Destroy();
  end;

  TDirection = 0..3; // 0 - лево, 1 - верх, 2 - право, 3 - низ

  TSnake = object
    FirstElement: PElement;
    LastElement: PElement;
    Direction: TDirection;
    Color: TColor;
    Len: Integer;
    Score: Integer;
    Pole: TPole;

    constructor Create(_x, _y, _length, _score: Integer; _direction: TDirection; _color: TColor; _pole: TPole);
    function AddElements(Count: Integer): Integer;
    function DelElements(Count: Integer): Integer;
    function GetElement(_x, _y: Integer): PElement;
    function SetDirection(newDirection: TDirection): TDirection;
    function Move(): Boolean;
    procedure Draw();
    destructor Destroy();
  end;

implementation

{ TSnake }

function TSnake.AddElements(Count: Integer): Integer;
var
  element: PElement;
  i: Integer;
begin
  if LastElement = nil then exit;
  for i:=0 to Count - 1 do begin
    new(element);
    element.X := 0;
    element.Y := 0;
    element.Color := LastElement.Color;
    element.Prev := LastElement;
    element.Next := nil;
    LastElement.Next := element;
    LastElement := element;
    Len := Len + 1;
  end;
  Result := Len;
end;

constructor TSnake.Create(_x, _y, _length, _score: Integer; _direction: TDirection; _color: TColor; _pole: TPole);
var
  i: Integer;
  element: PElement;
begin
  Color := _color;
  Direction := _direction;
  Pole := _pole;
  Score := _score;

  new(FirstElement);
  FirstElement.X := _x;
  FirstElement.Y := _y;
  FirstElement.Color := Color;
  FirstElement.Prev := nil;
  FirstElement.Next := nil;
  LastElement := FirstElement;

  Len := 1;
  Len := AddElements(_length - 1);
  Move();
end;

function TSnake.DelElements(Count: Integer): Integer;
var
  element: PElement;
  i: Integer;
begin
  if LastElement = nil then exit;
  if Count >= Len then exit;
  for i:=0 to Count - 1 do begin
    LastElement := LastElement.Prev;
    Dispose(LastElement.Next);
    LastElement.Next := nil;
    Len := Len - 1;
  end;
  Result := Len;
end;

destructor TSnake.Destroy;
begin
  DelElements(Len - 1);
  dispose(FirstElement);
  Pole.Destroy;
end;

procedure TSnake.Draw();
var
  element: PElement;
  rect: TRect;
begin
  Pole.Draw();
  element := FirstElement;
  while element <> nil do begin
    rect.Left := element.X * Pole.ElementWidth;
    rect.Top := element.Y * Pole.ElementHeight;
    rect.Right := rect.Left + Pole.ElementWidth;
    rect.Bottom := rect.Top + Pole.ElementHeight;
    Pole.Image.Canvas.Pen.Color := clBlack;
    Pole.Image.Canvas.Brush.Color := Color;
    Pole.Image.Canvas.Rectangle(rect);
    element := element.Next;
  end;
end;

function TSnake.GetElement(_x, _y: Integer): PElement;
var
  element: PElement;
begin
  element := FirstElement;
  while element <> nil do begin
    if (element.X = _x) and (element.Y = _y) then break
    else element := element.Next;
  end;
  Result := element;
end;

function TSnake.Move: Boolean;
var
  dx: Integer;
  dy: Integer;
  rndx: Integer;
  rndy: Integer;
  e: Boolean;
begin
  Randomize;
  Result := true;
  if FirstElement = nil then exit;
  case Direction of
    0: begin dx := -1; dy :=  0; end;
    1: begin dx :=  0; dy := -1; end;
    2: begin dx :=  1; dy :=  0; end;
    3: begin dx :=  0; dy :=  1; end;
  end;
  if (Length(Pole.Pole) <= FirstElement.X + dx)
    or (0 > FirstElement.X + dx)
    or (Length(Pole.Pole[0]) <= FirstElement.Y + dy)
    or (0 > FirstElement.Y + dy)
    or (GetElement(FirstElement.X + dx, FirstElement.Y + dy) <> nil) then begin
    Result := false;
    exit;
  end;
  e := false;
  while not e do begin
    rndx := Random(Pole.Width-1);
    rndy := Random(Pole.Height-1);
    if (Pole.Pole[rndx, rndy] = 0) and (GetElement(rndx, rndy) = nil) then
      e := true;
  end;
  case Pole.Pole[FirstElement.X + dx, FirstElement.Y + dy] of
    1: begin
        AddElements(1);
        Score := Score + 10;
        Pole.Pole[FirstElement.X + dx, FirstElement.Y + dy] := 0;
        Pole.Pole[rndx,rndy] := 1;
      end;
    2: begin
        Score := Score + 20;
        Pole.Pole[FirstElement.X + dx, FirstElement.Y + dy] := 0;
        Pole.Pole[rndx,rndy] := Random(3) + 2;
      end;
    3: begin
        Score := Score + 30;
        Pole.Pole[FirstElement.X + dx, FirstElement.Y + dy] := 0;
        Pole.Pole[rndx,rndy] := Random(3) + 2;
      end;
    4: begin
        Score := Score + 40;
        Pole.Pole[FirstElement.X + dx, FirstElement.Y + dy] := 0;
        Pole.Pole[rndx,rndy] := Random(3) + 2;
      end;
    5: begin
        Score := Score + 50;
        Pole.Pole[FirstElement.X + dx, FirstElement.Y + dy] := 0;
        Pole.Pole[rndx,rndy] := Random(3) + 2;
      end;
    6: begin
        if (Len > 2) then begin
          DelElements(1);
          Pole.Pole[FirstElement.X + dx, FirstElement.Y + dy] := 0;
          Pole.Pole[rndx,rndy] := 6;
        end else
          Result := false;
      end;
    7: begin
        if (Len > 4) then begin
          DelElements(Len - 3);
          Pole.Pole[FirstElement.X + dx, FirstElement.Y + dy] := 0;
          Pole.Pole[rndx,rndy] := 7;
        end else
          Result := false;
      end;
    255: begin
        // если впоролись в стену
        Result := false;
      end;
  end;
  LastElement.Next := FirstElement;
  FirstElement.Prev := LastElement;
  FirstElement := LastElement;
  LastElement := LastElement.Prev;
  LastElement.Next := nil;
  FirstElement.Prev := nil;
  FirstElement.X := FirstElement.Next.X + dx;
  FirstElement.Y := FirstElement.Next.Y + dy;
end;

function TSnake.SetDirection(newDirection: TDirection): TDirection;
begin
  Direction := newDirection;
  Result := Direction;
end;

{ TPole }

constructor TPole.Create(_image: TImage; _width, _height: Integer);
var
  i: Integer;
  j: Integer;
begin
  Image := _image;
  Width := _width;
  Height := _height;
  ElementWidth := Image.Width div Width;
  ElementHeight := Image.Height div Height;
  ShowGrid := false;
  SetLength(Pole, Width);

  for i := 0 to Width - 1 do
    SetLength(Pole[i], Height);

  for i := 0 to Width - 1 do
    for j := 0 to Height - 1 do
      Pole[i,j] := 0;
end;

destructor TPole.Destroy;
begin

end;

procedure TPole.Draw;
var
  i: Integer;
  j: Integer;
  rect: TRect;
begin
  Image.Canvas.Brush.Color := clWhite;
  Image.Canvas.Pen.Color := clWhite;
  Image.Canvas.Rectangle(0,0,Image.Width,Image.Height);
  for i := 0 to Width - 1 do begin
    for j := 0 to Height - 1 do begin
      rect.Left := i * ElementWidth;
      rect.Top := j * ElementHeight;
      rect.Right := rect.Left + ElementWidth;
      rect.Bottom := rect.Top + ElementHeight;
      case Pole[i,j] of
        1: begin
            Image.Canvas.Brush.Color := clGreen;
            Image.Canvas.Pen.Color := clBlack;
            Image.Canvas.Rectangle(rect);
          end;
        2: begin
            Image.Canvas.Brush.Color := clSkyBlue;
            Image.Canvas.Pen.Color := clBlack;
            Image.Canvas.Rectangle(rect);
          end;
        3: begin
            Image.Canvas.Brush.Color := clBackground;
            Image.Canvas.Pen.Color := clBlack;
            Image.Canvas.Rectangle(rect);
          end;
        4: begin
            Image.Canvas.Brush.Color := clBlue;
            Image.Canvas.Pen.Color := clBlack;
            Image.Canvas.Rectangle(rect);
          end;
        5: begin
            Image.Canvas.Brush.Color := clYellow;
            Image.Canvas.Pen.Color := clBlack;
            Image.Canvas.Rectangle(rect);
          end;
        6: begin
            Image.Canvas.Brush.Color := clFuchsia;
            Image.Canvas.Pen.Color := clBlack;
            Image.Canvas.Rectangle(rect);
          end;
        7: begin
            Image.Canvas.Brush.Color := clRed;
            Image.Canvas.Pen.Color := clBlack;
            Image.Canvas.Rectangle(rect);
          end;
        255: begin
            Image.Canvas.Brush.Color := clBlack;
            Image.Canvas.Pen.Color := clBlack;
            Image.Canvas.Rectangle(rect);
          end;
      end;
    end;
  end;
end;

procedure TPole.LoadMap(map: TMap);
begin

end;

end.
