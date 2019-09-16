      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. YOUR-PROGRAM-NAME.


       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE-CONTROL.



           SELECT FICHIER-OUTPUT ASSIGN TO "Indexe.livre"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS O-NOM.


       DATA DIVISION.
       FILE SECTION.


           FD FICHIER-OUTPUT.
           01 O-LIGNE.
               05 O-ID PIC 9(9).
               05 O-NOM PIC X(21).
               05 O-QUANTITE PIC 9(2).


       WORKING-STORAGE SECTION.
           01 OPTION-CHOISIE PIC X(20).


       PROCEDURE DIVISION.
           OPEN I-O FICHIER-OUTPUT.
       MAIN-PROCEDURE.
           DISPLAY "TAPEZ CE QUE VOUS VOULEZ FAIRE : "
             "RECHERCHE, AFFICHER STOCK, MODIFIER STOCK, MODIFIER ID"
             "OU SUPPRIMER ? "
               " QUITTER POUR SORTIR DU PROGRAMME.".
           ACCEPT OPTION-CHOISIE.
           IF FUNCTION TRIM(OPTION-CHOISIE) = "RECHERCHE" THEN
               GO TO RECHERCHE
           ELSE IF FUNCTION TRIM(OPTION-CHOISIE) = "AFFICHER STOCK" THEN
               GO TO AFFICHER-STOCK
           ELSE IF FUNCTION TRIM(OPTION-CHOISIE) = "MODIFIER STOCK" THEN
               GO TO MODIFIER-STOCK
           ELSE IF FUNCTION TRIM(OPTION-CHOISIE) = "MODIFIER ID" THEN
               GO TO MODIFIER-ID
           ELSE IF FUNCTION TRIM(OPTION-CHOISIE) = "SUPPRIMER" THEN
               GO TO SUPPRIMER
           ELSE IF FUNCTION TRIM(OPTION-CHOISIE) = "QUITTER" THEN
               GO TO QUITTER
           ELSE
               DISPLAY "DESOLER "
               "VOUS AVEZ ENTREZ UNE MAUVAISE COMMANDE"
               GO TO MAIN-PROCEDURE
           END-IF.

       RECHERCHE.
           DISPLAY " QUEL EST LE NOM DU LIVRE DONT VOUS RECHERCHER ?"
           ACCEPT O-NOM.
           READ FICHIER-OUTPUT
           INVALID KEY DISPLAY 'LE NOM NE FIGURE PAS DANS LA LISTE'
           GO TO MAIN-PROCEDURE
           NOT INVALID KEY DISPLAY "ID :"O-ID "NOM : "O-NOM
           "QUANTITE :" O-QUANTITE
           END-READ.
           GO TO MODIFIER-STOCK.

       MODIFIER-STOCK.
           DISPLAY "QUEL EST LE NOM DU LIVRE A MODIFIER SON STOCK : ".
           ACCEPT O-NOM.
           READ FICHIER-OUTPUT
           DISPLAY "QUEL EST LA NOUVELLE QUANTITE DU STOCKE : ".
           ACCEPT O-QUANTITE.
           REWRITE O-LIGNE
               INVALID KEY DISPLAY "L'ACTION EXISTE DEJA"
               NOT INVALID KEY DISPLAY "MODIFICATION REUSSI"
           END-REWRITE.
           GO TO AFFICHER-STOCK.

       AFFICHER-STOCK.
           DISPLAY " QUEL EST LE NOM DU LIVRE A AFFICHER SON STOCK ?"
           ACCEPT O-NOM.
           READ FICHIER-OUTPUT
           INVALID KEY DISPLAY 'LE NOM NE FIGURE PAS DANS LA LISTE'
           NOT INVALID KEY DISPLAY "LA QUANTITE EST :" O-QUANTITE

           END-READ.
           GO TO MAIN-PROCEDURE.

       MODIFIER-ID.
           DISPLAY "QUEL EST LE NOM DU LIVRE A MODIFIER SON ID : ".
           ACCEPT O-NOM.
           READ FICHIER-OUTPUT
           DISPLAY "QUEL EST LA NOUVELLE ID DU LIVRE : ".
           ACCEPT O-ID.
           REWRITE O-LIGNE
               INVALID KEY DISPLAY "L'ACTION EXISTE DEJA"
               NOT INVALID KEY DISPLAY "MODIFICATION REUSSI"
           END-REWRITE.
           GO TO MAIN-PROCEDURE.

       SUPPRIMER.
           DISPLAY " QUEL EST LE NOM DE VOTRE LIVRE A SUPPRIMER : ".
           ACCEPT O-NOM.
           DELETE FICHIER-OUTPUT RECORD
               INVALID KEY DISPLAY "CE LIVRE N'EXISTE PAS"
               GO TO SUPPRIMER
               NOT INVALID KEY DISPLAY "SUPPRESSION REUSSI"
           GO TO MAIN-PROCEDURE.






       QUITTER.

           CLOSE FICHIER-OUTPUT.
           STOP RUN.






       END PROGRAM YOUR-PROGRAM-NAME.
