**** Panelanalysen für Onsite****

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
use "5_OS_Promo14_aufb_1c.dta"

*Vorbereitung für Längsschnittformat: Variablen umbenennen:

		rename k1geschl woman
		recode woman 2=1 1=0
		label def womanlb 0 "Männer" 1 "Frauen"
		label value woman womanlb
		label var woman "Geschlecht"
		tab woman
 
		//Aktuelle Stelle in der Wissenschaft
		 tab c1jwisstaet
		 rename c1jwisstaet job_science1
		 recode job_science1 2=0
		 label val job_science1 umzug_bl_lb
		 tab job_science1 
		 
		 tab c2jwiss  // Aktuelle Stelle./Und letzte Stelle bei denjenigen, 
		              // die momentan keine Erwerbstätigkeit haben, aber schon mal erwerbstätig waren
		 rename c2jwiss job_science2
		 recode job_science2 2=0
		 label val job_science2 umzug_bl_lb
		 tab job_science2
		 
		 tab c3jwiss
		 rename c3jwiss job_science3
		 recode job_science3 2=0
		 label val job_science3 umzug_bl_lb
		 tab job_science3
		 
		 tab c4jwiss
		 rename c4jwiss job_science4
		 recode job_science4 2=0
		 label val job_science4 umzug_bl_lb
		 tab job_science4
		 
		 tab c5jwiss
		 rename c5jwiss job_science5
		 recode job_science5 2=0
		 label val job_science5 umzug_bl_lb
		 tab job_science5
		 
		 //Vollzeit/Teilzeit
		 tab c1jstd //Stundenumfang aktuelle Stelle, Welle 1
		 gen teilzeit1=.
		 replace teilzeit1=0 if c1jstd>=39 & c1jstd<=99
		 replace teilzeit1=1 if c1jstd>=1 & c1jstd<=38
		 label var teilzeit1 "Teilzeitstelle (1 bis 38h pro Monat)"
		 label def tz_lb 0 "nein" 1 "ja"
		 label values teilzeit1 tz_lb
		 tab teilzeit1, mi
		 		 
		 gen vollzeit1=.
		 replace vollzeit1=0 if c1jstd>=1 & c1jstd<=38
		 replace vollzeit1=1 if c1jstd>=39 & c1jstd<=99
		 label var vollzeit1 "Vollzeitstelle (39 bis 99h pro Monat)"
		 label values vollzeit1 tz_lb
		 tab vollzeit1, mi
		 
		 *Vollzeit / Teilzeit aus Welle 2 aus den ersten drei Jobs definiert
		 tab c2jstd
		 gen teilzeit2=.
		 replace teilzeit2=0 if c2jstd>=39 & c2jstd<=99
		 replace teilzeit2=1 if c2jstd>=1 & c2jstd<=38
		 label var teilzeit2 "Teilzeitstelle (1 bis 38h pro Monat)"
		 label values teilzeit2 tz_lb
		 tab teilzeit2, mi
		 
		 gen vollzeit2=.
		 replace vollzeit2=0 if c2jstd>=1 & c2jstd<=38
		 replace vollzeit2=1 if c2jstd>=39 & c2jstd<=99
		 label var vollzeit2 "Vollzeitstelle (39 bis 99h pro Monat)"
		 label values vollzeit2 tz_lb
		 tab vollzeit2, mi
		 
		 *Vollzeit / Teilzeit aus Welle 3 aus den ersten drei Jobs definiert
		 tab c3jstd
		 gen teilzeit3=.
		 replace teilzeit3=0 if c3jstd>=39 & c3jstd<=99
		 replace teilzeit3=1 if c3jstd>=1 & c3jstd<=38
		 label var teilzeit3 "Teilzeitstelle (1 bis 38h pro Monat)"
		 label values teilzeit3 tz_lb
		 tab teilzeit3, mi
		 
		 gen vollzeit3=.
		 replace vollzeit3=0 if c3jstd>=1 & c3jstd<=38
		 replace vollzeit3=1 if c3jstd>=39 & c3jstd<=99
		 label var vollzeit3 "Vollzeitstelle (39 bis 99h pro Monat)"
		 label values vollzeit3 tz_lb
		 tab vollzeit3, mi
		 
		 *Vollzeit / Teilzeit aus Welle 4 aus den ersten drei Jobs definiert
		 tab c4jstd
		 gen teilzeit4=.
		 replace teilzeit4=0 if c4jstd>=39 & c4jstd<=99
		 replace teilzeit4=1 if c4jstd>=1 & c4jstd<=38
		 label var teilzeit4 "Teilzeitstelle (1 bis 38h pro Monat)"
		 label values teilzeit4 tz_lb
		 tab teilzeit4, mi
		 
		 gen vollzeit4=.
		 replace vollzeit4=0 if c4jstd>=1 & c4jstd<=38
		 replace vollzeit4=1 if c4jstd>=39 & c4jstd<=99
		 label var vollzeit4 "Vollzeitstelle (39 bis 99h pro Monat)"
		 label values vollzeit4 tz_lb
		 tab vollzeit4, mi
		 
		  *Vollzeit / Teilzeit aus Welle 5 aus den ersten drei Jobs definiert
		 tab c5jstd
		 gen teilzeit5=.
		 replace teilzeit5=0 if c5jstd>=39 & c5jstd<=99
		 replace teilzeit5=1 if c5jstd>=1 & c5jstd<=38
		 label var teilzeit5 "Teilzeitstelle (1 bis 38h pro Monat)"
		 label values teilzeit5 tz_lb
		 tab teilzeit5, mi
		 
		 gen vollzeit5=.
		 replace vollzeit5=0 if c5jstd>=1 & c5jstd<=38
		 replace vollzeit5=1 if c5jstd>=39 & c5jstd<=99
		 label var vollzeit5 "Vollzeitstelle (39 bis 99h pro Monat)"
		 label values vollzeit5 tz_lb
		 tab vollzeit5, mi
		 
		 tab1 vollzeit1 teilzeit1 vollzeit2 teilzeit2 vollzeit3 teilzeit3 vollzeit4 teilzeit4 ///
		 vollzeit5 teilzeit5

		//Einkommen (Welle 1 bis Welle 5)
		 rename c1jbrutto eink1
		 tab eink1
		 
		 rename c2jbrutto eink2
		 tab eink2
		 
		 rename c3jbrutto eink3
		 tab eink3
		 
		 rename c4jbrutto eink4
		 tab eink4
		 
		 rename c5jbrutto eink5
		 tab eink5
		 
		 //Partnerschaftsstatus (Welle 1 bis Welle 5)
		 tab k1partner
		 rename k1partner famstat1
		 recode famstat1 1=0 2=1 3=2
		 label define famstat_lb 0 "ledig" 1 "feste Partnerschaft" ///
		 2 "verheiratet / eingetr. Lebensgem."
		 label values famstat1 famstat_lb
		 tab famstat1
		 
		 tab k2partner
		 rename k2partner famstat2
		 recode famstat2 1=0 2=1 3=2
		 label values famstat2 famstat_lb
		 tab famstat2
		 
		 tab k3partner
		 rename k3partner famstat3
		 recode famstat3 1=0 2=1 3=2
		 label values famstat3 famstat_lb
		 tab famstat3
		 
		 tab k4partner
		 rename k4partner famstat4
		 recode famstat4 1=0 2=1 3=2
		 label values famstat4 famstat_lb
		 tab famstat4
		 
		 tab k5partner
		 rename k5partner famstat5
		 recode famstat5 1=0 2=1 3=2
		 label values famstat5 famstat_lb
		 tab famstat5
		 
		 //eigene Kinder (Welle 1 bis Welle 5)
		 tab k1kindzahl_g1
		 gen kinder1=.
		 replace kinder1=0 if k1kindzahl_g1==0
		 replace kinder1=1 if k1kindzahl_g1>=1 & k1kindzahl_g1<=4
		 label var kinder1 "Sind eigene Kinder vorhanden?"
		 label values kinder1 umzug_bl_lb
		 tab kinder1
		 
		 tab k2kindzahl_g1, mi
		 gen kinder2=.
		 replace kinder2=0 if k2kindzahl_g1==.g
		 replace kinder2=1 if k2kindzahl_g1>=1 & k2kindzahl_g1<=4
		 label var kinder2 "Sind eigene Kinder vorhanden?"
		 label values kinder2 umzug_bl_lb
		 tab kinder2
		 
		 tab k3kindzahl_g1, mi
		 gen kinder3=.
		 replace kinder3=0 if k3kindzahl_g1==.g
		 replace kinder3=1 if k3kindzahl_g1>=1 & k2kindzahl_g1<=4
		 label var kinder3 "Sind eigene Kinder vorhanden?"
		 label values kinder3 umzug_bl_lb
		 tab kinder3
		 
		 tab k4kindzahl_g1, mi
		 gen kinder4=.
		 replace kinder4=0 if k4kindzahl_g1==.g
		 replace kinder4=1 if k4kindzahl_g1>=1 & k4kindzahl_g1<=4
		 label var kinder4 "Sind eigene Kinder vorhanden?"
		 label values kinder4 umzug_bl_lb
		 tab kinder4	
		 
		 tab k5kindzahl_g1, mi
		 gen kinder5=.
		 replace kinder5=0 if k5kindzahl_g1==.g
		 replace kinder5=1 if k5kindzahl_g1>=1 & k5kindzahl_g1<=4
		 label var kinder5 "Sind eigene Kinder vorhanden?"
		 label values kinder5 umzug_bl_lb
		 tab kinder5
		 
		 //Welle
		 gen welle1 = x1datum==0 | x1datum==1
		 label define welle_le 1 "Teilnahme"
		 label values welle1 welle_le
		 label var welle1 "Erste Welle"
		 tab welle1
		 		 	 
		 gen welle2=.
		 replace welle2=1 if x2teilnahme==1 
		 label values welle2 welle_le
		 label var welle2 "Zweite Welle"
		 tab welle2
		 
		 gen welle3=.
		 replace welle3=1 if x3teilnahme==1 
		 label values welle3 welle_le
		 label var welle3 "Dritte Welle"
		 tab welle3
		 
		 gen welle4=.
		 replace welle4=1 if x4teilnahme==1 
		 label values welle4 welle_le
		 label var welle4 "Vierte Welle"
		 tab welle4
		 
		 gen welle5=.
		 replace welle5=1 if x5teilnahme==1 
		 label values welle5 welle_le
		 label var welle5 "Fünfte Welle"
		 tab welle5
		 

*************************************************************************************
********************** Neue Variablen (08.03.2021) **********************************	
*************************************************************************************
	 
		//Beabsichtigung zukünftig in Wissenschaft tätig zu sein (Welle 2-5)
		rename d1wisskarr wiss_zukunft1
		rename w2wisskarr wiss_zukunft2
		rename w3wisskarr wiss_zukunft3
		rename w4wisskarr wiss_zukunft4	
		rename w5wisskarr wiss_zukunft5
				 
		//Bisher besuchte Konferenzen in Deutschland insgesamt
		gen konf_de2=.
		replace konf_de2=0 if w2konfanzd==0 
		replace konf_de2=1 if w2konfanzd>=1 & w2konfanzd<=2
		replace konf_de2=2 if w2konfanzd>=3 & w2konfanzd<=5
		replace konf_de2=3 if w2konfanzd>=6 & w2konfanzd<=200
		label define konf_lb 0 "Keine" 1 "1-2 Konferenzen" 2 "3-5 Konferenzen" 3 "6 und mehr"
		label value konf_de2 konf_lb
		lab var konf_de2 "Anzahl Konferenzen: Deutschland (kategorisiert)"
		tab konf_de2
		
		gen konf_de3=.
		replace konf_de3=0 if w3konfanzd==0 
		replace konf_de3=1 if w3konfanzd>=1 & w3konfanzd<=2
		replace konf_de3=2 if w3konfanzd>=3 & w3konfanzd<=5
		replace konf_de3=3 if w3konfanzd>=6 & w3konfanzd<=200
		label value konf_de3 konf_lb
		lab var konf_de3 "Anzahl Konferenzen: Deutschland (kategorisiert)"
				
		gen konf_de4=.
		replace konf_de4=0 if w4konfanzd==0 
		replace konf_de4=1 if w4konfanzd>=1 & w4konfanzd<=2
		replace konf_de4=2 if w4konfanzd>=3 & w4konfanzd<=5
		replace konf_de4=3 if w4konfanzd>=6 & w4konfanzd<=200
		label value konf_de4 konf_lb
		lab var konf_de4 "Anzahl Konferenzen: Deutschland (kategorisiert)"
				
		gen konf_de5=.
		replace konf_de5=0 if w5konfanzd==0 
		replace konf_de5=1 if w5konfanzd>=1 & w5konfanzd<=2
		replace konf_de5=2 if w5konfanzd>=3 & w5konfanzd<=5
		replace konf_de5=3 if w5konfanzd>=6 & w5konfanzd<=200
		label value konf_de5 konf_lb
		lab var konf_de5 "Anzahl Konferenzen: Deutschland (kategorisiert)"
		tab konf_de5
		
		//Anzahl der Konferenzen im Ausland
		gen konf_aus2=.
		replace konf_aus2=0 if w2konfanza==0 
		replace konf_aus2=1 if w2konfanza==1
		replace konf_aus2=2 if w2konfanza>=2 & w2konfanza<=3
		replace konf_aus2=3 if w2konfanza>=4 & w2konfanza<=150
		label define konf_aus_lb 0 "Keine" 1 "1 Konferenz" 2 "2-3 Konferenzen" 3 "4 und mehr"
		label value konf_aus2 konf_aus_lb
		lab var konf_aus2 "Anzahl Konferenzen: Ausland (kategorisiert)"
				
		gen konf_aus3=.
		replace konf_aus3=0 if w3konfanza==0 
		replace konf_aus3=1 if w3konfanza==1
		replace konf_aus3=2 if w3konfanza>=2 & w3konfanza<=3
		replace konf_aus3=3 if w3konfanza>=4 & w3konfanza<=150
		label value konf_aus3 konf_aus_lb
		lab var konf_aus3 "Anzahl Konferenzen: Ausland (kategorisiert)"
			 
		gen konf_aus4=.
		replace konf_aus4=0 if w4konfanza==0 
		replace konf_aus4=1 if w4konfanza==1
		replace konf_aus4=2 if w4konfanza>=2 & w4konfanza<=3
		replace konf_aus4=3 if w4konfanza>=4 & w4konfanza<=150
		label value konf_aus4 konf_aus_lb
		lab var konf_aus4 "Anzahl Konferenzen: Ausland (kategorisiert)"
				
		gen konf_aus5=.
		replace konf_aus5=0 if w5konfanza==0 
		replace konf_aus5=1 if w5konfanza==1
		replace konf_aus5=2 if w5konfanza>=2 & w5konfanza<=3
		replace konf_aus5=3 if w5konfanza>=4 & w5konfanza<=150
		label value konf_aus5 konf_aus_lb
		lab var konf_aus5 "Anzahl Konferenzen: Ausland (kategorisiert)"

/*      //Anzahl Konferenzen kontinuierlich
		rename w2konfanzd konf_d2
		rename w3konfanzd konf_d3
		rename w4konfanzd konf_d4
		rename w5konfanzd konf_d5
		
		rename w2konfanza konf_a2
		rename w3konfanza konf_a3
		rename w4konfanza konf_a4
		rename w5konfanza konf_a5
*/
						
		//Berufliches Netzwerk innerhalb der Wissenschaft (Welle2 - Welle5)
		rename d2bnetzwiss berufnetz2
		rename d3bnetzwiss berufnetz3	
		rename d4bnetzwiss berufnetz4
		rename d5bnetzwiss berufnetz5

		//Beteiligung/Koordination an/von Forschngs- und Entwicklungsentscheidungen, 
		//Beteiligung an Forschungsrelevanten Entscheidungen (Soziale Mobilität)
		tab1 c1akentsch c1akkoor c1akkonz
		//Bildung additiver Index (Mittelwert)
		alpha c1akkoor c1akkonz c1akentsch 			// Scale reliability coefficient: 0.9134
		egen anz_miss1 = rowmiss(c1akkoor c1akkonz c1akentsch)
		egen entscheid1 = rowmean(c1akkoor c1akkonz c1akentsch) if anz_miss1<=1
		gen entscheidungen1 = entscheid1 	
		lab var entscheidungen1 "Beteiligung/Koordination and Forsch.-Entwicklungsentscheidungen"
		
		alpha c2akkoor c2akkonz c2akentsch         // Scale reliability coefficient:  0.9170
		egen anz_miss2 = rowmiss(c2akkoor c2akkonz c2akentsch)
		egen entscheid2 = rowmean(c2akkoor c2akkonz c2akentsch) if anz_miss2<=1
		gen entscheidungen2 = entscheid2 
		lab var entscheidungen2 "Beteiligung/Koordination and Forsch.-Entwicklungsentscheidungen"
		
		alpha c3akkoor c3akkonz c3akentsch         // Scale reliability coefficient:  0.9254
		egen anz_miss3 = rowmiss(c3akkoor c3akkonz c3akentsch)
		egen entscheid3 = rowmean(c3akkoor c3akkonz c3akentsch) if anz_miss3<=1
		gen entscheidungen3 = entscheid3 
		lab var entscheidungen3 "Beteiligung/Koordination and Forsch.-Entwicklungsentscheidungen"
		
		alpha c4akkoor c4akkonz c4akentsch         // Scale reliability coefficient:  0.9323
		egen anz_miss4 = rowmiss(c4akkoor c4akkonz c4akentsch)
		egen entscheid4 = rowmean(c4akkoor c4akkonz c4akentsch) if anz_miss4<=1
		gen entscheidungen4 = entscheid4
		lab var entscheidungen4 "Beteiligung/Koordination and Forsch.-Entwicklungsentscheidungen"
		
		alpha c5akkoor c5akkonz c5akentsch         // Scale reliability coefficient:  0.9294
		egen anz_miss5 = rowmiss(c5akkoor c5akkonz c5akentsch)
		egen entscheid5 = rowmean(c5akkoor c5akkonz c5akentsch) if anz_miss5<=1
		gen entscheidungen5 = entscheid5 
		lab var entscheidungen5 "Beteiligung/Koordination and Forsch.-Entwicklungsentscheidungen"
		
		drop anz_miss1 anz_miss2 anz_miss3 anz_miss4 anz_miss5 entscheid1 entscheid2 entscheid3 ///
		entscheid4 entscheid5

//Praktiken räumlicher Mobilität (Aktuell im Ausland) --> 0=Nein, 1=Ja
		rename m2gradgwart im_ausland2
		rename m3gradgwart im_ausland3
		rename m4gradgwart im_ausland4
		rename m5gradgwart im_ausland5
		
//Ausland nach Studiumabschluss
		rename m2gradverg ausl_nachstudium2
		rename m3gradverg ausl_nachstudium3
		rename m4gradverg ausl_nachstudium4
		rename m5gradverg ausl_nachstudium5
		
		
//Auslandsmobilität im Längsschnitt  // Absicht in Zukunft ins Ausland zu gehen
gen ausland_abs2=.
replace ausland_abs2=1 if m2plandaof==1 | m2plandamf==1 | m2planzeit==1 | m2planfor==1 | m2planwbi==1 
replace ausland_abs2=2 if m2planson==1
replace ausland_abs2=3 if m2plannein==1
label define ausland_lb 1 "ja, beruflich" 2 "ja, privat" 3 "nein"
label value ausland_abs2 ausland_lb
lab var ausland_abs2 "Auslandmobilität"
tab ausland_abs2

gen ausland_abs3=.
replace ausland_abs3=1 if m3plandaof==1 | m3plandamf==1 | m3planzeit==1 | m3planfor==1 | m3planwbi==1 
replace ausland_abs3=2 if m3planson==1
replace ausland_abs3=3 if m3plannein==1
label value ausland_abs3 ausland_lb
lab var ausland_abs3 "Auslandmobilität"

gen ausland_abs4=.
replace ausland_abs4=1 if m4plandaof==1 | m4plandamf==1 | m4planzeit==1 | m4planfor==1 | m4planwbi==1 
replace ausland_abs4=2 if m4planson==1
replace ausland_abs4=3 if m4plannein==1
label value ausland_abs4 ausland_lb
lab var ausland_abs4 "Auslandmobilität"

gen ausland_abs5=.
replace ausland_abs5=1 if m5plandaof==1 | m5plandamf==1 | m5planzeit==1 | m5planfor==1 | m5planwbi==1 
replace ausland_abs5=2 if m5planson==1
replace ausland_abs5=3 if m5plannein==1
label value ausland_abs5 ausland_lb
lab var ausland_abs5 "Auslandmobilität"

// Dummy: Auslandsmobilität: Absicht in Zukunft ins Ausland zu gehen
gen dummy_ausl2=.
replace dummy_ausl2=1 if m2plandaof==1 | m2plandamf==1 | m2planzeit==1 | m2planfor==1 | m2planwbi==1 
replace dummy_ausl2=0 if m2plannein==1
label define aus_lb 0 "Nein" 1 "Ja, beruflich"
label value dummy_ausl2 aus_lb
lab var dummy_ausl2 "Auslandmobilität"
tab dummy_ausl2

gen dummy_ausl3=.
replace dummy_ausl3=1 if m3plandaof==1 | m3plandamf==1 | m3planzeit==1 | m3planfor==1 | m3planwbi==1 
replace dummy_ausl3=0 if m3plannein==1
label value dummy_ausl3 aus_lb
lab var dummy_ausl3 "Auslandmobilität"
tab dummy_ausl3

gen dummy_ausl4=.
replace dummy_ausl4=1 if m4plandaof==1 | m4plandamf==1 | m4planzeit==1 | m4planfor==1 | m4planwbi==1 
replace dummy_ausl4=0 if m4plannein==1
label value dummy_ausl4 aus_lb
lab var dummy_ausl4 "Auslandmobilität"
tab dummy_ausl4

gen dummy_ausl5=.
replace dummy_ausl5=1 if m5plandaof==1 | m5plandamf==1 | m5planzeit==1 | m5planfor==1 | m5planwbi==1 
replace dummy_ausl5=0 if m5plannein==1
label value dummy_ausl4 aus_lb
lab var dummy_ausl5 "Auslandmobilität"
tab dummy_ausl5

//Arbeitsverhältnis: Unbefristet=1; Befristet=2 --> recode: Berfristet=2 --> 0
//Aktuelle Stelle: Art des Arbeitsverhältnisses

		 rename c1jarve art_job1
		 recode art_job1 2=0
		 label define art_joblb 0 "Befristet" 1 "Unbefristet"
		 label val art_job1 art_joblb
		 lab var art_job1 "Arbeitsverhältnis"
		 tab art_job1

		 rename c2jarve art_job2
		 recode art_job2 2=0
		 label val art_job2 art_joblb
		 lab var art_job2 "Arbeitsverhältnis"
		 tab art_job2
		 
		 rename c3jarve art_job3
		 recode art_job3 2=0
		 label val art_job3 art_joblb
		 lab var art_job3 "Arbeitsverhältnis"
		 tab art_job3
		 
		 rename c4jarve art_job4
		 recode art_job4 2=0
		 label val art_job4 art_joblb
		 lab var art_job4 "Arbeitsverhältnis"
		 tab art_job4
		 
		 rename c5jarve art_job5
		 recode art_job5 2=0
		 label val art_job5 art_joblb
		 lab var art_job5 "Arbeitsverhältnis"
		 tab art_job5

****************************************************************************************
**************** Subjektive Einschätzung/Einstellungen der/zur Karriere ****************
****************************************************************************************
/*
p1lzanfo, p2lzanfoinwi, p5lzanfo //Ein gutes Verhältnis zwischen den Stellenanforderungen und den eigenen Fähigkeiten erreichen
p1lzsich, p2lzsichinwi, p5lzsich //Einen sicheren Arbeitsplatz haben
p1lzfami, p2lzfamiinwi, p5lzfami //Beruf und Familie miteinander vereinbaren
*/

//8.9 Würden Sie sagen, dass Sie entsprechend Ihrer Qualifikation (d.h der im Prüfungsjahr 2013/14 abgeschlossenen Promotion) 
//beschäftigt waren bzw. sind? (Aktuelle Stelle) (5 Wellen)
/*
//Hinsichtlich des Niveaus der Arbeitsaufgaben 
c1jqualniv
//Hinsichtlich der fachlichen Qualifikation (Promotionsfach) 
c1jqualqua
//Hinsichtlich der fachlichen Schwerpunktsetzung (Promotionsthema)
c1jqualthem
*/

//Hinsichtlich der beruflichen Position 
	rename c1jqualpos jobfit1
	rename c2jqualpos jobfit2
	rename c3jqualpos jobfit3
	rename c4jqualpos jobfit4
	rename c5jqualpos jobfit5
	
/* 
//8.13 Wie zufrieden sind Sie mit den folgenden Aspekten Ihrer aktuellen Beschäftigung? (5 Wellen) 
//Fort- und WB-Möglichkeiten 
c1zufbil
//Tätigkeitsinhalte 
c1zufinh
//Berufliche Position 
c1zufpos
//Aufstiegsmöglichkeiten 
c1zufauf
//Arbeitsplatzsicherheit 
c1zufsich
//Ausstattung mit Arbeitsmitteln 
c1zufmit
//Möglichkeit, eigene Ideen einzubringen 
c1zufidee
//Arbeitsklima 
c1zufklim
*/  
//Verdienst/Einkommen
	rename c1zufeink zuf_inc1
	rename c2zufeink zuf_inc2
	rename c3zufeink zuf_inc3
	rename c4zufeink zuf_inc4
	rename c5zufeink zuf_inc5

//Arbeitsbedingungen 
	rename c1zufbed zuf_arbed1
	rename c2zufbed zuf_arbed2
	rename c3zufbed zuf_arbed3
	rename c4zufbed zuf_arbed4
	rename c5zufbed zuf_arbed5
		
//Raum für Privatleben 
	rename c1zufleb zuf_privat1
	rename c2zufleb zuf_privat2
	rename c3zufleb zuf_privat3
	rename c4zufleb zuf_privat4
	rename c5zufleb zuf_privat5
	
//Qualifikationsangemessenheit 
	rename c1zufqua zuf_quali1
	rename c2zufqua zuf_quali2
	rename c3zufqua zuf_quali3
	rename c4zufqua zuf_quali4
	rename c5zufqua zuf_quali5
	
//Familienfreundlichkeit 
	rename c1zuffam zuf_fam1
	rename c2zuffam zuf_fam2
	rename c3zuffam zuf_fam3
	rename c4zuffam zuf_fam4
	rename c5zuffam zuf_fam5

//Weitere Karrierebestrebungen? (Karriereeinstellungen Subjektiv)
//4.2 [Ab Welle 2] Haben Sie nach Abschluss Ihrer Promotion eine der folgenden wissenschaftlichen 
//Weiterqualifizierungen geplant bzw. bereits begonnen? (Welle 2 – Welle 5)

/* //Weitere Promotion 
c2wwprom
*/

//Habilitation 
	rename c2wwhabil habil2
	rename c3wwhabil habil3
	rename c4wwhabil habil4
	rename c5wwhabil habil5
//Juniorprofessur 
    rename c2wwjupro jupro2
	rename c3wwjupro jupro3
	rename c4wwjupro jupro4
	rename c5wwjupro jupro5
//Nachwuchsgruppenleitung
	rename c2wwnagr nagr2
	rename c3wwnagr nagr3
	rename c4wwnagr nagr4
	rename c5wwnagr nagr5
//Forschungs- und Postdocstipendium 
	rename c2wwstip stip2
	rename c3wwstip stip3
	rename c4wwstip stip4
	rename c5wwstip stip5
//Nein 
	rename c2wwnein keinekarr2
	rename c3wwnein keinekarr3
	rename c4wwnein keinekarr4
	rename c5wwnein keinekarr5

/*//5.15 Professur (Welle 2 – Welle 5)
Streben Sie eine Professur an 
w2prof 
*/

// Personalkategorie
gen phase2=.
replace phase2=0 if c2jwisspeka_g1==1
replace phase2=1 if c2jwisspeka_g1==7
label define phase2_lb 0 "Post-Doc-Phase" 1 "Jun-Professur/Professur"
label val phase2 phase2_lb
lab var phase2 "Unterscheidung von Karrierephasen"
tab phase2

gen phase3=.
replace phase3=0 if c3jwisspeka_g1==1
replace phase3=1 if c3jwisspeka_g1==7
label val phase3 phase2_lb
lab var phase3 "Unterscheidung von Karrierephasen"
tab phase3

gen phase4=.
replace phase4=0 if c4jwisspeka_g1==1
replace phase4=1 if c4jwisspeka_g1==7
label val phase4 phase2_lb
lab var phase4 "Unterscheidung von Karrierephasen"
tab phase4

gen phase5=.
replace phase5=0 if c5jwisspeka_g1==1
replace phase5=1 if c5jwisspeka_g1==7
label val phase5 phase2_lb
lab var phase5 "Unterscheidung von Karrierephasen"
tab phase5

// SES Eltern
gen hilfsvariable1= ((k1berabvat>=1) & (k1berabvat<=3)) & ((k1berabmut>=4) & (k1berabmut<=9)) // HS-Abschluss: Vater ja/ Mutter nein
gen hilfsvariable2= ((k1berabvat>=4) & (k1berabvat<=9)) & ((k1berabmut>=1) & (k1berabmut<=3)) // HS-Abschluss: Mutter ja/Vater nein

gen SES_eltern=.
replace SES_eltern = 1 if ((k1berabvat>=4) & (k1berabvat<=9)) & ((k1berabmut>=4) & (k1berabmut<=9))
replace SES_eltern = 2 if hilfsvariable1 | hilfsvariable2
replace SES_eltern = 3 if ((k1berabvat>=1) & (k1berabvat<=3)) & ((k1berabmut>=1) & (k1berabmut<=3))
label define SESlb 1 "Geringer SES" 2 "Mittlerer SES" 3 "Hoher SES"
label values SES_eltern SESlb
label variable SES_eltern "Sozioökonomischer Status der Eltern"
tab SES_eltern

gen promfach_neu=.
replace promfach_neu=0 if d1profagr1_g1==3
replace promfach_neu=1 if d1profagr1_g1==4
replace promfach_neu=2 if d1profagr1_g1==5
replace promfach_neu=3 if d1profagr1_g1==8
label define promneulb 0 "Sozialwissenschaften" 1 "Mathe/Naturwissenschaften" 2 "Medizin" 3 "Ingenieurwissenschaften"
label values promfach_neu promneulb
label var promfach_neu "Promotionsfach: Disziplinspezifische Fächer"
tab promfach_neu

// Personalkategorie (Dichotom für logit-Regression)
gen personalkat_2=.
replace personalkat_2=0 if personalkat==1
replace personalkat_2=1 if personalkat==4
label define pers_lb 0 "Wissenschaftlicher Mitarbeiter" 1 "Prof./Juniorprof."
label values personalkat_2 persl_lb
label var personalkat_2 "Personalkategorie: Wimi und Prof/Juniorprof"

// Personalkategorie_W3 (Dichotom für logit-Regression)
gen personalkat_3=.
replace personalkat_3=0 if personalkat3==1
replace personalkat_3=1 if personalkat3==4
label values personalkat_3 persl_lb
label var personalkat_3 "Personalkategorie: Wimi und Prof/Juniorprof"

// Personalkategorie_W4 (Dichotom für logit-Regression)
gen personalkat_4=.
replace personalkat_4=0 if personalkat4==1
replace personalkat_4=1 if personalkat4==4
label values personalkat_4 persl_lb
label var personalkat_4 "Personalkategorie: Wimi und Prof/Juniorprof"

************************************************************************************************************
************************************************************************************************************
************************************************************************************************************
//Behalten relevanter Variablen 
keep pid sex welle1 welle2 welle3 welle4 welle5 job_science1 job_science2 job_science3 ausl_nachstudium2 ///
job_science4 job_science5 teilzeit1 teilzeit2 teilzeit3 teilzeit4 teilzeit5 vollzeit1 ausl_nachstudium3 ///
vollzeit2 vollzeit3 vollzeit4 vollzeit5 eink1 eink2 eink3 eink4 eink5 famstat1 famstat2 famstat3 promfach_neu ///
famstat4 famstat5 kinder1 kinder2 kinder3 kinder4 kinder5 konf_de2 konf_de3 konf_de4 konf_de5 SES_eltern ///
konf_aus2 konf_aus3 konf_aus4 konf_aus5 berufnetz2 berufnetz3 berufnetz4 berufnetz5 ausl_nachstudium4 ///
wiss_zukunft1 wiss_zukunft2 wiss_zukunft3 wiss_zukunft4 wiss_zukunft5 art_job1 art_job2 art_job3 art_job4 art_job5 ///
im_ausland2 im_ausland3 im_ausland4 im_ausland5 ausland_abs2 ausland_abs3 ausland_abs4 ausland_abs5 ///
keinekarr2 keinekarr3 keinekarr4 keinekarr5 stip2 stip3 stip4 stip5 nagr2 nagr3 nagr4 nagr5 jupro2 woman ///
jupro3 jupro4 jupro5 habil2 habil3 habil4 habil5 zuf_fam1 zuf_fam2 zuf_fam3 zuf_fam4 zuf_fam5 ausl_nachstudium5 ///
zuf_quali1 zuf_quali2 zuf_quali3 zuf_quali4 zuf_quali5 zuf_privat1 zuf_privat2 zuf_privat3 zuf_privat4 ///
zuf_privat5 zuf_arbed1 zuf_arbed2 zuf_arbed3 zuf_arbed4 zuf_arbed5 zuf_inc1 zuf_inc2 zuf_inc3 zuf_inc4 ///
zuf_inc5 jobfit1 jobfit2 jobfit3 jobfit4 jobfit5 entscheidungen1 entscheidungen2 entscheidungen3 entscheidungen4 ///
entscheidungen5 phase2 phase3 phase4 phase5 dummy_ausl2 dummy_ausl3 dummy_ausl4 dummy_ausl5 

//Für Fixed Effects Analyse
	//NUR DIE BEHALTEN; DIE IN WELLE 1 EINE WISSENSCHAFTLICHE TÄTIGKEIT AUSÜBTEN
	keep if job_science1==1 
	sort pid
	
	by pid: generate seq = _n // Sequenzzähler
	by pid: generate tot = _N // Zähler für Summe der Sequenzen
	
// Anzahl wellen
	egen anz_wellen = anycount(welle1 - welle5), values(1)	
	gen f_waves = anz_wellen+1  // Exakte Häufigkeit der Teilnahme inklusive Welle 1
	drop anz_wellen
	describe, short
	
// Keep all persons participated at least 2 times in the survey
	by pid (f_waves), sort: keep if f_waves >=2
	drop f_waves
	describe, short
	
	//Ins Längsschnittformat wechseln
	reshape long job_science eink famstat teilzeit vollzeit kinder berufnetz art_job im_ausland entscheidungen ///
	konf_aus konf_de wiss_zukunft ausland_abs keinekarr stip nagr jupro habil zuf_fam zuf_privat zuf_quali ///
	zuf_arbed zuf_inc jobfit phase dummy_ausl ausl_nachstudium, i(pid) j(welle)	

//reshape wide
//reshape long

$Daten_Bearb
save "6_OS_Promo14_long.dta", replace

$Daten_Bearb
use "6_OS_Promo14_long.dta", clear

	// Einstellung für Fixed Effects Analyse
	xtset pid welle
	xtdescribe
	
	
*****************************************************************************************************************
************ Führen Veränderungen der Karrieremotivation/Einstellungen im Laufe der Postdoc-Phase ***************
******************* zu einer Veränderung der Einstellungen zu räumlicher Mobilität? *****************************
*****************************************************************************************************************
// (VAR: (AV) dummy_ausl = Absicht in Zukunft ins Ausland zu gehen)
// (XA = Karrieremotivation --> Y1 = Einstellung zu RM) 

	// Mit Kontrollvariablen (Modell 1)
	xtlogit dummy_ausl wiss_zukunft, re  
		$Tabellen
		outreg2 using myfile_panel_1, word dec(3) replace ctitle(Model 1)
		
	// Mit Kontrollvariablen (Modell 2)
	xtlogit dummy_ausl wiss_zukunft kinder i.famstat i.welle, re
		$Tabellen
		outreg2 using myfile_panel_1, word dec(3) replace ctitle(Model 2)
	
	// Mit Kontrollvariablen (Modell 3)
	xtlogit dummy_ausl wiss_zukunft kinder i.famstat berufnetz eink i.welle, re
		$Tabellen
		outreg2 using myfile_panel_1, word dec(3) replace ctitle(Model 3)
		
	
		
	// Habilitation angestrebt
	xtlogit dummy_ausl habil berufnetz kinder i.famstat job_science i.welle, re
		$Tabellen
		outreg2 using panel_regression_results_2, replace excel dec(3)

*****************************************************************************************************************
************ Führen Veränderungen der Karrieremotivation/Einstellungen im Laufe der Postdoc-Phase ***************
******************* zu einer Veränderung der der Praktiken räumlicher Mobilität? ********************************
*****************************************************************************************************************
// (VAR: (AV) konf_de, konf_aus = Wie viele wissenschaft. Konf., Tagungen/Kongresse haben Sie bisher insgesamt besucht?
// (XA = Karrieremotivation --> Y2 = Praktiken von RM)

// Ordinal-logistische Regressionsanalyse (AV = Konferenzen besucht in Deutschland insgesamt)
	xtoprobit konf_de wiss_zukunft berufnetz kinder i.famstat job_science i.welle, vce(robust)
		$Tabellen
		outreg2 using panel_regression_results_2, replace excel dec(3)
// Ordinal-logistische Regressionsanalyse (AV = Konferenzen besucht im Ausland insgesamt)	
	xtoprobit konf_aus wiss_zukunft berufnetz kinder i.famstat job_science i.welle, vce(robust)
		$Tabellen
		outreg2 using panel_regression_results_2, replace excel dec(3)
// Ordinal-logistische Regressionsanalyse (AV = Konferenzen besucht im Ausland insgesamt) mit INTERAKTIONSEFFEKT!!!
	xtoprobit konf_aus wiss_zukunft berufnetz kinder i.famstat job_science##zuf_fam i.welle, vce(robust)
		$Tabellen
		outreg2 using panel_regression_results_2, replace excel dec(3)
//  Binär-logistische Regressionsanalyse	
	xtlogit ausl_nachstudium wiss_zukunft berufnetz kinder i.famstat job_science habil i.welle, fe
		$Tabellen
		outreg2 using panel_regression_results_2, replace excel dec(3)
	
	xtlogit habil job_science im_ausland kinder i.famstat wiss_zukunft berufnetz i.welle, re
	estimates store random
	
	xtlogit habil job_science im_ausland kinder i.famstat wiss_zukunft berufnetz i.welle, fe
	estimates store fixed
	
	hausman fixed random
	
	estimate store fe

	
// Ausscheiden aus der Wissenschaft

	xtlogit job_science kinder ib0.famstat im_ausland ausland_abs eink i.welle, fe
	
********** TEST ************

//Grafiken 

graph dot (mean) eink if welle==3, title("Durchschnittseinkommen") ///
caption("Mittelwertvergleich für Welle_2") over(sex, sort((mean) eink))	

graph dot (mean) zuf_fam if welle==2, title("Durschnittliche Zufriedenheit der Familiensituation") ///
caption("Mittelwertvergleich für Welle_2") over(sex, sort((mean) zuf_fam))

separate eink, by(sex)
rename eink1 Eink_Männer
rename eink2 Eink_Frauen

graph dot (mean) Eink_Männer Eink_Frauen, over(famstat, sort((mean) Eink_Männer))
graph dot (mean) Eink_Männer Eink_Frauen, title("Kinder") over(kinder, sort((mean) Eink_Männer)) 




