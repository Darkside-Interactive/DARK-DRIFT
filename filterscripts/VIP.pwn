#include <a_samp>
#include <Dini>
#include <dutils>
#define FILTERSCRIPT
#if defined FILTERSCRIPT
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define COLOR_GREEN           0x33AA33AA
#define COLOR_RED             0xAA3333AA
#define COLOR_YELLOW          0xFFFF00AA
#define COLOR_LIGHTBLUE       0x33CCFFAA
#define COLOR_ORANGE          0xFF9900AA
#pragma tabsize 0
#define PlayerFile 	       		"VIP/%s.ini"
public OnFilterScriptInit()
    {
	print("*Vip System By Etch*");
 	return 1;
    }
#endif
enum PLAYER_MAIN {
    pName[MAX_PLAYER_NAME],
	Pip[16],
	Vip_Level
}
new Pinfo[MAX_PLAYERS][PLAYER_MAIN];
public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid,COLOR_YELLOW,"Vip System By Etch");
 	new file[100],Name[MAX_PLAYER_NAME],Ip[16]; GetPlayerName(playerid,Name,sizeof(Name)); GetPlayerIp(playerid,Ip,sizeof(Ip)); format(file,sizeof(file),PlayerFile,Name);
	if(!dini_Exists(file)) {
		dini_Create(file);
		dini_Set(file,"Name",Name);
		dini_Set(file,"Ip",Ip);
		dini_IntSet(file,"Vip_Level",0);
	}
	Pinfo[playerid][Vip_Level] 			      = dini_Int(file,"Vip_Level");
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	new file[100];
 	format(file,sizeof(file),PlayerFile,Pinfo[playerid][pName]);
	dini_Set(file,"Name",Pinfo[playerid][pName]);
	dini_Set(file,"Ip",Pinfo[playerid][Pip]);
	dini_IntSet(file,"Vip_Level",Pinfo[playerid][Vip_Level]);
	Pinfo[playerid][Vip_Level]  = 0;
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
dcmd(setvip,6,cmdtext);
dcmd(viplevel,8,cmdtext);
return 0;
}

dcmd_setvip(playerid, params[])
{
    new file[100];
 	format(file,sizeof(file),PlayerFile,Pinfo[playerid][pName]);
    new string[128],string2[128];
	new giveplayerid, level;
	new playername[MAX_PLAYER_NAME],idname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	GetPlayerName(playerid,idname,MAX_PLAYER_NAME);
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_RED, "You Have To Be Rcon Admin To Use This Command!");
	if(sscanf(params, "ud", giveplayerid, level))return SendClientMessage(playerid, COLOR_RED, "Usage: /setvip [Playerid/Partname] [Level]");
	else if (giveplayerid == INVALID_PLAYER_ID)return SendClientMessage(playerid, COLOR_RED, "Player Is Not Connected");
 	else if (level > 3)return SendClientMessage(playerid, COLOR_RED, "Maximum Vip Level Is 3");
    else
	{
  		Pinfo[giveplayerid][Vip_Level] = level;
		format(string,sizeof(string),"Administrator %s Set Your Vip Level To %d",playername,level);
		SendClientMessage(giveplayerid,COLOR_YELLOW,string);
		format(string2,sizeof(string2),"%s Vip Level Is Now %d",idname,level);
		SendClientMessageToAll(COLOR_YELLOW,string2);
		dini_IntSet(file,"Vip_Level",Pinfo[playerid][Vip_Level]);
	}
	return 1;
}
dcmd_viplevel(playerid, params[])
{
#pragma unused params
new string1[128],string2[128],string3[128];
format(string1,sizeof(string1),"============================");
format(string2,sizeof(string2),"Your V.I.P Level Is %d",Pinfo[playerid][Vip_Level]);
format(string3,sizeof(string3),"============================");
SendClientMessage(playerid,COLOR_YELLOW,string1);
SendClientMessage(playerid,COLOR_YELLOW,string2);
SendClientMessage(playerid,COLOR_YELLOW,string3);
return 1;
}

//------------------[SSCANF]-------------------------------------
stock sscanf(string[], format[], {Float,_}:...)
{
	#if defined isnull
		if (isnull(string))
	#else
		if (string[0] == 0 || (string[0] == 1 && string[1] == 0))
	#endif
		{
			return format[0];
		}
	#pragma tabsize 4
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs(),
		delim = ' ';
	while (string[stringPos] && string[stringPos] <= ' ')
	{
		stringPos++;
	}
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new
					neg = 1,
					num = 0,
					ch = string[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = string[++stringPos];
				}
				do
				{
					stringPos++;
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					num = 0,
					ch = string[stringPos];
				do
				{
					stringPos++;
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						default:
						{
							return -1;
						}
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
			{

				new changestr[16], changepos = 0, strpos = stringPos;
				while(changepos < 16 && string[strpos] && string[strpos] != delim)
				{
					changestr[changepos++] = string[strpos++];
    				}
				changestr[changepos] = '\0';
				setarg(paramPos,0,_:floatstr(changestr));
			}
			case 'p':
			{
				delim = format[formatPos++];
				continue;
			}
			case '\'':
			{
				new
					end = formatPos - 1,
					ch;
				while ((ch = format[++end]) && ch != '\'') {}
				if (!ch)
				{
					return -1;
				}
				format[end] = '\0';
				if ((ch = strfind(string, format[formatPos], false, stringPos)) == -1)
				{
					if (format[end + 1])
					{
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				stringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new
					end = stringPos - 1,
					id = 0,
					bool:num = true,
					ch;
				while ((ch = string[++end]) && ch != delim)
				{
					if (num)
					{
						if ('0' <= ch <= '9')
						{
							id = (id * 10) + (ch - '0');
						}
						else
						{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id))
				{
					setarg(paramPos, 0, id);
				}
				else
				{
					#if !defined foreach
						#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
						#define __SSCANF_FOREACH__
					#endif
					string[end] = '\0';
					num = false;
					new
						name[MAX_PLAYER_NAME];
					id = end - stringPos;
					foreach (Player, playerid)
					{
						GetPlayerName(playerid, name, sizeof (name));
						if (!strcmp(name, string[stringPos], true, id))
						{
							setarg(paramPos, 0, playerid);
							num = true;
							break;
						}
					}
					if (!num)
					{
						setarg(paramPos, 0, INVALID_PLAYER_ID);
					}
					string[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				stringPos = end;
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = string[stringPos++]) && ch != delim)
					{
						setarg(paramPos, i++, ch);
					}
					if (!i)
					{
						return -1;
					}
				}
				else
				{
					while ((ch = string[stringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (string[stringPos] && string[stringPos] != delim && string[stringPos] > ' ')
		{
			stringPos++;
		}
		while (string[stringPos] && (string[stringPos] == delim || string[stringPos] <= ' '))
		{
			stringPos++;
		}
		paramPos++;
	}
	do
	{
		if ((delim = format[formatPos++]) > ' ')
		{
			if (delim == '\'')
			{
				while ((delim = format[formatPos++]) && delim != '\'') {}
			}
			else if (delim != 'z')
			{
				return delim;
			}
		}
	}
	while (delim > ' ');
	return 0;
}

