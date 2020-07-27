unit Umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Uchild, ComCtrls, ToolWin, Menus, ImgList;

type
  TFmain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Save1: TMenuItem;
    Open1: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Clear1: TMenuItem;
    ToolBar1: TToolBar;
    BLine: TToolButton;
    BRect: TToolButton;
    BEllipse: TToolButton;
    ToolButton4: TToolButton;
    BBrush: TToolButton;
    BColor: TToolButton;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    ColorDialog1: TColorDialog;
    StatusBar1: TStatusBar;
    SaveDialog1: TSaveDialog;
    procedure New1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure BLineClick(Sender: TObject);
    procedure BRectClick(Sender: TObject);
    procedure BEllipseClick(Sender: TObject);
    procedure BColorClick(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fmain: TFmain;
  FChild:TFChild;
  BrushClick:boolean=false;
  Bar:(line,rect,ellips);


implementation

{$R *.dfm}

procedure TFmain.BBrushClick(Sender: TObject);
begin
if not BrushClick then
  begin
FChild.Image.Canvas.Brush.Color:= FChild.Image.Canvas.Pen.Color;
    BBrush.Down:=true;
    BrushClick:=true;
  end
  else
  begin
      FChild.Image.Canvas.Brush.Color := clWindow;
      BBrush.Down:=false;
      BrushClick:=false;
  end;
end;

procedure TFmain.BColorClick(Sender: TObject);
begin
 if ColorDialog1.Execute then
    begin
	// устанавливаем цвет
     FChild.Image.Canvas.Pen.Color:= ColorDialog1.Color;
  if BrushClick then
       FChild.Image.Canvas.Brush.Color:= ColorDialog1.Color;
end;
end;

procedure TFmain.BEllipseClick(Sender: TObject);
begin
Bar:=ellips;
StatusBar1.Panels[0].Text:='Эллипс';
end;

procedure TFmain.BLineClick(Sender: TObject);
begin
Bar:=line;
StatusBar1.Panels[0].Text:='Линия';
end;


procedure TFmain.BRectClick(Sender: TObject);
begin
Bar:=rect;
StatusBar1.Panels[0].Text:='Квадра';
end;

procedure TFmain.Clear1Click(Sender: TObject);
var Bitmap: TBitmap;
begin
 try
 // создаем новый объект класса TBitmap
    Bitmap := TBitmap.Create;
    Bitmap.Width := 600;
    Bitmap.Height := 400;
    if Fmain.MDIChildCount>0 then
	// устанавливаем Bitmap на активное окно
     (ActiveMDIChild as TFChild).Image.Picture.Graphic:= Bitmap;
 finally
    Bitmap.Free;
  end;
end;

procedure TFmain.Exit1Click(Sender: TObject);
begin
Close; // Закрыть форму
end;

procedure TFmain.New1Click(Sender: TObject);
begin
FChild:=TFChild.Create(Application);
end;

procedure TFmain.Open1Click(Sender: TObject);
begin
if OpenDialog1.Execute then
  begin
	// открываем рисунок из файла
FChild:=TFChild.Create(Application);
FChild.Image.Picture.LoadFromFile(OpenDialog1.FileName);
end;
end;

procedure TFmain.Save1Click(Sender: TObject);
begin
if SaveDialog1.Execute then
// сохраняем активное окно
(ActiveMDIChild as TFChild).Image.Picture.SaveToFile(SaveDialog1.FileName);

end;

end.
