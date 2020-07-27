program Project1;

uses
  Forms,
  UChild in 'UChild.pas' {Fmain},
  Umain in 'Umain.pas' {FChild};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFmain, Fmain);
  //Application.CreateForm(TFChild, FChild);
  Application.Run;
end.
