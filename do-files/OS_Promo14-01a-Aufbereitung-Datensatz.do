*******************************************************************
*****  Do-file  Analysen Mobilität für Onsite-Recherche       *****
*****  Datum: 06.04.2021                                      *****
*******************************************************************
*****  Datenaufbereitung                                      *****
*******************************************************************

clear all
version 16
set more off
set scrollbufsize 500000 

*Globals
	
	global Verzeichnis "C:/Users/sonon001/Desktop/DZHW/HS Niederrhein/Forschung/Datenanalyse Mobilität/Analysen/OS_Promo14"
	global Abbildungen "cd "${Verzeichnis}/Abbildungen""
	global Daten_Bearb "cd "${Verzeichnis}/Daten/Daten_Bearb""
	global Daten_Orig "cd "${Verzeichnis}/Daten/Daten_Orig""
	global Do-Files "cd "${Verzeichnis}/Do-Files""
	global Tabellen "cd "${Verzeichnis}/Tabellen""

$Daten_Orig
use "phd2014_p_d_4-0-0.dta", clear

//numlabel, add

describe, short  //erster Überblick über den Datensatz

$Daten_Bearb
save "1_OS_Promo14.dta", replace

*****************************
*** Missings definieren
*****************************
/*
-948	läuft noch (zeitlich)
-965    ungültige Mehrfachnennung 
-966	nicht bestimmbar
-967	anonymisiert
-968	unplausibler Wert
-988	trifft nicht zu
-989	filterbedingt fehlend
-995    keine Teilnahme (Panel)
-996    Interviewabbruch
-998	keine Angabe
-999    Weiß nicht
-994    Verweigert
-997    keine Angabe (Antwortkategorie) 
*/

mvdecode _all, mv (-948=.a)
mvdecode _all, mv (-965=.b)
mvdecode _all, mv (-966=.c)
/*mvdecode _all, mv (-967=.d)*/  // Anonymisierte Daten bei OS zugänglich
mvdecode _all, mv (-968=.e)
mvdecode _all, mv (-988=.f)
mvdecode _all, mv (-989=.g)
mvdecode _all, mv (-995=.h)
mvdecode _all, mv (-996=.i) 
mvdecode _all, mv (-998=.j)
mvdecode _all, mv (-999=.k)
mvdecode _all, mv (-994=.l)
mvdecode _all, mv (-997=.m)

$Daten_Bearb
save "2_OS_Promo14_aufb.dta", replace


*******************************
*** Datenaufbereitung
*******************************


//doppelte Fälle  löschen
by pid, sort: generate pidcount= _N
generate index=_n
by pid : generate pidIndex= _n

list pidcount index pidIndex
tab1 pidcount index pidIndex

keep if pidIndex==1

$Daten_Bearb
save "3_OS_Promo14_aufb_1a.dta", replace



exit
