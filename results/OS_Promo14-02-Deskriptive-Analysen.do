****Deskriptive Analysen****

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


numlabel, add


********************************************************************************
********     Filter Zielgruppe      ***********************************************
********************************************************************************

// Eventuell eingrenzen: wo hat man promoviert: nur Universität und außeruniversitäre Einrichtung behalten?
tab d1instkont
// Fach eingrenzen?
tab d1profagr1_g1
tab d1profagr2_g1  // ggf. zweites Fach


********************************************************************************
********     Angaben zur Person       ******************************************
********************************************************************************

// Geburtskohorte (Jahrgang)
tab k1gebjahr_g2
*tab gebjahr

// Geburtsort
tab k1gebort         //Deutschland/Ausland
tab k1gebortplz_g3   //Deutschland: Bundesland
tab k1gebortla_g1    //Ausland: Land

// Geschlecht
tab k1geschl
*tab sex


// Nur in Welle 2 und 3 abgefragt 
// Deutsche Staatsangehörigkeit
tab k2natdegeb 
tab k3natdegeb
// Ausländische Staatsangehörigkeit
tab k2natausl  
tab k3natausl

// Partnerschaft (Welle 1-5)	
tab1 k1partner k2partner k3partner k4partner k5partner

// Branche (Welle 1-5)
tab1 c1jbranche c2jbranche c3jbranche c4jbranche c5jbranche		//  Branche 
tab einkommen 			//  Einkommen (gebildete Variable -> Do-File 1b)


********************************************************************************
********     Einstellungen  Karriere/Lebensziele     ***************************
********************************************************************************

tab1 p1mfachnei-p1mvertrau // Motive für die Promotion
tab1 p1lzinno-p1lzkind     // (Lebens-)Ziele
tab d1wisskarr             // Absicht: Verbleib in der Wissenschaft

//Welle 2 - Karriere   (Beide Variablen auch in Welle 3-5)
tab1 w2wisskarr w3wisskarr w4wisskarr w5wisskarr  //  Absicht, Verbleib in der Wissenschaft
$Tabellen 
tabout w2wisskarr w3wisskarr w4wisskarr w5wisskarr using univariat1.csv, replace sum oneway ///
dpcomma style(semi) cells(N w2wisskarr mean) format (2)

tab1 w2prof w3prof w4prof w5prof	//  Professur angestrebt
$Tabellen 
		tabout w2prof w3prof w4prof w5prof using univariat2.csv, replace sum oneway ///
		dpcomma style(semi) cells(N w2prof mean) format (2)
		
//Welle 2 - Zufriedenheit
tab1 c2zufinh-c2zuffam	


********************************************************************************
********     Einstellungen  Räumliche Mobilität     ****************************
********************************************************************************

tab p1mobort  // Viele Orte zum Leben vorstellbar
tab p1mobtaet // Tätigkeit im Ausland käme nicht in Betracht
tab p1mobausl // Arbeit im Ausland vorstellbar
tab p1mobarsu // Arbeitssuche auch anderswo in D
tab p1mobheim // Heimat verlassen würde schwerfallen
tab p1mobgeg // Ungern in andere Gegend ziehen
tab p1mobgra // Umziehen ist ein Gräuel
tab p1mobbess // Würde an anderen Ort ziehen
tab p1mobverl // Hoffe, an untersch. Orten zu arbeiten

//Absicht, in Zukunft ins Ausland zu gehen (Gründe) 
tab m2plandaof	//  dauerhafte Erwerbstätigkeit im Ausland ohne Forschung
tab m2plandamf	//  dauerhafte Erwerbstätigkeit im Ausland mit Forschung
tab m2planzeit	//  zeitweilige Erwerbstätigkeit im Ausland ohne Forschung
tab m2planfor	//  zeitweilige Erwerbstätigkeit im Ausland ohne Forschung
tab m2planwbi	//  Weiterbildungsaufenthalt im Ausland
tab m2planson   //  andere/private Gründe
tab m2plannein	//  nein

tab1 m3plandaof m3plandamf m3planzeit m3planfor m3planwbi m3planson m3plannein
tab1 m4plandaof m4plandamf m4planzeit m4planfor m4planwbi m4planson m4plannein
tab1 m5plandaof m5plandamf m5planzeit m5planfor m5planwbi m5planson m5plannein


********************************************************************************
********     Räumliche Mobilität: Standorte      *******************************
********************************************************************************

//Welle 1
tab d1prohsbl_g2    // Promotion: Bundesland (Hochschule)
tab k1studbort      // Studienberechtigung: Deutschland oder Ausland
tab k1studbplz_g3   // Studienberechtigung: Bundesland
tab k1studbla_g1    // Studienberechtigung: Ausland (Land)
tab b1hs1bl_g2      // 1. akademischer Abschluss: Bundesland

//Ab Welle 2
//Auslandsaufenthalt (mind. 1 Monat) seit Studienabschluss
tab1 m2gradverg m3gradverg m4gradverg m5gradverg //im Ausland gewesen
tab1 m2gradgwart m3gradgwart m4gradgwart m5gradgwart //aktuell im Ausland
tab1 m2gradnein m3gradnein m4gradnein m5gradnein //nein

//Welle 2
//Auslandsaufenthalt vor dem Studium
tab k2studbort     //Studienberechtigung: Deutschland oder Ausland
tab k2studbplz_g3  //Studienberechtigung: Bundesland (aggregiert)
tab k2studbla_g1   //Studienberechtigung: Ausland (Land)

//Auslandsaufenthalt (mind. 1 Monat) seit Studienabschluss
tab m2grad1land_g1  //1. Aufenthalt: Land
tab m2grad2land_g1  //2. Aufenthalt: Land
tab m2grad3land_g1  	//3. Aufenthalt: Land
tab m2grad4land_g1  //4. Aufenthalt: Land
tab m2grad5land_g1  //5. Aufenthalt: Land
tab m2grad6land_g1  	//6. Aufenthalt: Land

tab1 m3grad1land_g1 m3grad2land_g1 m3grad3land_g1 m3grad4land_g1 m3grad5land_g1 m3grad6land_g1
tab1 m4grad1land_g1 m4grad2land_g1 m4grad3land_g1 m4grad4land_g1 m4grad5land_g1 m4grad6land_g1
tab1 m5grad1land_g1 m5grad2land_g1 m5grad3land_g1 m5grad4land_g1 m5grad5land_g1 m5grad6land_g1

//	Berufliche Tätigkeit nach Abschluss der Promotion (1. bis 10. Tätigkeit)
tab c2taet1bula_g1	//  Arbeitsort
tab c2taet1land_g1	//  Arbeitsort

tab1 c3taet1bula_g1 c3taet1land_g1
tab1 c4taet1bula_g1 c4taet1land_g1
tab1 c5taet1bula_g1 c5taet1land_g1

//Welle 1
// Forschungsaufenthalte (mind. 1 Monat) während der Promotion
tab d1mobild   // Deutschland
tab d1mobilaus // Ausland
tab d1mobilnein // nein


********************************************************************************
********  Räumliche Mobilität: Forschungs- und Auslandsaufenthalte   ***********
********************************************************************************

//Welle 2
//Auslandsaufenthalt vor dem Studium: Art
tab m2schuljahr  // Auslandsschuljahr/Au-pair
tab m2schulaust  // Schüleraustausch
tab m2schulprak  // Praktikum
tab m2schulkurs  // Sprachkurs
 
 //WELLE 2
//Auslandsaufenthalt während des Studiums: Art
tab m2studkompl  //komplettes Studium
tab m2studsem    //Auslandssemester/Teilstudium
tab m2studprak   //Praktikum
tab m2studkurs  //Sprachkurs
tab m2studson   //sonstiger studienbezogener Aufenthalt

//WELLE 2
//Auslandsaufenthalt (mind. 1 Monat) seit Studienabschluss: Zweck
tab m2grad1zweck		//1. Aufenthalt: Zweck
tab m2grad2zweck		//2. Aufenthalt: Zweck
tab m2grad3zweck		//3. Aufenthalt: Zweck
tab m2grad4zweck		//4. Aufenthalt: Zweck
tab m2grad5zweck		//5. Aufenthalt: Zweck
tab m2grad6zweck		//6. Aufenthalt: Zweck

tab1 m3grad1zweck m3grad2zweck m3grad3zweck m3grad4zweck m3grad5zweck m3grad6zweck
tab1 m4grad1zweck m4grad2zweck m4grad3zweck m4grad4zweck m4grad5zweck m4grad6zweck
tab1 m5grad1zweck m5grad2zweck m5grad3zweck m5grad4zweck m5grad5zweck m5grad6zweck


********************************************************************************
********     Soziale Mobilität      ******************************************
********************************************************************************

tab d1reputinst   // Einschätzung Reputation der Institution

//Welle 2
//Erwerbstätigkeit während des Studiums 
tab c3studhit     // SHK/Tutor
tab c2studnein    // nicht erwerbstätig

//Welle 1
// Erwerbstätigkeit während der Promotion
tab c1taet1best // Berufliche Stellung (Tätigkeit 1)
tab c1taet2best // Berufliche Stellung (Tätigkeit 2)
tab c1taet3best // Berufliche Stellung (Tätigkeit 3)
tab c1taet4best // Berufliche Stellung (Tätigkeit 4)
tab c1taet5best // Berufliche Stellung (Tätigkeit 5)
tab c1taet6best // Berufliche Stellung (Tätigkeit 6)
tab c1taet7best // Berufliche Stellung (Tätigkeit 7)
tab c1taet8best // Berufliche Stellung (Tätigkeit 8)
tab c1taet9best // Berufliche Stellung (Tätigkeit 9)
tab c1taet10best // Berufliche Stellung (Tätigkeit 10)

//Welle 1
// Erwerbstätigkeit nach der Promotion
tab c1nperwerb   // Erwerbstätigkeit nach der Promotion
tab c1eberuf_g2  // Berufsbezeichnung (KldB 2010) 1. Stelle nach Promotion
tab c1jberuf_g2  // Berufsbezeichnung (KldB 2010) aktuelle Stelle nach Promotion

//Welle 2
//Abschluss Promotion
tab c2nperwerb       //Erwerbstätigkeit nach der Promotion

//Pläne nach Promotion
tab1 c2wwpromm-c2wwnein     //Wiss. Weiterqual. nach Promotion geplant/begonnen (Habil etc.)
tab c2wwprombn				//Weitere Promotion begonnen
tab c2wwhabilbn				//Habilitation begonnen
tab c2wwjuprobn				//Juniorprofessur begonnen
tab c2wwnagrbn				//Nachwuchsgruppenleitung begonnen
tab c2wwstipbn				//Stipendium begonnen

//Werdegang seit Abschluss der Promotion (Kalender -> Episodendatensatz)
//	Jahr 2013, 2014, 2015, 2016

//	Berufliche Tätigkeit nach Abschluss der Promotion (1. bis 10. Tätigkeit)
tab c2taet1best		//  Berufliche Stellung
tab c2taet1arve		//  Befristet/Unbefristet
tab stdvollzeit     //  Vollzeit: Vertraglich vereinbarte Arbeitszeit
tab stdteilzeit 	//  Teilzeit: Vertraglich vereinbarte Arbeitszeit
tab c2taet1wiss		//  Wissenschaftliche Tätigkeit
tab c2taet1betr	 	//  Arbeitgeber


//Wissenschaftliche Tätigkeit
//Welle 2
tab1 c2akkonz-c2akwiver // Inwieweit mit wiss. Tätigkeiten involviert? 
tab c2jwiss		//  Letzte/Aktuelle Stelle Tätigkeit in der Wissenschaft ja/nein

tab c2jwisspeka_g1		//  Personalkategorie
tab c2joeffdi			//  Öffentlicher Dienst


********************************************************************************
********        Zeitliche Angaben     ******************************************
********************************************************************************

// Formaler Beginn Promotion
tab d1promanf	// Monat 
tab d1projanf	// Jahr
tab  phdbeginn  // Jahr kategorisiert ( -> Do-File 1b)

// Abgabe der Dissertation
tab d1mdissab	// Monat 
tab d1jdissab	// Jahr
tab  abgabediss  // Jahr kategorisiert ( -> Do-File 1b)


// Abschließende Promotionsprüfung
tab d1promend	// Monat 
tab d1projend	// Jahr

// Unterbrechung Promotion
tab d1unterbro	// ja/nein 
tab d1unterbroj	// Jahr
//tab d1unterbrom	// Monat

// Forschungsaufenthalte (mind. 1 Monat) während der Promotion
tab d1mobildm	// Deutschland - Gesamtdauer in Monaten
tab d1mobilausm	// Ausland - Gesamtdauer in Monaten

//*********Welle 2
//tab d2mdissver		//Monat: Veröffentlichung der Dissertation
tab d2jdissver 		//Jahr: Veröffentlichung der Dissertation
//tab d2murkunde		//Monat: Erhalt der Promotionsurkunde
tab  d2jurkunde		//Jahr: Erhalt der Promotionsurkunde

//Welle 2 Weiterbildung
//Auslandsaufenthalt (mind. 1 Monat) seit Studienabschluss
//********* 1. Auslandsaufenthalt
tab m2grad1dauer		//1. Aufenthalt: geplante Dauer
//tab m2grad1mo		//1. Aufenthalt: Beginn (Monat)
tab m2grad1ja		//1. Aufenthalt: Beginn (Jahr)
//********* 2. Auslandsaufenthalt
tab m2grad2dauer	//2. Aufenthalt: geplante Dauer
//tab m2grad2mo		//2. Aufenthalt: Beginn (Monat)
tab m2grad2ja	        //2. Aufenthalt: Beginn (Jahr)
//********* 3. Auslandsaufenthalt
tab m2grad3zweck		//3. Aufenthalt: Zweck
//tab m2grad3mo		//3. Aufenthalt: Beginn (Monat)
tab m2grad3ja		//3. Aufenthalt: Beginn (Jahr)
//********* 4. Auslandsaufenthalt
tab m2grad4dauer	//4. Aufenthalt: geplante Dauer
//tab m2grad4mo		//4. Aufenthalt: Beginn (Monat)
tab m2grad4ja		//4. Aufenthalt: Beginn (Jahr)
//********* 5. Auslandsaufenthalt
tab m2grad5dauer	//5. Aufenthalt: geplante Dauer
//tab m2grad5mo		//5. Aufenthalt: Beginn (Monat)
tab m2grad5ja 		//5. Aufenthalt: Beginn (Jahr)
//********* 6. Auslandsaufenthalt
tab m2grad6dauer 	//6. Aufenthalt: geplante Dauer
//tab m2grad6mo 	//6. Aufenthalt: Beginn (Monat)
tab m2grad6ja 		//6. Aufenthalt: Beginn (Jahr)

//******* Pläne nach Promotion
//tab1 c2wwprombn	//Monat: Beginn weitere Promotion
tab1 c2wwpromjb 	//Jahr: Beginn weitere Promotion
//tab1 c2wwpromme 	//Monat: Ende weitere Promotion
tab1 c2wwpromje 	//Jahr: Ende weitere Promotion
//tab1 c2wwhabilmb	//Monat: Beginn Habilitation
tab1 c2wwhabiljb	//Jahr: Beginn Habilitation
//tab1 c2wwhabilme	//Monat: Ende Habilitation
tab1  c2wwhabilje	//Jahr: Ende Habilitation
//tab1 c2wwjupromb 	//Monat: Beginn Juniorprofessur
tab1 c2wwjuprojb	//Jahr: Beginn Juniorprofessur
//tab1 c2wwjuprome	//Monat: Ende Juniorprofessur
tab1 c2wwjuproje	//Jahr: Ende Juniorprofessur

//******* Aktuelle Situation (nach Promotion)
//tab c2jbegm 		//  Monat: Antritt aktuelle/letzte Stelle
tab c2jbegj		//  Jahr: Antritt aktuelle/letzte Stelle
//tab c2jendm  		//  Monat: Beendigung letzte Stelle
tab c2jendj		//  Jahr: Beendigung letzte Stelle

//******* Berufliche Tätigkeit nach Abschluss der Promotion (1. bis 10. Tätigkeit)
//tab1 c2taet1manf	//  Zeitraum (Monat): von
tab1 c2taet1janf	//  Zeitraum (Jahr): von
//tab1 c2taet1mend      //  Zeitraum (Monat): bis
tab1 c2taet1jend 	//  Zeitraum (Jahr): bis
tab1 c2taet1lnoc	//  läuft noch


********************************************************************************
********     Räumliche Mobilität: Forschung/Netzwerk      **********************
********************************************************************************

tab s1oriikont      // Internationale Kontakte knüpfen
tab s1oriizaus      // Zusammenarbeit mit Wissenschaftlern aus dem Ausland
tab s1oriiproj      // Forschen in internationalen Projketzusammenhängen

tab d1konf      // Besuch von Tagungen
tab anzahltagungen      // Anzahl der besuchten Tagungen  (Original: d1konfanz)

// Netzwerk
tab d1nwunt   // Großes Unterstützungsnetzwerk
tab d1nwbez   // Zeit Beziehungen
tab d1nwein   // Beziehungen einflussreiche Wissenschaftler
// Kooperationen
tab c1koaust  // Austausch
tab c1kogepub // Publikationen
tab c1kovort  // Vorträge
tab c1kokont  // Kontakte

//Welle 2/3
//Netzwerk
tab1 d2bnetzwiss-d2bnetzaus //Berufliches Netzwerk (inner-/außerhalb der Wissenschaft)
tab d3bnetzwiss-d3bnetzaus

//Welle 2
//Postdoc (zwischen Abschluss der Promotion und heute)
//Wissenschaftliches Arbeiten (trifft zu/trifft nicht zu) aktuell + Vergangenheit
tab1 w2pubp-w2pubb 		//  Publikationen
tab w2konf			// 	Konferenzen
tab w2foan 			// 	Drittmittelanträge
tab w2gut 			// 	Gutachtertätigkeiten
tab w2asv			// 	Akademische Selbstverwaltung











