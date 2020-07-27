 unit UChild;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TFChild = class(TForm)
    ScrollBox1: TScrollBox;
    Image: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Draw(PointTop,PointBottom:TPoint;Pmode:TPenMode);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FChild: TFChild;
  f:boolean;
  MovePoint,OPoint:TPoint  ;

implementation

uses Umain;
   procedure TFChild.Draw(PointTop,PointBottom:TPoint;Pmode:TPenMode);
begin
with Image.Canvas do
begin
Pen.Mode:=Pmode; //������ ����������
  if Bar=line then
  begin //������ �����
    MoveTo(PointTop.X,PointTop.y);
    LineTo(PointBottom.x,PointBottom.Y);
  end;
  if Bar=rect then
// ������ �������
Rectangle(PointTop.X,PointTop.y,PointBottom.x,PointBottom.Y);
  if Bar=ellips then
//������ ������
     Ellipse(PointTop.X,PointTop.y,PointBottom.x,PointBottom.Y);
     end;
end;

{$R *.dfm}

procedure TFChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Free; // ��������� �� ������
end;

procedure TFChild.FormCreate(Sender: TObject);
var   Bitmap: TBitmap;
begin
 try
// ������� ����� ������ ������ TBitmap
    Bitmap := TBitmap.Create;
    Bitmap.Width := 600;
    Bitmap.Height := 400;
// ������������� Bitmap �� ���������� Image
    Image.Picture.Graphic:= Bitmap;
  finally
    Bitmap.Free;
  end;
end;


procedure TFChild.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
f:=true;
Image.Canvas.MoveTo(X, Y);
OPoint:=Point(x,y);
MovePoint:=Point(x,y);

end;

procedure TFChild.ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if f then
begin
Draw(OPoint,MovePoint,pmNotXor);
MovePoint:=Point(x,y);
Draw(OPoint,MovePoint,pmNotXor);
end;
Fmain.StatusBar1.Panels[1].Text:=inttostr(x)+':'+inttostr(y);
end;

procedure TFChild.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if f then
begin
Draw(OPoint,Point(x,y),pmmask);
f:=false;
end;
 end;
end.
