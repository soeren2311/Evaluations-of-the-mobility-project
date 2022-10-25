*******************************************************************
*****  Do-file Analysen Mobilität   Onsite                    *****
*****  Datum: 06.04.2021                                      *****
*******************************************************************
***** Aufbereitung Variablen                                  *****
*******************************************************************

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
use "3_OS_Promo14_aufb_1a.dta", clear


//numlabel, add

describe, short  //erster Überblick über den Datensatz


**************************************************************
**************** Aufbereitung der Variablen******************
**************************************************************

//Geschlecht   (Bereits codiert, aber gedropt)
gen sex=.
replace sex=1 if k1geschl==1
replace sex=2 if k1geschl==2
label define Sexlb 1 "Männlich" 2 "Weiblich"
label value sex Sexlb
lab var sex "Geschlecht"
tab k1geschl sex

//Geburtsjahr
gen gebjahr=.
replace gebjahr=1 if k1gebjahr_g2==1
replace gebjahr=2 if k1gebjahr_g2==2
replace gebjahr=3 if k1gebjahr_g2==3
replace gebjahr=4 if k1gebjahr_g2==4
replace gebjahr=5 if k1gebjahr_g2==5
replace gebjahr=6 if k1gebjahr_g2==6
replace gebjahr=7 if k1gebjahr_g2==7
replace gebjahr=8 if k1gebjahr_g2==8
label define gebjahrlb 1 "bis 1959" 2 "1960-1969" 3 "1970-1979" 4 "1980-1981" ///
5 "1982-1983" 6 "1984-1985" 7 "1986-1987" 8 "1988 und jünger"
lab value gebjahr gebjahrlb
lab var gebjahr "Geburtsjahr"
tab k1gebjahr_g2 gebjahr

//Einkommen (Monatliches Bruttoeinkommen kategorisiert) -> Welle 2
gen einkommen=.
replace einkommen=1 if c2jbrutto>=1 & c2jbrutto<=3899
replace einkommen=2 if c2jbrutto>=3900 & c2jbrutto<=4999
replace einkommen=3 if c2jbrutto>=5000 & c2jbrutto<=120000
label define einkommenlb 1 "unter 3900 Euro" 2 "3900 bis 4999 Euro" 3 "5000 Euro und mehr"
label value einkommen einkommenlb
lab var einkommen "Einkommen"
tab c2jbrutto einkommen

//  Vollzeit: Stundenumfang
tab c2taet1stdvz            
gen stdvollzeit=.
replace stdvollzeit=1 if c2taet1stdvz>=1 & c2taet1stdvz<=40
replace stdvollzeit=2 if c2taet1stdvz>=41 & c2taet1stdvz<=80
label define stdvollzeitlb 1 "bis 40 Std./Woche" 2 "40 Std./Woche und mehr" 
label value stdvollzeit stdvollzeitlb
lab var stdvollzeit "Vertraglich vereinbarte Arbeitszeit: Vollzeit"
tab c2taet1stdvz stdvollzeit
tab  stdvollzeit

tab c5taet1stdvz            
gen stdvollzeit5=.
replace stdvollzeit5=1 if c5taet1stdvz>=1 & c5taet1stdvz<=40
replace stdvollzeit5=2 if c5taet1stdvz>=41 & c5taet1stdvz<=80
label define stdvollzeitlb 1 "bis 40 Std./Woche" 2 "40 Std./Woche und mehr" 
label value stdvollzeit5 stdvollzeitlb
lab var stdvollzeit5 "Vertraglich vereinbarte Arbeitszeit: Vollzeit"
tab c5taet1stdvz stdvollzeit5
tab  stdvollzeit5

//  Vollzeit: Stundenumfang
tab c2taet1stdtz            
gen stdteilzeit=.
replace stdteilzeit=1 if c2taet1stdtz>=1 & c2taet1stdtz<=20
replace stdteilzeit=2 if c2taet1stdtz>=21 & c2taet1stdtz<=40
label define stdteilzeitlb 1 "bis 20 Std./Woche" 2 "21 Std./Woche und mehr" 
label value stdteilzeit stdteilzeitlb
lab var stdteilzeit "Vertraglich vereinbarte Arbeitszeit: Teilzeit"
tab c2taet1stdtz stdteilzeit
tab stdteilzeit


//  Formaler Promotionsbeginn: Jahr
tab d1projanf, mi    // Jahr
gen phdbeginn=.
replace phdbeginn=1 if d1projanf>=1980 & d1projanf<=2008
replace phdbeginn=2 if d1projanf==2009 
replace phdbeginn=3 if d1projanf==2010
replace phdbeginn=4 if d1projanf>=2011 & d1projanf<=2018
label define phdbeginnlb 1 "bis 2008" 2 "2009" 3 "2010" 4 "2011 und später"
label value phdbeginn phdbeginnlb
lab var phdbeginn "Promotionsverlauf: Formaler Beginn (Jahr)"
tab phdbeginn
tab phdbeginn d1projanf


//  Abgabe der Dissertation: Jahr
tab d1jdissab   // Jahr
gen abgabediss=.
replace abgabediss=1 if d1jdissab>=1980 & d1jdissab<=2012
replace abgabediss=2 if d1jdissab==2013 
replace abgabediss=3 if d1jdissab>=2014 & d1jdissab<=2018
label define abgabedisslb 1 "bis 2012" 2 "2013" 3 "2014 und später"
label value abgabediss abgabedisslb
lab var abgabediss "Abgabe der Dissertation (Jahr)"
tab abgabediss
tab abgabediss d1jdissab


//Erwerbstätigkeit aus Welle 1
//neue Variable "permanent wissenschaftlich tätig während Promotionszeit"
capture drop science_per1
generate science_per1=0
replace science_per1=1 if c1taet1lnoc==1 & c1taet1wiss==1 | c1taet2lnoc==1 ///
& c1taet2wiss==1 & c1taet1wiss==1 | c1taet3lnoc==1 & c1taet3wiss==1 & c1taet2wiss==1 ///
& c1taet1wiss==1| c1taet4lnoc==1 & c1taet4wiss==1 & c1taet3wiss==1 & c1taet2wiss==1 ///
& c1taet1wiss==1| c1taet5lnoc==1 & c1taet5wiss==1 & c1taet4wiss==1 & c1taet3wiss==1 ///
& c1taet2wiss==1 & c1taet1wiss==1 | c1taet6lnoc==1 & c1taet6wiss==1 & c1taet5wiss==1 ///
& c1taet4wiss==1 & c1taet3wiss==1 & c1taet2wiss==1 & c1taet1wiss==1| c1taet7lnoc==1 ///
& c1taet7wiss==1 & c1taet6wiss==1 & c1taet5wiss==1 & c1taet4wiss==1 & c1taet3wiss==1 ///
& c1taet2wiss==1 & c1taet1wiss==1| c1taet8lnoc==1 & c1taet8wiss==1 & c1taet7wiss==1 ///
& c1taet6wiss==1 & c1taet5wiss==1 & c1taet4wiss==1 & c1taet3wiss==1 & c1taet2wiss==1 ///
& c1taet1wiss==1| c1taet9lnoc==1 & c1taet9wiss==1 & c1taet8wiss==1 & c1taet7wiss==1 ///
& c1taet6wiss==1 & c1taet5wiss==1 & c1taet4wiss==1 & c1taet3wiss==1 & c1taet2wiss==1 ///
& c1taet1wiss==1| c1taet10lnoc==1 & c1taet10wiss==1 & c1taet9wiss==1 & c1taet8wiss==1 ///
& c1taet7wiss==1 & c1taet6wiss==1 & c1taet5wiss==1 & c1taet4wiss==1 & c1taet3wiss==1 ///
& c1taet2wiss==1 & c1taet1wiss==1
label var science_per1 "Permanent wissenschaftlich tätig (Promotionsphase)"
label define science_per_l 0 "nein" 1 "ja"
label value science_per1 science_per_l
tab science_per1 
				
Erwerbstätigkeit aus Welle 5
//neue Variable "permanent wissenschaftlich tätig"
capture drop science_per5
gen science_per5=.
replace science_per5=1 if c5taet1lnoc==1 & c5taet1wiss==1 | c5taet2lnoc==1 ///
& c5taet2wiss==1 & c5taet1wiss==1 | c5taet3lnoc==1 & c5taet3wiss==1 & c5taet2wiss==1 ///
& c5taet1wiss==1 | c5taet4lnoc==1 & c5taet4wiss==1 & c5taet3wiss==1 & c5taet2wiss==1 ///
& c5taet1wiss==1 | c5taet5lnoc==1 & c5taet5wiss==1 & c5taet4wiss==1 & c5taet3wiss==1 ///
& c5taet2wiss==1 & c5taet1wiss==1 | c5taet6lnoc==1 & c5taet6wiss==1 & c5taet5wiss==1 ///
& c5taet4wiss==1 & c5taet3wiss==1 & c5taet2wiss==1 & c5taet1wiss==1 | c5taet7lnoc==1 ///
& c5taet7wiss==1 & c5taet6wiss==1 & c5taet5wiss==1 & c5taet4wiss==1 & c5taet3wiss==1 ///
& c5taet2wiss==1 & c5taet1wiss==1
replace science_per5=0 if c5taet1wiss==2 | c5taet2wiss==2 & c5taet1wiss==2 | ///
c5taet3wiss==2 & c5taet2wiss==2 & c5taet1wiss==2 | c5taet4wiss==2 & c5taet3wiss==2 & c5taet2wiss==2 ///
& c5taet1wiss==2 | c5taet5wiss==2 & c5taet4wiss==2 & c5taet3wiss==2 & c5taet2wiss==2 & c5taet1wiss==2 | ///
c5taet6wiss==2 & c5taet5wiss==2 & c5taet4wiss==2 & c5taet3wiss==2 & c5taet2wiss==2 & c5taet1wiss==2 | ///
c5taet7wiss==2 & c5taet6wiss==2 & c5taet5wiss==2 & c5taet4wiss==2 & c5taet3wiss==2 ///
& c5taet2wiss==2 & c5taet1wiss==2
label var science_per5 "Permanent wissenschaftlich tätig (Post-Doc)"
label value science_per5 science_per_l
tab science_per5 

	
//  Erwerbstätigkeit ab Promotion: Berufliche Stellung 
tab c1taet1best   // Tätigkeit 1
gen berufstellng_1=.
replace berufstellng_1=1 if c1taet1best==2 | c1taet1best==3 |  c1taet1best==8 |  c1taet1best==9
replace berufstellng_1=2 if c1taet1best==1 | c1taet1best==4 | c1taet1best==5 |  c1taet1best==6 | c1taet1best==7
replace berufstellng_1=3 if c1taet1best==10 | c1taet1best==11 |  c1taet1best==12 | c1taet1best==13 | c1taet1best==13
label define berufstellng_1lb 1 "Wiss. Qualifizierter, Beamte" 2 "Angestellte und Selbständige" 3 "Beamte einf./mittl. Dienst, (Fach-)Arbeiter"
label value berufstellng_1 berufstellng_1lb
lab var berufstellng_1 "Berufliche Stellung kategorisiert (Tätigkeit 1)"
tab berufstellng_1
tab berufstellng_1 c1taet1best


tab d1konfanz      // Anzahl der besuchten Tagungen
gen anzahltagungen=.
replace anzahltagungen=1 if d1konfanz>=1 & d1konfanz<=3
replace anzahltagungen=2 if d1konfanz>=4 & d1konfanz<=8
replace anzahltagungen=3 if d1konfanz>=9 & d1konfanz<=100
label define Anzahltagungenlb 1 "1-3" 2 "4-8" 3 "9 und mehr"
label value anzahltagungen Anzahltagungenlb
lab var anzahltagungen "Anzahl der besuchten Tagungen (kategorisiert)"
tab anzahltagungen
tab anzahltagungen d1konfanz 


tab m2grad1dauer       // Geplante Dauer Auslandsaufenthalt: Seit letztem Studiumabschl/akt. Ausl.-Aufenthalt
gen geplantedauerausland_1=.
replace geplantedauerausland_1=1 if m2grad1dauer>=1 & m2grad1dauer<=2
replace geplantedauerausland_1=2 if m2grad1dauer>=3 & m2grad1dauer<=8
replace geplantedauerausland_1=3 if m2grad1dauer>=9 & m2grad1dauer<=100
label define geplantedauerausland_1lb 1 "1-2 Monate" 2 "3-8" 3 "9 und mehr"
label value geplantedauerausland_1 geplantedauerausland_1lb
lab var geplantedauerausland_1 "1. Auslandsaufenthalt: geplante Dauer (kategorisiert)"
tab geplantedauerausland_1
tab geplantedauerausland_1 m2grad1dauer


 // Absicht in Zukunft ins Ausland zu gehen
  //kein Ausland
gen ausland=.
replace ausland=1 if m2plandaof==1 | m2plandamf==1 | m2planzeit==1 | m2planfor==1 | m2planwbi==1 
replace ausland=2 if m2planson==1
replace ausland=3 if m2plannein==1
label define auslandlb 1 "ja, beruflich" 2 "ja, privat" 3 "nein"
label value ausland auslandlb
lab var ausland "Auslandmobilität"
tab ausland


$Daten_Bearb
save "4_OS_Promo14_aufb_1b.dta", replace

exit