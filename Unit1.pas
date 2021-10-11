unit Unit1;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, ComCtrls, ToolWin, ImgList,
   ExtDlgs, Spin, Menus;

type
   TForm1 = class(TForm)
      Panel1: TPanel;
      barre_outils: TToolBar;
      barre_status: TStatusBar;
      Panel2: TPanel;
      Charger_image: TToolButton;
      ToolButton3: TToolButton;
      Fabriquer_anaglyphe: TToolButton;
      image_anaglyphe: TImage;
      sauver_anaglyphe: TToolButton;
      Liste_boutons: TImageList;
      PageControl1: TPageControl;
      TabSheet1: TTabSheet;
      TabSheet3: TTabSheet;
      separe_images: TToolButton;
      Panel5: TPanel;
      Panel6: TPanel;
      affiche_Image_droite: TImage;
      Panel7: TPanel;
      affiche_Image_Gauche: TImage;
      enregistrer_anaglyphe: TSaveDialog;
      ouvrir_image: TOpenPictureDialog;
      charger_droite: TToolButton;
      charger_gauche: TToolButton;
      Panel8: TPanel;
      Bevel1: TBevel;
      reglage_luminosite_droite: TScrollBar;
      reglage_luminosite_gauche: TScrollBar;
      reglage_contraste_gauche: TScrollBar;
      reglage_contraste_droite: TScrollBar;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      passer_en_gris: TButton;
      reserve_image_gauche: TImage;
      reserve_image_droite: TImage;
      Gris_gauche: TCheckBox;
      Gris_droite: TCheckBox;
      Button1: TButton;
      Indicateur_modification: TPanel;
      Button2: TButton;
      Panel9: TPanel;
      GroupBox1: TGroupBox;
      GroupBox2: TGroupBox;
      Ajouter_rouge: TCheckBox;
      Ajouter_vert: TCheckBox;
      Ajouter_bleu: TCheckBox;
      affiche_modif_rouge: TLabel;
      affiche_modif_vert: TLabel;
      affiche_modif_bleu: TLabel;
      modification_rouge: TScrollBar;
      modification_vert: TScrollBar;
      modification_Bleu: TScrollBar;
      mise_a_zero_couleur: TSpeedButton;
      GroupBox3: TGroupBox;
      Label7: TLabel;
      luminosite_anaglyphe: TScrollBar;
      Label6: TLabel;
      Contraste_anaglyphe: TScrollBar;
      affichage_automatique: TCheckBox;
      reserve_image_anaglyphe: TImage;
      SpeedButton1: TSpeedButton;
      SpeedButton2: TSpeedButton;
      Panel4: TPanel;
      image_origine: TImage;
      Panel10: TPanel;
      Panel11: TPanel;
      MainMenu1: TMainMenu;
      Fichiers1: TMenuItem;
      O1: TMenuItem;
      Ouvririmagedroite1: TMenuItem;
      ouvririmagegauche1: TMenuItem;
      Enregistreranaglyphe1: TMenuItem;
      Apropos1: TMenuItem;
      Panel3: TPanel;
      dimension_image_origine: TLabeledEdit;
      RadioGroup1: TRadioGroup;
      Button3: TButton;
      SpeedButton3: TSpeedButton;
      procedure Charger_imageClick(Sender: TObject);
      procedure Calculer_anaglyphe(Sender: TObject);
      procedure mise_a_zero_couleurClick(Sender: TObject);
      procedure Changer_valeur_couleur(Sender: TObject);
      procedure Valider_couleur(Sender: TObject);
      procedure passage_en_gris(Sender: TObject);
      procedure separer_image_droite_gauche(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure image_anaglypheClick(Sender: TObject);
      procedure affiche_Image_droiteClick(Sender: TObject);
      procedure affiche_Image_GaucheClick(Sender: TObject);
      procedure reglage_luminosite_contraste_gauche(Sender: TObject);
      procedure revenir_image_precedente_gauche(Sender: TObject);
      procedure reglage_luminosite_contraste_droite(Sender: TObject);
      procedure Valider_reglage(Sender: TObject);
      procedure revenir_image_precedente_droite(Sender: TObject);
      procedure reglage_luminosite_contraste_anaglyphe(Sender: TObject);
      procedure SpeedButton1Click(Sender: TObject);
      procedure SpeedButton2Click(Sender: TObject);
      procedure O1Click(Sender: TObject);
      procedure sauver_anaglypheClick(Sender: TObject);
    procedure Enregistreranaglyphe1Click(Sender: TObject);

   private
      procedure Changer_luminosite(NbChange: integer; affiche_Image_origine, affiche_Image_finale: Timage);
      procedure Changer_luminosite_contraste(lum_Change, Contr_Change: integer; passage_gris: boolean; affiche_Image_origine, affiche_Image_finale: Timage);
      procedure Changer_contraste(NbChange: integer; Image: Timage);
      procedure Changer_niveau_gris(Image: Timage);

    { Private declarations }
   public
    { Public declarations }
   end;

   TRGBArray = array[0..0] of TRGBTriple;
   pRGBArray = ^TRGBArray; // type pointeur vers tableau 3 octets

var
   Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.Charger_imageClick(Sender: TObject);
var
   ImgExt: string;
   Jpeg: TJpegImage;
begin

   case (sender as ttoolbutton).tag of

      1:
         begin
            if ouvrir_image.Execute then
               begin
                  ImgExt := LowerCase(ExtractFileExt(ouvrir_image.FileName));
                  if (ImgExt = '.jpg') or (ImgExt = '.jpeg') then
                     begin
                        Jpeg := TJpegImage.Create;
                        try
                           Jpeg.LoadFromFile(ouvrir_image.FileName);
                             //copie de l'image du jpeg dans un bitmap
                           Image_origine.Picture.Bitmap.Assign(Jpeg);
                        finally
                           Jpeg.Free;
                        end;
                     end;

                  if (ImgExt = '.bmp') then image_origine.picture.LoadFromFile(ouvrir_image.FileName);

                  dimension_image_origine.Text := inttostr(Image_origine.Picture.Bitmap.Width) + ' X ' + inttostr(Image_origine.Picture.Bitmap.height);
                  separer_image_droite_gauche(Self);
                  if affichage_automatique.Checked then Calculer_anaglyphe(Self);
               end;

         end;
      2:
         begin
            begin
               if ouvrir_image.Execute then
                  begin
                     ImgExt := LowerCase(ExtractFileExt(ouvrir_image.FileName));
                     if (ImgExt = '.jpg') or (ImgExt = '.jpeg') then
                        begin
                           Jpeg := TJpegImage.Create;
                           try
                              Jpeg.LoadFromFile(ouvrir_image.FileName);
                             //copie de l'image du jpeg dans un bitmap
                              affiche_Image_Gauche.Picture.Bitmap.width := Jpeg.Width;
                              affiche_Image_gauche.Picture.Bitmap.height := Jpeg.height;
                              affiche_Image_Gauche.Picture.Bitmap.Assign(Jpeg);
                           finally
                              Jpeg.Free;
                           end;
                        end;

                     if (ImgExt = '.bmp') then affiche_Image_Gauche.picture.LoadFromFile(ouvrir_image.FileName);
                  end;
            end;
         end;
      3:
         begin
            begin
               if ouvrir_image.Execute then
                  begin
                     ImgExt := LowerCase(ExtractFileExt(ouvrir_image.FileName));
                     if (ImgExt = '.jpg') or (ImgExt = '.jpeg') then
                        begin
                           Jpeg := TJpegImage.Create;
                           try
                              Jpeg.LoadFromFile(ouvrir_image.FileName);
                             //copie de l'image du jpeg dans un bitmap
                              affiche_Image_Droite.Picture.Bitmap.width := Jpeg.Width;
                              affiche_Image_Droite.Picture.Bitmap.height := Jpeg.height;
                              affiche_Image_Droite.Picture.Bitmap.Assign(Jpeg);
                           finally
                              Jpeg.Free;
                           end;
                        end;

                     if (ImgExt = '.bmp') then affiche_Image_Droite.picture.LoadFromFile(ouvrir_image.FileName);

                  end;
            end;
         end;

   end;

end;

procedure TForm1.Calculer_anaglyphe(Sender: TObject);
var
   ligne_anaglyphe, ligne_image_origine: pRGBarray; // pointeurs sur une ligne
   R, V, B: integer; // couleurs
   y, x: integer; // Boucles
   Hauteur, Largeur: integer;
   Anaglyphe: tbitmap; // bitmap de travail
begin
   try

      Largeur := affiche_image_droite.picture.Bitmap.Width;
      Hauteur := affiche_image_droite.picture.Bitmap.Height;

      Anaglyphe := tbitmap.create;
      Anaglyphe.assign(affiche_image_droite.picture.Bitmap); // garder la moitié droite de l'image
      Anaglyphe.Width := largeur;
      Anaglyphe.Height := hauteur
         ;
      for y := 0 to hauteur - 1 do // boucle lignes
         begin

            ligne_anaglyphe := Anaglyphe.scanline[y];
            ligne_image_origine := affiche_image_gauche.Picture.bitmap.scanline[y]; // pointeur vers la ligne

            for x := 0 to Largeur - 1 do // boucle colonnes  lecture de la moitié droite
               begin

               // lecture des couleurs

                  R := ligne_image_origine[x].RGBtRed;
                  V := ligne_image_origine[x].RGBtGreen;
                  B := ligne_image_origine[x].RGBtBlue;

                  // modifications des couleurs ici

                  R := R + modification_rouge.Position;
                  V := V + modification_vert.Position;
                  B := B + modification_bleu.Position;

            // contrôle limite des couleurs.

                  if R > 255 then
                     R := 255
                  else
                     if R < 0 then
                        R := 0;
                  if V > 255 then
                     V := 255
                  else
                     if V < 0 then
                        V := 0;
                  if B > 255 then
                     B := 255
                  else
                     if B < 0 then
                        B := 0;

                // Choix des couleurs a modifier  écriture sur moitié gauche

                  if Ajouter_Rouge.checked then
                     ligne_anaglyphe[x].RGBtRed := R;
                  if Ajouter_Vert.checked then
                     ligne_anaglyphe[x].RGBtGreen := V;
                  if Ajouter_Bleu.checked then
                     ligne_anaglyphe[x].RGBtBlue := B;

               end;
         end;

      Image_anaglyphe.Picture.bitmap.Assign(Anaglyphe); // affichage
      reserve_image_anaglyphe.Picture.bitmap.Assign(Anaglyphe);

   finally
      Anaglyphe.Free;
   end;

end;

procedure TForm1.mise_a_zero_couleurClick(Sender: TObject);
begin
   modification_rouge.Position := 0;
   modification_vert.Position := 0;
   modification_bleu.Position := 0;
end;

procedure TForm1.Changer_valeur_couleur(Sender: TObject);
begin
   Affiche_modif_rouge.Caption := inttostr(modification_rouge.Position);
   Affiche_modif_vert.Caption := inttostr(modification_vert.Position);
   Affiche_modif_bleu.Caption := inttostr(modification_bleu.Position);
   if affichage_automatique.Checked then
      Calculer_anaglyphe(Self);
end;

procedure TForm1.Valider_couleur(Sender: TObject);
begin
   if affichage_automatique.Checked then
      Calculer_anaglyphe(Self);
end;

procedure TForm1.passage_en_gris(Sender: TObject);
begin
   if affichage_automatique.Checked then
      Calculer_anaglyphe(Self);
end;

procedure TForm1.separer_image_droite_gauche(Sender: TObject);
var
   ligne_image_droite, ligne_image_gauche, ligne_image_origine: pRGBarray; // pointeurs sur une ligne
   y, x: integer; // Boucles
   debut_image_droite, debut_image_gauche, largeur_origine, hauteur, Largeur_image_separee: integer;
   Image_droite, Image_gauche, image_entiere: tbitmap; // bitmap de travail
begin

   largeur_origine := Image_origine.Picture.bitmap.width;
   hauteur := Image_origine.Picture.bitmap.height;
   debut_image_gauche := 0;
   debut_image_droite := largeur_origine div 2;
   Largeur_image_separee := largeur_origine div 2;

   try

  // définition des images droite et gauche

      Image_droite := tbitmap.create;
      Image_gauche := tbitmap.create;
      Image_droite.Assign(Image_origine.picture.Bitmap);
      Image_gauche.Assign(Image_origine.picture.Bitmap);
      Image_droite.Width := Largeur_image_separee;
      Image_gauche.Width := Largeur_image_separee;
      Image_droite.Height := Hauteur;
      Image_gauche.Height := Hauteur;

   // image entiere de travail

      Image_entiere := tbitmap.create;
      Image_entiere.Width := largeur_origine;
      Image_entiere.height := hauteur;
      Image_entiere.assign(Image_origine.picture.Bitmap);

      for y := 0 to hauteur - 1 do // boucle lignes
         begin
            ligne_image_droite := Image_droite.scanline[y];
            ligne_image_Gauche := Image_Gauche.scanline[y];
            ligne_image_origine := Image_entiere.scanline[y]; // pointeur vers la ligne

            for x := 0 to largeur_origine - 1 do // boucle colonnes

               begin

                  if x < debut_image_droite then
                     Ligne_image_gauche[x] := ligne_image_origine[x]
                  else
                     ligne_image_droite[x - debut_image_droite] := ligne_image_origine[x];

               end;
         end;

      affiche_Image_droite.Picture.bitmap.Assign(Image_droite); // affichage
      reserve_Image_droite.Picture.bitmap.Assign(Image_droite);
      affiche_Image_gauche.Picture.bitmap.Assign(Image_gauche);
      reserve_Image_gauche.Picture.bitmap.Assign(Image_gauche);

   finally
      Image_droite.free;
      Image_gauche.free;
      Image_entiere.free;
   end;
   if affichage_automatique.Checked then Calculer_anaglyphe(Self);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   ouvrir_image.InitialDir := ExtractFilePath(Application.ExeName) + 'images\';
end;

procedure TForm1.image_anaglypheClick(Sender: TObject);
begin
   plein_ecran.Image_plein_ecran.picture.bitmap.assign(image_anaglyphe.Picture.Bitmap);
   plein_ecran.showmodal;
end;

procedure TForm1.affiche_Image_droiteClick(Sender: TObject);
begin
   plein_ecran.Image_plein_ecran.picture.bitmap.assign(affiche_Image_droite.Picture.Bitmap);
   plein_ecran.showmodal;
end;

procedure TForm1.affiche_Image_GaucheClick(Sender: TObject);
begin
   plein_ecran.Image_plein_ecran.picture.bitmap.assign(affiche_Image_gauche.Picture.Bitmap);
   plein_ecran.showmodal;
end;

procedure TForm1.Changer_luminosite(NbChange: integer; affiche_Image_origine, affiche_Image_finale: Timage);
var
   ligne_image_nouvelle, ligne_image_origine: pRGBarray; // pointeurs sur une ligne
   R, V, B, Gris, RVBtotal: integer; Delta: extended; // couleurs
   y, x: integer; // Boucles
   image_nouvelle, image_origine: tbitmap; // bitmap de travail
   hauteur, largeur: integer;
begin
   try

      image_nouvelle := tbitmap.create;
      image_nouvelle.assign(affiche_Image_origine.Picture.Bitmap);
      image_origine := tbitmap.create;
      image_origine.assign(affiche_Image_origine.picture.Bitmap);
      Hauteur := affiche_Image_origine.Picture.Bitmap.height;
      largeur := affiche_Image_origine.Picture.Bitmap.width;

      for y := 0 to hauteur - 1 do // boucle lignes
         begin

            ligne_image_nouvelle := image_nouvelle.scanline[y];
            ligne_image_origine := Image_origine.scanline[y]; // pointeur vers la ligne

            for x := 0 to largeur - 1 do // boucle colonnes  lecture de la moitié droite

               begin

               // lecture des couleurs

                  R := ligne_image_origine[x].RGBtRed;
                  V := ligne_image_origine[x].RGBtGreen;
                  B := ligne_image_origine[x].RGBtBlue;

                  // modifications des couleurs ici

            // Luminosité

                  R := round(R * (1 + NbChange / 100));
                  V := round(V * (1 + NbChange / 100));
                  B := round(B * (1 + NbChange / 100));

            // contrôle limite des couleurs.

                  if R > 255 then
                     R := 255
                  else
                     if R < 0 then
                        R := 0;
                  if V > 255 then
                     V := 255
                  else
                     if V < 0 then
                        V := 0;
                  if B > 255 then
                     B := 255
                  else
                     if B < 0 then
                        B := 0;

                // Choix des couleurs a modifier

                  ligne_image_nouvelle[x].RGBtRed := R;
                  ligne_image_nouvelle[x].RGBtGreen := V;
                  ligne_image_nouvelle[x].RGBtBlue := B;

               end;
         end;

      affiche_Image_Finale.Picture.Bitmap.Assign(image_nouvelle); // affichage

   finally
      image_nouvelle.Free;
      image_origine.Free;
   end;

end;

procedure TForm1.Changer_contraste(NbChange: integer; Image: Timage);
var
   ligne_image_nouvelle, ligne_image_origine: pRGBarray; // pointeurs sur une ligne
   R, V, B, Gris, RVBtotal: integer; Delta: extended; // couleurs
   y, x: integer; // Boucles
   image_nouvelle, image_origine: tbitmap; // bitmap de travail
   hauteur, largeur: integer;
begin
   try

      image_nouvelle := tbitmap.create;
      image_nouvelle.assign(image.Picture.Bitmap);
      image_origine := tbitmap.create;
      image_origine.assign(image.picture.Bitmap);
      Hauteur := image.Picture.Bitmap.height;
      largeur := image.Picture.Bitmap.width;

      for y := 0 to hauteur - 1 do // boucle lignes
         begin

            ligne_image_nouvelle := image_nouvelle.scanline[y];
            ligne_image_origine := Image_origine.scanline[y]; // pointeur vers la ligne

            for x := 0 to largeur - 1 do // boucle colonnes  lecture de la moitié droite

               begin

               // lecture des couleurs

                  R := ligne_image_origine[x].RGBtRed;
                  V := ligne_image_origine[x].RGBtGreen;
                  B := ligne_image_origine[x].RGBtBlue;

            // Contraste

                  RVBtotal := R + V + B;

                  if RVBtotal >= 382 then

                     Delta := (100 + NbChange) / 100

                  else

                     Delta := (100 - NbChange) / 100;

                  R := round(R * Delta);
                  V := round(V * Delta);
                  B := round(B * Delta);

            // contrôle limite des couleurs.

                  if R > 255 then
                     R := 255
                  else
                     if R < 0 then
                        R := 0;
                  if V > 255 then
                     V := 255
                  else
                     if V < 0 then
                        V := 0;
                  if B > 255 then
                     B := 255
                  else
                     if B < 0 then
                        B := 0;

                // Choix des couleurs a modifier

                  ligne_image_nouvelle[x].RGBtRed := R;
                  ligne_image_nouvelle[x].RGBtGreen := V;
                  ligne_image_nouvelle[x].RGBtBlue := B;

               end;
         end;

      Image.Picture.Bitmap.Assign(image_nouvelle); // affichage

   finally
      image_nouvelle.Free;
      image_origine.Free;
   end;

end;

procedure TForm1.Changer_niveau_gris(Image: Timage);

begin

end;

procedure TForm1.Changer_luminosite_contraste(lum_Change, Contr_Change: integer; passage_gris: boolean; affiche_Image_origine, affiche_Image_finale: Timage);
var
   ligne_image_nouvelle, ligne_image_origine: pRGBarray; // pointeurs sur une ligne
   R, V, B, Gris, RVBtotal: integer; Delta: extended; // couleurs
   y, x: integer; // Boucles
   image_nouvelle, image_origine: tbitmap; // bitmap de travail
   hauteur, largeur: integer;
begin
   try

      image_nouvelle := tbitmap.create;
      image_nouvelle.assign(affiche_Image_origine.Picture.Bitmap);
      image_origine := tbitmap.create;
      image_origine.assign(affiche_Image_origine.picture.Bitmap);
      Hauteur := affiche_Image_origine.Picture.Bitmap.height;
      largeur := affiche_Image_origine.Picture.Bitmap.width;

      for y := 0 to hauteur - 1 do // boucle lignes
         begin

            ligne_image_nouvelle := image_nouvelle.scanline[y];
            ligne_image_origine := Image_origine.scanline[y]; // pointeur vers la ligne

            for x := 0 to largeur - 1 do // boucle colonnes  lecture de la moitié droite

               begin

               // lecture des couleurs

                  R := ligne_image_origine[x].RGBtRed;
                  V := ligne_image_origine[x].RGBtGreen;
                  B := ligne_image_origine[x].RGBtBlue;

                  // modifications des couleurs ici

                  if passage_gris then
                     begin
                        Gris := Trunc((R * 0.299) + (V * 0.587) + (B * 0.114));

                        R := Gris;
                        V := Gris;
                        B := Gris;
                     end;
            // Luminosité

                  R := round(R * (1 + lum_Change / 100));
                  V := round(V * (1 + lum_Change / 100));
                  B := round(B * (1 + lum_Change / 100));
              // Contraste

                  RVBtotal := R + V + B;

                  if RVBtotal >= 382 then

                     Delta := (100 + Contr_Change) / 100

                  else

                     Delta := (100 - Contr_Change) / 100;

                  R := round(R * Delta);
                  V := round(V * Delta);
                  B := round(B * Delta);
            // contrôle limite des couleurs.
             // niveau de gris

                  if R > 255 then
                     R := 255
                  else
                     if R < 0 then
                        R := 0;
                  if V > 255 then
                     V := 255
                  else
                     if V < 0 then
                        V := 0;
                  if B > 255 then
                     B := 255
                  else
                     if B < 0 then
                        B := 0;

                // Choix des couleurs a modifier

                  ligne_image_nouvelle[x].RGBtRed := R;
                  ligne_image_nouvelle[x].RGBtGreen := V;
                  ligne_image_nouvelle[x].RGBtBlue := B;

               end;
         end;

      affiche_Image_Finale.Picture.Bitmap.Assign(image_nouvelle); // affichage

   finally
      image_nouvelle.Free;
      image_origine.Free;
   end;

end;

procedure TForm1.reglage_luminosite_contraste_gauche(Sender: TObject);
begin
   Changer_luminosite_contraste(reglage_luminosite_gauche.position, reglage_contraste_gauche.position, gris_gauche.Checked, reserve_image_gauche, affiche_image_gauche);
   Indicateur_modification.Caption := 'Mode prévisualisation';
   Indicateur_modification.Color := ClRed;
   if affichage_automatique.Checked then
      Calculer_anaglyphe(Self);
end;

procedure TForm1.revenir_image_precedente_gauche(Sender: TObject);
begin

   reglage_luminosite_gauche.position := 0;
   reglage_contraste_gauche.position := 0;
   Indicateur_modification.Caption := 'Images de travail';
   Indicateur_modification.Color := ClLime;

end;

procedure TForm1.reglage_luminosite_contraste_droite(Sender: TObject);
begin
   Changer_luminosite_contraste(reglage_luminosite_droite.position, reglage_contraste_droite.position, gris_droite.checked, reserve_image_droite, affiche_image_droite);
   Indicateur_modification.Caption := 'Mode prévisualisation';
   Indicateur_modification.Color := ClRed;
   if affichage_automatique.Checked then
      Calculer_anaglyphe(Self);
end;

procedure TForm1.Valider_reglage(Sender: TObject);
begin

   reserve_Image_Gauche.Picture.Bitmap.Assign(affiche_Image_Gauche.Picture.Bitmap);
   reserve_Image_droite.Picture.Bitmap.Assign(affiche_Image_Droite.Picture.Bitmap);
   reglage_luminosite_droite.position := 0;
   reglage_contraste_droite.position := 0;
   reglage_luminosite_gauche.position := 0;
   reglage_contraste_gauche.position := 0;
   Indicateur_modification.Caption := 'Images de travail';
   Indicateur_modification.Color := ClLime;
end;

procedure TForm1.revenir_image_precedente_droite(Sender: TObject);
begin
   reglage_luminosite_droite.position := 0;
   reglage_contraste_droite.position := 0;
   Indicateur_modification.Caption := 'Images de travail';
   Indicateur_modification.Color := ClLime;
end;

procedure TForm1.reglage_luminosite_contraste_anaglyphe(Sender: TObject);
begin
   Changer_luminosite_contraste(luminosite_anaglyphe.position, contraste_anaglyphe.position, False, reserve_image_anaglyphe, image_anaglyphe);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
   luminosite_anaglyphe.Position := 0;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
   Contraste_anaglyphe.Position := 0;
end;

procedure TForm1.O1Click(Sender: TObject);
begin
   Charger_imageClick(charger_image);
end;

procedure TForm1.sauver_anaglypheClick(Sender: TObject);
begin
   if enregistrer_anaglyphe.Execute then image_anaglyphe.Picture.SaveToFile(enregistrer_anaglyphe.filename);
end;

procedure TForm1.Enregistreranaglyphe1Click(Sender: TObject);
begin
 Close;
end;

end.

