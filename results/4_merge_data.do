******************************************************
****** Merge "abstract_3" mit "OS_AG_Wechsel" ********
******************************************************

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
use "abstract_3.dta", clear
	sort pid
	merge 1:1 pid using OS_AG_Wechsel.dta
	drop _merge
	
	
keep pid x1gewi x2gewi x2geaus x3gewi kontakt_hs akadem_laufbahn tät_forsch sa_vat w2prof habil2 p1mobtaet p1mobort ///
sa_mut abschl_vat abschl_mut gebort ausl_sa deu_sa einkommen kinder1 kinder2 pub_peer pub_o_peer p1mobarsu ///
pub_sammel pub_bücher anz_patanträge ausland_nachstudium konf_aus promfach prom_gemf prom_koop pub_peer_kat p1mobgeg ///
prom_intkont prom_intprofor prom_zwisaus berufnetz2 gebort prom_vorbakadem prom_berufprax wiss_zuk p1mobheim p1mobbess ///
bedeut_wiss science_per1 science_per5 stdvollzeit stdteilzeit gebjahr phdbeginn abgabediss berufstellng_1 postprom_mobil ///
anzahltagungen job_mobil d1mobilaus d1mobild p1mobausl p1mobgra konf_deu befrist1 befrist2 d1instkont p1mobverl ///
c1jbrutto c2jbrutto c3jbrutto d1konvanz d1konpanz w2konvanz w2konpanz ag_wechsel_1 ag_wechsel_2 bild_eltern ///
c1jwiss c2jwiss worklife2 im_ausland2 umzug_bl_1 umzug_bl_2 ausland geplantedauerausland_1 partner2 ///
c2jwisspeka_g1 c3jwisspeka_g1 c4jwisspeka_g1 c5jwisspeka_g1 x2teilnahme branche1 branche2 prom_wich1 prom_wich2 ///
logeink ausland2 sex01 vorträge2 bereit_auslmob bereit_deutmob worklife_dummy prom_intkont_dummy index2 mobil_1-mobil_5 ///
c2zufleb c2zufbed c2zufeink c2zufeink c1taet1manf-c1taet11betr c2taet1manf-c2taet10betr c3taet1manf-c3taet10betr ///
c4taet1manf-c4taet10betr c5taet1manf-c5taet10betr

$Daten_Bearb
save "abstract_4.dta", replace

$Daten_Bearb
use "abstract_4.dta", clear


// Berechnungen // Chi²-Tests

tab index2 deu_sa, chi2 V expected  // Mit deutscher Staatsangehörigkeit mobiler
tab index2 ausl_sa, chi2 V expected

tab index2 bereit_auslmob, chi2 V expected 
tab index2 bereit_auslmob if c2jwiss==1, chi2 V expected

tab index2 p1mobausl if c2jwiss==1, chi2 V expected 

tab index2 berufnetz2, chi2 V expected

