//
// Created:
// Aurthor: Dmitry Frolov (FP)
//

#if defined _admin_commands_sys_included
#endinput
#endif
#define _admin_commands_sys_included
#pragma library admin_commands_sys
#include "base"
#include "player"
#include "synctime"
#include "mission\minerun"
#include "mission\gates"
#include "mission\teleports"
//Защиты
#include "protections\flame"
#include "protections\pingkicker"
#include "protections\idle"
#include "protections\flood"
#include "protections\reconnect"
#include "protections\jetpack"
#include "protections\bots"
#include "protections\antiveh"
#include "protections\spam"
#include "protections\spawnkill"
#include "protections\spoofkill"
#include "protections\weaponcheat"
#include "protections\carkill"
#include "protections\driveby"
#include "protections\forbidnames"
#include "protections\helikill"

forward AdminCommandHandlerSys(playerid,text[]);

new syslotto = 1;	//LOTTERY, WITH Time
public AdminCommandHandlerSys(playerid,text[])
{
if (!IsPlayerConnected(playerid)) return 0;
if ( !IsPlayerAdmin(playerid) )
{
return 0;
}
new cmd[20];
new idx;
set(cmd,strcharsplit(text, idx,strchar(" ")));
if(strcomp(cmd, "/sys", true) == 0) return 0;
set(cmd,strcharsplit(text, idx,strchar(" ")));
//------------------------------------------------------------------------------
if(strcomp(cmd, "cmdlist", true) == 1)
{
  SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
  SendClientMessage(playerid, COLOUR_YELLOW, lang_texts[621]);
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys cmdlist', '/sys about', '/sys info'");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys weath <param>', - Weather AutoChange: 0 - off, 1 - rand, 2 - slowly");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys lotto <param>', - Lottery (0/1-20 min)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys minerun <param>', - Military Base Bombing (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys gates <param>', - Close/Open Gates (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys tps <param>', - Teleports On PickUps (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys time <param>', - Choose Timer - 1 real, 0 virtual");
  SendClientMessage(playerid, COLOUR_YELLOW, "SYS: Protections On-Line Settings...");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys aflame <param>', - AntiFlame (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys aping <param>', - AntiPingKicker (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys aidle <param>', - AntiIdle (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys aflood <param>', - AntiFlood (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys aspam <param>', - AntiSpam (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys arecon <param>', - AntiReconnect (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys ajetp <param>', - AntiJetPack (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys abots <param>', - AntiBots (Mass Connect per one IP) (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys aveh <param>', - AntiVehicleCheat (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys aspawn <param>', - AntiSpawnKill (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys aspoof <param>', - AntiSpoofKill (0/1)");
  SendClientMessage(playerid, COLOUR_YELLOW, "S: '/sys aweap <param>', - AntiWeaponCheat (0/1)");
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "about", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
  SendClientMessage(playerid, COLOUR_YELLOW, lang_texts[621]);
  SendClientMessage(playerid, COLOUR_YELLOW, lang_texts[622]);
  SendClientMessage(playerid, COLOUR_YELLOW, lang_texts[623]);
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "info", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
SendClientMessage(playerid, COLOUR_RED, "_________________________________________________________________________________");
SendClientMessage(playerid, COLOUR_YELLOW, lang_texts[624]);
new string[MAX_STRING];
format(string,sizeof(string),lang_texts[625] , TotalVehicles() ); //ActiveVehiclesCount);
SendClientMessage(playerid, COLOUR_LIGHTGREEN, string);
format(string,sizeof(string),lang_texts[629] , never);
SendClientMessage(playerid, COLOUR_LIGHTGREEN, string);
new PlayersCount = PlayerCount();
format(string,sizeof(string),lang_texts[626] , PlayersCount, MAX_PLAYERS);
SendClientMessage(playerid, COLOUR_LIGHTGREEN, string);
format(string,sizeof(string),lang_texts[627] , GetStringGettime() );
SendClientMessage(playerid, COLOUR_LIGHTGREEN, string);
format(string,sizeof(string),lang_texts[628] , MAX_BANK, MAX_MONEY);
SendClientMessage(playerid, COLOUR_LIGHTGREEN, string);
SendClientMessage(playerid, COLOUR_YELLOW, lang_texts[630]);
format(string,sizeof(string)," '/sys weath' = %d (Weather AutoChange)" , sysweath);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys time' = %d (Virtual/Real Time)" , Real_Time);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys lotto' = %d (Lottery)" , syslotto);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys minerun' = %d (Military Base Bombing)" , Minerun_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys gates' = %d (Gates Open for Players)" , Gates_Enter);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys tps' = %d (Teleports on PickUp)" , TelePort_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
SendClientMessage(playerid, COLOUR_YELLOW, "SYS: Protections On-Line Settings...");
format(string,sizeof(string)," '/sys aflame' = %d (AntiFlame)" , AntiFlame_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys aping' = %d (AntiPingKicker)" , PingKicker_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys aidle' = %d (AntiIdle)" , Anti_Idle_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys aflood' = %d (AntiFlood)" , AntiFlood_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys aspam' = %d (AntiSpam)" , AntiSpam_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys arecon' = %d (AntiReconnect)" , AntiReconnect_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys ajetp' = %d (AntiJetPack)" , Anti_Jetpack_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys abots' = %d (AntiBots) (Mass Connect per one IP)" , Anti_Bot_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys aveh' = %d (AntiVehicleCheat)" , AntiVeh_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys aspawn' = %d (AntiSpawnKill)" , Anti_Spawnkill_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys aspoof' = %d (AntiSpoofKill)" , Anti_Spoof_Kill_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string)," '/sys aweap' = %d (AntiWeaponCheat)" , Anti_Weapon_Cheat_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string),"> %d (AntiCarKills)" , Anti_Carkill_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string),"> %d (AntiDriveBy)" , Anti_Driveby_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string),"> %d (AntiForbiddenNames)" , Forbidden_Names_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
format(string,sizeof(string),"> %d (AntiHeliKill)" , Anti_Helikill_Enabled);
SendClientMessage(playerid, COLOUR_WHITE, string);
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "weath", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid == 0)
{
sysweath=0;
SendPlayerFormattedText(playerid,"SYS: Weather AutoChange OFF ", 0,COLOUR_WHITE);
} else if (paramid == 1)
	{
	sysweath=1;
	SendPlayerFormattedText(playerid,"SYS: Weather AutoChange ON (randomly)", 0,COLOUR_WHITE);
	} else if (paramid == 2)
		{
		sysweath=2;
		SendPlayerFormattedText(playerid,"SYS: Weather AutoChange ON (slowly)", 0,COLOUR_WHITE);
		} else if ((paramid < 0) && (paramid >2))
			{
			SendPlayerFormattedText(playerid, lang_texts[631] , 0,COLOUR_RED);
			return 0;
			}
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "time", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"Применение: /sys time <Param> (0 or 1)");
	return 0;
	}
if (paramid == 0)
{
Real_Time = 0;
TextDrawHideForAll(TimeText);
SendPlayerFormattedText(playerid,"Время изменено на игровое", 0,COLOUR_WHITE);
} else if (paramid == 1)
	{
	Real_Time = 1;
	TextDrawShowForAll(TimeText);
	SendPlayerFormattedText(playerid,"Время сихронизованно", 0,COLOUR_WHITE);
	}
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "lotto", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid == 0)
{
SetTimer("Lottery", 20*60000,0);
syslotto=0;
SendPlayerFormattedText(playerid,"SYS: Lottery OFF", 0,COLOUR_WHITE);
} else if ((paramid >= 1) && (paramid <= 20))
{
SetTimer("Lottery",paramid*60000, 1);
syslotto=1;
SendPlayerFormattedText(playerid,"SYS: Lottery ON", 0,COLOUR_WHITE);
} else
{
SendPlayerFormattedText(playerid, lang_texts[631] , 0,COLOUR_RED);
return 0;
}
return 1;
}
if(strcomp(cmd, "minerun", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);

new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid == 0)
{
Minerun_Enabled=0;
Minerun_Off();
SendPlayerFormattedText(playerid,"Отключено", 0,COLOUR_WHITE);
} else if (paramid == 1)
{
Minerun_Enabled=1;
Minerun_On();
SendPlayerFormattedText(playerid,"Включено", 0,COLOUR_WHITE);
} else
{
SendPlayerFormattedText(playerid, lang_texts[632] , 0,COLOUR_RED);
return 0;
}
return 1;
}


if(strcomp(cmd, "gates", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"Применение: /sys gates <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
Gates_Enter = 1;
SendPlayerFormattedText(playerid,"Все автоматические ворота включены", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	Gates_Enter = 0;
	SendPlayerFormattedText(playerid,"Все автоматические ворота отключены", 0,COLOUR_WHITE);
	}
return 1;
}
//------------------------------------------------------------------------------
if(strcomp(cmd, "tps", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys tps <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1 && TelePort_Enabled==0)
{
TelePort_Enabled = 1;
TelePortInit();
SendPlayerFormattedText(playerid,"SYS: Teleports on PickUps ON", 0,COLOUR_WHITE);
} else if (paramid == 0 && TelePort_Enabled==1)
	{
	TelePort_Enabled = 0;
	TelePortDestroy();
	SendPlayerFormattedText(playerid,"SYS: Teleports on PickUps OFF", 0,COLOUR_WHITE);
	}
return 1;
}

// PROTECTIONS -----------------------

if(strcomp(cmd, "aflame", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys aflame <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
AntiFlame_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiFlame ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	AntiFlame_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiFlame OFF", 0,COLOUR_WHITE);
	}
return 1;
}

if(strcomp(cmd, "aping", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys aping <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
PingKicker_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiPingKicker ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	PingKicker_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiPingKicker OFF", 0,COLOUR_WHITE);
	}
return 1;
}

if(strcomp(cmd, "aidle", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys aidle <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
Anti_Idle_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiIdle ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	Anti_Idle_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiIdle OFF", 0,COLOUR_WHITE);
	}
return 1;
}

if(strcomp(cmd, "aflood", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys aflood <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
AntiFlood_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiFlood ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	AntiFlood_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiFlood OFF", 0,COLOUR_WHITE);
	}
return 1;
}

if(strcomp(cmd, "arecon", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys arecon <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
AntiReconnect_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiReconnect ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	AntiReconnect_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiReconnect OFF", 0,COLOUR_WHITE);
	}
return 1;
}

if(strcomp(cmd, "ajetp", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys ajetp <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
Anti_Jetpack_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiJetPack ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	Anti_Jetpack_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiJetPack OFF", 0,COLOUR_WHITE);
	}
return 1;
}

if(strcomp(cmd, "abots", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys abots <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
Anti_Bot_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiBots ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	Anti_Bot_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiBots OFF", 0,COLOUR_WHITE);
	}
return 1;
}

if(strcomp(cmd, "aveh", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys aveh <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
AntiVeh_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiVehicleCheat ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	AntiVeh_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiVehicleCheat OFF", 0,COLOUR_WHITE);
	}
return 1;
}

if(strcomp(cmd, "aspam", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys aspam <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
AntiSpam_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiSpam ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	AntiSpam_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiSpam OFF", 0,COLOUR_WHITE);
	}
return 1;
}

if(strcomp(cmd, "aspawn", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys aspawn <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
Anti_Spawnkill_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiSpawnKill ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	Anti_Spawnkill_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiSpawnKill OFF", 0,COLOUR_WHITE);
	}
return 1;
}

if(strcomp(cmd, "aspoof", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys aspoof <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
Anti_Spoof_Kill_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiSpoofKill ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	Anti_Spoof_Kill_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiSpoofKill OFF", 0,COLOUR_WHITE);
	}
return 1;
}

if(strcomp(cmd, "aweap", true) == 1)
{
SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, text);
new paramid;
paramid = strval(strcharsplit(text, idx,strchar(" ")));
if (paramid<0 || paramid>1)
	{
	SendClientMessage(playerid,COLOUR_RED,"USAGE: /sys aweap <Param> (0 or 1)");
	return 0;
	}
if (paramid == 1)
{
Anti_Weapon_Cheat_Enabled = 1;
SendPlayerFormattedText(playerid,"SYS: AntiWeaponCheat ON", 0,COLOUR_WHITE);
} else if (paramid == 0)
	{
	Anti_Weapon_Cheat_Enabled = 0;
	SendPlayerFormattedText(playerid,"SYS: AntiWeaponCheat OFF", 0,COLOUR_WHITE);
	}
return 1;
}


return 0;
}
// SendMessageToAdmins(playerid,COLOUR_LIGHTGREEN, cmd);

