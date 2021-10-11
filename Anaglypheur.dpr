program Anaglypheur;

uses
   Forms,
   Unit1 in 'Unit1.pas' {Form1},
   Unit2 in 'Unit2.pas' {plein_ecran};

{$R *.res}

begin
   Application.Initialize;
   Application.CreateForm(TForm1, Form1);
   Application.CreateForm(Tplein_ecran, plein_ecran);
   Application.Run;
end.

