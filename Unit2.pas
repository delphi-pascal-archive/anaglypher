unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  Tplein_ecran = class(TForm)
    Image_plein_ecran: TImage;
    procedure Image_plein_ecranClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  plein_ecran: Tplein_ecran;

implementation

{$R *.dfm}

procedure Tplein_ecran.Image_plein_ecranClick(Sender: TObject);
begin
  close;
end;

end.

