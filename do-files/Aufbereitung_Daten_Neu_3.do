****************************************************************************
*****  Do-file Analysen Mobilität (Für Onsite-Recherche möglich)    ********
*****  Datum: 23.08.2021                                      		********
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
use "OS_Promo14_Aufbereitung_Neu_2",clear

describe, short

tab1 m2grad1zweck m2grad1dauer

count if m2grad1zweck==1 | m2grad1zweck==2
count if m2grad2zweck==1 | m2grad2zweck==2
count if m2grad3zweck==1 | m2grad3zweck==2

// Dauer und Art der Auslandsaufenthalte (1. Aufenthalt)
gen auslandsaufenthalt1=.
replace auslandsaufenthalt1=1 if m2grad1dauer<=1 & (m2grad1zweck==1 | m2grad1zweck==2)
replace auslandsaufenthalt1=2 if m2grad1dauer>=2 & m2grad1dauer<=3 & (m2grad1zweck==1 | m2grad1zweck==2)
replace auslandsaufenthalt1=3 if m2grad1dauer>=4 & m2grad1dauer<=6 & (m2grad1zweck==1 | m2grad1zweck==2)
replace auslandsaufenthalt1=4 if m2grad1dauer>=7 & (m2grad1zweck==1 | m2grad1zweck==2)
lab define auflb 1 "Weniger als 1 Monat" 2 "2-3 Monate" 3 "4-6 Monate" 4 "Mehr als 6 Monate"
lab value auslandsaufenthalt1 auflb
lab var auslandsaufenthalt1 "Auslandsaufenthalt im Ausland: Anzahl Monate"
tab auslandsaufenthalt1

// Dauer und Art der Auslandsaufenthalte (2. Aufenthalt)
gen auslandsaufenthalt2=.
replace auslandsaufenthalt2=1 if m2grad2dauer<=1 & (m2grad2zweck==1 | m2grad2zweck==2)
replace auslandsaufenthalt2=2 if m2grad2dauer>=2 & m2grad2dauer<=3 & (m2grad2zweck==1 | m2grad2zweck==2)
replace auslandsaufenthalt2=3 if m2grad2dauer>=4 & m2grad2dauer<=6 & (m2grad2zweck==1 | m2grad2zweck==2)
replace auslandsaufenthalt2=4 if m2grad2dauer>=7 & (m2grad2zweck==1 | m2grad2zweck==2)
lab value auslandsaufenthalt2 auflb
lab var auslandsaufenthalt2 "Auslandsaufenthalt im Ausland: Anzahl Monate"
tab auslandsaufenthalt2

// Dauer und Art der Auslandsaufenthalte (3. Aufenthalt)
gen auslandsaufenthalt3=.
replace auslandsaufenthalt3=1 if m2grad3dauer<=1 & (m2grad3zweck==1 | m2grad3zweck==2)
replace auslandsaufenthalt3=2 if m2grad3dauer>=2 & m2grad3dauer<=3 & (m2grad3zweck==1 | m2grad3zweck==2)
replace auslandsaufenthalt3=3 if m2grad3dauer>=4 & m2grad3dauer<=6 & (m2grad3zweck==1 | m2grad3zweck==2)
replace auslandsaufenthalt3=4 if m2grad3dauer>=7 & (m2grad3zweck==1 | m2grad3zweck==2)
lab value auslandsaufenthalt3 auflb
lab var auslandsaufenthalt3 "Auslandsaufenthalt im Ausland: Anzahl Monate"
tab auslandsaufenthalt3

// Personalkategorien
gen personalkat=. 
replace personalkat=1 if c2jwisspeka_g1==1
replace personalkat=2 if c2jwisspeka_g1>=2 & c2jwisspeka_g1<=4
replace personalkat=3 if c2jwisspeka_g1==6
replace personalkat=4 if c2jwisspeka_g1==7
label def personalkat_lb 1 "Wissenschaftlicher Mitarbeiter" 2 "Lehrbeauftragter/Privatdozent" ///
						 3 "Akademischer Oberrat" 4 "Professur/Juniorprofessur"
label values personalkat personalkat_lb
label var personalkat "Aktuelle Stelle: Personalkategorien"
tab personalkat, mi

// Personalkategorien Welle 3
gen personalkat3=. 
replace personalkat3=1 if c3jwisspeka_g1==1
replace personalkat3=2 if c3jwisspeka_g1>=2 & c3jwisspeka_g1<=4
replace personalkat3=3 if c3jwisspeka_g1==6
replace personalkat3=4 if c3jwisspeka_g1==7
label values personalkat3 personalkat_lb
label var personalkat3 "Aktuelle Stelle: Personalkategorien"
tab personalkat3, mi


// Index_variable3
	
	//Geburt-Hochschulzugangsberechtigung im gleichen Bundesland
	
	//Hochschulzugangsberechtigung - 1. Abschluss im gleichen Bundesland?
	preserve
		keep if k1studbplz_g3>=1 & k1studbplz_g3<=9 & b1hs1bl_g2>=1 & b1hs1bl_g2<=9
		gen mobib_3=. 
		replace mobib_3=0 if k1studbplz_g3==b1hs1bl_g2 
		replace mobib_3=1 if k1studbplz_g3!=b1hs1bl_g2 
			
		$Daten_Bearb
		save "mobib_3.dta", replace
	restore
		
	// 1. Abschluss - 2. Abschluss im gleichen Bundesland?  
	preserve
		keep if b1hs1bl_g2>=1 & b1hs1bl_g2<=9 & b1hs2bl_g2>=1 & b1hs2bl_g2<=9
		gen mobic_3=. 
		replace mobic_3=0 if b1hs1bl_g2==b1hs2bl_g2
		replace mobic_3=1 if b1hs1bl_g2!=b1hs2bl_g2
			
		$Daten_Bearb
		save "mobic_3.dta", replace
	restore
	
	// 1. Abschluss - Promotionshochschule im gleichen Bundesland?
	preserve
		keep if b1hs1bl_g2>=1 & b1hs1bl_g2<=9 & d1prohsbl_g2>=1 & d1prohsbl_g2<=9
		gen mobid_3=. 
		replace mobid_3=0 if b1hs1bl_g2==d1prohsbl_g2
		replace mobid_3=1 if b1hs1bl_g2!=d1prohsbl_g2
		
		$Daten_Bearb
		save "mobid_3.dta", replace
	restore
	
	// Promotionshochschule - erster Job im gleichen Bundesland
	preserve
		keep if d1prohsbl_g2>=1 & d1prohsbl_g2<=9 & c2taet1bula_g1>=1 & c2taet1bula_g1<=9
		gen mobie_3=. 
		replace mobie_3=0 if d1prohsbl_g2==c2taet1bula_g1
		replace mobie_3=1 if d1prohsbl_g2!=c2taet1bula_g1
		
		$Daten_Bearb
		save "mobie_3.dta", replace
	restore
	
	// erster Job im gleichen Bundesland - zweiter Job im gleichen Bundesland
	preserve
		keep if c2taet1bula_g1>=1 & c2taet1bula_g1<=9 & c2taet2bula_g1>=1 & c2taet2bula_g1<=9
		gen mobif_3=. 
		replace mobif_3=0 if c2taet1bula_g1==c2taet2bula_g1
		replace mobif_3=1 if c2taet1bula_g1!=c2taet2bula_g1
		
		$Daten_Bearb
		save "mobif_3.dta", replace
	restore
	
	// zweiter Job im gleichen Bundesland - dritter Job im gleichen Bundesland
	preserve
		keep if c2taet2bula_g1>=1 & c2taet2bula_g1<=9 & c2taet3bula_g1>=1 & c2taet3bula_g1<=9
		gen mobig_3=. 
		replace mobig_3=0 if c2taet2bula_g1==c2taet3bula_g1
		replace mobig_3=1 if c2taet2bula_g1!=c2taet3bula_g1
			
		$Daten_Bearb
		save "mobig_3.dta", replace
	restore
	
	// Dritter Job im gleichen Bundesland - Vierter Job im gleichen Bundesland
	preserve
		keep if c2taet3bula_g1>=1 & c2taet3bula_g1<=9 & c2taet4bula_g1>=1 & c2taet4bula_g1<=9
		gen mobih_3=. 
		replace mobih_3=0 if c2taet3bula_g1==c2taet4bula_g1
		replace mobih_3=1 if c2taet3bula_g1!=c2taet4bula_g1
			
		$Daten_Bearb
		save "mobih_3.dta", replace
	restore
	
	$Daten_Bearb
	save "OS_Promo14_Aufbereitung_Neu_2", replace
	
	//Verbinden der Datensätze
	clear
	
	$Daten_Bearb
	use "OS_Promo14_Aufbereitung_Neu_2", clear
						
			sort pid
			merge 1:1 pid using mobib_3.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobic_3.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobid_3.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobie_3.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobif_3.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobig_3.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobih_3.dta
			drop _merge

	save "bildungsmobil_3.dta", replace
	
	// Index erstellen
	gen index_3= (mobib_3==1) + (mobic_3==1) + (mobid_3==1) + (mobie_3==1) + (mobif_3==1) + (mobig_3==1) + (mobih_3==1)
	tab index_3
		
	$Daten_Bearb
	save "OS_Promo14_Aufbereitung_Neu_2", replace 
	
exit
	
// index_post = Index_postdoc-Phase mit c2taet1bula_g1

	// Promotionshochschule - erster Job im gleichen Bundesland
	preserve
		keep if d1prohsbl_g2>=1 & d1prohsbl_g2<=9 & c2taet1bula_g1>=1 & c2taet1bula_g1<=9
		gen mobil_post1=. 
		replace mobil_post1=0 if d1prohsbl_g2==c2taet1bula_g1
		replace mobil_post1=1 if d1prohsbl_g2!=c2taet1bula_g1
		
		$Daten_Bearb
		save "mobil_post1.dta", replace
	restore

	// erster Job im gleichen Bundesland - zweiter Job im gleichen Bundesland
	preserve
		keep if c2taet1bula_g1>=1 & c2taet1bula_g1<=9 & c2taet2bula_g1>=1 & c2taet2bula_g1<=9
		gen mobil_post2=. 
		replace mobil_post2=0 if c2taet1bula_g1==c2taet2bula_g1
		replace mobil_post2=1 if c2taet1bula_g1!=c2taet2bula_g1
		
		$Daten_Bearb
		save "mobil_post2.dta", replace
	restore
	
	// zweiter Job im gleichen Bundesland - dritter Job im gleichen Bundesland
	preserve
		keep if c2taet2bula_g1>=1 & c2taet2bula_g1<=9 & c2taet3bula_g1>=1 & c2taet3bula_g1<=9
		gen mobil_post3=. 
		replace mobil_post3=0 if c2taet2bula_g1==c2taet3bula_g1
		replace mobil_post3=1 if c2taet2bula_g1!=c2taet3bula_g1
			
		$Daten_Bearb
		save "mobil_post3.dta", replace
	restore
	
	// Dritter Job im gleichen Bundesland - Vierter Job im gleichen Bundesland
	preserve
		keep if c2taet3bula_g1>=1 & c2taet3bula_g1<=9 & c2taet4bula_g1>=1 & c2taet4bula_g1<=9
		gen mobil_post4=. 
		replace mobil_post4=0 if c2taet3bula_g1==c2taet4bula_g1
		replace mobil_post4=1 if c2taet3bula_g1!=c2taet4bula_g1
			
		$Daten_Bearb
		save "mobil_post4.dta", replace
	restore
	
	$Daten_Bearb
	save "OS_Promo14_Aufbereitung_Neu_2", replace
	
	//Verbinden der Datensätze
	clear
	
	$Daten_Bearb
	use "OS_Promo14_Aufbereitung_Neu_2", clear
			sort pid
			merge 1:1 pid using mobil_post1.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobil_post2.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobil_post3.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobil_post4.dta
			drop _merge
				
	save "bildungsmobil_post2.dta", replace
	
	// Index erstellen
	gen index_post2=(mobil_post1==1) + (mobil_post2==1) + (mobil_post3==1) + (mobil_post4==1)
	tab index_post2
		
	$Daten_Bearb
	save "OS_Promo14_Aufbereitung_Neu_2", replace 	

	exit
	
// index_post4 = Index_postdoc-Phase mit c4taet1bula_g1

	// Promotionshochschule - erster Job im gleichen Bundesland
	preserve
		keep if d1prohsbl_g2>=1 & d1prohsbl_g2<=9 & c4taet1bula_g1>=1 & c4taet1bula_g1<=9
		gen mobil_post4_1=. 
		replace mobil_post4_1=0 if d1prohsbl_g2==c4taet1bula_g1
		replace mobil_post4_1=1 if d1prohsbl_g2!=c4taet1bula_g1
		
		$Daten_Bearb
		save "mobil_post4_1.dta", replace
	restore

	// erster Job im gleichen Bundesland - zweiter Job im gleichen Bundesland
	preserve
		keep if c4taet1bula_g1>=1 & c4taet1bula_g1<=9 & c4taet2bula_g1>=1 & c4taet2bula_g1<=9
		gen mobil_post4_2=. 
		replace mobil_post4_2=0 if c4taet1bula_g1==c4taet2bula_g1
		replace mobil_post4_2=1 if c4taet1bula_g1!=c4taet2bula_g1
		
		$Daten_Bearb
		save "mobil_post4_2.dta", replace
	restore
	
	// zweiter Job im gleichen Bundesland - dritter Job im gleichen Bundesland
	preserve
		keep if c4taet2bula_g1>=1 & c4taet2bula_g1<=9 & c4taet3bula_g1>=1 & c4taet3bula_g1<=9
		gen mobil_post4_3=. 
		replace mobil_post4_3=0 if c4taet2bula_g1==c4taet3bula_g1
		replace mobil_post4_3=1 if c4taet2bula_g1!=c4taet3bula_g1
			
		$Daten_Bearb
		save "mobil_post4_3.dta", replace
	restore
	
	// Dritter Job im gleichen Bundesland - Vierter Job im gleichen Bundesland
	preserve
		keep if c4taet3bula_g1>=1 & c4taet3bula_g1<=9 & c4taet4bula_g1>=1 & c4taet4bula_g1<=9
		gen mobil_post4_4=. 
		replace mobil_post4_4=0 if c4taet3bula_g1==c4taet4bula_g1
		replace mobil_post4_4=1 if c4taet3bula_g1!=c4taet4bula_g1
			
		$Daten_Bearb
		save "mobil_post4_4.dta", replace
	restore
	
	$Daten_Bearb
	save "OS_Promo14_Aufbereitung_Neu_2", replace
	
	//Verbinden der Datensätze
	clear
	
	$Daten_Bearb
	use "OS_Promo14_Aufbereitung_Neu_2", clear
			sort pid
			merge 1:1 pid using mobil_post4_1.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobil_post4_2.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobil_post4_3.dta
			drop _merge
			
			sort pid
			merge 1:1 pid using mobil_post4_4.dta
			drop _merge
					
	save "bildungsmobil_post4.dta", replace
	
	// Index erstellen
	gen index_post4=(mobil_post4_1==1) + (mobil_post4_2==1) + (mobil_post4_3==1) + (mobil_post4_4==1)
	tab index_post4
		
	$Daten_Bearb
	save "OS_Promo14_Aufbereitung_Neu_2", replace 	
	
	use "OS_Promo14_Aufbereitung_Neu_2", clear
	
// Kohorte
gen kohorte=.
replace kohorte=1 if gebjahr==3
replace kohorte=2 if gebjahr==4
replace kohorte=3 if gebjahr==5
replace kohorte=4 if gebjahr==6
replace kohorte=5 if gebjahr==7
label define kohlb 1 "1970-1979" 2 "1980-1981" 3 "1982-1983" 4 "1984-1985" 5 "1986-1987"
label values kohorte kohlb
label variable kohorte "5 verschiedene Alters-Kohorten"
tab kohorte

// Kohorte
gen kohorte_alle=.
replace kohorte_alle=1 if gebjahr==2
replace kohorte_alle=2 if gebjahr==3
replace kohorte_alle=3 if gebjahr==4
replace kohorte_alle=4 if gebjahr==5
replace kohorte_alle=5 if gebjahr==6
replace kohorte_alle=6 if gebjahr==7
label define koh_lb 1 "1960-1969" 2 "1970-1979" 3 "1980-1981" 4 "1982-1983" 5 "1984-1985" 6 "1986-1987"
label values kohorte koh_lb
label variable kohorte_alle "6 verschiedene Alters-Kohorten"
tab kohorte_alle


//Variablen behalten
keep pid x1tag x1mon x1jahr x1fbart x1gewi x1datum x2teilnahme x2gewi x2mon x2jahr d2projend2 d2promabdat /// 
x2datum x3consent x3teilnahme x2geaus x3geaus x3mon x3jahr x3datum x3gewi c2jwiss c3jwiss c2jbrutto s1chakallf ///
gebjahr einkommen2 stdvollzeit2 stdteilzeit2 phdbeginn abgabediss science_per1 science_per5 d1finquell ///
berufstellng_1 anzahltagungen geplantedauerausland_1 ausland d1mobilaus d1mobild s1supwausl vorträge2 ///
umzug_bl_1 umzug_bl_2 umzug_bl3_1 umzug_bl3_2 job_mobil2 job_mobil_dummy2 job_mobil3 job_mobil_dummy3 ///
b1hs1bl_g2 b1hs1art_g2r b1hs2art_g2r c1jwisstaet c2jwiss c3jwiss d1wisskarr akadem_laufbahn kohorte_alle ///
d1prohsart_g3r d1profach1_r c1eberuf_g1o c1jberuf_g1o c2jberuf_g1o c3jberuf_g1o c4jberuf_g1o c5jberuf_g1o ///
k1gebortplz_g2r k1gebortplz_g1o c2jwisspeka_r c2jwisspeka_g1 c3jwisspeka_r k2studbplz_g1o kontakt_hs  ///
tät_forsch sa_mut sa_vat bild_eltern abschl_mut abschl_vat gebort deu_sa ausl_sa kinder1 kinder2 pub_peer ///
pub_o_peer pub_sammel pub_bücher pub_peer_kat anz_patanträge ausland_nachstudium konf_aus konf_deu promdauer ///
promfach prom_gemf prom_koop prom_intkont prom_zwisaus prom_intprofor berufnetz2 d1konvanz d1konpanz woman ///
w2konvanz w2konpanz prom_vorbakadem prom_berufprax wiss_zuk bedeut_wiss befrist1 befrist2 im_ausland2 ///
worklife2 partner1 partner2 p1mobort p1mobtaet p1mobausl p1mobarsu p1mobheim p1mobgeg p1mobgra p1mobbess ///
p1mobverl branche1 branche2 prom_wich1 prom_wich2 logeink1 logeink2 ausland2 bereit_auslmob bereit_deutmob ///
worklife_dummy prom_intkont_dummy c2zufle c2zufbed c2zufeink c3zufle c3zufbed c3zufeink c3zufeink personalkat ///
c2wwjupro c2wwnagr d1reputinst lehrdeputat habil2 c2taet1plz_g1r c2taet1plz_o postprom_mobil_dummy ///
index_post2 index_post4 index_3 SES_eltern kohorte promfach_neu auslandsaufenthalt1 auslandsaufenthalt2 ///
auslandsaufenthalt3 index_sozkapital1 index_sozkapital2 index_sozkapital3 personalkat3 ///
prom_mobil postprom_mobil 

describe, short

$Daten_Bearb
save "OS_Promo14_Aufbereitung_Neu_3.dta", replace

exit
