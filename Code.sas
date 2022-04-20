/*Importation des données sous SAS*/  
PROC IMPORT DATAFILE="C:\Users\f21204892\Documents\PROJET\Data_projet1.csv" OUT=Covid_data REPLACE dbms=CSV;
delimiter=';';
run;

/* Affichage de la table des matières des données */
proc contents data=Covid_data;
run;

/* Création de la variable binaire  "Mesures_stop_covid1"  ("oui"=1 et "non"=0) */
data Covid_data1;
	set Covid_data;
if Mesures_stop_covid="Plutôt oui" then Mesures_stop_covid1="Oui";
else if Mesures_stop_covid="." then delete;
else if Mesures_stop_covid="Oui, tout à fait" then Mesures_stop_covid1="Oui";
else if Mesures_stop_covid=" Plutôt non " then Mesures_stop_covid1="Non";
else if Mesures_stop_covid="Non, pas du tout" then Mesures_stop_covid1="Non";
run;

/* On code en variable binaire les variables administratives qui nous semblent pertinentes*/
data Covid_data2;
	set Covid_data1;	
if Boursier="Boursier" then Boursier1=1;
else if Boursier="CPGE brse" then Boursier1=0;
else if Boursier="Normal" then Boursier1=0;
else if Boursier="Decis indi" then Boursier1=0;
else if Boursier="En attente" then Boursier1=0;
run;

data Covid_data3;
	set Covid_data2;	
if Nationalite_R="FRANCAIS(E)" then Nationalite_R1=1;
else if Nationalite_R="ETRNAGER(E)" then Nationalite_R1=0;
run;

data Covid_data4;
	set Covid_data3;	
if Bac="Général" then Bac1=1;
else if Bac="Technologique" then Bac1=0;
else if Bac="Professionnel" then Bac1=0;
else if Bac="Autre" then Bac1=0;
run;

data Covid_data5;
	set Covid_data4;	
if Tiers_temps="Oui" then Tiers_temps1=1;
else if Tiers_temps="Non" then Tiers_temps1=0;
run;

data Covid_data6;
	set Covid_data5;	
if Composante="Scien" then Composante1=1;
else if Composante="ALLSH" then Composante1=0;
run;

data Covid_data7;
	set Covid_data6;	
if Genre="M" then Genre1=1;
else if Genre="F" then Genre1=0;
run;

data Covid_data8;
	set Covid_data7;	
if Regime_inscription="FI" then Regime_inscription1=1;
else if Regime_inscription="FA" then Regime_inscription1=0;
else if Regime_inscription="Mo" then Regime_inscription1=0;
else if Regime_inscription="Re" then Regime_inscription1=0;
run;

/* On fait l'estimation des coefficients du  modèle logit liant les valeurs présentes de notre variable d'intérèt et nos variables explicatives */
proc logistic data = Covid_data8;
model Mesures_stop_covid1(event='Oui')= Boursier1 Nationalite_R1 Bac1 Tiers_temps1 Composante1 
Genre1 Regime_inscription1;
run;

/* On refait l'estimation en conservant les variables signficatives au seuil de /*Importation des données sous SAS*/  
PROC IMPORT DATAFILE="C:\Users\f21204892\Documents\PROJET\Data_projet1.csv" OUT=Covid_data REPLACE dbms=CSV;
delimiter=';';
run;

/* Affichage de la table des matières des données */
proc contents data=Covid_data;
run;

/* Création de la variable binaire  "Mesures_stop_covid1"  ("oui"=1 et "non"=0) */
data Covid_data1;
	set Covid_data;
if Mesures_stop_covid="Plutôt oui" then Mesures_stop_covid1="Oui";
else if Mesures_stop_covid="." then delete;
else if Mesures_stop_covid="Oui, tout à fait" then Mesures_stop_covid1="Oui";
else if Mesures_stop_covid=" Plutôt non " then Mesures_stop_covid1="Non";
else if Mesures_stop_covid="Non, pas du tout" then Mesures_stop_covid1="Non";
run;

/* On code en variable binaire les variables administratives qui nous semblent pertinentes*/
data Covid_data2;
	set Covid_data1;	
if Boursier="Boursier" then Boursier1=1;
else if Boursier="CPGE brse" then Boursier1=0;
else if Boursier="Normal" then Boursier1=0;
else if Boursier="Decis indi" then Boursier1=0;
else if Boursier="En attente" then Boursier1=0;
run;

data Covid_data3;
	set Covid_data2;	
if Nationalite_R="FRANCAIS(E)" then Nationalite_R1=1;
else if Nationalite_R="ETRNAGER(E)" then Nationalite_R1=0;
run;

data Covid_data4;
	set Covid_data3;	
if Bac="Général" then Bac1=1;
else if Bac="Technologique" then Bac1=0;
else if Bac="Professionnel" then Bac1=0;
else if Bac="Autre" then Bac1=0;
run;

data Covid_data5;
	set Covid_data4;	
if Tiers_temps="Oui" then Tiers_temps1=1;
else if Tiers_temps="Non" then Tiers_temps1=0;
run;

data Covid_data6;
	set Covid_data5;	
if Composante="Scien" then Composante1=1;
else if Composante="ALLSH" then Composante1=0;
run;

data Covid_data7;
	set Covid_data6;	
if Genre="M" then Genre1=1;
else if Genre="F" then Genre1=0;
run;

data Covid_data8;
	set Covid_data7;	
if Regime_inscription="FI" then Regime_inscription1=1;
else if Regime_inscription="FA" then Regime_inscription1=0;
else if Regime_inscription="Mo" then Regime_inscription1=0;
else if Regime_inscription="Re" then Regime_inscription1=0;
run;

/* On fait l'estimation avec un model logit */
proc logistic data = Covid_data8;
model Mesures_stop_covid1(event='Oui')= Boursier1 Nationalite_R1 Bac1 Tiers_temps1 Composante1 
Genre1 Regime_inscription1;
run;

/* On refait l'estimation en conservant les variables signficatives au seuil de  0.01 soit 1%  */
proc logistic data = Covid_data8;
model Mesures_stop_covid1(event='Oui')= Boursier1 Nationalite_R1 Bac1 Tiers_temps1 Composante1 
Genre1 Regime_inscription1 / selection=forward slentry=0.01;
run;  
/* On fait la prédiction des valeurs manquantes de notre variable d'intérèt à partir du modèle estimé*/

 data Covid_data9;
	set Covid_data8;
 if Mesures_stop_covid1="" then Proba_estimee=1/(1+ exp(-3.4523 - 0.9082*Composante1+0.7310*Genre1));
 else Proba_estimee=".";
 run;

 /* On crée une nouvelle variable qui contient les valeurs pour les répondants à notre variable d'intéret et les valeurs estimées pour les non répondants par modèle 
 logit */
 data Covid_data_10;
 	set Covid_data9;
 if Proba_estimee > 0.5 then Mesures_stop_covid2 = "Oui";
 else if Proba_estimee < 0.5 then Mesures_stop_covid2 = "Non";
 else if Mesures_stop_covid2 = Mesures_stop_covid1;
run;
/*  Création de la variable binaire  "Mesures_stop_covid3"  ("oui"=1 et "non"=0)  */
data Covid_data_final;
	  set Covid_data_10;
if Mesures_stop_covid2 = "Oui" then Mesures_stop_covid3 = 1;
else if Mesures_stop_covid2 = "Non" then Mesures_stop_covid3 = 0;
run;
/* Statistiques de la variable Mesures_stop_covid3,estimation de la proportion des individus ayant répondu oui à notre variable d'intérêt dans la grande population  */
Proc means
	data=Covid_data_final;
var Mesures_stop_covid3;
run;



 

	
 
 








