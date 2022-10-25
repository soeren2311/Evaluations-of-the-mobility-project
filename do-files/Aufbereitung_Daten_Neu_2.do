****************************************************************************
*****  Do-file Analysen Mobilität (Für Onsite-Recherche möglich)    ********
*****  Datum: 23.08.2021                                      		********
****************************************************************************
***** Aufbereitung Variablen Teil 2                            		********
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
use "OS_Promo14_Aufbereitung_Neu_1.dta", clear

*******************************************************************************************
******************Frage 1 Abstract) Motive für eine Promotion******************************
*******************************************************************************************

// Den Konakt zur Hochschule aufrechterhalten
rename p1mkontahs kontakt_hs
// Eine akademische Laufbahn einschlagen
rename p1makademi akadem_laufbahn
// Tätigkeit in Forschung ausüben
rename p1mforsch tät_forsch

*******************************************************************************************
****Frage 2 Abstract) Effekte sozialer Herkunft, Geschlecht, Migrationshintergrund etc.****
*******************************************************************************************

// Bildungsgrad Vater
gen sa_vat=.
replace sa_vat=5 if k1bilvat==1
replace sa_vat=4 if k1bilvat>=2 & k1bilvat<=4
replace sa_vat=3 if k1bilvat==5
replace sa_vat=2 if k1bilvat==6 
replace sa_vat=1 if k1bilvat==7
label define sa_vatlb 5 "Abitur" 4 "Fachhochschulreife" 3 "Mittlere Reife" 2 "Hauptschule" 1 "Kein Abschluss" 
label value sa_vat sa_vatlb
label variable sa_vat "Schulabschluss Vater"
tab sa_vat

//Bildungsgrad Mutter
gen sa_mut=.
replace sa_mut=5 if k1bilmut==1
replace sa_mut=4 if k1bilmut>=2 & k1bilmut<=4
replace sa_mut=3 if k1bilmut==5
replace sa_mut=2 if k1bilmut==6 
replace sa_mut=1 if k1bilmut==7
label value sa_mut sa_vatlb
label variable sa_mut "Schulabschluss Mutter"
tab sa_mut

//Index Bildungsgrad Eltern
	alpha sa_mut sa_vat 			// Scale reliability coefficient: 0.8374694
		egen anz_miss = rowmiss(sa_mut sa_vat)
		egen b_eltern = rowmean(sa_mut sa_vat) if anz_miss<1
		gen bild_eltern = b_eltern 	
		lab var bild_eltern "Bildungsabschluss Eltern"

// Beruflicher Abschluss Vater
gen abschl_vat=.
replace abschl_vat=3 if k1berabvat>=1 & k1berabvat<=3
replace abschl_vat=2 if k1berabvat>=5 & k1berabvat<=7
replace abschl_vat=1 if k1berabvat==8
label define ab_vatlb 3 "Promotion/Uni" 2 "Tech.-Meister/Beruf. Ausbildung" 1 "Kein Abschluss" 
label values abschl_vat ab_vatlb
label variable abschl_vat "Abschluss Vater"
tab abschl_vat
// Beruflicher Abschluss Mutter
gen abschl_mut=.
replace abschl_mut=3 if k1berabmut>=1 & k1berabmut<=3
replace abschl_mut=2 if k1berabmut>=5 & k1berabmut<=7
replace abschl_mut=1 if k1berabmut==8
label values abschl_mut ab_vatlb
label variable abschl_mut "Abschluss Mutter"
tab abschl_mut

// SES Eltern (1=Beide Eltern haben keinen HS-Abschluss, 2= 1 Elternteil hat HS-Abschluss, 3=Beide Eltern haben HS-Abschluss)

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

//Geburtsort
rename k1gebort gebort
recode gebort 1=0 2=1
label define gebortlb 0 "Deutschland" 1 "In einem anderen Land"
label val gebort gebortlb
lab var gebort "Geburtsort"
tab gebort

// Deutsche Staatsangehörigkeit
tab k2natdegeb 
rename k2natdegeb deu_sa
// Ausländische Staatsangehörigkeit
tab k2natausl  
rename k2natausl ausl_sa

// Kinder (welle1)
gen kinder1=.
replace kinder1=0 if k1kindzahl_g1==0
replace kinder1=1 if k1kindzahl_g1>=1 & k1kindzahl_g1<=4
label var kinder1 "Sind eigene Kinder vorhanden?"
label values kinder1 umzug_bl_lb
tab kinder1
		
// Kinder (Welle2)
tab k2kindzahl_g1, mi
gen kinder2=.
replace kinder2=0 if k2kindzahl_g1==.g
replace kinder2=1 if k2kindzahl_g1>=1 & k2kindzahl_g1<=4
label var kinder2 "Sind eigene Kinder vorhanden?"
label values kinder2 umzug_bl_lb
tab kinder2
 		
// Frage 3 Abstract) Anerkennung von Leistungen/Erfolgen in- und außerhalb der Wissenschaft
// (Publikationen, Internationale Mobilität, Erhobene Drittmittel)

//Publikationen  (Welle2)
//Wie viele wissenschaftliche Publikationen haben Sie in den jeweiligen Formaten veröffentlicht?
//Aufsätze in Fachzeitschriften mit Peer-Review-Verfahren
gen pub_peer = w2pubpanz if !mi(w2pubpanz)
replace pub_peer=. if pub_peer>=100
lab var pub_peer "Aufsätze veröffentlicht mit Peer-Review-Verfahren"
//Aufsätze in Fachzeitschriften ohne Peer-Review-Verfahren
gen pub_o_peer = w2puboanz if !mi(w2puboanz)
replace pub_o_peer=. if pub_peer>=100
lab var pub_o_peer "Aufsätze veröffentlicht ohne Peer-Review-Verfahren"
//Aufsätze in Sammelbänden
gen pub_sammel = w2pubsanz if !mi(w2pubsanz)
replace pub_sammel=. if pub_peer>=100
lab var pub_sammel "Aufsätze veröffentlicht in Sammelbänden"
//Publikationen Bücher
gen pub_bücher = w2pubbanz if !mi(w2pubbanz)
replace pub_bücher=. if pub_peer>=100
lab var pub_bücher "Aufsätze veröffentlicht in Sammelbänden"  

//pub-peer (kategorisiert)
gen pub_peer_kat=.
replace pub_peer_kat=1 if pub_peer>=1 & pub_peer<=2
replace pub_peer_kat=2 if pub_peer>=3 & pub_peer<=5
replace pub_peer_kat=3 if pub_peer>=6 & pub_peer<=89
label define publb 1 "1-2" 2 "3-5" 3 "6 und mehr"
label value pub_peer_kat publb
label var pub_peer_kat "Anzahl Publikationen mit peer-Review Ver. (kategorisiert)"
tab pub_peer_kat
 
//Patente (welle2)
//Auf wie vielen Anträgen für Patente/Gebrauchsmuster/Marken/eingetragene Designs werden Sie namentlich als
//Erfinder(in) genannt?
gen anz_patanträge = w2patanz if !mi(w2patanz)
replace anz_patanträge=. if pub_peer>=100
lab var anz_patanträge "Aufsätze veröffentlicht in Sammelbänden"

//Auslandsmobilität
// Absicht in Zukunft ins Ausland zu gehen
tab ausland
// Geplante Dauer Ausland
tab geplantedauerausland_1
// Ausland nach Studium
tab m2gradverg, mi
rename m2gradverg ausland_nachstudium
// Konferenzen/Tagungen im Ausland
gen konf_aus = w2konfanza if !mi(w2konfanza)
replace konf_aus=. if w2konfanza>=100
lab var konf_aus "Tagungen/Konferenzen im Ausland besucht"
tab konf_aus
// Konferenzen/Tagungen in Deutschland
gen konf_deu = w2konfanzd if !mi(w2konfanzd)
replace konf_deu=. if w2konfanzd>=100
lab var konf_deu "Tagungen/Konferenzen in Deutschland besucht"
tab konf_deu

// Frage 4 Abstract) Gibt es Disziplinspezifische Determinanten für den Karriereerfolg?
//Promotionsfach
gen promfach=.
replace promfach=1 if d1profagr1_g1==3
replace promfach=2 if d1profagr1_g1==4
replace promfach=3 if d1profagr1_g1==8
label define promfachlb 1 "Rechts-Wirtschafts-Sozialwiss." 2 "Mathematik/Naturwiss." ///
						3 "Ingenieurwissenschaften"
label value promfach promfachlb
label variable promfach "Promotionsfach: Disziplinspezifische Ausrichtung"
tab promfach d1profagr1_g1
tab promfach

// Frage 5 abstract) Does cooperation foster new ideas and innovations? Do scientists benefit from being part of interdisciplinary, international, or non-scientific professional networks?

//Während meiner Promotionsphase wurde ich dazu angehalten, gemeinsam mit anderen Wissenschaftler(inne)n zu forschen.
rename s1chakgemf prom_gemf
//Arbeiten zwischen mir und anderen Wissenschaftler(inne)n explizit gefördert.
rename s1chakkoop prom_koop

//Unabhängig davon, in welchem Maße Sie selbst während Ihrer Promotionsphase in internationalen
//Zusammenhängen gearbeitet haben: Wie sehr wurde in Ihrem wissenschaftlichen Umfeld Wert darauf gelegt, ...

//Internationale Kontakte zu knüpfen
rename s1oriikont prom_intkont
//mit Wissenschaftler(inne)n aus dem Ausland zusammenzuarbeiten?
rename s1oriizaus prom_zwisaus
//in internationalen Projektzusammenhängen zu forschen?
rename s1oriiproj prom_intprofor

//Berufliches Netzwerk
rename d2bnetzwiss berufnetz2

tab d1konvanz // Vorträge gehalten im Rahmen der Promotion
tab d1konpanz // Poster vorgestellt im Rahmen der Promotion

// Haben Sie eigene Beiträge auf diesen Veranstaltungen geleistet? (Anzahl)
tab w2konvanz  // Ja, ich habe Vorträge gehalten und zwar
tab w2konpanz // Ja, ich habe Poster vorgestellt, und zwar Anzahl


//Frage 6 abstract) To what degree are tasks in jobs outside academia related to the skills 
//acquired during the studies  and/or the doctorate? 
rename s1orifakal prom_vorbakadem //Vorbereitung akadem_laufbahn
//Berufspraxis
rename d1bpraxis prom_berufprax
recode prom_berufprax 2=0
lab define berufpraxlb 1 "Ja" 0 "Nein"
lab val prom_berufprax berufpraxlb
lab var prom_berufprax "Berufspraxis während Promotion gesammelt"
tab prom_berufprax

//Variablen - Soziale Mobilität
//Beabsichtigen Sie, in Zukunft in der Wissenschaft tätig zu sein?
rename w2wisskarr wiss_zuk
//Bedeutung einer Karriere in der Wissenschaftl
rename p1lzwiss bedeut_wiss
tab science_per1
tab science_per5

rename c1jarve befrist1
recode befrist1 2=0
lab define befristlb 0 "Befristet" 1 "Unbefristet"
lab val befrist1 befristlb
lab var befrist1 "Befristungsvertrag"
tab befrist1

rename c2jarve befrist2
recode befrist2 2=0
lab val befrist2 befristlb
lab var befrist2 "Befristungsvertrag"
tab befrist2


//Praktiken räumlicher Mobilität (Aktuell im Ausland) --> 0=Nein, 1=Ja
rename m2gradgwart im_ausland2
// Bedeutung Work-Life-Balance
rename p2lzfamiinwi worklife2
//Habilitation 
rename c2wwhabil habil2

//Partnerschaft w1
gen partner1=. 
replace partner1=0 if k1partner==1
replace partner1=1 if k1partner==2
replace partner1=2 if k1partner==3
label define partnerlb 0 "Nein" 1 "Feste Partnerschaft" 2 "Verheiratet/Eing. Lebenspartnerschaft"
label values partner1 partnerlb
label var partner1 "Partnerschaftsstatus"
tab partner1

//Partnerschaft
gen partner2=. 
replace partner2=0 if k2partner==1
replace partner2=1 if k2partner==2
replace partner2=2 if k2partner==3
label values partner2 partnerlb
label var partner2 "Partnerschaftsstatus"
tab partner2

//Erläuterungen
/*umzug_bl_1 // Bundeslandwechsel zwischen 1. und 2. Job
umzug_bl_2 // Bundeslandwechsel zwischen 2. und 3. Job
ausland // Absicht in Zukunft ins Ausland zu gehen (Welle2)
geplantedauerausland_1 // Geplante Dauer aktueller Auslandsaufenthalt (Welle2)
*/

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

//Logarithmiertes Einkommen zur Basis 2
//Jede Erhöhung von logeink um eine Einheit entspricht einer Verdoppelung des Einkommens
gen logeink1 = log(c1jbrutto)/log(2)
lab var logeink1 "Logarithmiertes Einkommen zur Basis 2"

gen logeink2 = log(c2jbrutto)/log(2)
lab var logeink2 "Logarithmiertes Einkommen zur Basis 2"

//Absicht in zukunft aus beruf. Gründen ins Ausland zu gehen dichotomisiert
gen ausland2=.
replace ausland2=1 if ausland==1
replace ausland2=0 if ausland==3
label define auslb 0 "Nein" 1 "Ja"
lab value ausland2 auslb
lab var ausland2 "Absicht in Zukunft ins Ausland zu gehen"
tab ausland2

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
lab var bereit_deutmob "Arbeit anderswo in Deutschland vorstellbar"
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

// Motilität während Promotionsphase (motility_ökonomisch)
gen motility_ökonomisch=.
replace motility_ökonomisch=0 if d1finquell>=3 & d1finquell<=5
replace motility_ökonomisch=1 if d1finquell>=1 & d1finquell<=2
replace motility_ökonomisch=2 if d1finquell==7
lab def motökolb 0 "Wimi-Stelle/Anderer AG" 1 "Stipendium" 2 "Unterstützung durch Partner/Familie"
lab val motility_ökonomisch motökolb
lab var motility_ökonomisch "Monetäre Ressourcen während Promotionsphase"
tab motility_ökonomisch

// Promotionsdauer
by pid, sort: gen promdauer = d1projend - d1projanf if !mi(d1projend, d1projanf) 

// Geschlecht recodieren (An Konvention anpassen)
 tab k1geschl
 rename k1geschl woman
 recode woman 2=1 1=0
 label def womanlb 0 "Männer" 1 "Frauen"
 label value woman womanlb
 label var woman "Geschlecht"
 tab woman
		 
//Forschungsfrage: Verändern sich im Laufe wissenschaftlicher Karrieren (Prä-Doc, Post-Doc)
//Praktiken zu räumlicher Mobilität?
gen postprom_mobil_dummy=.
replace postprom_mobil_dummy=1 if postprom_mobil>=1 & postprom_mobil<=2
replace postprom_mobil_dummy=0 if postprom_mobil==0
lab define postlb 0 "Nicht mobil" 1 "1-2 Mal mobil" 
lab value postprom_mobil_dummy postlb
lab var postprom_mobil_dummy "Postdoc-Phase: Räumliche Mobilität"
tab postprom_mobil_dummy

// Lehrauftrag
tab w2lehre
rename w2lehre lehrdeputat
recode lehrdeputat 2=0
label def lehrdeplb 0 "Nein" 1 "Ja"
label val lehrdeputat lehrdeplb
tab lehrdeputat

********************************************************************************************************************
*********************** Index = Soziales Kapital während Promotionsphase (Abgefragt in Welle 1) ********************
********************************************************************************************************************

//Korrelation
pwcorr s1supmmoti s1supeemon s1supemutm s1supfinha s1supfmeth s1supfwiss s1supakont s1suparelp s1supanetz, star(.01)
//Faktorenanalyse 
factor s1supmmoti s1supeemon s1supemutm s1supfinha s1supfmeth s1supfwiss s1supakont s1suparelp s1supanetz
//Kaisers-Meyer-Olkin-Kriterium (Zeigt Ausmaß der Zusammengehörigkeit der Variablen) > 0,8 daher sehr gut
estat kmo
scree
// Varimax-Rotation (Varianz wird maximal auf einzelne Faktoren verteilt)
rotate, blanks(.4)
rotate
// Oblique-Rotation (Theoretische Annahme: Korrelation auch zwischen Faktoren)
rotate, oblique oblimin blanks(.3)
rotate, oblique oblimin 
alpha s1supmmoti s1supeemon s1supemutm s1supfinha s1supfmeth s1supfwiss s1supakont s1suparelp s1supanetz

//Faktorladungsplot 
loadingplot, xlab(0(.2)1) ylab(0(.2)1) aspect(1) yline(0) xline(0) 

// Gewichteter additiver Index für "emotionale Unterstützung" (Mut etc.)
gen index_sozkapital1 = (0.66*s1supmmoti) + (0.91*s1supeemon) + (0.9*s1supemutm) 

// Gewichteter additiver Index für "Fachliche Unterstützung"
gen index_sozkapital2 = (0.86*s1supfinha) + (0.82*s1supfmeth) + (0.82*s1supfwiss)

// Gewichteter additiver Index für "Ermutigung Kontakte zu Forschern knüpfen" etc.
gen index_sozkapital3 = (0.87*s1supakont) + (0.85*s1suparelp) + (0.86*s1supanetz)

***************************************************************************************************
***************************************************************************************************
***************************************************************************************************

tab d1profagr1_g1
gen promfach_neu=.
replace promfach_neu=0 if d1profagr1_g1==3
replace promfach_neu=1 if d1profagr1_g1==4
replace promfach_neu=2 if d1profagr1_g1==5
replace promfach_neu=3 if d1profagr1_g1==8
label define promneulb 0 "Sozialwissenschaften" 1 "Mathe/Naturwissenschaften" 2 "Medizin" 3 "Ingenieurwissenschaften"
label values promfach_neu promneulb
label var promfach_neu "Promotionsfach: Disziplinspezifische Fächer"
tab promfach_neu


//Variablen behalten
keep pid x1tag x1mon x1jahr x1fbart x1gewi x1datum x2teilnahme x2gewi x2mon x2jahr d2projend2 x2geaus x3geaus /// 
x2datum x3consent x3teilnahme x3mon x3jahr x3datum x3gewi x4consent x4teilnahme x4mon x4jahr x4datum ///
x4gewi x5consent x5teilnahme x5mon x5jahr x5datum x5gewi c2jwiss c3jwiss c2jbrutto c3jbrutto s1chakallf ///
sex gebjahr einkommen2 stdvollzeit2 stdteilzeit2 phdbeginn abgabediss science_per1 science_per5 d1finquell ///
berufstellng_1 anzahltagungen geplantedauerausland_1 ausland d1mobilaus d1mobild s1supwausl akadem_laufbahn ///
umzug_bl_1 umzug_bl_2 umzug_bl3_1 umzug_bl3_2 job_mobil2 job_mobil_dummy2 job_mobil3 job_mobil_dummy3 ///
pidIndex b1hs1bl_g2 b1hs1art_g2r b1hs2art_g2r c1jwisstaet c2jwiss c3jwiss d1wisskarr motility_ökonomisch  ///
d1prohsart_g3r d1profach1_r c1eberuf_g1o c1jberuf_g1o c2jberuf_g1o c3jberuf_g1o c4jberuf_g1o c5jberuf_g1o ///
k1gebortplz_g2r k1gebortplz_g1o c2jwisspeka_r c2jwisspeka_g1 c3jwisspeka_r c3jwisspeka_g1 k2studbplz_g1o ///
tät_forsch sa_mut sa_vat bild_eltern abschl_mut abschl_vat gebort deu_sa ausl_sa kinder1 kinder2 pub_peer ///
pub_o_peer pub_sammel pub_bücher pub_peer_kat anz_patanträge ausland_nachstudium konf_aus konf_deu promdauer ///
promfach prom_gemf prom_koop prom_intkont prom_zwisaus prom_intprofor berufnetz2 d1konvanz d1konpanz woman ///
w2konvanz w2konpanz prom_vorbakadem prom_berufprax wiss_zuk bedeut_wiss befrist1 befrist2 im_ausland2 ///
worklife2 partner1 partner2 p1mobort p1mobtaet p1mobausl p1mobarsu p1mobheim p1mobgeg p1mobgra p1mobbess ///
p1mobverl branche1 branche2 prom_wich1 prom_wich2 logeink1 logeink2 ausland2 vorträge2 bereit_auslmob ///
worklife_dummy prom_intkont_dummy c2zufle c2zufbed c2zufeink c3zufle c3zufbed c3zufeink c3zufeink ///
prom_mobil postprom_mobil d2promabdat bereit_deutmob kontakt_hs promfach_neu ///
c2wwjupro c2wwnagr d1reputinst lehrdeputat habil2 c2taet1plz_g1r c2taet1plz_o postprom_mobil_dummy ///
c1taet1manf-c1taet4betr c2taet1manf-c2taet4betr c3taet1manf-c3taet4betr k1gebortplz_g3 k1studbplz_g3 ///
b1hs1bl_g2 b1hs2bl_g2 d1prohsbl_g2 SES_eltern index_sozkapital1 index_sozkapital2 index_sozkapital3 ///
m2grad1zweck-m2grad4ja c4taet1bula_g1 c4taet2bula_g1 c4taet3bula_g1 c4taet4bula_g1 

describe, short

$Daten_Bearb
save "OS_Promo14_Aufbereitung_Neu_2.dta", replace

exit
