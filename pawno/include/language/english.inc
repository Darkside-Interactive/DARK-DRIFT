/*
	Language:   		English
	Version:    		0.8a

	Translation by:		Goldkiller (gta-goldkiller@web.de)
	Notice : - Write your Comment here,maybe advertice ;)


*/

#if defined _gAdminLANG_included
	#endinput
#endif
#define _gAdminLANG_included
#pragma library gAdminENG

	new login1[]="* Succesfull logged in";
	new login2[]="* Loaded Userdata. Your Level: %d";
	new login3[]="* %s logged in. Level:%d";
	new login4[]="You are already logged in";
	new login5[]="This account doesnt exist.Please use '/register [password]'.";
	new login6[]="Wrong Usage '/login password'";
	new login7[]="[Warning] Wrong Password %d/%d";
	new login8[]="You have been kicked from the Server(Not logged in)";
	new login9[]="%s has been kicked from the Server (Incorrect Password)";
	new login10[]="%s has been kicked from the Server (Not logged in)";
	new autolog[]="* You have automatically been logged in (IP comparison)";
	new register1[]="You are already logged in";
	new register2[]="This Account already exists,please ise '/login [password]'.";
	new register3[]="Wrong Usage. '/register [password]' .Your Password need at least 4 Characters";
	new register4[]="* Account created. You are now logged in";
	new register5[]="[REGISTRATION] Username '%s' is now registrated";
	new register6[]="* Rcon Admin detected,Full Admin (lvl 5)";
	new changepw1[]="*Your new PassWord is '%s'";
	new changepw2[]="Incorrect PassWord!";
	new ping1[]="Attention! Your Ping was %d of max.%d times to high.";
	new ping2[]="*** %s has been kicked for having a too high Ping,Sorry";
	#if defined BASIC_COMMANDS
	new pos1[]="* Your position X: %.3f, Y: %.3f, Z: %.3f";
	#endif
	new fake1[]="[INFO] %s tried to fake you (%s)";
	new fake2[]="You can not fake an Admin with a higher Level";
	new report1[]="' %s reported %s [ID %d]:%s";
	new report2[]="Thanks for reporting!Your Report has been sent to all Online Admins";
	#if defined EXTRA_COMMANDS
	new bank1[]="Invalid Cash Amount";
	new bank2[]="You have got %d $ on the bank";
	new bank3[]="You have %d $ saved on the Bank";
	new bank4[]="24/7 Shop is the bank.Stay in front of the Drink machine";
	new bank5[]="You can take max. %d $ off the bank";
	new bank6[]="You have %d $ still on the bank. You took %d $ off the bank";
	#endif
	#if defined LOCK_MODE
	new lock1[]="* Vehicle locked";
	new lock2[]="Vehicle already locked";
	new lock3[]="You are not in a Vehicle";
	new unlock1[]="Vehicle wasnt locked";
	new unlock2[]="* Vehicle unlocked";
	new unlock3[]="You are not in a Vehicle";
	#endif
	#if defined BASIC_COMMANDS
	new money1[]="You cant sent more money then you self own";
	new money2[]="%s gave %s %d $";
	new money3[]="%s gave you %d $";
	#endif
	new setmoney1[]="Admin %s sets the money of %s to %d $";
	new setmoney2[]="Your money has been set to %d $";
	new it1[]="You must be the Driver of the Vehicle";
	new it2[]="You are not in a Vehicle";
	new loc1[]="* %s is in %s";
	new vote1[]="You cant VoteKick an Admin";
	new vote2[]="* You have already voted this Player";
	new vote3[]="* Player %s started a vote for a kicking %s [Reason:%s]";
	new vote4[]="* VoteKick : %d/%d on %s";
	new vote5[]="* VoteKick : %d/%d on %s ( %s )";
	new vote6[]="* VoteKick : %s has been vote-kicked";
	new voteban1[]="You cant VoteBan an Admin";
	new voteban2[]="* You have already voted this Player";
	new voteban3[]="* Player %s started a vote for a banning %s [Reason:%s]";
	new voteban4[]="* VoteBan : %d/%d on %s";
	new voteban5[]="* VoteBan : %d/%d on %s ( %s )";
	new voteban6[]="* VoteBan : %s has been vote-banned";
	new votelistk[]="[VoteKicks]";
	new votelistb[]="[VoteBans]";
	new novotekicks[]="There are currently no VoteKicks";
	new novotebans[]="There are currently no VoteBans";
	new kick1[]="You have been kicked from the Server";
	new kick2[]="* %s [ID %d] has been kicked by Admin %s [Reason:%s]";
	new kick3[]="You cant kick an Admin with a higher Level";
	new kick4[]="[INFO] %s tried to kick you";
	new heal1[]="* %s [ID %d] has been healed by Admin %s";
	new slap1[]="* %s [ID %d] has been slapped by Admin %s";
	new slap2[]="You can not Slap an Admin with a higher Level";
	new slap3[]="[INFO] %s tried to slap you";
	new freeze2[]="* %s [ID %d] has been freezed by Admin %s";
	new freeze3[]="You can not freeze an Admin with a higher Level";
	new freeze4[]="[INFO] %s tried to freeze you";
	new freeze5[]="%s is already freezed";
	new unfreeze2[]="* %s [ID %d] has been unfreezed by Admin %s";
	new unfreeze3[]="You can not unfreeze an Admin with a higher Level";
	new unfreeze4[]="%s is not freezed";
	new gravity1[]="* Gravity has changed to: %.5f";
	new ip1[]="* %s's IP is: %s";
	new ban1[]="* You have been banned";
	new ban2[]="* %s [ID %d] has been banned by Admin %s [Reason:%s]";
	new ban3[]="You can not ban an Admin with a higher Level";
	new ban4[]="[INFO] %s tried to ban you";
	new goto1[]="* Admin %s was teleported to %s [ID %d]";
	new mute1[]="* %s [ID %d] has been muted";
	new mute2[]="* You have been muted for a certain time";
	new mute3[]="You can not Mute an Admin with a higher Level";
	new mute4[]="[INFO] %s tried to mute you";
	new mute5[]="%s is already muted";
	new unmute1[]="* %s [ID %d] was unmuted";
	new unmute2[]="%s is not muted";
	new get1[]="* %s [ID %d] was teleported to %s";
	new get3[]="You can not teleport an Admin with a higher Level to you";
	new get4[]="[INFO] %s tried to teleport you to him";
	new jail1[]="Selected Player is already in Jail";
	new jail2[]="* %s [ID %d] has been jailed by Admin %s";
	new jail3[]="You can not jail an Admin with a higher Level";
	new jail4[]="[INFO] %s tried to jail you";
	new unjail1[]="Selected Player is not in Jail";
	new unjail2[]="* %s [ID %d] was unjailed by Admin %s";
	new unjail3[]="You can not unjail an Admin with a higher Level";
	new wt1[]="Error: Invalid Time";
	new wt2[]="* Time has changed to %d:00";
	new black1[]="You have been banned from the Server";
	new black2[]="* %s [ID %d] has been blacklisted";
	new black3[]="You can not Blacklist an Admin!";
	new black4[]="[INFO] %s tried to add you to the Blacklist";
	new subnet1[]="You can not Ban an Admin!";
	new subnet2[]="* Added Range IP Ban";
	new nick2[]="* %s changes his Nick into %s";
	new nick3[]="Your new NickName is: %s";
	new ct1[]="Invalid Time";
	new ct2[]="Old Countdown canceled";
	new allmoney1[]="* Every Player receives %d $ by an Admin";
	new givecash1[]="* %s gave %s %d $";
	new givecash2[]="* Admin %s gives you %d $";
	new setadmin1[]="You can not set an Admin Level which is higher then yours";
	new setadmin2[]="Selected Player is not logged in";
	new setadmin3[]="You can not change your Admin Level";
	new setadmin4[]="* You set the Admin Level of %s to:%d";
	new setadmin5[]="*INFO:Your Admin Level has changed to %d";
	new setadmin6[]="Your Level is lower than the Level of selected Player";
	new armor1[]="You gave yourself armour";
	new disarm1[]="You have been disarmed by an Admin";
	new disarm2[]="[INFO] %s tried to disarm you";
	new numberplate1[]="You have to be in a Vehicle for this Commands";
	new numberplate2[]="* Numberplate:%s";
	new numberplate3[]="Too long numberplate [Max 8 characters]";
	new numberplate4[]="Get back to your latest location with /back";
	new allheal1[]="* Admin %s healed every Player";
	new resetmoney1[]="* Admin %s resets the Money of %s [ID %d] [%d$]";
	new resetmoney2[]="[INFO] %s tried to reset your money";
	new vr1[]="* %s's Vehicle has been fixed";
	new flip1[]="* %s flips his Car";
	new skin1[]="Invalid Skin ID";
	new skin2[]="* New playerskin ID %d";
	new bomb1[]="[INFO] %s tried to bomb you";
	new bomb2[]="* Admin %s bombed %s [ID %d]";
	new score2[]="* Admin %s sets %s [ID %d] score to %d";
	new color1[]="Invalid Color ID";
	new color2[]="* You changed the Color of your Vehicle [%d] [%d]";
	new tim1[]="* Time Changed : noon";
	new tim2[]="* Time Changed : night";
	new tim3[]="* Time Changed : midday";
	new tim4[]="* Time Changed : morning";
	#if defined SPECTATE_MODE
	new spec1[]=" * you are watching %s";
	new spec2[]=" * Canceled spectating";
	#endif
	new akill1[]="* %s [ID %d] has been killed by an Admin";
	new akill2[]="You can not kill an Admin with a higher level";
	new akill3[]="[INFO] %s tried to kill you";
	new vcolor1[]="Command only possible in a Vehicle";
	new fuckup1[]="You cant fuck up an higher Admin";
	new fuckup2[]="[INFO] %s tried to fuckup you";
	new fuckup3[]="* %s [ID %d] has been fucked up by Admin %s";
	new force1[]="[INFO] %s tried to force you to spawn";
	new force2[]="* %s [ID %d] has been forced to spawn by Admin %s";
	new force3[]="You cant spawn force an Admin with a higher level to spawn";
	new ejet1[]="* %s has been removed from %s Vehicle";
	new ejet2[]="Player is not in your Vehicle";
	new ejet3[]="You have to be the Driver of a Vehicle";
	new ejet4[]="[INFO] %s tried to ejet you";
	new giveweapon1[]="* Admin %s gave %s a %s with %d Munition";
	#if defined EXTRA_COMMANDS
	new hitman1[]="You do not even own that much Money";
	new hitman2[]="Very funny...";
	new hitman3[]="You cant set Bounty on yourself";
	new hitman4[]="* %s puts a Bounty of %d$ on %s's Head [Total: %d$]";
	new bounty1[]="* There is a Bounty of %d$ on %s's [ID %d] Head";
	#endif
	new vip1[]="Player is already V.I.P";
	new vip2[]="You have been upgraded to a V.I.P .You can now use VIP Chat '*'";
	new vip3[]="* %s is now a V.I.P";
	new vip4[]="Admins can use the V.I.P Chat also";
	new delvip1[]="* %s is no V.I.P anymore";
	new delvip2[]="* %s is no V.I.P";
	new delvip3[]="You are no V.I.P anymore";
	#if defined LOCK_MODE
	new xunlock1[]="All Cars has been unlocked!";
	#endif
	new sethp1[]="You should better use then /akill";
	new sethp2[]="* Admin %s sets %s [ID %d] HP to %d";
	new reloadbans1[]="samp.ban's has been reloaded";
	new teleport1[]="* %s teleported himself using the Admin Teleport Menu";
	new id1[]="Found more then 1 Players with Part of Name %s";
	new id2[]="No Player found with a Part of Name %s";
	new id3[]="* Player ID of %s is %d";
	new admins1[]="No Admins Online yet";
	new gskin1[]="* %s changed %s's Skin ID to %d";
	new gskin2[]="* %s changed your Skin ID to %d";
	new garmor1[]="* %s gave %s Armor";
	new garmor2[]="* %s gave you Armor";
	#if defined DISPLAY_MODE
	new speedo1[]="SpeedOMeter is now deactivated for you";
	new speedo2[]="SpeedOMeter is already deactivated for you";
	new speedo3[]="SpeedOMeter is already active for you";
	new speedo4[]="SpeedOMeter now active for you";
	#endif
	new clear[]="*** Chatbox has been cleared";
	new station[]="Weatherstation : %s";
	new sunny[]="Sunny";
	new foggy[]="Foggy";
	new rain[]="Rain";
	new storm[]="Sandstorm";
	new clouds[]="Cloudy";
	new stormy[]="Stormy";
	new esunny[]="Extra Sunny";
	new wrnd[]="Random";
	
	new Version[10]="0.8 ENG";
	new info[]="Filterscript gAdmin V 0.8";
	new back[]="You haven't saved a Position";
	new save[]="Your Position X: %.3f, Y: %.3f, Z: %.3f has succesfull been saved";
	new invalidmenu1[]="Menu is Invalid,recreate Menus with /gmenu";
	#if defined BASIC_COMMANDS
	new players[]="* %d Player(s) Online";
	#endif
	new missing[]="gAdmin stopped (Reason:Server will crash because of missing folders)";
	new ImportMoney[]= "You dont have enaugh Money to buy this Item";
	new error404[]= "Your Admin Level is too low for this Command";
	new selfslct[]="You cant you use this Command on your own";
	new InvalidID[]= "Error Invalid Player ID";
	new welcome[]= "Welcome %s .Write '/gcommands' for a Command List";
	new join[]="*** %s joined the Server";
	new leave[]="*** %s left the Server";
	new userexists[] ="This username is registrated.Please login or you will be kicked";
	new LoginSpawn[] ="You have %d seconds to login.Otherwise you will be kicked";
	new LameKickMsg[] ="[Lame Kills]* %s has been kicked";
	new NotSpawned[] ="Player has not yet spawned";
	new noreason[] = " <None>";
	new deactivated[]="* gAdmin Filterscript deactivated [%d %d %d]";
	new activated[]="* gAdmin Filterscript started [%d %d %d]";
	new censored[]="Censored Word";
	new filter[]="Wordfilter";
	new go[]="~g~GO GO GO!";
	new icommands[]="USAGE";
