/*
	Language:   		German
	Version:    		0.8a

	Translation by:		Goldkiller (gta-goldkiller@web.de)
	Notice : - Write your Comment here,maybe advertice ;)


*/

#if defined _gAdminLANG_included
	#endinput
#endif
#define _gAdminLANG_included
#pragma library gAdminGER

	new login1[]="* Erfolgreich eingeloggt";
	new login2[]="* Userprofil geladen. Dein Level: %d ";
	new login3[]="* %s hat sich eingeloggt. Level:%d";
	new login4[]="Du bist bereits eingeloggt";
	new login5[]="Account existiert nicht, bitte benutzte '/register [passwort]'";
	new login6[]="Richtige Nutzung: '/login [password]'";
	new login7[]="[Warnung] Falsches Passwort %d/%d";
	new login8[]="Du wurdest vom Server gekickt (Nicht eingeloggt)";
	new login9[]="%s wurde vom Server gekickt (Falsches Passwort)";
	new login10[]="%s wurde vom Server gekickt (Nicht eingeloggt)";
	new autolog[]="* Du wurdest automisch eingeloggt (IP Vergleich)";
	new register1[]="Du bist bereits eingeloggt";
	new register2[]="Account existiert bereits, bitte benutzt '/login [passwort]'";
	new register3[]="Richtige Nutzung: '/register passwort' .Dein Passwort muss mindestens 4 Zeichen lang sein";
	new register4[]="* Account erstellt. Du bist nun automatisch eingeloggt";
	new register5[]="[REGISTRATION] Username '%s' ist jetzt registriert";
	new register6[]="* Rcon Admin gefunden,voller Admin (lvl 5)";
	new changepw1[]="*:Dein neues Passwort ist '%s'";
	new changepw2[]="Falsches Passwort!";
	new ping1[]="Achtung! Dein Ping war bisher %d von Maximal %d zu hoch";
	new ping2[]="*** %s wurde gekickt da er einen zu hohen Ping hatte,Sorry";
	#if defined BASIC_COMMANDS
	new pos1[]="* Deine Position X: %.3f, Y: %.3f, Z: %.3f";
	#endif
	new fake1[]="[INFO] %s has versucht dich zu faken (%s)";
	new fake2[]="Du kannst keinen Admin mit einem hoeheren Level faken";
	new report1[]="' %s meldet %s [ID %d]Grund:%s";
	new report2[]="Danke fuer diesen Hinweis!Deine Beschwerde wurde an alle Admins versendet die Online sind";
	#if defined  EXTRA_COMMANDS
	new bank1[]="Unerlaube Summe";
	new bank2[]="Dein Kontostand betraegt: %d$";
	new bank3[]="Du hast %d $ auf deinem Konto";
	new bank4[]="24/7 Shop ist die Bank.Stell dich vor einen der dort vorhandenen Automaten";
	new bank5[]="Du kannst maximal %d$ von der Bank abheben";
	new bank6[]="Du hast noch %d $ auf deinem Konto,%d $ abgehoben";
	#endif
	#if defined LOCK_MODE
	new lock1[]="* Fahrzeug gelockt";
	new lock2[]="Fahrzeug ist bereits gelockt";
	new lock3[]="Du bist nicht in einem Fahrzeug";
	new unlock1[]="Fahrzeug war nicht gelockt";
	new unlock2[]="* Fahrzeug entlockt";
	new unlock3[]="Du bist nicht in einem Fahrzeug";
	#endif
	#if defined BASIC_COMMANDS
	new money1[]="Du kannst nicht mehr Geld versenden als du selber besitzt";
	new money2[]="%s gab %s %d $";
	new money3[]="%s gibt dir %d $";
	#endif
	new setmoney1[]="Admin %s setzt das Geld von %s auf %d $";
	new setmoney2[]="Dein Geld wurde auf %d $ gesetzt";
	new it1[]="Du musst der Fahrer des Fahrzeuges sein";
	new it2[]="Du bist nicht in einem Auto";
	new loc1[]="* %s ist in %s";
	new vote1[]="Du kannst keinen Admin Votekicken";
	new vote2[]="* Du hast diesen Spieler bereits gevotet";
	new vote3[]="* VoteKick :%s startet ein Votekick an %s [Grund:%s]";
	new vote4[]="* VoteKick : %d/%d auf %s";
	new vote5[]="* VoteKick : %d/%d auf %s ( %s )";
	new vote6[]="* VoteKick : %s wurde gevote-kicked";
	new voteban1[]="Du kannst keinen Admin VoteBannen";
	new voteban2[]="* Du hast diesen Spieler bereits gevotet";
	new voteban3[]="* VoteBan :%s startet ein Voteban auf %s [Grund:%s]";
	new voteban4[]="* VoteBan : %d/%d auf %s";
	new voteban5[]="* VoteBan : %d/%d auf %s ( %s )";
	new voteban6[]="* VoteBan : %s wurde gevote-banned";
	new votelistk[]="[VoteKicks]";
	new votelistb[]="[VoteBans]";
	new novotekicks[]="Zur Zeit stehen keine VoteKicks aus";
	new novotebans[]="Zur Zeit stehen keine VoteBans aus";
	new kick1[]="Du wurdest vom Server gekickt";
	new kick2[]="* %s [ID %d] wurde durch Admin %s vom Server gekickt [Grund:%s]";
	new kick3[]="Du kannst keinen Admin mit einem hoeheren Level kicken";
	new kick4[]="[INFO] %s hat versucht dich zu kicken";
	new heal1[]="* %s [ID %d] wurde geheilt von Admin %s";
	new slap1[]="* %s [ID %d] wurde von Admin %s geslappt";
	new slap2[]="Du kannst keinen Admin mit einem hoeheren Level slappen";
	new slap3[]="[INFO] %s hat versucht dich zu slappen";
	new freeze2[]="* %s [ID %d] wurde gefreezt von Admin %s";
	new freeze3[]="Du kannst keinen Admin mit einem hoeheren Level freezeen";
	new freeze4[]="[INFO] %s hat versucht dich zu freezen";
	new freeze5[]="%s ist bereits gefreezt";
	new unfreeze2[]="* %s [ID %d] wurde entfreezt von Admin %s";
	new unfreeze3[]="Du kannst keinen Admin mit einem hoeheren Level unfreezen";
	new unfreeze4[]="%s ist nicht gefreezt";
	new gravity1[]="* Erdanziehung wurde geaendert: %.5f ";
	new ip1[]="* %s's IP ist: %s ";
	new ban1[]="* Du wurdest gebannt";
	new ban2[]="* %s [ID %d] wurde gebannt von Admin %s [Grund:%s]";
	new ban3[]="Du kannst keinen Admin mit einem hoeheren Level bannen";
	new ban4[]="[INFO] %s hat versucht dich zu bannen";
	new goto1[]="* Admin %s wurde zu %s [ID %d] teleportiert";
	new mute1[]="* %s [ID %d] wurde gemutet";
	new mute2[]="*Du wurdest auf unbestimmte Zeit gemutet";
	new mute3[]="Du kannst keinen Admin mit einem hoeheren Level muten";
	new mute4[]="[INFO] %s hat versucht dich zu muten";
	new mute5[]="%s ist bereits gemutet";
	new unmute1[]="* %s [ID %d] wurde entmutet";
	new unmute2[]="%s ist nicht gemutet";
	new get1[]="* %s [ID %d] wurde zu %s teleportiert";
	new get3[]="Du kannst keinen Admin mit einem hoeheren Level get'en";
	new get4[]="[INFO] %s that versucht dich zu ihm zu teleportieren";
	new jail1[]="Ausgewaehlter Spieler ist bereits im Jail";
	new jail2[]="* %s [ID %d] wurde von Admin %s gejailt";
	new jail3[]="Du kannst keinen Admin mit einem hoeheren Level jailen";
	new jail4[]="[INFO] %s hat versucht dich zu jailen";
	new unjail1[]="Ausgewaehlter Spieler ist nicht im Jail";
	new unjail2[]="* %s [ID %d] wurde von Admin %s unjailt";
	new unjail3[]="Du kannst keinen Admin mit einem hoeheren Level unjailen";
	new wt1[]="Error: Unerlaubte Zeit Angabe";
	new wt2[]="* Uhrzeit wurde geaendert auf %d:00";
	new black1[]="Du wurdest vom Server gebannt";
	new black2[]="* %s [ID %d] wurde geblacklistet";
	new black3[]="Du kannst keinen Admin mit einem hoeheren Level blacklisten";
	new black4[]="[INFO] %s hat versucht dich auf der Blacklist zu adden";
	new subnet1[]="Du kannst keinen Admin Bannen!";
	new subnet2[]="* Range IP Ban hinzugefuegt";
	new nick2[]="* %s aenderte seinen Nickname in %s";
	new nick3[]="Dein Neuer Nickname ist: %s ";
	new ct1[]="Ungueltige Sekunden Angabe";
	new ct2[]="Alter Countdown geloescht";
	new allmoney1[]="* Jeder Spieler erhaelt %d $ von einem Admin";
	new givecash1[]="* %s gab %s %d $";
	new givecash2[]="* Admin %s gibt dir %d $";
	new setadmin1[]="Du kannst kein Admin level vergeben das hoeher ist als dein Eigenes";
	new setadmin2[]="Ausgewaehlter Player ist nicht eingeloggt";
	new setadmin3[]="Du kannst dein eigenes Admin Level nicht aendern";
	new setadmin4[]="* Du hast das Admin level von %s auf: %d gesetzt";
	new setadmin5[]="*INFO:Dein Admin level wurde geaendert auf %d";
	new setadmin6[]="Dein Level ist niedrieger als das Level des ausgewaehlten Admins";
	new armor1[]="Du hast dir selber Armor gegeben";
	new disarm1[]="Du wurdest entwaffnet von einem Admin";
	new disarm2[]="[INFO] %s hat versucht dich zu disarmen";
	new numberplate1[]="Du musst in einem Fahrzeug sein fuer diesen Command";
	new numberplate2[]="* Nummernschild:%s";
	new numberplate3[]="Zu langes Kennzeichen [Maximal 8 Zeichen]";
	new numberplate4[]="Gebe /back ein und du wirst zurueck teleportiert";
	new allheal1[]="* Administrator %s hat alle Spieler geheilt";
	new resetmoney1[]="* Admin %s hat das Geld von  %s [ID %d] zurueckgesetzt [%d$]";
	new resetmoney2[]="[INFO] %s hat versucht dein Geld zurueckzusetzten";
	new vr1[]="* %s's Fahrzeug wurde repariert";
	new flip1[]="* %s flipt sein Car";
	new skin1[]="Unerlaubte Skin ID";
	new skin2[]="* Neue PlayerSkin ID %d";
	new bomb1[]="[INFO] %s hat versucht dich zu bomben";
	new bomb2[]="* Admin %s hat %s [ID %d] zerbombt";
	new score2[]="* Admin %s setzt %s [ID %d] Score auf %d";
	new color1[]="Ungueltige Color ID";
	new color2[]="* Du hast deine Fahrzeug Farbe geaendert [%d] [%d]";
	new tim1[]="* Uhrzeit geaendert : Abends";
	new tim2[]="* Uhrzeit geaendert : Nachts";
	new tim3[]="* Uhrzeit geaendert : Mittags";
	new tim4[]="* Uhrzeit geaendert : Morgens";
	#if defined SPECTATE_MODE
	new spec1[]="* Du beobachtest %s";
	new spec2[]="* Beobachten abgebrochen";
	#endif
	new akill1[]="* %s [ID %d] wurde getoetet von einem Admin";
	new akill2[]="Du kannst keinen Admin mit einem hoeheren Level akillen";
	new akill3[]="[INFO] %s hat versucht dich zu akillen";
	new vcolor1[]="Command nur in einem Fahrzeug moeglich";	
	new fuckup1[]="Du kannst keinen Admin nerven mit einem hoeheren Level";
	new fuckup2[]="[INFO] %s hat versucht dich zu nerven ";
	new fuckup3[]="* %s [ID %d] wurde gefuckuped von Admin %s";
	new force1[]="[INFO] %s hat versucht dich zum spawnen zu zwingen";
	new force2[]="* %s [ID %d] wurde durch Admin %s zum spawnen gezwungen";
	new force3[]="* Du kannst keinen Admin zum spawnen zwingen";
	new ejet1[]="* %s wurde aus %s Fahrzeug entfernt";
	new ejet2[]="Der ausgewaelte Spieler ist nicht in deinem Fahrzeug";
	new ejet3[]="Du musst der Fahrer eines Fahrzeuges sein";	
	new ejet4[]="[INFO] %s hat versucht dich aus dem Fahrzeug zu entfernen";
	new giveweapon1[]="* Admin %s gab %s ein(e) %s mit %d Munition";
  	#if defined EXTRA_COMMANDS
	new hitman1[]="Du selber besitzt nicht so viel Geld";
	new hitman2[]="Sehr witzig...";
	new hitman3[]="Du kannst kein Kopfgeld auf dich selber setzten";
	new hitman4[]="* %s setzt ein Kopfgeld von %d$ auf %s's Kopf [Total: %d$]";
	new bounty1[]="* Ein Kopfgeld von %d $ ist auf %s's [ID %d] Kopf";
	#endif
	new vip1[]="Der Spieler ist bereits V.I.P";
	new vip2[]="Du wurdest zu einem V.I.P .Du kannst jetzt den V.I.P Chat nutzen,'*'";
	new vip3[]="* %s ist jetzt ein V.I.P";
	new vip4[]="Admins koennen den V.I.P Chat auch benutzten.";
	new delvip1[]="* %s ist kein V.I.P mehr";
	new delvip2[]="* %s ist kein V.I.P";
	new delvip3[]="Du bist kein V.I.P mehr";
	#if defined LOCK_MODE
	new xunlock1[]="Alle Fahrzeuge wurden aufgeschlossen";
	#endif
	new sethp1[]="Du solltest wohl lieber /akill benutzten";
	new sethp2[]="Admin %s hat %s [ID %d] Lebenspunkte auf %d gesetzt";
	new reloadbans1[]="samp.ban's has been reloaded";
	new teleport1[]="* %s hat sich selbst teleportiert durch das Admin Teleport Menu";
	new id1[]="Es wurde mehr als 1 Spieler gefunden mit %s im Nickname";
	new id2[]="Es wurde kein Spieler mit %s im Nickname gefunden";
	new id3[]="* Player ID von %s ist %d";
	new admins1[]="Keine Admins Online zur Zeit";
	new gskin1[]="* %s hat %s's Skin ID auf %d geaendert";
	new gskin2[]="* %s hat deine Skin ID auf %d geaendert";
	new garmor1[]="* %s gibt %s Armor";
	new garmor2[]="* %s gibt dir Armor";
	#if defined DISPLAY_MODE
	new speedo1[]="SpeedOMeter ist nun deaktiviert";
	new speedo2[]="SpeedOMeter ist bereits deaktiviert";
	new speedo3[]="SpeedOMeter ist bereits aktiviert";
	new speedo4[]="SpeedOMeter ist nun aktiviert";
	#endif
	new clear[]="*** Chatbox wurde geleert";
	new station[]="Wetterstation : %s";
	new sunny[]="Sonnig";
	new foggy[]="Nebelig";
	new rain[]="Regen";
	new storm[]="Sandsturm";
	new clouds[]="Bewoelkt";
	new stormy[]="Stuermisch";
	new esunny[]="Sehr Sonnig";
	new wrnd[]="Zufall";

	new Version[10]="0.8 GER";
	new info[]="Filterscript gAdmin V 0.8";
	new back[]="Du hast keine Position gespeichert";
	new save[]="Deine Position X: %.3f, Y: %.3f, Z: %.3f wurde erfolgreich gespeichert";
	new invalidmenu1[]="Menu ist nicht verfuegbar,Menu's neu erstellen mit /gmenu";
   	#if defined BASIC_COMMANDS
	new players[]="* %d Spieler Online";
	#endif
	new missing[]="gAdmin gestopt (Grund:Server wird crashen wegen fehlenden Ordnern)";
	new ImportMoney[]= "Du besitzt nicht genug Geld um dieses Item zu kaufen";
	new error404[]= "Dein Admin Level ist nicht hoch genug fuer diesen Command";
	new selfslct[]="Du kannst diesen Command nicht an dir selber anwenden";
	new InvalidID[]= "Error Player ID Fehler";
	new welcome[]= "Willkommen %s .Schreibe '/gcommands' fuer eine Command Liste";
	new join[]="*** %s hat den Server betreten";
	new leave[]="*** %s hat den Server verlassen";
	new userexists[] ="Dieser Username ist registriert.Bitte logge dich ein oder du wirst gekickt";
	new LoginSpawn[] ="Du hast %d Sekunden Zeit um dich einzuloggen oder du wirst gekickt";
	new LameKickMsg[] ="[Lame Kills]* %s wurde vom Server gekickt";
	new NotSpawned[] ="Spieler noch ist noch nicht gespawnt";
	new noreason[] = " <Keine Angabe>";
	new deactivated[]="* gAdmin Filterscript deaktiviert [%d %d %d]";
	new activated[]="* gAdmin Filterscript aktiviert [%d %d %d]";
	new censored[]="Zensiertes Mord";
	new filter[]="Wortfilter";
	new go[]="~g~Los Los Los!";
	new icommands[]="Benutztung";
