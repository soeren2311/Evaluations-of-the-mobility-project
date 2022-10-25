//Analysen mit Datensatz "4_OS_Promo14_aufb_1b"

clear all
version 16
set more off
set scrollbufsize 500000 

*Globals
	
	global Verzeichnis "C:\Users\sonon001\Desktop\DZHW\HS Niederrhein\Forschung\Datenanalyse Mobilität\Analysen\OS_Promo14"
	global Abbildungen "cd "${Verzeichnis}/Abbildungen""
	global Daten_Bearb "cd "${Verzeichnis}/Daten/Daten_Bearb""
	global Daten_Orig "cd "${Verzeichnis}/Daten/Daten_Orig""
	global Do-Files "cd "${Verzeichnis}/Do-Files""
	global Tabellen "cd "${Verzeichnis}/Tabellen""


$Daten_Bearb
use "4_OS_Promo14_aufb_1b.dta", clear


********************************************************************************
********                     Analysen                   ************************
********************************************************************************

*Einfluss des Umzugs in anderes Bundesland (BL) auf Gehalt

//Variable für den Umzug erstellen
	
	*Ausgangsvariablen
	tab c2taet1bula_g1, mi
	tab c2taet1bula_g1 c2taet2bula_g1
	tab c2taet2bula_g1, mi
	tab c2taet3bula_g1, mi

	*neue Variable für BL-Wechsel zwischen erstem und zweitem Job
	//Logik Filter (Beispiel): Wenn Person bei Job1 bei AG1 arbeitet und für Job2 gleichen AG angibt, 
	//muss Bundesland ja das Gleiche sein. 
	gen umzug_bl_1=1
	replace umzug_bl_1=0 if c2taet1bula_g1==c2taet2bula_g1 | c2taet2bula_g1==.g
	replace umzug_bl_1=. if c2taet2bula_g1==.f | c2taet2bula_g1==.h | c2taet2bula_g1==.i | ///
			c2taet2bula_g1==.j | c2taet2bula_g1==.
	label var umzug_bl_1 "BL-Wechsel zw. Job 1 und Job 2"
	label define umzug_bl_lb 0 "nein" 1 "ja"
	label values umzug_bl_1 umzug_bl_lb
	tab umzug_bl_1
	tab umzug_bl_1 c2taet2bula_g1

	
	*neue Variable für BL-Wechsel zwischen zweitem und drittem Job

	gen umzug_bl_2=1 if  umzug_bl_1==1
	replace umzug_bl_2=. if c2taet3bula_g1==.g 
	replace umzug_bl_2=0 if umzug_bl_1==0 | c2taet2bula_g1==c2taet3bula_g1
	replace umzug_bl_2=. if c2taet3bula_g1==.f | c2taet3bula_g1==.h | ///
	c2taet3bula_g1==.i | c2taet3bula_g1==.j 
	label var umzug_bl_2 "BL-Wechsel zw. Job 2 und Job 3"
	label values umzug_bl_2 umzug_bl_lb
	tab umzug_bl_2
	tab umzug_bl_2 c2taet3bula_g1
	
	*neue Variable für arbeitsbedingten Umzug in anderes BL
	gen job_mobil=.
	replace job_mobil=0 if umzug_bl_1==0
	replace job_mobil=1 if umzug_bl_1==1
	replace job_mobil=2 if umzug_bl_2==1
	label var job_mobil "Jobwechsel in anderes BL"
	label define job_mobil_lb 0 "0x" 1 "1x" 2 "2x"
	label values job_mobil job_mobil_lb
	tab job_mobil
	
		*Dummy-Variable für mindestens einen Jobwechsel in anderes BL-Wechsel
		gen job_mobil_dummy=.
		replace job_mobil_dummy=0 if job_mobil==0
		replace job_mobil_dummy=1 if job_mobil==1 | job_mobil==2
		label var job_mobil_dummy "Jobwechsel zu AG in anderem Bundesland?"
		label values job_mobil_dummy umzug_bl_lb
		tab job_mobil_dummy

	*bestehende Variable für Gehalt der letzten/aktuellen Stelle:
	tab c2jbrutto
	tab einkommen
	
	*neue Variable für Lohndifferenz zwischen zweiter und erster Welle für die 
	*jeweils letzte Stelle
	
	by pid: gen differenz21 = c2jbrutto - c1jbrutto
	sum differenz21, detail
	sum differenz21 if sex==1, detail
	sum differenz21 if sex==2, detail
		//Für Fächergruppen als Exceltabelle
		$Tabellen 
		tabout d1profagr1_g1 using OS_Fach_Einkommen.csv, replace sum oneway ///
		dpcomma style(semi) cells(N differenz21 mean differenz21 median differenz21 sd differenz21 ///
		skewness differenz21 min differenz21 max differenz21) format (2)
	
$Daten_Bearb
save "5_OS_Promo14_aufb_1c.dta", replace

*****************************************************************
**                     Regressionsanalysen                     **
*****************************************************************
	
	*Lineare Regressionsanalysen für Vollzeitkräfte
	regress c2jbrutto i.job_mobil sex if stdvollzeit!=.
		// leider nicht signifikant
	regress c2jbrutto job_mobil_dummy sex if stdvollzeit!=.
	
	regress differenz i.d1profagr1_g1 sex job_mobil_dummy
	
		
	*Ordinal logistische Regressionsanalyse für Vollzeitkräfte
	ologit einkommen i.job_mobil sex if stdvollzeit!=.
	margins, dydx(*) post //"post" testet auch auf Unterschiede zwischen Koeffizienten
		// nur Geschlecht ist signifikant
	ologit einkommen job_mobil_dummy sex if stdvollzeit!=.
	margins, dydx(*) post
	
	
******************************************************************
************  Regressionsanalysen Sören Nonnengart ***************	
******************************************************************

//Je fortgeschrittener die Karrierestufe, desto höher die Beritschaft räum. mobil zu sein? (Einstellung)
regress p1mobausl c1akentsch
regress p1mobausl c1akentsch sex

regress p1mobheim c1akentsch



*************************************************************************
**************  Weitere Variablen generieren  ***************************
*************************************************************************

//Wissensarbeiter an Hochschule? 
gen betrieb=.
replace betrieb=0 if c1jbetrgr_g1<=2
replace betrieb=1 if c1jbetrgr_g1>=3
label define betrieblb 0 "< 250 Mitarbeiter" 1 ">= 250 Mitarbeiter"
label values betrieb betrieblb
label var betrieb "Mitarbeitergröße des Betriebes"
tab betrieb

gen TVöD_hs=.
replace TVöD_hs=0 if betrieb==0 & c1joeffdi==2
replace TVöD_hs=1 if betrieb==1 & c1joeffdi==1
label define tvöd_lb 0 "Kein Wissensarbeiter Hochschule" 1 "Wissensarbeiter an HS"
label values TVöD_hs tvöd_lb
label var TVöD_hs "Wissenschaftliches Personal an einer Hochschule"
tab TVöD_hs



