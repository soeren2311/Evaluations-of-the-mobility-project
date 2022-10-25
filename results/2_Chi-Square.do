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
use "abstract_1.dta", clear

//Variablen vorbereiten (Branchenzugehörigkeit Welle 1 und 2)
gen branche1=.
replace branche1=1 if c1jbranche>=28 & c1jbranche<=29
replace branche1=2 if c1jbranche>=1 & c1jbranche<=22  
replace branche1=3 if c1jbranche==23
label define branchelb 1 "Hochschule/Forschungsein." 2 "Freie Wirtschaft" 3 "Gesundheitswesen"
label values branche1 branchelb
label var branche1 "Branchenzugehörigkeit"
tab branche1

gen branche2=.
replace branche2=1 if c2jbranche>=28 & c2jbranche<=29
replace branche2=2 if c2jbranche>=1 & c2jbranche<=22  
replace branche2=3 if c2jbranche==23
label values branche2 branchelb
label var branche2 "Branchenzugehörigkeit"
tab branche2

drop c1jbranche c2jbranche

rename c1jpos prom_wich1
rename c2jpos prom_wich2

*******************************************************************************************
******************Frage 1 Abstract) Motive für eine Promotion******************************
*******************************************************************************************


*******************************************************************************************
****Frage 2 Abstract) Werden Karriereentscheidungen und Chancen beeinflusst durch**********
*************soziale Herkunft, Geschlecht, Migrationshintergrund etc.**********************
*******************************************************************************************
		
							********* Soziale Herkunft **********				

*******BILDUNG ELTERN - Soziale Mobilität*******
//Chi-Quadrat-Test (Bildung Eltern - zukünftig in Wissenschaft tätig?)
tab sa_vat wiss_zuk, chi2 V expected // n.s
tab sa_mut wiss_zuk, chi2 V expected // n.s
//Chi-Quadrat-Test (Bildung Eltern - bisher dauerhaft in Wissenschaft tätig gewesen (Promotionsphase))
tab sa_vat science_per1, chi2 V expected // n.s
tab sa_mut science_per1, chi2 V expected // n.s
//Chi-Quadrat-Test (Bildung Eltern - Wichtigkeit Wissenschaftskarriere)
tab sa_vat bedeut_wiss, chi2 V expected // n.s 
tab sa_mut bedeut_wiss, chi2 V expected // p-value: 0.003, Cramér's V: 0.0472

tab abschluss_eltern wiss_zuk, chi2 V expected
tab bild_eltern wiss_zuk, chi2 V expected

*******BILDUNG ELTERN - Räumliche Mobilität*******
//Chi-Quadrat-Test (Bildung Eltern - Absicht in Zukunft ins Ausland zu gehen)
tab sa_vat ausland, chi2 V expected // n.s.
tab sa_mut ausland, chi2 V expected // p-value: 0.025, Cramér's V = 0.0435
//Chi-Quadrat-Test (Bildung Eltern - Geplante Dauer Auslandsaufenhalt)
tab sa_vat geplantedauerausland_1, chi2 V expected // n.s.
tab sa_mut geplantedauerausland_1, chi2 V expected // n.s.
//Chi-Quadrat-Test (Bildung Eltern - Ausland nach Studium)
tab sa_vat ausland_nachstudium, chi2 V expected // p-value: 0.034
tab sa_mut ausland_nachstudium, chi2 V expected // n.s
//Chi-Quadrat-Test (Bildung Eltern - Ausland/Deutschland Forschungsauf. Dauer>=1 Monat während Prom.)
tab sa_vat d1mobilaus, chi2 V expected // n.s.
tab sa_mut d1mobilaus, chi2 V expected // n.s.
tab sa_vat d1mobild, chi2 V expected // n.s.
tab sa_mut d1mobild, chi2 V expected // n.s.

//Chi-Quadrat-Test (Bildung Eltern - Vorstellen im Ausland zu arbeiten)
tab sa_vat p1mobausl, chi2 V expected // p-value: 0.001, Cramér's V: 0.0513
tab sa_mut p1mobausl, chi2 V expected // p-value: 0.000, Cramér's V: 0.0590
//Chi-Quadrat-Test (Bildung Eltern - Aus beruf. Gründen umziehen Gräuel)
tab sa_vat p1mobgra, chi2 V expected // p-value: 0.005, Cramér's V: 0.0458
tab sa_mut p1mobgra, chi2 V expected // p-value: 0.004, Cramér's V: 0.0464
// --> Bereitschaft im Ausland zu arbeiten größer bei Wiss. aus gebildetem Elterhaus

*******ABSCHLUSS ELTERN - Soziale Mobilität*******
//Chi-Quadrat-Test (Bildung Eltern - zukünftig in Wissenschaft tätig?)
tab abschl_vat wiss_zuk, chi2 V expected // n.s. 
tab abschl_mut wiss_zuk, chi2 V expected // n.s.
//Chi-Quadrat-Test (Abschluss Eltern - Bisher dauerhaft in Wissenschaft tätig gewesen (Promotionsphase))
tab abschl_vat science_per1, chi2 V expected // n.s 
tab abschl_mut science_per1, chi2 V expected // n.s
//Chi-Quadrat-Test (Abschluss Eltern - Wichtigkeit Wissenschaftskarriere)
tab abschl_vat bedeut_wiss, chi2 V expected // p-value: 0.001, Cramér's V: 0.0514
tab abschl_mut bedeut_wiss, chi2 V expected // p-value: 0.000, Cramér's V: 0.0564

*******ABSCHLUSS ELTERN - Räumliche Mobilität*******
//Chi-Quadrat-Test (Abschluss Eltern - Absicht in Zukunft ins Ausland zu gehen - postdoc)
tab abschl_vat ausland, chi2 V expected // n.s.
tab abschl_mut ausland, chi2 V expected // p-value: 0.03, Cramér's V = 0.0435
//Chi-Quadrat-Test (Abschluss Eltern - Geplante Dauer Auslandsaufenhalt)
tab abschl_vat geplantedauerausland_1, chi2 V expected // n.s.
tab abschl_mut geplantedauerausland_1, chi2 V expected // n.s.
//Chi-Quadrat-Test (Abschluss Eltern - Ausland nach Studium)
tab abschl_vat ausland_nachstudium, chi2 V expected // n.s
tab abschl_mut ausland_nachstudium, chi2 V expected // n.s
//Chi-Quadrat-Test (Abschluss Eltern - Ausland/Deutschland Forschungsauf. Dauer>=1 Monat während Prom.)
tab abschl_vat d1mobilaus, chi2 V expected // n.s.
tab abschl_mut d1mobilaus, chi2 V expected // n.s.
tab abschl_vat d1mobild, chi2 V expected // n.s.
tab abschl_mut d1mobild, chi2 V expected // n.s.
//Chi-Quadrat-Test (Abschluss Eltern - Vorstellen im Ausland zu arbeiten)
tab abschl_vat p1mobausl, chi2 V expected // p-value: 0.000, Cramér's V: 0.0544
tab abschl_mut p1mobausl, chi2 V expected // p-value: 0.000, Cramér's V: 0.0573
//Chi-Quadrat-Test (Abschluss Eltern - Aus beruf. Gründen umziehen Gräuel)
tab abschl_vat p1mobgra, chi2 V expected // n.s.
tab abschl_mut p1mobgra, chi2 V expected // n.s.

					************** Geschlecht ************* 			
					
********GESCHLECHT - Soziale Mobilität******
//Chi-Quadrat-Test (Geschlecht - zukünftig in Wissenschaft tätig?)
tab sex wiss_zuk, chi2 V expected // p-value: 0.000, Cramér's V: 0.1263, -> Männer eher bereit in Wiss. zu bleiben
//Chi-Quadrat-Test (Geschlecht - bisher dauerhaft in Wissenschaft tätig gewesen (Promotionsphase))
tab sex science_per1, chi2 V expected // p-value: 0.000, Phi-Koeffizient (Φ): -0.0659 -> Frauen verlassen eher Wiss.
//Chi-Quadrat-Test (Geschlecht - bisher dauerhaft in Wissenschaft tätig gewesen (Post-Doc-Phase))
tab sex science_per5, chi2 V expected // n.s.
//Chi-Quadrat-Test (Geschlecht - Wichtigkeit Wissenschaftskarriere)
tab sex bedeut_wiss, chi2 V expected // p-value: 0.007 , Cramér's V: 0.0521

********GESCHLECHT - Räumliche Mobilität******
//Chi-Quadrat-Test (Geschlecht - Absicht in Zukunft ins Ausland zu gehen)
tab sex ausland, chi2 V expected // p-value: 0.000, Cramér's V: 0.1236
//Chi-Quadrat-Test (Geschlecht - Geplante Dauer Auslandsaufenhalt)
tab sex geplantedauerausland_1, chi2 V expected // n.s.
//Chi-Quadrat-Test (Geschlecht - Ausland nach Studium)
tab sex ausland_nachstudium, chi2 V expected // n.s.
//Chi-Quadrat-Test (Geschlecht - Forschungsauf. Ausl/Deut Dauer>=1 Monat während Prom.)
tab sex d1mobilaus, chi2 V expected // p-value: 0.026, Phi-Koeffizient (Φ): -0.0307 --> Männer etwas häufiger
tab sex d1mobild, chi2 V expected // n.s.

//Chi-Quadrat-Test (Geschlecht - Vorstellen im Ausland zu arbeiten)
tab sex p1mobausl, chi2 V expected // p-value: 0.000, Cramér's V: 0.0819
//Chi-Quadrat-Test (Geschlecht - Aus beruf. Gründen umziehen Gräuel)
tab sex p1mobgra, chi2 V expected // p-value: 0.000, Cramér's V: 0.0921
//  --> Männer eher bereit im Ausland zu arbeiten

					*************** Migrationshintergrund **************
					
******* Migrationshintergrund - Soziale Mobilität*************
//Chi-Quadrat-Test (Geburtsort - Beabsichtigung zukünftig in Wissenschaft tätig zu sein?)
tab gebort wiss_zuk, chi2 V expected // p-value: 0.002, Cramér's V: 0.0740, -> Ausländer eher zukunft in Wiss.
//Chi-Quadrat-Test (Geburtsort - bisher dauerhaft in Wissenschaft tätig gewesen (Promotionsphase))
tab gebort science_per1, chi2 V expected // n.s.
//Chi-Quadrat-Test (Geburtsort - Wichtigkeit Wissenschaftskarriere)
tab gebort bedeut_wiss, chi2 V expected // p-value: 0.000 , Cramér's V: 0.110

**********Migrationshintergrund - räumliche Mobilität**********
//Chi-Quadrat-Test (Ander SA - Absicht in Zukunft ins Ausland zu gehen)
tab ausl_sa ausland, chi2 V expected // p-value: 0.000, Cramér's V: 0.1006
//Chi-Quadrat-Test (Andere SA - Geplante Dauer Auslandsaufenhalt)
tab ausl_sa geplantedauerausland_1, chi2 V expected // 
//Chi-Quadrat-Test (Andere SA - Forschungsauf. Ausl/Deut Dauer>=1 Monat während Prom.)
tab ausl_sa d1mobilaus, chi2 V expected // 
tab ausl_sa d1mobild, chi2 V expected // n.s.

//Chi-Quadrat-Test (Andere SA - Vorstellen im Ausland zu arbeiten)
tab ausl_sa p1mobausl, chi2 V expected // p-value: 0.000, Cramér's V: 0.0819
//Chi-Quadrat-Test (Andere SA - Aus beruf. Gründen umziehen Gräuel)
tab ausl_sa p1mobgra, chi2 V expected // p-value: 0.000, Cramér's V: 0.0862
// --> Personen mit anderer SA eher bereit im Ausland zu arbeiten


*******************************************************************************************************
*******Frage 3 Abstract) Anerkennung von Leistungen/Erfolgen in- und außerhalb der Wissenschaft********
*****************(Publikationen, Internationale Mobilität, Erhobene Drittmittel)***********************
*******************************************************************************************************

tab promfach pub_peer_kat, chi2 V expected  //Naturwissenschaften meisten Veröffentlichungen
					//Sozialwissenschaften die wenigsten
tab promfach pub_peer_kat if c2jwiss==1, chi2 V expected												
												
tab promfach anzahltagungen if c1jwiss==1, chi2 V expected // Tagungsbesuche in den Ingenieur- und Sowi am höchsten
												
tab kinder1 pub_peer_kat, chi2 V expected //n.s.
tab sex pub_peer_kat if c1jwiss==1, chi2 V expected // Männer publizieren mehr als Frauen
tab sex pub_peer_kat if c2jwiss==1, chi2 V expected // n.s.

tab gebort pub_peer_kat if c2jwiss==2, chi2 V expected // n.s.
tab ausl_sa pub_peer_kat, chi2 V expected // n.s.
// -> Migrationshintergrund scheint keinen Effekt auf die Publikationshäufigkeit zu haben

tab d1mobilaus eink, chi2 V expected // n.s.
tab d1mobilaus befrist1, chi2 V expected // ohne Auslandserfahrung während Prom. häufiger unb. beschäftigt

**************************************************************************************
*************Frage 4) Gibt es disziplinspezifische Determinanten des******************
*******Karriereerfolgs? Und wenn ja, wie können diese theoretisch erklärt werden?*****
**************************************************************************************

tab promfach science_per1, chi2 V expected // n.s. während Promotionsphase
tab promfach science_per5, chi2 V expected // signifikant für Post-doc Phase
			// Ingenieurswissenschaftler*innen scheinen häufiger aus Wiss. auszusteigen
			

***********************************************************************************************
***********Frage 5) Fördern Kooperationen neue Ideen und Innovationen? Profitieren************* 
*********Wissenschaftler von der Zugehörigkeit zu interdisziplinären, internationalen********** 
**********************oder nicht-wissenschaftlichen beruflichen Netzwerken?********************
***********************************************************************************************
/*
--> Untere Modelle aufgrund von des Skalenniveaus besser für Regressionanalysen geeignet

// Berufliches Netzwerk 
tab berufnetz2 science_per1, chi2 V expected
tab berufnetz2 science_per5, chi2 V expected
// Berufliches Netzwerk -
tab berufnetz2 wiss_zuk, chi2 V expected
tab berufnetz2 wiss_zuk, chi2 V expected

// Interdisziplinarität - Zukunft in der Wissenschaft vorstellbar
tab prom_intkont wiss_zuk, chi2 V expected
tab prom_zwisaus wiss_zuk, chi2 V expected
tab prom_intprofor wiss_zuk, chi2 V expected
// Interdisziplinarität - Dauerhaft in Wiss. tätig gewesen
tab prom_intkont science_per1, chi2 V expected
tab prom_zwisaus science_per1, chi2 V expected
tab prom_intprofor science_per1, chi2 V expected
tab prom_intkont science_per5, chi2 V expected
tab prom_zwisaus science_per5, chi2 V expected
tab prom_intprofor science_per5, chi2 V expected
// Interdisziplinarität - Publikationen
tab prom_intkont pub_peer_kat, chi2 V expected
tab prom_zwisaus pub_peer_kat, chi2 V expected
tab prom_intprofor pub_peer_kat, chi2 V expected
// Interdisziplinarität - Einkommen
tab prom_intkont eink, chi2 V expected
tab prom_zwisaus eink, chi2 V expected
tab prom_intprofor eink, chi2 V expected
*/

***********************************************************************************
********Frage 6) Inwieweit sind die Aufgaben im außeruniversitären Bereich********* 
******mit den im Studium bzw. der Promotion erworbenen Fähigkeiten verbunden?******
***********************************************************************************

tab promfach prom_wich1, chi2 V expected // --> Promotion in den Naturwissenschaften sehr wichtig
tab branche1 eink, chi2 V expected // --> In der freien Wirtschaft wird am meisten verdient
							// ABER! Stichprobenbias. Zu wenige Uni-Professoren in Stichprobe

// Vorbereitung auf akad. Laufbahn durch Prom'phase 
tab prom_vorbakadem
//Haben Sie während Ihrer Promotionsphase fachnahe Berufspraxis außerhalb der akademischen Forschung
//gesammelt (z. B. in einem Betrieb, Selbständigkeit)?
tab prom_berufprax


*****************************************************************************************
*******************Weitere Ergebnisse mit Drittvariablenkontrolle************************
*****************************************************************************************

// Beispiel
by gebort, sort : tabulate sex p1mobausl if sa_vat==1, chi2 expected V

by kinder2, sort: tabulate sex pub_peer_kat, chi2 expected V 
//--> Kinder scheinen keinen Effekt auf Pub. zu haben
by kinder1, sort: tabulate sex pub_peer_kat, chi2 expected V

tabulate sex science_per1 if kinder1==0, chi2 expected V
tabulate sex science_per1 if kinder1==1, chi2 expected V   
by kinder1, sort: tab sex science_per1, chi2 expected V
// --> Frauen mit Kindern scheiden eher aus Wissenschaft (während Promphase) aus als Männer mit Kindern 
// und Frauen ohne Kinder

tabulate sex science_per5 if kinder1==0, chi2 expected V
tabulate sex science_per5 if kinder1==1, chi2 expected V // n.s. für Post-Doc-Phase


$Daten_Bearb
save "abstract_2.dta", replace





