******Deskriptive Analysen/Signifikanztests******

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
use "abstract_2.dta", clear

//Logarithmiertes Einkommen zur Basis 2
//Jede Erhöhung von logeink um eine Einheit entspricht einer Verdoppelung des Einkommens
gen logeink = log(c2jbrutto)/log(2)
lab var logeink "Logarithmiertes Einkommen zur Basis 2"

//Absicht in zukunft aus beruf. Gründen ins Ausland zu gehen dichotomisiert
gen ausland2=.
replace ausland2=1 if ausland==1
replace ausland2=0 if ausland==3
label define auslb 0 "Nein" 1 "Ja"
lab value ausland2 auslb
lab var ausland2 "Absicht in Zukunft ins Ausland zu gehen"
tab ausland2

//Geschlecht Dummy
rename sex sex01
recode sex01 2=0
lab define sexlb 0 "Frauen" 1 "Männer"
lab value sex01 sexlb
lab var sex01 "Geschlecht"
tab sex01

// Anzahl Vorträge
gen vorträge2 = w2konvanz if !mi(w2konvanz)
replace vorträge2=. if vorträge2>=101
lab var vorträge2 "Vorträge gehalten"

gen bereit_auslmob=.
replace bereit_auslmob=0 if p1mobausl==1 | p1mobausl==2 
replace bereit_auslmob=1 if p1mobausl==4 | p1mobausl==5
label define bereit_lb 0 "Geringe Bereitschaft" 1 "Hohe Bereitschaft"
lab value bereit_auslmob bereit_lb
lab var bereit_auslmob "Arbeit im Ausland vorstellbar"
tab bereit_auslmob

gen bereit_deutmob=.
replace bereit_deutmob=0 if p1mobarsu==1 | p1mobarsu==2
replace bereit_deutmob=1 if p1mobarsu==4 | p1mobarsu==5
lab val bereit_deutmob bereit_lb
lab var bereit_deutmob "Arbeit im Ausland vorstellbar"
tab bereit_deutmob

gen worklife_dummy=.
replace worklife_dummy=0 if worklife2==1 | worklife2==2
replace worklife_dummy=1 if worklife2==4 | worklife2==5
lab define worklifelb 0 "Geringe Chance" 1 "Große Chance"
lab val worklife_dummy worklifelb
lab var worklife_dummy "Chancen innerhalb Wissenschaft: Beruf und Familie miteinander vereinbaren"
tab worklife_dummy

gen prom_intkont_dummy=.
replace prom_intkont_dummy=0 if prom_intkont==1 | prom_intkont==2
replace prom_intkont_dummy=1 if prom_intkont==4 | prom_intkont==5
label define promlb 0 "Trifft nicht zu" 1 "Trifft zu"
lab val prom_intkont_dummy promlb
lab var prom_intkont_dummy "Während Prom. angehalten internat. Kontakte zu knüpfen"
tab prom_intkont_dummy

$Daten_Bearb
save "abstract_3.dta", replace

$Daten_Bearb
use "abstract_3.dta", clear

************************************************************************
********************   Gewichtung der Stichprobe  **********************
************************************************************************
svyset [pweight=x2gewi]

************************************************************************
*************   Regressionsdiagnostik OLS-Regression  ******************
************************************************************************

* 1. Normalverteilung der Residuen
predict resid if e(sample), rstandard
hist resid
kdensity resid
* 2. Homoskedastiziät
rvfplot 
symplot p1mobausl
* 3. Linearität der Zusammenhänge (für "av", "uv" und "var" entsprechende Variablen eingeben)
scatter p1mobausl berufnetz2, ms(oh) || mband p1mobausl kinder1, ///
bands(30) clp(solid)
cprplot berufnetz2, lowess
cprplot sex01 
* 4. Multikollinearität
estat vif
* 5. Vollständigkeit des Modells // Anzahl der UV's wichtig, d.h. R² sollte hoch sein
* 6. Autokorrelation // Bei Querschnittsdaten kein Problem

****************************************************************************
*************  				 OLS-Regression  			********************
****************************************************************************
// Eigene Vorträge gehalten
reg vorträge2 sex01 kinder2 bedeut_wiss if c2jwiss==1
reg vorträge2 sex01 kinder2 bedeut_wiss ib3.promfach if c2jwiss==1
// Werden Karriereentscheidungen beeinflusst zu soziale Herkunft
reg bedeut_wiss ib3.sa_vat ib3.abschl_vat sex01 kinder2
reg bedeut_wiss ib3.sa_mut ib3.abschl_mut sex01 kinder2
// Einflussfaktoren auf das Einkommen
reg c2jbrutto ib3.sa_mut ib3.sa_mut sex01 kinder2
//Räumliche Mobilität
reg p1mobausl sex01 kinder1 i.promfach ib3.sa_mut ib3.sa_vat 
reg p1mobausl sex01 kinder1 i.promfach
reg p1mobausl sex01 kinder2 i.promfach berufnetz2 gebort
reg p1mobausl ausl_sa sex01 kinder1 berufnetz2 
//Anzahl Publikationen
reg pub_peer i.promfach ib3.sa_mut ib3.sa_vat kinder2 if c2jwiss==1

********************************************************************************
*************   Regressionsdiagnostik Logistische-Regression  ******************
********************************************************************************

* 1. Linearität
lowess ausland2 berufnetz2, jitter(2) bwidth (.5)

********************************************************************************
*************************   Logistische Regression  ****************************
********************************************************************************

// Logistische Regressionsmodelle
// Geschlecht, Kinder, Größe des subj. wahrgenomm. Berfsnetzwerks auf Bereitschaft Auslandsmobilität in Zukunft
logit ausland2 berufnetz2 sex01 kinder2 i.partner2 i.sex01#i.partner2 //if c2jwiss==1
// Odds-Ratio
display exp(_b[_cons] + _b[berufnetz2]*1) // Chance bei berufnetz=1 ist .2028854
display exp(_b[_cons] + _b[berufnetz2]*2) // Chance bei berufnetz=2 ist .31551399
di exp(_b[_cons] + _b[berufnetz2]*2)/exp(_b[_cons] + _b[berufnetz2]*1) 
// wenn Einschätzung zur Größe des beruflichen Netzwerkes um 1 Einheit steigt, steigt Chance
// zur geäußerten Absicht ins Ausland zu gehen um 1.5454583
di exp(_b[_cons] + _b[berufnetz2]*5)/exp(_b[_cons] + _b[berufnetz2]*1) 
// Odds-Ratios
logit, or 
// 1. Personen, die ihr berufliches Netzwerk am höchsten einschätzen, haben die 5,7 fache Chance die Absicht 
// zu äußern, zukünftig ins Ausland gehen zu wollen
// 2. Männer haben eine 1.75-fach so hohe Chance, die Absicht zu äußern, ins Ausland zu gehen
// 3. Befragte mit Kindern 0.586-fache Chance bzw. 1.70 ohne kinder 


//Formel wandelt Logits in Wahrscheinlichkeiten um (Kinderlose Frauen mit durchschnittlich großem Berufsnetz)
di exp(_b[_cons] + _b[berufnetz2]*3)/(1 + exp(_b[_cons] + _b[berufnetz2]*3))
predict Phat

// Grafik mit marginsplot
//Vorhergesagte Wahrscheinlichkeiten mit margins-Befehl
margins, at(berufnetz2=(1(1)5) sex01=1 kinder2=0) noatlegend
margins, at(berufnetz2=(1(1)5)) over(sex01 kinder2) 
marginsplot, by(kinder2)


// AV-Räumliche Mobilität
logit science_per5 berufnetz2 ib3.abschl_mut ib3.abschl_vat worklife2
logit d1mobilaus sex01 kinder1 ib3.sa_mut ib3.sa_vat
logit umzug_bl_1 sex01 kinder2 ib3.sa_mut ib3.sa_vat
logit befrist2 sex01 kinder2 i.branche2 i.promfach
logit, or

********************************************************************************
****************************** Für Abstract ************************************
********************************************************************************

// Forschungsaufenthalte im Ausland während Promotion
svy: logit d1mobilaus berufnetz ib3.promfach kinder1 sex01 if c1jwiss==1 // Erste Querschnittsanalysen
						// deuten darauf hin, dass sich das Ausmaß der Auslandsmobilität zwischen den Disziplinen
						// geringfügig unterscheiden könnte. 
						
// Absicht in Zukunft ins Ausland zu gehen
svy: logit ausland2 ib3.promfach berufnetz2 kinder2 sex01 // Absicht aus beruflichen Gründen ins Ausland zu gehen
						// unterscheidet sich zwischen den Disziplinen nicht signifikant
						
// Berufsbedingte Umzüge (Bundesländer)
svy: logit umzug_bl_1 sex01 kinder2 i.promfach i.branche1 // Disziplinen haben keinen signifikanten Einfluss auf
						// berufsbedingte Umzugsmobilität zwischen den Bundesländern
						// Es zeigt sich jedoch, dass Kinder im Haushalt zu einer Verringerung
						// berufsbedingte Umzugsmobilität führen können
											
reg wiss_zuk berufnetz2 sex01 kinder2 ib3.sa_mut ib3.sa_vat // Für Männer ist die Vorstellung auch zukünftig in der 
										// Wissenschaft zu arbeiten stärker ausgeprägt als bei Frauen
										
reg bedeut_wiss berufnetz2 sex01 kinder2 i.promfach // n.s.

svy: reg worklife2 sex01 i.promfach // Männer stimmen deutlich stärker der Aussage zu, dass Beruf und Familie innerhalb 
									// der Wissenchaft miteinander vereinbart werden können
																		
logit science_per1 sex01 kinder1 i.promfach berufnetz // Wissenschaftler*innen mit Kindern scheiden eher aus der Wissenschaft während der Promotionsphase aus als  Wissenschaftler*innen ohne Kinder

logit science_per5 sex01 kinder1 i.promfach berufnetz 

svy: logit im_ausland2 sex01 kinder2 i.promfach phase2 
// Männer können sich eher vorstellen für eine begrenzte Zeit im Ausland zu arbeiten, Personen mit Kindern weniger
svy: logit science_per1 p1mobausl sex01 kinder1 i.promfach 

svy: reg konf_aus sex01 kinder2 i.promfach phase5 


**********************************************************************************
************************ Mit Interaktionseffekt **********************************
**********************************************************************************

//Erzeuge Interaktionsvariable int_sp
gen int_sp = sex01*partner2

// Logistische Regressionsmodelle
// Geschlecht, Kinder, Berfsnetzwerk, Partnerschaft auf Bereitschaft Auslandsmobilität in Zukunft
logit ausland2 berufnetz2 kinder2 i.sex01##partner2 //if c2jwiss==1

margins, at(partner2=(0,1,2) sex01=(0,1))
marginsplot, bydim(sex01) byopt(rows(1))

