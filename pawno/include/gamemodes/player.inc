/*
*	Created:			21.04.10
*	Author:				009
*	Description:		�����������, �����������, ������, ��������
*	Info:				����� �� Undead Attack 0.1 beta 4, �������� ��� WoG
*/

#if defined _player_included
	#endinput
#endif

#define _player_included
#pragma library player

// --------------------------------------------------
// defines
// --------------------------------------------------
#define PLAYERS_DIR				"players/"
#define PLAYERS_FILE_TYPE		".ini"
#define START_HELP_FILE			"start_help.txt"
#define START_HELP_COLOR		0xFFFFFFAA
#define REGENERATION_TIME		5
#define TIME_FOR_SAVE			1800_000
#define HELP_TIME				10_000
#define XP_RATE					150

// --------------------------------------------------
// enums
// --------------------------------------------------
enum
{
	PLAYER_STAT_CMD,
	PLAYER_HELP_CMD,
	PLAYER_SAVECHAR_CMD,
	PLAYER_CHANGEPASS_CMD,
	PLAYER_KILL_CMD,
	PLAYER_CREDITS_CMD
};
enum
{
	CHANGE_STAT_ADD,
	CHANGE_STAT_SET
};
enum
{
	SAVE_REASON_SAVECHAR,
	SAVE_REASON_AUTOSAVE,
	SAVE_REASON_DISCONNECT
};
enum
{
	STARTHELP_ACTION_TITLE,
	STARTHELP_ACTION_TEXT,
	STARTHELP_ACTION_INTERIOR,
	STARTHELP_ACTION_CAMERA_POS
};

// --------------------------------------------------
// forwards
// --------------------------------------------------
forward Autosave();
forward StartHelpNextStep(playerid);
// global
forward OnSavePlayerData(playerid,File:datafile,reason);
forward OnLoadPlayerData(playerid,datastr[],separatorpos);

// --------------------------------------------------
// publics
// --------------------------------------------------
public Autosave()
{
	// autosave
	for(new i = 0;i <= GetPlayersCount();i++)
	{
		if(!IsPlayerConnected(i)) continue;
		if(IsPlayerNPC(i)) continue;
		if(GetPVarInt(i,"Logged") != 1) continue;
		
		// save
		SavePlayer(i,SAVE_REASON_AUTOSAVE);
	}
}

public StartHelpNextStep(playerid)
{
	itmp[0] = GetPVarInt(playerid,"StartHelpStep") + 1;
	SetPVarInt(playerid,"StartHelpStep",itmp[0]);
	itmp[0] = ChangeStartHelpStep(playerid,itmp[0]);
	if(itmp[0] != -1) SetTimerEx("StartHelpNextStep",itmp[0],0,"d",playerid);
}

// --------------------------------------------------
// stocks
// --------------------------------------------------
stock SavePlayer(playerid,reason)
{
	if(GetPVarInt(playerid,"Logged") != 1) return;
	
	new name[MAX_PLAYER_NAME];
	GetPVarString(playerid,"Account",name,sizeof(name));
	
	format(stmp,sizeof(stmp),MODE_DIR PLAYERS_DIR "%s" PLAYERS_FILE_TYPE,name);
	
	new File:pfile = fopen(stmp,io_write);
	
	// player core stats
	GetPVarString(playerid,"Password",stmp,sizeof(stmp));
	format(stmp,sizeof(stmp),"Password=%s\r\n",stmp);
	fwrite(pfile,stmp);
	format(stmp,sizeof(stmp),"Level=%d\r\n",GetPVarInt(playerid,"Level"));
	fwrite(pfile,stmp);
	format(stmp,sizeof(stmp),"Kills=%d\r\n",GetPVarInt(playerid,"Kills"));
	fwrite(pfile,stmp);
	format(stmp,sizeof(stmp),"Deaths=%d\r\n",GetPVarInt(playerid,"Deaths"));
	fwrite(pfile,stmp);
	format(stmp,sizeof(stmp),"Money=%d\r\n",oGetPlayerMoney(playerid));
	fwrite(pfile,stmp);
	format(stmp,sizeof(stmp),"XP=%d\r\n",GetPVarInt(playerid,"XP"));
	fwrite(pfile,stmp);
	format(stmp,sizeof(stmp),"UpgradesPoints=%d\r\n",GetPVarInt(playerid,"UpgradesPoints"));
	fwrite(pfile,stmp);
	format(stmp,sizeof(stmp),"Regeneration=%.1f\r\n",GetPVarFloat(playerid,"Regeneration"));
	fwrite(pfile,stmp);
	format(stmp,sizeof(stmp),"MaxHealth=%.1f\r\n",GetPVarFloat(playerid,"MaxHealth"));
	fwrite(pfile,stmp);
	for(new i = 0;i <= 10;i++)
	{
		format(stmp,sizeof(stmp),"Skill_%d",i);
		format(stmp,sizeof(stmp),"%s=%d\r\n",stmp,GetPVarInt(playerid,stmp));
		fwrite(pfile,stmp);
	}
	for(new i = 0;i <= 11;i++)
	{
		format(stmp,sizeof(stmp),"SlotWeapon_%d",i);
		format(stmp,sizeof(stmp),"%s=%d\r\n",stmp,GetPVarInt(playerid,stmp));
		fwrite(pfile,stmp);
		format(stmp,sizeof(stmp),"SlotAmmo_%d",i);
		format(stmp,sizeof(stmp),"%s=%d\r\n",stmp,GetPVarInt(playerid,stmp));
		fwrite(pfile,stmp);
	}
	// other systems
	OnSavePlayerData(playerid,pfile,reason);
	
	fclose(pfile);
}

stock LoadPlayer(playerid,pass[])
{
	new name[MAX_PLAYER_NAME];
	GetPVarString(playerid,"Account",name,sizeof(name));
	
	format(stmp,sizeof(stmp),MODE_DIR PLAYERS_DIR "%s" PLAYERS_FILE_TYPE,name);
	
	new File:pfile = fopen(stmp,io_read),
		tmp[20];
	if(!pfile) return 0;
	
	while(fread(pfile,stmp))
	{
		if(!CheckFileLine(stmp)) continue;
		
		if((itmp[0] = strfind(stmp,"=")) == -1) continue;
		
		// player core stats
		if(!strcmp(stmp,"Password",true,itmp[0]))
		{
			if(!strcmp(stmp[itmp[0] + 1],pass,true))
			{
				SetPVarInt(playerid,"Logged",1);
				SetPVarString(playerid,"Password",pass);
				continue;
			}
			else return 0;
		}
		if(!strcmp(stmp,"Level",true,itmp[0])) 
		{					
			SetPVarInt(playerid,"Level",strval(stmp[itmp[0] + 1]));
			continue;
		}
		if(!strcmp(stmp,"Kills",true,itmp[0])) 
		{
			SetPVarInt(playerid,"Kills",strval(stmp[itmp[0] + 1]));
			continue;
		}
		if(!strcmp(stmp,"Deaths",true,itmp[0])) 
		{
			SetPVarInt(playerid,"Deaths",strval(stmp[itmp[0] + 1]));
			continue;
		}
		if(!strcmp(stmp,"Money",true,itmp[0])) 
		{
			oSetPlayerMoney(playerid,strval(stmp[itmp[0] + 1]));
			continue;
		}
		if(!strcmp(stmp,"XP",true,itmp[0])) 
		{
			SetPVarInt(playerid,"XP",strval(stmp[itmp[0] + 1]));
			continue;
		}
		if(!strcmp(stmp,"UpgradesPoints",true,itmp[0])) 
		{
			SetPVarInt(playerid,"UpgradesPoints",strval(stmp[itmp[0] + 1]));
			continue;
		}
		if(!strcmp(stmp,"Regeneration",true,itmp[0]))
		{
			SetPVarFloat(playerid,"Regeneration",floatstr(stmp[itmp[0] + 1]));
			continue;
		}
		if(!strcmp(stmp,"MaxHealth",true,itmp[0])) 
		{
			SetPVarFloat(playerid,"MaxHealth",floatstr(stmp[itmp[0] + 1]));
			continue;
		}
		for(new i = 0;i <= 10;i++)
		{
			format(tmp,sizeof(tmp),"Skill_%d",i);
			if(!strcmp(stmp,tmp,true,itmp[0])) 
			{
				SetPVarInt(playerid,tmp,strval(stmp[itmp[0] + 1]));
				break;
			}
		}
		for(new i = 0;i <= 11;i++)
		{
			format(tmp,sizeof(tmp),"SlotWeapon_%d",i);
			if(!strcmp(stmp,tmp,true,itmp[0])) 
			{
				SetPVarInt(playerid,tmp,strval(stmp[itmp[0] + 1]));
				break;
			}
			format(tmp,sizeof(tmp),"SlotAmmo_%d",i);
			if(!strcmp(stmp,tmp,true,itmp[0])) 
			{
				SetPVarInt(playerid,tmp,strval(stmp[itmp[0] + 1]));
				break;
			}
		}
		// other systems
		OnLoadPlayerData(playerid,stmp,itmp[0]);
	}
	
	fclose(pfile);
	return 1;
}

stock ChangeStatByNameInt(name[],stat[],data,type)
{
	static 
		ntmp[MAX_PLAYER_NAME],
		pid;
	pid = INVALID_PLAYER_ID;
	for(new i = 0;i <= GetPlayersCount();i++)
	{
		GetPlayerName(i,ntmp,sizeof(ntmp));
		if(!strcmp(ntmp,name))
		{
			pid = i;
			break;
		}
	}
	if(pid != INVALID_PLAYER_ID)
	{
		switch(type)
		{
			case CHANGE_STAT_ADD:
			{
				SetPVarInt(pid,stat,GetPVarInt(pid,stat) + data);
				if(!strcmp(stat,"Money")) GivePlayerMoney(pid,data);
				else if(!strcmp(stat,"XP"))
				{
					SetPVarInt(pid,"Level",CalculateLevelForXP(data));
					SetPlayerScore(pid,GetPVarInt(pid,"Level"));
				}
			}
			case CHANGE_STAT_SET: 
			{
				SetPVarInt(pid,stat,data);
				if(!strcmp(stat,"Money")) 
				{
					oSetPlayerMoney(pid,data);
				}
				else if(!strcmp(stat,"XP"))
				{
					SetPVarInt(pid,"Level",CalculateLevelForXP(data));
					SetPlayerScore(pid,GetPVarInt(pid,"Level"));
				}
			}
		}		
	}
	else
	{
		format(stmp,sizeof(stmp),MODE_DIR PLAYERS_DIR "%s" PLAYERS_FILE_TYPE,name);
	
		new File:pfile = fopen(stmp,io_read);
		new File:tfile = fopen("temp",io_write);
		
		while(fread(pfile,stmp))
		{
			if(strfind(stmp,stat) == -1) fwrite(tfile,stmp);
			else 
			{
				itmp[0] = strfind(stmp,"=");
				new ndata = strval(stmp[itmp[0] + 1]);
				switch(type)
				{
					case CHANGE_STAT_ADD: ndata += data;
					case CHANGE_STAT_SET: ndata = data;
				}				
				format(stmp,sizeof(stmp),"%s=%d\r\n",stat,ndata);
				fwrite(tfile,stmp);
			}
		}
		fclose(pfile);
		fclose(tfile);
		// rename
		format(stmp,sizeof(stmp),MODE_DIR PLAYERS_DIR "%s" PLAYERS_FILE_TYPE,name);
		tfile = fopen(stmp,io_write);
		pfile = fopen("temp",io_read);
		while(fread(pfile,stmp)) fwrite(tfile,stmp);
		fclose(pfile);
		fclose(tfile);
		// delete temp
		fremove("temp");
	}
}

stock SetPlayerXP(playerid,xp)
{
	SetPVarInt(playerid,"XP",xp);
	SetPVarInt(playerid,"Level",CalculateLevelForXP(xp));
	SetPlayerScore(playerid,GetPVarInt(playerid,"Level"));
}

stock GivePlayerXP(playerid,xp)
{
	SetPVarInt(playerid,"XP",GetPVarInt(playerid,"XP") + xp);
	SetPVarInt(playerid,"Level",CalculateLevelForXP(GetPVarInt(playerid,"XP")));
	SetPlayerScore(playerid,GetPVarInt(playerid,"Level"));
}

stock CalculateXPForLevel(level)
{
	return floatround((level * level) * XP_RATE);
}

stock CalculateLevelForXP(xp)
{
	return floatround(floatsqroot((xp / XP_RATE)));
}

stock ChangeStartHelpStep(playerid,step)
{
	static line[256];
	new File:datafile = fopen(MODE_DIR START_HELP_FILE,io_read);
	if(datafile)
	{
		// find line by step
		for(new i = 0;i <= step;i++) 
		{
			if(!fread(datafile,line))
			{
				// file end - complete help show
				fclose(datafile);
				TogglePlayerSpectating(playerid,false);
				return -1;
			}
			else if(!CheckFileLine(line)) i--;
		}
		// check
		if(!CheckFileLine(line)) return -1;
		// parse
		static idx;
		idx = 0;
		// time of action 
		itmp[0] = strval(strtok(line,idx,','));
		// type of action
		itmp[1] = strval(strtok(line,idx,','));
		// next by type
		switch(itmp[1])
		{
			case STARTHELP_ACTION_TITLE:
			{
				GameTextForPlayer(playerid,line[idx],5000,1);
			}
			case STARTHELP_ACTION_TEXT: 
			{
				SendClientMessage(playerid,START_HELP_COLOR,line[idx]);
			}
			case STARTHELP_ACTION_INTERIOR:
			{
				itmp[2] = strval(strtok(line,idx,','));
				SetPlayerInterior(playerid,itmp[2]);
			}
			case STARTHELP_ACTION_CAMERA_POS:
			{
				ftmp[0] = floatstr(strtok(line,idx,','));
				ftmp[1] = floatstr(strtok(line,idx,','));
				ftmp[2] = floatstr(strtok(line,idx,','));
				ftmp[3] = floatstr(strtok(line,idx,','));
				ftmp[4] = floatstr(strtok(line,idx,','));
				ftmp[5] = floatstr(strtok(line,idx,','));
				SetPlayerCameraPos(playerid,ftmp[0],ftmp[1],ftmp[2]);
				SetPlayerCameraLookAt(playerid,ftmp[3],ftmp[4],ftmp[5]);
			}
		}		
		// file end
		fclose(datafile);		
		return itmp[0];
	}
	else 
	{
		printf("[ERROR] start help file not found (%s)",MODE_DIR START_HELP_FILE);
		return -1;
	}
}

// --------------------------------------------------
// Obligatory functions
// --------------------------------------------------
Player_OnGameModeInit()
{
	SetTimer("Autosave",TIME_FOR_SAVE,1);
	print("Players manager loaded.");
}

Player_OnPlayerConnect(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	if(!strcmp("Unknown",name)) 
	{
		SendClientMessage(playerid,SYSTEM_COLOR,"������������� ���� Unknown �����������");
		return Kick(playerid);
	}
	TogglePlayerSpectating(playerid,true);
	SetPVarString(playerid,"Account",name);
	format(stmp,sizeof(stmp),MODE_DIR PLAYERS_DIR "%s" PLAYERS_FILE_TYPE,name);
	if(fexist(stmp))
	{
		format(stmp,sizeof(stmp),"� ������������, %s!\n������� ���� ������ ����� ���������� � ����",name);
		ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_INPUT,MODE_NAME,stmp,"������","�����");
	}
	else
	{
		format(stmp,sizeof(stmp),"������������, %s!\n������� ���� ������ ����� ������������������",name);
		ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,MODE_NAME,stmp,"������","�����");	
	}
	return 1;
}

Player_OnPlayerDisconnect(playerid,reason)
{
	#pragma unused reason
	
	SavePlayer(playerid,SAVE_REASON_DISCONNECT);
}

Player_OnPlayerDeath(playerid,killerid,reason)
{
	#pragma unused reason
	SetPVarInt(playerid,"Deaths",GetPVarInt(playerid,"Deaths") + 1);
	if(killerid != INVALID_PLAYER_ID) SetPVarInt(killerid,"Kills",GetPVarInt(killerid,"Kills") + 1);
	return 1;
}

Player_OnPlayerSpawn(playerid)
{
	// check quest 
	if(GetPlayerQuest(playerid) == INVALID_QUEST_ID)
	{
		oSetPlayerHealth(playerid,GetPVarFloat(playerid,"MaxHealth"));
		SetPlayerScore(playerid,GetPVarInt(playerid,"Level"));
		for(new i = 0;i <= 11;i++)
		{
			format(stmp,sizeof(stmp),"SlotWeapon_%d",i);
			itmp[0] = GetPVarInt(playerid,stmp);
			format(stmp,sizeof(stmp),"SlotAmmo_%d",i);
			itmp[1] = GetPVarInt(playerid,stmp);
			oGivePlayerWeapon(playerid,itmp[0],itmp[1]);
		}
		SetPlayerColor(playerid,PLAYERS_COLOR);
	}
	for(new i = 0;i <= 10;i++)
	{
		format(stmp,sizeof(stmp),"Skill_%d",i);
		SetPlayerSkillLevel(playerid,i,GetPVarInt(playerid,stmp));
	}
}

Player_Update()
{
	// regeneration
	for(new i = 0;i <= GetPlayersCount();i++)
	{
		if(!IsPlayerConnected(i)) continue;
		if(IsPlayerNPC(i)) continue;
		if(GetPlayerState(i) == PLAYER_STATE_NONE) continue;
		if(GetPlayerState(i) == PLAYER_STATE_WASTED) continue;
		if(GetPlayerState(i) == PLAYER_STATE_SPECTATING) continue;
		
		itmp[0] = GetPVarInt(i,"RegenerationTicks") + 1;
		if(itmp[0] >= REGENERATION_TIME)
		{
			SetPVarInt(i,"RegenerationTicks",0);
			ftmp[0] = oGetPlayerHealth(i);
			if(ftmp[0] >= GetPVarFloat(i,"MaxHealth")) continue;
			ftmp[0] += GetPVarFloat(i,"Regeneration");
			if(ftmp[0] > GetPVarFloat(i,"MaxHealth")) ftmp[0] = GetPVarFloat(i,"MaxHealth");
			oSetPlayerHealth(i,ftmp[0]);
		}
		else SetPVarInt(i,"RegenerationTicks",itmp[0]);
	}
}

Player_Dialog(playerid,dialogid,response,listitem,inputtext[])
{
	#pragma unused listitem
	
	switch(dialogid)
	{
		case DIALOG_LOGIN:
		{
			if(!response) return ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_INPUT,MODE_NAME,"������� ���� ������ ����� ���������� � ����","������","�����");
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_INPUT,MODE_NAME,"������� ���� ������ ����� ���������� � ����","������","�����");
			// load
			if(!LoadPlayer(playerid,inputtext)) return ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_INPUT,MODE_NAME,"������� ���� ������ ����� ���������� � ����","������","�����");
			// selecting
			TogglePlayerSpectating(playerid,false);
			return 1;
		}
		case DIALOG_REGISTER:
		{
			if(!response) return ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,MODE_NAME,"������� ���� ������ ����� ������������������","������","�����");
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,MODE_NAME,"������� ���� ������ ����� ������������������","������","�����");

			// pvar
			SetPVarInt(playerid,"Logged",1);
			SetPVarString(playerid,"Password",inputtext);
			SetPVarInt(playerid,"Level",0);
			SetPVarInt(playerid,"Kills",0);
			SetPVarInt(playerid,"Deaths",0);
			oSetPlayerMoney(playerid,0);
			SetPVarInt(playerid,"BankMoney",0);
			SetPVarInt(playerid,"XP",0);
			SetPVarInt(playerid,"UpgradesPoints",0);
			SetPVarFloat(playerid,"Regeneration",0.0);
			SetPVarFloat(playerid,"MaxHealth",100.0);
			for(new i = 0;i <= 10;i++)
			{
				format(stmp,sizeof(stmp),"Skill_%d",i);
				SetPVarInt(playerid,stmp,0);
				SetPlayerSkillLevel(playerid,i,0);
			}
			SavePlayer(playerid,SAVE_REASON_AUTOSAVE);
			// start show help
			SetPVarInt(playerid,"StartHelpStep",0);
			itmp[0] = ChangeStartHelpStep(playerid,0);
			if(itmp[0] != -1) SetTimerEx("StartHelpNextStep",itmp[0],0,"d",playerid);
			return 1;
		}
	}
	return 0;
}

Player_Command(playerid,cmdid,params[])
{
	switch(cmdid)
	{
		case PLAYER_STAT_CMD:
		{
			stmp[0] = 0;
			format(stmp,sizeof(stmp),"\
				������� �������:				%s\n\
				�����:						%s\n\
				�������:					%d\n\
				����:						%d\n\
				������:					%d\n\
				����� �� ��������:				%d\n\
				��������:					%d\n\
				������:					%d\n\
				���� ��������:				%d\n\
				�������� �����:				%.0f\n\
				�����������:					%.0f\n\
				",
				oGetPlayerAdminLevelName(playerid),
				oGetPlayerGangName(playerid),
				GetPVarInt(playerid,"Level"),
				GetPVarInt(playerid,"XP"),
				oGetPlayerMoney(playerid),
				GetPVarInt(playerid,"BusinessIncome"),
				GetPVarInt(playerid,"Kills"),
				GetPVarInt(playerid,"Deaths"),
				GetPVarInt(playerid,"UpgradesPoints"),
				GetPVarFloat(playerid,"MaxHealth"),
				GetPVarFloat(playerid,"Regeneration")
			);
			format(stmp,sizeof(stmp),"%s\
				����� ���������:				%d\n\
				����� ��������� � ����������:		%d\n\
				����� \"���������� ����\"			%d\n\
				����� ���������:				%d\n\
				����� ������:				%d\n\
				����� S.P.A.S.:				%d\n\
				����� ����� ���:				%d\n\
				����� MP5:					%d\n\
				����� ��47:					%d\n\
				����� �4:					%d\n\
				����� ����������� ��������:		%d\n\
				",
				stmp,
				GetPVarInt(playerid,"Skill_" #WEAPONSKILL_PISTOL),
				GetPVarInt(playerid,"Skill_" #WEAPONSKILL_PISTOL_SILENCED),
				GetPVarInt(playerid,"Skill_" #WEAPONSKILL_DESERT_EAGLE),
				GetPVarInt(playerid,"Skill_" #WEAPONSKILL_SHOTGUN),
				GetPVarInt(playerid,"Skill_" #WEAPONSKILL_SAWNOFF_SHOTGUN),
				GetPVarInt(playerid,"Skill_" #WEAPONSKILL_SPAS12_SHOTGUN),
				GetPVarInt(playerid,"Skill_" #WEAPONSKILL_MICRO_UZI),
				GetPVarInt(playerid,"Skill_" #WEAPONSKILL_MP5),
				GetPVarInt(playerid,"Skill_" #WEAPONSKILL_AK47),
				GetPVarInt(playerid,"Skill_" #WEAPONSKILL_M4),
				GetPVarInt(playerid,"Skill_" #WEAPONSKILL_SNIPERRIFLE)
			);
			ShowPlayerDialog(playerid,DIALOG_NONE_ACTION,DIALOG_STYLE_MSGBOX,"����������",stmp,"��","��");
			return 1;
		}
		case PLAYER_HELP_CMD:
		{
			stmp[0] = 0;
			strcat(stmp,MODE_NAME " - TDM-RPG ���, ����� �� ������ �������� ������ ���������, �������� � �����, ������������ � ������,\n���������, ����-�������, ��������� ������� � ���� ��������� ��������� ������.\n");
			strcat(stmp,"/stats - ���� ����������\n/savechar - ��������� ���������(������������� ����������� ��� ������ �� ����)\n/changepass - �������� ������ �� ��������\n/kill - ����� ����\n/credits - ������ ������ �������������\n");
			strcat(stmp,"��� ��������� ������ ����������� �������:\n/b help - ������ �� ��������\n/h help - ������ �� �����\n/g help - ������ �� ������\n/dm help - ������ �� ���������\n/race help - ������ �� ������\n");
			strcat(stmp,"/bank help - ������ �� ������\n/gz help - ������ �� ����� ����\n/gw help - ������ �� ������ ����\n/tq help - ������ �� ��������� �������");			
			ShowPlayerDialog(playerid,DIALOG_NONE_ACTION,DIALOG_STYLE_MSGBOX,"������",stmp,"��","��");
			return 1;
		}
		case PLAYER_SAVECHAR_CMD:
		{
			SavePlayer(playerid,SAVE_REASON_SAVECHAR);
			SendClientMessage(playerid,SYSTEM_COLOR,"������� ������� ��������");
			return 1;
		}
		case PLAYER_CHANGEPASS_CMD:
		{
			if(GetPVarInt(playerid,"Logged") != 1) return 0;
			
			SetPVarString(playerid,"Password",params);
			SavePlayer(playerid,SAVE_REASON_AUTOSAVE);
			SendClientMessage(playerid,SYSTEM_COLOR,"������ ������� ������.");
			return 1;
		}
		case PLAYER_KILL_CMD:
		{
			oSetPlayerHealth(playerid,0.0);
			return 1;
		}
		case PLAYER_CREDITS_CMD:
		{
			ShowPlayerDialog(playerid,DIALOG_NONE_ACTION,DIALOG_STYLE_MSGBOX,"���������",
				"������� �����������: 009\n\
				������ �����������: ZiGGi\n\
				�������: MadCat(�� ���������� �����, ��������, �����, ���������)"
				,"��","��");
			return 1;
		}
	}
	return 0;
}