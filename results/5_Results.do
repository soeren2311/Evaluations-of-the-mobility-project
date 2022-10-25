****************************************************************************
*****  Do-file Analysen Mobilität (Für Onsite-Recherche möglich)    ********
*****  Datum: 30.09.2021                                      		********
****************************************************************************
*****  Analaysen/Regressionen etc.                          		********
****************************************************************************

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
use "OS_Promo14_Aufbereitung_Neu_3",clear

describe, short

// recode Variablen zur räumlichen Mobilitätsbereitschaft
foreach var of varlist p1mobtaet p1mobheim p1mobgeg p1mobgra {
	cap drop `var'rev
	gen byte `var'rev=6-`var'
}

gen wissenschaft=.
replace wissenschaft=0 if c2jwiss==2
replace wissenschaft=1 if c2jwiss==1
label define wisslb 0 "Nein" 1 "Ja"
label values wissenschaft wissl
label var wissenschaft "Aktuelle Stelle Tätigkeit in der Wissenschaft"

// Personalkategorie (Dichotom für logit-Regression)
gen personalkat2=.
replace personalkat2=0 if personalkat==1
replace personalkat2=1 if personalkat==4
label define pers_lb 0 "Wissenschaftlicher Mitarbeiter" 1 "Prof./Juniorprof."
label values personalkat2 persl_lb
label var personalkat2 "Personalkategorie: Wimi und Prof/Juniorprof"
tab personalkat2

// Variablen index_sozkapital* runden auf Null-Nachkommastelllen für Interaktionseffekt
replace index_sozkapital1 = round(index_sozkapital1, 1.0) //Emotionale Unterstützung während Promotionsphase
replace index_sozkapital2 = round(index_sozkapital2, 1.0)
replace index_sozkapital3 = round(index_sozkapital3, 1.0)

// Gewichtung
svyset x2geaus [pweight=x2gewi]

**********************************************************************************
************  Mobilitätsverhalten Welle_2 OLS-Regressionen  **********************
**********************************************************************************

// Modelle, die mit Benjamin besprochen wurden 
asdoc svy: reg index_2 ib1.SES_eltern woman kinder2 logeink2 ib1.partner2 ib1.kohorte c.kinder2#c.woman if c2jwiss==1, replace
#delimit ;
margins, at(kinder2 = (0 1) woman = (0 1)) vsquish;
marginsplot, recast(line) recastci(rarea)
	title("Mobilitätsbereitschaft - Interaktion Geschlecht und Elternschaft") 
	name(margins1, replace);
#delimit cr

svy: reg index_3kat ib1.SES_eltern woman kinder2 logeink2 ib1.partner2 ib1.kohorte c.kinder2#c.woman if c2jwiss==1
$Tabellen
outreg2 using ols_results_5, replace excel dec(3)

*********************************************************************************
************  Mobilitätsbereitschaft Welle_1 OLS-Regressionen *******************
*********************************************************************************

//Mobilitätsbereitschaft: Deutschland)
asdoc svy: reg p1mobarsu ib1.SES_eltern woman kinder1 i.promfach logeink1 index_sozkapital2 ib1.kohorte c.woman#c.kinder1 ///
if c1jwisstaet==1, replace
#delimit ;
margins, at(woman = (0 1) kinder1 = (0 1 )) vsquish;
marginsplot, recast(line) recastci(rarea)
	title("Mobilitätsbereitschaft - Interaktion Geschlecht und Kinder")
	name(margins1, replace);
#delimit cr

//Mobilitätsbereitschaft: Tätigkeit im Ausland käme nicht in Betracht (recoded)
asdoc svy: reg p1mobtaetrev ib1.SES_eltern woman kinder1 i.promfach logeink1 ib1.kohorte c.woman#c.kinder1 if c1jwisstaet==1, replace
#delimit ;
margins, at(woman = (0 1) kinder1 = (0 1 )) vsquish;
marginsplot, recast(line) recastci(rarea)
	title("Mobilitätsbereitschaft - Interaktion Geschlecht und Kinder")
	name(margins1, replace);
#delimit cr

// Mobilitätsbereitschaft: Heimat verlassen würde schwerfallen (recoded)
asdoc svy: reg p1mobheimrev ib1.SES_eltern woman kinder1 i.promfach logeink1 ib1.kohorte c.woman#c.kinder1 if c1jwisstaet==1, replace
#delimit ;
margins, at(woman = (0 1) kinder1 = (0 1 )) vsquish;
marginsplot, recast(line) recastci(rarea)
	title("Mobilitätsbereitschaft - Interaktion Geschlecht und Kinder")
	name(margins1, replace);
#delimit cr

// Mobilitätsbereitschaft: Umziehen ist ein Gräuel (recoded)
asdoc svy: reg p1mobgrarev ib1.SES_eltern woman kinder1 i.promfach logeink1 ib1.kohorte c.woman#c.kinder1 if c1jwisstaet==1, replace
#delimit ;
margins, at(woman = (0 1) kinder1 = (0 1 )) vsquish;
marginsplot, recast(line) recastci(rarea)
	title("Mobilitätsbereitschaft - Interaktion Geschlecht und Kinder")
	name(margins1, replace);
#delimit cr

// Vorstellung auch anderswo in Deutschland arbeiten zu wollen	
svy: logit bereit_deutmob ib1.SES_eltern woman kinder1 i.promfach logeink1 index_sozkapital1 index_sozkapital2 index_sozkapital3 ///
ib1.kohorte c.woman#c.kinder1 
logit, or

// Effekte auf Wissenschaft 
svy: logit wissenschaft index_3 ib1.SES_eltern woman kinder2 logeink2 index_sozkapital1 index_sozkapital2 index_sozkapital3 ib1.kohorte

svy: reg worklife2 index_3 ib1.SES_eltern bedeut_wiss woman kinder2 logeink2 i.promfach_neu index_sozkapital1 index_sozkapital2 ///
index_sozkapital3 ib1.kohorte if c2jwiss==1


// Mit Modellen
// Modell 1
svy: logit personalkat2 index_3 if c2jwiss==1
$Tabellen
outreg2 using myfile_paper1, word dec(3) replace ctitle(Model 1)

// Modell 2
svy: logit personalkat2 index_3 woman kinder2 ib0.partner2 if c2jwiss==1
$Tabellen
outreg2 using myfile_paper1, word dec(3) append ctitle(Model 2)

// Modell 3
svy: logit personalkat2 index_3 woman kinder2 ib0.partner2 logeink2 ib1.SES_eltern ///
index_sozkapital3 if c2jwiss==1
$Tabellen
outreg2 using myfile_paper1, word dec(3) append ctitle(Model 3)

// Modell 4
svy: logit personalkat2 index_3 woman kinder2 ib0.partner2 logeink2 ib1.SES_eltern ///
index_sozkapital3 i.promfach_neu ib1.kohorte if c2jwiss==1
$Tabellen
outreg2 using myfile_paper1, word dec(3) append ctitle(Model 4)

// Modell 5
svy: logit personalkat2 index_3 woman kinder2 ib0.partner2 logeink2 ib1.SES_eltern ///
index_sozkapital3 i.promfach_neu ib1.kohorte i.promfach_neu#c.index_sozkapital3 if c2jwiss==1
$Tabellen
outreg2 using myfile_paper1, word dec(3) append ctitle(Model 5)

// Durchschnittliche Marginaleffekte des sozialen Kapitals (emotional) für die Kategorie Promotionsfach
margins promfach_neu, dydx(index_sozkapital1)
//Interpretation
// Für Sozialwissenschaftler steigt die vorhergesagte Wahrscheinlichkeit Juniorprof/bzw- Prof. zu 
// werden im Schnitt um etwa 1,55 % pro zusätzlichem Punkt auf der Sozialkapital-Variable (Nicht signifikant)


********************************************************************************
****************************** Zusätzliche Analysen*****************************
********************************************************************************

// Forschungsaufenthalte im Ausland während Promotion
svy: logit d1mobilaus berufnetz ib3.promfach kinder1 woman if c1jwiss==1 // Erste Querschnittsanalysen
						// deuten darauf hin, dass sich das Ausmaß der Auslandsmobilität zwischen den Disziplinen
						// geringfügig unterscheiden könnte. 
						
// Absicht in Zukunft ins Ausland zu gehen
svy: logit ausland2 ib3.promfach berufnetz2 kinder2 sex // Absicht aus beruflichen Gründen ins Ausland zu gehen
						// unterscheidet sich zwischen den Disziplinen nicht signifikant
						
// Berufsbedingte Umzüge (Bundesländer)
svy: logit umzug_bl_1 sex kinder2 i.promfach i.branche1 // Disziplinen haben keinen signifikanten Einfluss auf
						// berufsbedingte Umzugsmobilität zwischen den Bundesländern
						// Es zeigt sich jedoch, dass Kinder im Haushalt zu einer Verringerung
						// berufsbedingte Umzugsmobilität führen können
											
reg wiss_zuk berufnetz2 sex kinder2 ib3.sa_mut ib3.sa_vat // Für Männer ist die Vorstellung auch zukünftig in der 
										// Wissenschaft zu arbeiten stärker ausgeprägt als bei Frauen
										
reg bedeut_wiss berufnetz2 sex kinder2 i.promfach // n.s.

svy: reg worklife2 sex i.promfach // Männer stimmen deutlich stärker der Aussage zu, dass Beruf und Familie innerhalb 
									// der Wissenchaft miteinander vereinbart werden können
																		
logit science_per1 sex kinder1 i.promfach berufnetz // Wissenschaftler mit Kindern scheiden eher aus der 
										// Wissenschaft während der Promotionsphase aus als  Wissenschaftler ohne Kinder

logit science_per5 sex kinder1 i.promfach berufnetz 

svy: logit im_ausland2 sex kinder2 i.promfach phase2 
// Männer können sich eher vorstellen für eine begrenzte Zeit im Ausland zu arbeiten, Personen mit Kindern weniger
svy: logit science_per1 p1mobausl sex kinder1 i.promfach 

//ssc install asdoc
//help asdoc


************************************************************
******************** Aktuell 24.11.2021 ********************
************************************************************

// Mit Modellen (Mobilität während der Promotion)
// Modell 1 
svy: logit personalkat2 index_3 if c2jwiss==1
$Tabellen
outreg2 using myfile_paper1, word dec(3) replace ctitle(Model 1)

// Modell 2
svy: logit personalkat2 index_3 woman kinder2 ib0.partner2 if c2jwiss==1
$Tabellen
outreg2 using myfile_paper1, word dec(3) append ctitle(Model 2)

// Modell 3
svy: logit personalkat2 index_3 woman kinder2 ib0.partner2 logeink2 ib1.SES_eltern ///
index_sozkapital3 if c2jwiss==1
$Tabellen
outreg2 using myfile_paper1, word dec(3) append ctitle(Model 3)

// Modell 4
svy: logit personalkat2 index_3 woman kinder2 ib0.partner2 logeink2 ib1.SES_eltern ///
index_sozkapital3 i.promfach_neu ib1.kohorte if c2jwiss==1
$Tabellen
outreg2 using myfile_paper1, word dec(3) append ctitle(Model 4)

// Modell 5
svy: logit personalkat2 index_3 woman kinder2 ib0.partner2 logeink2 ib1.SES_eltern ///
index_sozkapital3 i.promfach_neu ib1.kohorte i.promfach_neu#c.index_sozkapital3 if c2jwiss==1
$Tabellen
outreg2 using myfile_paper1, word dec(3) append ctitle(Model 5)

