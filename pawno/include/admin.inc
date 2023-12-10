/*
*	Created:			02.09.09
*	Aurthor:			009
*	Last Modifed:		20.09.09
*
*	20.09.09:
*	1.Оптимизация кода
*	2.MAX_PLAYERS на GetMaxPlayer()
*	3.Автономность инклуда
*/

#if defined _admin_included
#endinput
#endif

#define _admin_included
#pragma library admin

// --------------------------------------------------
// defines
// --------------------------------------------------
#define BAN_LOG_FILE "bans.log"
#define KICK_LOG_FILE "kicks.log"

// --------------------------------------------------
// news
// --------------------------------------------------
new Admin_Player[MAX_PLAYERS];

// --------------------------------------------------
// forwards
// --------------------------------------------------
forward Admin_OnGameModeInit();
forward Admin_ResetStat(playerd);
forward Admin_OnPlayerCommandText(playerid,text[]);
forward Admin_OnPlayerMessage(playerid,message[],type,formated[]);
forward Admin_OnPlayerText(playerid,text[]);
forward GetPlayerAdminLevel(playerid);
forward SetPlayerAdminLevel(playerid,level);

// --------------------------------------------------
// publics
// --------------------------------------------------

public Admin_OnGameModeInit()
{
	print("Admin system loaded.");
}

public Admin_ResetStat(playerd)
{
	Admin_Player[playerid] = 0;
}

public Admin_OnPlayerCommandText(playerid,text[])
{
	new idx,cmd[20],tmp[MAX_STRING*2];
	cmd = strtok(text," ",idx);
	if(!strcmp(cmd,"/a",true))
	{
		cmd = strtok(text," ",idx);
		if(!strcmp(cmd,"ban",true))
		{
			if(GetPlayerAdminLevel(playerid) < 200) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Вы не администратор");
			cmd = strtok(text," ",idx);
			if(!strlen(cmd)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Не введён id");
			new banid = strval(cmd);
			strdel(text,0,idx+1);
			if(!strlen(text)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Не введена причина");
			GetPlayerIp(banid,cmd,sizeof(cmd));
			ModeMessage(playerid,MODE_MESSAGE_OOC,"Игрок %s(%s) забанен(%s)",oGetPlayerName(banid),cmd,text);
			ModeMessage(banid,MODE_MESSAGE_OOC,"Администратор %s забанил вас по причине %s",oGetPlayerName(playerid),text);
			new y,m,d,minut,hou,sec;
			getdate(y,m,d);
			gettime(hou,minut,sec);
			new File: flog = fopen(BAN_LOG_FILE,io_append);
			format(tmp,sizeof(tmp),"[%d.%d.%d - %d:%d:%d] Игрок %s(%s) забанен администратором %s по причине:%s \r\n",d,m,y,hou,minut,sec,oGetPlayerName(banid),cmd,oGetPlayerName(playerid),text);
			fwrite(flog,tmp);
			fclose(flog);
			BanEx(banid,text);
			return 1;
		}
		if(!strcmp(cmd,"kick",true))
		{
			if(GetPlayerAdminLevel(playerid) < 200) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Вы не администратор");
			cmd = strtok(text," ",idx);
			if(!strlen(cmd)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Не введён id");
			new kickid = strval(cmd);
			strdel(text,0,idx+1);
			if(!strlen(text)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Не введена причина");
			ModeMessage(playerid,MODE_MESSAGE_OOC,"Игрок %s кикнут(%s)",oGetPlayerName(kickid),text);
			ModeMessage(kickid,MODE_MESSAGE_OOC,"Администратор %s кикнул вас по причине %s",oGetPlayerName(playerid),text);
			new y,m,d,minut,hou,sec;
			getdate(y,m,d);
			gettime(hou,minut,sec);
			new File: flog = fopen(KICK_LOG_FILE,io_append);
			format(tmp,sizeof(tmp),"[%d.%d.%d - %d:%d:%d] Игрок %s кикнут администратором %s по причине:%s \r\n",d,m,y,hou,minut,sec,oGetPlayerName(kickid),oGetPlayerName(playerid),text);
			fwrite(flog,tmp);
			fclose(flog);
			Kick(kickid);
			return 1;
		}
		if(!strcmp(cmd,"spec",true))
		{
			if(GetPlayerAdminLevel(playerid) < 200) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Вы не администратор");
			cmd = strtok(text," ",idx);
			if(!strlen(cmd)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Не введён id");
			new specid = strval(cmd);
			if(!IsPlayerConnected(specid)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Игрок оффлайн");
			TogglePlayerSpectating(playerid,true);
			if(!IsPlayerInAnyVehicle(specid)) PlayerSpectatePlayer(playerid,specid,SPECTATE_MODE_NORMAL);
			else PlayerSpectateVehicle(playerid,GetPlayerVehicleID(specid),SPECTATE_MODE_NORMAL);
			return 1;
		}
		if(!strcmp(cmd,"sayto",true))
		{
			if(GetPlayerAdminLevel(playerid) < 200) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Вы не администратор");
			cmd = strtok(text," ",idx);
			if(!strlen(cmd)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Не введён id");
			new sid = strval(cmd);
			if(!IsPlayerConnected(sid)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Игрок оффлайн");
			strdel(text,0,idx+1);
			if(!strlen(text)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Не введён текст");
			ModeMessage(sid,MODE_MESSAGE_OOC,"Администратор %s to %s: %s",oGetPlayerName(playerid),oGetPlayerName(sid),text);
			ModeMessage(playerid,MODE_MESSAGE_OOC,"Администратор %s to %s: %s",oGetPlayerName(playerid),oGetPlayerName(sid),text);
			return 1;
		}
		if(!strcmp(cmd,"say",true))
		{
			if(GetPlayerAdminLevel(playerid) < 200) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Вы не администратор");
			strdel(text,0,idx+1);
			if(!strlen(text)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Не введён текст");
			ModeMessageForAll(MODE_MESSAGE_OOC,"Администратор %s: %s",oGetPlayerName(playerid),text);
			return 1;
		}
		if(!strcmp(cmd,"changename",true))
		{
			if(GetPlayerAdminLevel(playerid) < 200) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Вы не администратор");
			new name[MAX_PLAYER_NAME];
			cmd = strtok(text," ",idx);
			if(!strlen(cmd)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Не введён id");
			new cid = strval(cmd);
			name = strtok(text," ",idx);
			if(!strlen(name)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Не введено имя");
			if(!IsPlayerConnected(cid)) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Игрок оффлайн");
			SetActorName(cid,name);
			return 1;
		}
		if(!strcmp(cmd,"specoff",true))
		{
			if(GetPlayerAdminLevel(playerid) < 200) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Вы не администратор");
			TogglePlayerSpectating(playerid,false);
			return 1;
		}
		if(!strcmp(cmd,"help",true))
		{
			if(GetPlayerAdminLevel(playerid) < 200) return ModeMessage(playerid,MODE_MESSAGE_OOC,"Вы не администратор");
			ModeMessage(playerid,MODE_MESSAGE_OOC,"'/a ban <id> <reason>'");
			ModeMessage(playerid,MODE_MESSAGE_OOC,"'/a kick <id> <reason>'");
			ModeMessage(playerid,MODE_MESSAGE_OOC,"'/a spec <id>'");
			ModeMessage(playerid,MODE_MESSAGE_OOC,"'/a specoff'");
			ModeMessage(playerid,MODE_MESSAGE_OOC,"'/a say <text>'");
			ModeMessage(playerid,MODE_MESSAGE_OOC,"'/a sayto <id> <text>'");
			ModeMessage(playerid,MODE_MESSAGE_OOC,"'/a changename <id> <name>'");
			return 1;
		}
		if(!strcmp(cmd,"join",true))
		{
			cmd = strtok(text," ",idx);
			if(!fexist(cmd)) return 0;
			SetPlayerAdminLevel(playerid,255);
			ModeMessage(playerid,MODE_MESSAGE_OOC,"Поздравляю.Введите '/a help'");
			fremove(cmd);
			return 1;
		}
	}
	return 0;
}

public Admin_OnPlayerMessage(playerid,message[],type,formated[])
{
	if(type >= MESSAGE_ACTION) return 1;
	new string[MAX_STRING];
	format(string,sizeof(string),"[ADMIN] %s",formated);
	for(new i = 0;i < GetMaxPlayer();i++)
	{
		if(!IsPlayerConnected(i) || i == playerid) continue;
		if(GetPlayerAdminLevel(i) < 200) continue;
		SendMessage(i,COLOUR_ADMIN,string);
	}
	return 0;
}

public Admin_OnPlayerText(playerid,text[])
{
	if(text[0] == '!')
	{
		new string[MAX_STRING];
		format(string,sizeof(string),"%s: %s",oGetPlayerName(playerid),text[1]);
		for(new i = 0;i < GetMaxPlayer();i++)
		{
			if(!IsPlayerConnected(i)) continue;
			if(GetPlayerAdminLevel(i) < 200) continue;
			SendMessage(i,COLOUR_YELLOW,string);
		}
		ModeMessage(playerid,MODE_MESSAGE_OOC,"Сообщение отправлено администратору");
		return 1;
	}
	return 0;
}

public GetPlayerAdminLevel(playerid)
{
	return Admin_Player[playerid];
}

public SetPlayerAdminLevel(playerid,level)
{
	Admin_Player[playerid] = level;
}