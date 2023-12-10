//
// Created:     14.09.06
// Aurthor:    Iain Gilbert
//

#if defined _gang_included
  #endinput
#endif

#define _gang_included
#pragma library gang
#include "base"

forward GangLoadConfig();
forward GangSaveConfig();
forward GetFreeMemberID();
forward GangLoad(gangname[]);
forward GangCommandHandler(playerid,text[]);
forward PlayerGangColour(playerid);
forward GangJoinMember(gangid,playerid);
forward GangRemoveMember(gangid,kickplayername[]);
forward GangCreate(leaderid,gangname[],gangcolour);
forward GangCleanup(gangid);
forward GangSaveAll();
forward GangMemberLogout(playerid,gangid);
forward GangSave(gangid);
forward GangUnload(gangid);
forward GangKill(gangid,killerid,victimid,reason);
forward GangMemberLogin(playerid,gangid);
forward SendGangMessage(gangid,message[MAX_STRING],colour);
forward GangOnlineCount(gangid);
forward GangGiveXP(gangid,xpamount,giverid);
forward SetGangColour(gangid,colour);

#define MAX_GANGS MAX_PLAYERS // maximum gangs (at runtime), (total maximum gangs is unlimited)
#define MAX_GANG_SIZE 16 // maximum number of ppl can be in any specific gang

new GANG_CREATE_LEVEL = 3;		//Start level for create a gang!

new GANG_CREATE_COST = 400000; // money cost to create a gang
new GANG_COLOUR_COST = 20000; // cost to change gang colour
new GangDB[MAX_STRING] = "GTO/Gang/";

enum MemberInfo {
 member_active,
 member_online, // bool
 member_name[MAX_NAME],
 member_playerid
}

enum GangInfo {
 gang_active, //bool
 gang_name[MAX_NAME],
    gang_colour,
    gang_kills,
    gang_score,
    gang_loginmessage[130]
}

enum ColourInfo {
 colour_name[MAX_NAME],
    colour_code
}
#define COLOURS_SIZE 18
new GangColours[COLOURS_SIZE][ColourInfo] = {
{ "Red",     COLOUR_RED},
{ "LightRed",    COLOUR_LIGHTRED},
{ "Crimson", COLOUR_CRIMSON},
{ "Grey",    COLOUR_GREY},
{ "Orange",    COLOUR_ORANGE},
{ "Yellow",    COLOUR_YELLOW},
{ "Green",    COLOUR_GREEN},
{ "LightGreen",    COLOUR_LIGHTGREEN},
{ "LimeGreen", COLOUR_LIMEGREEN},
{ "Aqua", COLOUR_AQUA},
{ "Blue",    COLOUR_BLUE},
{ "LightBlue",    COLOUR_LIGHTBLUE},
{ "Flblue",    COLOUR_FLBLUE},
{ "Magenta",    COLOUR_MAGENTA},
{ "Gold",    COLOUR_GOLD},
{ "White",    COLOUR_WHITE},
{ "Pink",    COLOUR_PINK},
{ "Purple",    COLOUR_PURPLE}
};

new GangMemberInfo[MAX_GANGS*MAX_GANG_SIZE][MemberInfo]; //shit way of '3d' array
new GangMembers[MAX_GANGS][MAX_GANG_SIZE]; // shit

new Gangs[MAX_GANGS][GangInfo];
new GangInvite[MAX_PLAYERS];
new tempstring[MAX_STRING];

public GangLoadConfig()
{
if (ForceOverwrite) return;
if (!dini_Exists(ConfigDB)) return;
new temp[MAX_STRING];
set(temp,dini_Get(ConfigDB,"Gang_DB"));
if (strlen(temp) > 0) set(GangDB,temp);
set(temp,nullstr);
set(temp,dini_Get(ConfigDB,"Gang_Create_Cost"));
if (strlen(temp) > 0) GANG_CREATE_COST = strval(temp);
set(temp,nullstr);
set(temp,dini_Get(ConfigDB,"Gng_Colour_Cost"));
if (strlen(temp) > 0) GANG_COLOUR_COST =strval(temp);
return;
}

public GangSaveConfig()
{
 if (!dini_Exists(ConfigDB)) return;
 new temp[MAX_STRING];
 dini_Set(ConfigDB,"Gang_DB",GangDB);
 valstr(temp,GANG_CREATE_COST);
 dini_Set(ConfigDB,"Gang_Create_Cost",temp);
 valstr(temp,GANG_COLOUR_COST);
 dini_Set(ConfigDB,"Gang_Colour_Cost",temp);
 return;
}

public GetFreeMemberID()
{
 for (new memberid = 1;memberid<MAX_GANG_SIZE*MAX_GANGS;memberid++)
 {
     if (GangMemberInfo[memberid][member_active] == 0)
     {
         return memberid;
  }
 }
 return 0;
}

public GangLoad(gangname[])
{
 // search for gang in runtime memory
 for (new id=1;id<MAX_GANGS;id++)
 {
  if (Gangs[id][gang_active] == 1)
  {
   if (strcomp(gangname,Gangs[id][gang_name],false) == 1)
   {
       return id; // gang found in runtime memory
   }
  }
 }

 new gangid;
 for (new id=1;id<MAX_GANGS;id++)
 {
     if(!Gangs[id][gang_active])
     {
      gangid = id;
      Gangs[id][gang_active] = true; // find first free gang slot and andd our gang
      break;
  }
 }
 gang_load_db_dini(gangid,gangname);

 new logstring[256];
 format(logstring, sizeof (logstring), "gang_loaded: %d",gangid);
 WriteLog(logstring);
 return gangid;
}

gang_load_db_dini(gangid,gangname[])
{
 new dinifilename[MAX_STRING];
 format(dinifilename,sizeof(dinifilename),"%sGTO.Gang.%s.txt",GangDB,gangname);

 if (!dini_Exists(dinifilename))
 {
 	return;
 }

  set(Gangs[gangid][gang_name],dini_Get(dinifilename,"Name"));
  Gangs[gangid][gang_colour] = strval(dini_Get(dinifilename,"Colour"));
  Gangs[gangid][gang_kills] = strval(dini_Get(dinifilename,"Kills"));
  Gangs[gangid][gang_score] = strval(dini_Get(dinifilename,"Score"));
//  Gangs[gangid][gang_loginmessage] = strval(dini_Get(dinifilename,"Login_Message"));

//MadCat Addded

 set(Gangs[gangid][gang_loginmessage],dini_Get(dinifilename,"Login_Message"));
//new tempstring[MAX_STRING];
//format(tempstring,sizeof(tempstring),": %s :" ,lang_texts[282]);
//if (!strlen(Gangs[gangid][gang_loginmessage])) set(Gangs[gangid][gang_loginmessage],tempstring);

if (!strlen(Gangs[gangid][gang_loginmessage])) set(Gangs[gangid][gang_loginmessage],lang_texts[282]);
//

  for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
  { // foreach member

   GangMembers[gangid][gangmember] = GetFreeMemberID();
   new memberid = GangMembers[gangid][gangmember];
   if (memberid == 0)
   {
    WriteLog("script error: free gang member id not found.");
    break;
   }
   GangMemberInfo[memberid][member_active] = 1;
   GangMemberInfo[memberid][member_online] = 0;
   new dinistring[MAX_STRING];
   format(dinistring,sizeof(dinistring),"Member%d" ,gangmember);
   set(GangMemberInfo[memberid][member_name],dini_Get(dinifilename,dinistring));
   GangMemberInfo[memberid][member_playerid] = INVALID_PLAYER_ID;
  }

}

public GangCommandHandler(playerid,text[]) // process player commands
{

	new cmd[20];
	new idx;

	set(cmd,strcharsplit(text, idx,strchar(" ")));
	if (strlen(cmd) == 0) return 0;

	if (Player[playerid][Muted] == 1)
	{
		SendPlayerFormattedText(playerid,lang_texts[14], 0,COLOUR_RED);
		return 1;
	}

	if(strcomp(cmd, "/g", true) == 1)
 	{
    	if (PlayerGangid[playerid] == 0) return 1;
     	new gangmessage[MAX_STRING];

     	set(gangmessage,text);
        strdel(gangmessage, 0, idx);
        if (!strlen(gangmessage)) return 1;
     	format(gangmessage, sizeof(gangmessage),  lang_texts[201] , oGetPlayerName(playerid),gangmessage);
        SendGangMessage(PlayerGangid[playerid],gangmessage,COLOUR_GANG_CHAT);

        new logstring[256];
  		format(logstring, sizeof (logstring), "player: %d:  %s:    %s",playerid,oGetPlayerName(playerid),gangmessage);
     	WriteChatLog(logstring);

        return 1;
	}

    if(strcomp(cmd, "/gang", true) == 1)
	{
//		new tempstring[MAX_STRING];
		if (!IsPlayerRegistered(playerid))
  		{
   			SendPlayerFormattedText(playerid,  lang_texts[202] , 0,COLOUR_RED);
   			return 1;
  		}

  		set(cmd,strcharsplit(text, idx,strchar(" ")));
  		if (strlen(cmd) == 0) return 0;

  		if(strcomp(cmd, "help", true) == 1)
  		{
   			SendPlayerScrollingText(playerid,  lang_texts[203] );
   			SendPlayerScrollingText(playerid,  lang_texts[204] );
   			SendPlayerScrollingText(playerid,  lang_texts[205] );
   			SendPlayerScrollingText(playerid,  lang_texts[206] );
   			SendPlayerScrollingText(playerid,  lang_texts[207] );
   			SendPlayerScrollingText(playerid,  lang_texts[208] );
   			return 1;
  		}

  		if(strcomp(cmd, "commands", true) == 1)
  		{
   			SendPlayerScrollingText(playerid,  lang_texts[209] );
   			SendPlayerScrollingText(playerid,  lang_texts[210] );
            		SendPlayerScrollingText(playerid,  lang_texts[211] );
   			SendPlayerScrollingText(playerid,  lang_texts[212] );
   			SendPlayerScrollingText(playerid,  lang_texts[213] );
   			SendPlayerScrollingText(playerid,  lang_texts[214] );
            		SendPlayerScrollingText(playerid,  lang_texts[215] );
  			SendPlayerScrollingText(playerid,  lang_texts[216] );
   			SendPlayerScrollingText(playerid,  lang_texts[217] );
            		SendPlayerScrollingText(playerid,  lang_texts[218] );
   			SendPlayerScrollingText(playerid,  lang_texts[219] );
			SendPlayerScrollingText(playerid,  lang_texts[220] );
   			return 1;
  		}

  		if((strcomp(cmd, "colours", true) == 1) || (strcomp(cmd, "COLOURS", true) == 1))
  		{
//			new tempstring[MAX_STRING];
   			SendPlayerFormattedText(playerid,  lang_texts[221], 0,COLOUR_GREEN);
   			for (new i = 0;i<COLOURS_SIZE;i++)
   			{
    			format(tempstring, sizeof(tempstring),  lang_texts[222] ,GangColours[i][colour_name]);
//    			SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_GREY);
    			SendPlayerFormattedText(playerid, tempstring, 0, GangColours[i][colour_code]);
   			}
   			return 1;
  		}

  		if((strcomp(cmd, "stats", true) == 1) || (strcomp(cmd, "stat", true) == 1) || (strcomp(cmd, "status", true) == 1))
  		{

      		if (PlayerGangid[playerid] == 0)
      		{
          		SendPlayerFormattedText(playerid,  lang_texts[223] , 0,COLOUR_RED);
       			return 1;
      		}
      		new gangid = PlayerGangid[playerid];
      		format(tempstring, sizeof(tempstring),  lang_texts[224] , Gangs[gangid][gang_name]);
      		SendPlayerFormattedText(playerid, tempstring, 0, Gangs[gangid][gang_colour]);
		format(tempstring, sizeof(tempstring), lang_texts[283] ,Gangs[gangid][gang_loginmessage]);
		SendPlayerFormattedText(playerid, tempstring, 0, Gangs[gangid][gang_colour]);

      		format(tempstring, sizeof(tempstring),  lang_texts[225] , Gangs[gangid][gang_kills]);
   		SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_MISC);
   		format(tempstring, sizeof(tempstring),  lang_texts[226] , Gangs[gangid][gang_score]);
   		SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_MISC);

   		format(tempstring, sizeof(tempstring),  lang_texts[227] , GangOnlineCount(gangid));
   		SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_MISC);
   		return 1;
  		}

  		if(strcomp(cmd, "members", true) == 1)
  		{

      		if (PlayerGangid[playerid] == 0)
      		{
       			SendPlayerFormattedText(playerid,  lang_texts[228] , 0,COLOUR_RED);
       			return 1;
      		}
      		new gangid = PlayerGangid[playerid];
      		new status[10];
      		format(tempstring, sizeof(tempstring),  lang_texts[229] , Gangs[gangid][gang_name]);
      		SendPlayerFormattedText(playerid, tempstring, 0,Gangs[gangid][gang_colour]);

      		for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
   			{ // foreach member
    			new memberid = GangMembers[gangid][gangmember];
    			if (strlen(GangMemberInfo[memberid][member_name]) > 0)
          		{
           			if (GangMemberInfo[memberid][member_online])
           			{
      					set(status,"Online");
         				format(tempstring, sizeof(tempstring),  lang_texts[230] , GangMemberInfo[memberid][member_name],status,GetPlayerLevel(GangMemberInfo[memberid][member_playerid]));
     				}
     				else
     				{
      					set(status,"Offline");
      					format(tempstring, sizeof(tempstring),  lang_texts[231] , GangMemberInfo[memberid][member_name],status);
     				}
     				SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_MISC);
    			}
   			}
   			return 1;
  		}

  		if(strcomp(cmd, "create", true) == 1)
  		{

      		if (PlayerGangid[playerid] != 0)
      		{
       			SendPlayerFormattedText(playerid,  lang_texts[232] , 0,COLOUR_RED);
       			return 1;
      		}

      		if (Player[playerid][Level] < GANG_CREATE_LEVEL)
      		{
			format(tempstring, sizeof(tempstring),  lang_texts[279] , GANG_CREATE_LEVEL);
       			SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_RED);
       			return 1;
      		}

      		if (oGetPlayerMoney(playerid) < GANG_CREATE_COST)
      		{
          		format(tempstring, sizeof(tempstring),  lang_texts[233] , GANG_CREATE_COST);
       			SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_RED);
       			return 1;
      		}
   			new gangname[MAX_STRING];
   			new colourname[MAX_NAME];
   			new gangcolour=255;

   			set(colourname,strcharsplit(text, idx,strchar(" ")));
   			if(!strlen(colourname))
   			{
       			SendPlayerFormattedText(playerid,  lang_texts[234] , 0,COLOUR_RED);
                SendPlayerFormattedText(playerid,  lang_texts[235] , 0,COLOUR_RED);
    			return 1;
         	}

         	for (new colourid=0;colourid<COLOURS_SIZE;colourid++)
         	{
             	if (strcomp(colourname,GangColours[colourid][colour_name],true) == 1)
             	{
              		gangcolour = GangColours[colourid][colour_code];
    			}
         	}
         	if (gangcolour == 255)
         	{
          		SendPlayerFormattedText(playerid,  lang_texts[236] , 0,COLOUR_RED);
                SendPlayerFormattedText(playerid,  lang_texts[237] , 0,COLOUR_RED);
    			return 1;
   			}

      		set(gangname,text);
         	strdel(gangname, 0, idx);
         	if (strlen(gangname) <3)
   			{
       			SendPlayerFormattedText(playerid,  lang_texts[238] , 0,COLOUR_RED);
    			return 1;
   			}
   			if (strlen(gangname) >40)
   			{
       			SendPlayerFormattedText(playerid,  lang_texts[239] , 0,COLOUR_RED);
    			return 1;
   			}
   			new tempname[MAX_STRING];
   			set(tempname,gangname);
   			if (!StringCharCheck(tempname))
   			{
    			SendPlayerFormattedText(playerid,  lang_texts[240] , 0,COLOUR_RED);
    			return 1;
   			}

   			if (GangCreate(playerid,gangname,gangcolour) != 0)
   			{
    				oGivePlayerMoney(playerid,0-GANG_CREATE_COST,1);
    				SendPlayerFormattedText(playerid,  lang_texts[241] , 0,COLOUR_GREEN);
    				new logstring[256];
    				format(logstring, sizeof (logstring), "player: %d:  %s: created gang '%s' ",playerid,oGetPlayerName(playerid),gangname);
       				WriteLog(logstring);
   			}
   			else
   			{
    				SendPlayerFormattedText(playerid,  lang_texts[242] , 0,COLOUR_RED);
   			}
  			return 1;
  		} // end create

  		if((strcomp(cmd, "accept", true) == 1) || (strcomp(cmd, "join", true) == 1))
  		{
      			if (PlayerGangid[playerid] != 0)
      			{
       				SendPlayerFormattedText(playerid,  lang_texts[243] , 0,COLOUR_RED);
				return 1;
      			}
      			if (GangInvite[playerid] == 0)
      			{
       				SendPlayerFormattedText(playerid,  lang_texts[244] , 0,COLOUR_RED);
    				return 1;
      			}
   			new gangid = GangInvite[playerid];

   			if (GangOnlineCount(gangid) >= MAX_GANG_SIZE)
   			{
	    			SendPlayerFormattedText(playerid,  lang_texts[245] , 0,COLOUR_RED);
    				GangInvite[playerid] = 0;
    				return 1;
   			}

      			if (GangJoinMember(gangid,playerid) == 1)
      			{
          			format(tempstring, sizeof(tempstring),  lang_texts[246] ,Gangs[gangid][gang_name]);
    				SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_GANG);
    				format(tempstring, sizeof(tempstring),  lang_texts[247] , oGetPlayerName(playerid));
    				SendGangMessage(gangid,tempstring,COLOUR_GANG);
                		new logstring[256];
    				format(logstring, sizeof (logstring), "player: %d:  %s: have joined '%s' gang.",playerid, oGetPlayerName(playerid), Gangs[gangid][gang_name]);
    				WriteLog(logstring);
    				return 1;
   			}
   			else
   				{
          			format(tempstring, sizeof(tempstring),  lang_texts[248] , Gangs[gangid][gang_name]);
    				SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_RED);
    				return 1;
   				}
  		}

  		if (PlayerGangid[playerid] == 0)
  		{
   			SendPlayerFormattedText(playerid,  lang_texts[249] , 0,COLOUR_RED);
   			return 1;
  		}
  		new gangid = PlayerGangid[playerid];
  		new leadermemberid = GangMembers[gangid][0];


  		if((strcomp(cmd, "quit", true) == 1) || (strcomp(cmd, "leave", true) == 1))
  		{
      		if (PlayerGangid[playerid] == 0)
      		{
       			SendPlayerFormattedText(playerid,  lang_texts[250] , 0,COLOUR_RED);
       			return 1;
      		}
		new kickplayername[MAX_NAME];
   		set(kickplayername,oGetPlayerName(playerid));
		GangRemoveMember(gangid,kickplayername);
//      	GangRemoveMember(gangid,oGetPlayerName(playerid));
      		return 1;
  		}


  		if(strcomp(cmd, "invite", true) == 1)
  		{
      		if (strcomp(GangMemberInfo[leadermemberid][member_name],oGetPlayerName(playerid),false) == 0)
      		{ // player is not leader of this gang
       			SendPlayerFormattedText(playerid,  lang_texts[251] , 0,COLOUR_RED);	//ты бля не лидер чтоп приглашать!
    			return 1;
   			}
      		new inviteid = INVALID_PLAYER_ID;

		inviteid = strval(strcharsplit(text, idx,strchar(" ")));

//		new string[MAX_STRING];
//		format(string,sizeof(string), "'/gang invite' Запрошен ИД %d" ,inviteid );			//игроку
//		SendPlayerFormattedText(playerid, string, 0,COLOUR_XP_GOOD);

		if ((inviteid < 0) || (inviteid >= MAX_PLAYERS))
		{
		SendPlayerFormattedText(playerid, lang_texts[445] , 0,COLOUR_RED);
		return 1;
		}

/*
      		new inviteplayername[MAX_NAME];
   			set(inviteplayername,text);
            	strdel(inviteplayername, 0, idx);
            	if (!strlen(inviteplayername))
            		{
       			SendPlayerFormattedText(playerid,  lang_texts[255] , 0,COLOUR_RED);	//
                	return 1;
         		}

            	for (new i = 0;i<MAX_PLAYERS;i++)
            		{
                	if (IsPlayerRegistered(i))
                		{
                    		if (strcomp(oGetPlayerName(i),inviteplayername,true) == 1)
                    			{
                     			inviteid = i;
                    			break;
                    			}
                		}
            		}
*/

      		if (inviteid == INVALID_PLAYER_ID)
      		{
       			SendPlayerFormattedText(playerid,  lang_texts[255] , 0,COLOUR_RED);
                return 1;
      		}
      		if (!IsPlayerRegistered(inviteid))
      		{
          		SendPlayerFormattedText(playerid,  lang_texts[254] , 0,COLOUR_RED);
       			SendPlayerFormattedText(playerid,  lang_texts[255] , 0,COLOUR_RED);
                return 1;
   			}

   		if (PlayerGangid[inviteid] != 0)
      		{
       			SendPlayerFormattedText(playerid,  lang_texts[256] , 0,COLOUR_RED);
    			return 1;
      		}
         	format(tempstring, sizeof(tempstring),  lang_texts[257] , oGetPlayerName(playerid),Gangs[gangid][gang_name]);
   			SendPlayerFormattedText(inviteid, tempstring, 0,COLOUR_GANG);
   			format(tempstring, sizeof(tempstring),  lang_texts[258] , oGetPlayerName(inviteid),Gangs[gangid][gang_name]);
   			SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_GANG);
   			GangInvite[inviteid] = gangid;
   			new logstring[256];
   			format(logstring, sizeof (logstring), "player: %d:  %s: has invited %s to join gang '%s'.",playerid,oGetPlayerName(playerid),oGetPlayerName(inviteid),Gangs[gangid][gang_name]);
      		WriteLog(logstring);
   			return 1;
  		}

  		if(strcomp(cmd, "kick", true) == 1)
  		{
      		if (strcomp(GangMemberInfo[leadermemberid][member_name],oGetPlayerName(playerid),false) == 0)
      		{
       			SendPlayerFormattedText(playerid,  lang_texts[259] , 0,COLOUR_RED);
    			return 1;
   			}
   			new kickplayername[MAX_NAME];
   			set(kickplayername,text);
            strdel(kickplayername, 0, idx);
            if (!strlen(kickplayername))
            {
            	SendPlayerFormattedText(playerid,  lang_texts[260] , 0,COLOUR_RED);
    			return 1;
            }
            if (GangRemoveMember(gangid,kickplayername))
            {
       			format(tempstring, sizeof(tempstring),  lang_texts[261] , kickplayername);
    			SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_GREEN);
   			}
   			else
   			{
    			format(tempstring, sizeof(tempstring),  lang_texts[262] , kickplayername);
    			SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_RED);
   			}
   			return 1;

  		}

  		if((strcomp(cmd, "colour", true) == 1) || (strcomp(cmd, "COLOUR", true) == 1))
  			{
      			if (strcomp(GangMemberInfo[leadermemberid][member_name],oGetPlayerName(playerid),false) == 0)
      				{
       				SendPlayerFormattedText(playerid,  lang_texts[263] , 0,COLOUR_RED);
    				return 1;
   				}
    			if (oGetPlayerMoney(playerid) < GANG_COLOUR_COST)
      				{
       				SendPlayerFormattedText(playerid,  lang_texts[264] , GANG_COLOUR_COST,COLOUR_RED);
    				return 1;
   				}
   			new colourname[MAX_NAME];
   			new gangcolour;
   			set(colourname,strcharsplit(text, idx,strchar(" ")));
   			if(!strlen(colourname))
   				{
       				SendPlayerFormattedText(playerid,  lang_texts[265] , 0,COLOUR_RED);
   				return 1;
         			}

        		for (new colourid=0;colourid<COLOURS_SIZE;colourid++)
         			{
            			if (strcomp(colourname,GangColours[colourid][colour_name],true) == 1)
             				{
              				gangcolour = GangColours[colourid][colour_code];
    					}
         			}
         		if (gangcolour == 0)
         			{
          			SendPlayerFormattedText(playerid,  lang_texts[266] , 0,COLOUR_RED);
               			 SendPlayerFormattedText(playerid,  lang_texts[267] , 0,COLOUR_RED);
    				return 1;
   				}

   			SendPlayerFormattedText(playerid,  lang_texts[268] , GANG_COLOUR_COST,gangcolour);
   			SetGangColour(gangid,gangcolour);
   			oGivePlayerMoney(playerid,0-GANG_COLOUR_COST,1);
   			return 1;
  			}

		if(strcomp(cmd, "motd", true) == 1)
  			{
//			Debug("gang.inc > Command 'gang motd' - Start");

  			if (PlayerGangid[playerid] == 0)
  				{
   				SendPlayerFormattedText(playerid,  lang_texts[249] , 0,COLOUR_RED);
				Debug("gang.inc > Command 'gang motd' - Stop");
   				return 1;
  				}

			new message[MAX_STRING];
			set(message,text);
			strdel(message, 0, idx);
			if( !strlen(message) || (strlen(message) > 100) )
				{
				SendPlayerFormattedText(playerid,  lang_texts[280] , 0,COLOUR_RED);
				Debug("gang.inc > Command 'gang motd' - Stop");
    				return 1;
        			}
			format(tempstring, sizeof(tempstring), "%s (%s)",message,oGetPlayerName(playerid));
			format(Gangs[PlayerGangid[playerid]][gang_loginmessage],130,"%s",tempstring);
			SendPlayerFormattedText(playerid,  lang_texts[281] , 0,COLOUR_GREEN);
			format(tempstring, sizeof(tempstring), lang_texts[283] ,Gangs[gangid][gang_loginmessage]);
			SendGangMessage(PlayerGangid[playerid],tempstring,COLOUR_WHITE);
//			Debug("gang.inc > Command 'gang motd' - Stop");
  			return 1;
  			}

	} // end gang
 	return 0;
}

public PlayerGangColour(playerid)
{
 new gangid = PlayerGangid[playerid];
 new newcolour = COLOUR_PLAYER;
 if (gangid != 0)
 {
     if (Gangs[gangid][gang_colour] != 0)
     {
         newcolour = Gangs[gangid][gang_colour];
  }
 }
 return newcolour;
}

public GangJoinMember(gangid,playerid)
{
 if (gangid == 0)
 {
 	WriteLog("script_warning: invalid gang id.");
 	return 0;
 }
 if (PlayerGangid[playerid] != 0)
    {
    	WriteLog("script_warning: player already in a gang!");
    	return 0;
    }

 if (GangOnlineCount(gangid) >= MAX_GANG_SIZE)
 {
  WriteLog("script_warning: Gang is already full.");
  return 0;
 }

 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 { // foreach member of the gang
  new memberid = GangMembers[gangid][gangmember]; // get memberid
  if (strlen(GangMemberInfo[memberid][member_name]) == 0) // if member slot free
  {
   set(GangMemberInfo[memberid][member_name],oGetPlayerName(playerid));
   GangMemberInfo[memberid][member_playerid] = playerid;
   GangMemberInfo[memberid][member_online] = 1;
   PlayerGangid[playerid] = gangid;
   set(PlayerGangName[playerid],Gangs[gangid][gang_name]);
   GangMemberLogin(gangid,playerid);

   SetPlayerColour(playerid,Gangs[gangid][gang_colour]);
//	if (strlen(Gangs[gangid][gang_loginmessage]))
//	{
//	format(tempstring, sizeof(tempstring), lang_texts[283] ,Gangs[gangid][gang_loginmessage]);
//	SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_WHITE);
//	}
   return 1;
  }
 }
 return 0;
}

public GangRemoveMember(gangid,kickplayername[])
{
 new playerid = INVALID_PLAYER_ID;

 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 { // foreach member of the gang

  new memberid = GangMembers[gangid][gangmember]; // get memberid
  if (strcomp(GangMemberInfo[memberid][member_name],kickplayername,true) == 1)
  {
   playerid = GangMemberInfo[memberid][member_playerid];
   GangMemberInfo[memberid][member_online] = 0;
   GangMemberInfo[memberid][member_playerid] = INVALID_PLAYER_ID;
//   set(GangMemberInfo[memberid][member_name],nullstr);			//Это не пашет!!!

   format(GangMemberInfo[memberid][member_name],1,"%s",nullstr);

   format(tempstring, sizeof(tempstring),  lang_texts[269] , kickplayername);
   SendGangMessage(gangid,tempstring,COLOUR_GANG);

   new logstring[256];
   format(logstring, sizeof (logstring), "%s has been removed from gang '%s'", kickplayername,Gangs[gangid][gang_name]);
   WriteLog(logstring);

   if (playerid != INVALID_PLAYER_ID)
   {
    format(tempstring, sizeof(tempstring),  lang_texts[270] , Gangs[gangid][gang_name]);
    SendClientMessage(playerid,COLOUR_GANG,tempstring);
    PlayerGangid[playerid] = 0;
    set(PlayerGangName[playerid],nullstr);
   }

	GangSave(gangid);
	SetPlayerColour(playerid,COLOUR_PLAYER);

   if (GangOnlineCount(gangid) == 0)
      {
          GangUnload(gangid);
   }
   return 1;
  }
 }
 return 0;
}


public GangCreate(leaderid,gangname[],gangcolour)
{
 if (!IsPlayerRegistered(leaderid)) return 0;

 new tempname[MAX_STRING];
 set(tempname,gangname);
if ( !StringCharCheck(tempname) || IsGangNameForbidden(tempname) )
  {
  SendPlayerFormattedText(leaderid,  lang_texts[271] , 0,COLOUR_RED);
  return 0;
 }
//Проверили имя банды на правильность


 // dini
 new dinifilename[MAX_STRING];
 format(dinifilename,sizeof(dinifilename),"%sGTO.Gang.%s.txt",GangDB,gangname);

 if (dini_Exists(dinifilename))
 {
 	SendClientMessage(leaderid,COLOUR_RED,  lang_texts[272] );
 	return 0;
 }
//Проверили что такой банды еще нет


 // Create the gang
 new gangid;
 for (new id=1;id<MAX_GANGS;id++)
 {
     if(!Gangs[id][gang_active])
     {
      gangid = id;
      Gangs[id][gang_active] = true; // find first free gang slot and andd our gang
      break;
  }
 }
//Присвоили новой банде новый ИД

//		format(tempstring, sizeof(tempstring), " ИД НОВОЙ БАНДЫ: %d (%s)" ,gangid,gangid);
//		SendPlayerFormattedText(leaderid, tempstring, 0,COLOUR_WHITE);

 set(Gangs[gangid][gang_name],gangname);
 Gangs[gangid][gang_colour] = gangcolour;
 Gangs[gangid][gang_kills] = 0;
 Gangs[gangid][gang_score] = 0;
 set(Gangs[gangid][gang_loginmessage],lang_texts[282]);
//Обнулили основные параметры



//ВОт тут начинается заполнение списка бандитов...

 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 { // foreach member
  GangMembers[gangid][gangmember] = GetFreeMemberID();
  new memberid = GangMembers[gangid][gangmember];
  if (memberid == 0)
  	{
   	WriteLog("script error: free gang member id not found.");
   	return 0;
  	}
  	GangMemberInfo[memberid][member_active] = 1;
  	GangMemberInfo[memberid][member_online] = 0;
   new dinistring[MAX_STRING];
   format(dinistring,sizeof(dinistring),"Member%d" ,gangmember);
   set(GangMemberInfo[memberid][member_name],dini_Get(dinifilename,dinistring));
  	GangMemberInfo[memberid][member_playerid] = INVALID_PLAYER_ID;
 }

 new memberid = GangMembers[gangid][0];
 set(GangMemberInfo[memberid][member_name],oGetPlayerName(leaderid));
 GangMemberInfo[memberid][member_playerid] = leaderid;
 GangMemberInfo[memberid][member_online] = 1;
 set(PlayerGangName[leaderid],gangname);
 PlayerGangid[leaderid] = gangid;
 SetPlayerColour(leaderid,Gangs[gangid][gang_colour]);

	if (strlen(Gangs[gangid][gang_loginmessage]))
		{
		format(tempstring, sizeof(tempstring), lang_texts[283] ,Gangs[gangid][gang_loginmessage]);
		SendPlayerFormattedText(leaderid, tempstring, 0,COLOUR_WHITE);
		}

 GangSave(gangid);

 return gangid;
}

public GangCleanup(gangid)
{
 if (!Gangs[gangid][gang_active]) return;

 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 { // foreach member of the gang

  new memberid = GangMembers[gangid][gangmember]; // get memberid
  if (GangMemberInfo[memberid][member_online])
  {
      if (GangMemberInfo[memberid][member_playerid] == INVALID_PLAYER_ID) return;
      if (!IsPlayerRegistered(GangMemberInfo[memberid][member_playerid]))
   {
    GangMemberLogout(GangMemberInfo[memberid][member_playerid],gangid);
    GangMemberInfo[memberid][member_online] = 0;
   }
  }
 }

 if (GangOnlineCount(gangid) == 0)
    {
        GangUnload(gangid);
 }
}

public GangSaveAll()
{
 for (new i = 1;i<MAX_GANGS;i++)
 {
  if (Gangs[i][gang_active])
  {
      GangSave(i);
      GangCleanup(i);
  }
 }

}

public GangMemberLogout(playerid,gangid)
{
 GangInvite[playerid] = 0;
 if (gangid == 0)
 {
  return;
 }
 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 { // foreach member of the gang
  new memberid = GangMembers[gangid][gangmember]; // get memberid
  if (GangMemberInfo[memberid][member_playerid] == playerid)
  {
   GangMemberInfo[memberid][member_online] = 0;
   GangMemberInfo[memberid][member_playerid] = INVALID_PLAYER_ID;
   break;
  }
 }
 if (GangOnlineCount(gangid) == 0)
 {
 	GangUnload(gangid);
 }
 else
 {
 	format(tempstring, sizeof(tempstring),  lang_texts[273] , oGetPlayerName(playerid));
 	SendGangMessage(gangid,tempstring,COLOUR_GANG);
 }
}

public GangSave(gangid)
{
 if (gangid == 0) return 0;
 if (!Gangs[gangid][gang_active]) return 0;
 if (!strlen(Gangs[gangid][gang_name])) return 0;
 gang_save_db_dini(gangid);
 return 1;
}

gang_save_db_dini(gangid)
{
 new gangname[MAX_STRING];
 set(gangname,Gangs[gangid][gang_name]);
 new dinifilename[MAX_STRING];
 format(dinifilename,sizeof(dinifilename),"%sGTO.Gang.%s.txt",GangDB,gangname);
 if (!dini_Exists(dinifilename))
 {
  	if (strlen(gangname) > 1) {dini_Create(dinifilename);}
 }

//new tempstring[MAX_STRING];
//format(tempstring,sizeof(tempstring),": %s :" ,lang_text[6][83]);
//if (!strlen(Gangs[gangid][gang_loginmessage])) set(Gangs[gangid][gang_loginmessage],tempstring);

 if (!strlen(Gangs[gangid][gang_loginmessage])) set(Gangs[gangid][gang_loginmessage],lang_texts[282]);

 new temp[MAX_STRING];

 dini_Set(dinifilename,"Name",gangname);

 valstr(temp,Gangs[gangid][gang_colour]);
 dini_Set(dinifilename,"Colour",temp);

 valstr(temp,Gangs[gangid][gang_kills]);
 dini_Set(dinifilename,"Kills",temp);

 valstr(temp,Gangs[gangid][gang_score]);
 dini_Set(dinifilename,"Score",temp);

// valstr(temp,Gangs[gangid][gang_loginmessage]);
// dini_Set(dinifilename,"Login_Message",temp);
 dini_Set(dinifilename,"Login_Message",Gangs[gangid][gang_loginmessage]);

 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 { // foreach member of the gang
  new tempname[MAX_STRING];
  format(tempname,sizeof(tempname),"Member%d",gangmember);
  new memberid = GangMembers[gangid][gangmember];
  dini_Set(dinifilename,tempname,GangMemberInfo[memberid][member_name]);
 }
}

public GangUnload(gangid)
{
 GangSave(gangid);

//MadCat Added
new dinifilename[MAX_STRING];
format(dinifilename,sizeof(dinifilename),"%sGTO.Gang.%s.txt",GangDB,Gangs[gangid][gang_name]);
//format(dinifilename,sizeof(dinifilename),"%s%s.txt",Gang_DB,Gangs[gangid][gang_name]);
if (IsGangFileEmpty(dinifilename))
	{ //No members in gang. remove file.
	if (dini_Exists(dinifilename))
		{ 
		dini_Remove(dinifilename);
		new logstring[MAX_STRING];
		format(logstring,MAX_STRING,"gang %s (%d) removed (no members in file)",Gangs[gangid][gang_name],gangid);
		WriteLog(logstring);
		}
	}
//

 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 { // foreach member
  new memberid = GangMembers[gangid][gangmember];
  GangMemberInfo[memberid][member_active] = 0;
  GangMemberInfo[memberid][member_online] = 0;
  GangMemberInfo[memberid][member_playerid] = INVALID_PLAYER_ID;
 }
 Gangs[gangid][gang_active] = 0;

}

public GangKill(gangid,killerid,victimid,reason)
{
 if (victimid != INVALID_PLAYER_ID)
 {
     Gangs[gangid][gang_kills]++;
 }
 if (PlayerGangid[killerid] == PlayerGangid[victimid])
    { // killed a gang member
  format(tempstring, sizeof(tempstring),  lang_texts[275] , oGetPlayerName(killerid));
  SendGangMessage(PlayerGangid[killerid],tempstring,COLOUR_GANG);
  return 1;
  }
 return 0;
}



public GangMemberLogin(playerid,gangid)
{
 	if (PlayerGangid[playerid] != 0)
 		{
  		PlayerGangid[playerid] = 0;
 		}
 	if (gangid == 0)
 		{
  		return 0;
 		}
 	for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 		{ // foreach member of the gang
  		new memberid = GangMembers[gangid][gangmember]; // get memberid

  		if (strcomp(GangMemberInfo[memberid][member_name],oGetPlayerName(playerid),false) == 1)
  			{
   			format(tempstring, sizeof(tempstring),  lang_texts[276] , oGetPlayerName(playerid));
   			SendGangMessage(gangid,tempstring,COLOUR_GANG);
   			GangMemberInfo[memberid][member_online] = 1;
   			GangMemberInfo[memberid][member_playerid] = playerid;
   			PlayerGangid[playerid] = gangid;
   			set(PlayerGangName[playerid],Gangs[gangid][gang_name]);

   			format(tempstring, sizeof(tempstring),  lang_texts[277] ,Gangs[gangid][gang_name],GangOnlineCount(gangid)-1);
   			SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_GANG);
   			GangInvite[playerid] = 0;
   			SetPlayerColour(playerid,Gangs[gangid][gang_colour]);
			
			if (strlen(Gangs[gangid][gang_loginmessage]))
				{
				format(tempstring, sizeof(tempstring), lang_texts[283] ,Gangs[gangid][gang_loginmessage]);
				SendPlayerFormattedText(playerid, tempstring, 0,COLOUR_GANG);
				}
   			return 1;
  			}
 		}
 	return 0;
}

public SendGangMessage(gangid,message[MAX_STRING],colour)
{
 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 { // foreach member of the gang
  new memberid = GangMembers[gangid][gangmember]; // get memberid
  if(GangMemberInfo[memberid][member_online]) SendPlayerFormattedText(GangMemberInfo[memberid][member_playerid], message, 0,colour);
 }
}

public GangOnlineCount(gangid)
{
 new memberscount;
 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 { // foreach member of the gang
  new memberid = GangMembers[gangid][gangmember]; // get memberid
  if (GangMemberInfo[memberid][member_online]) memberscount++;
 }
 return memberscount;
}

public GangGiveXP(gangid,xpamount,giverid)
{
 Gangs[gangid][gang_score] = Gangs[gangid][gang_score] + xpamount;
 new giveamount;
 giveamount = xpamount / GangOnlineCount(gangid);

 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 { // foreach member of the gang
  new memberid = GangMembers[gangid][gangmember]; // get memberid
  if((GangMemberInfo[memberid][member_online] == 1) && (giverid != GangMemberInfo[memberid][member_playerid]))
  {
	if (GetPlayerXP(GangMemberInfo[memberid][member_playerid]) < MAX_LVLXP) 
		{
		GivePlayerXP(GangMemberInfo[memberid][member_playerid],giveamount,0);
   		new string[MAX_STRING];
   		format(string, sizeof(string),  lang_texts[278] ,xpamount,oGetPlayerName(giverid));
   		SendPlayerFormattedText(GangMemberInfo[memberid][member_playerid], string, 0,COLOUR_XP_GOOD);
   		CheckPlayerLevel(GangMemberInfo[memberid][member_playerid]);
		} else {
			new string[MAX_STRING];
			format(string, sizeof(string),  lang_texts[356] );
			SendClientMessage(GangMemberInfo[memberid][member_playerid], COLOUR_RED, string);
			}
  }
 }
}


public SetGangColour(gangid,colour)
{
 Gangs[gangid][gang_colour] = colour;
 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 { // foreach member of the gang
  new memberid = GangMembers[gangid][gangmember]; // get memberid
  if(GangMemberInfo[memberid][member_online] == 1)
  {
   new playerid = GangMemberInfo[memberid][member_playerid];
   SetPlayerColour(playerid,colour);
  }
 }
}

stock IsGangFileEmpty(filename[])
{
if (!dini_Exists(filename)) return true;
new dinistring[MAX_STRING];
 for (new gangmember = 0;gangmember<MAX_GANG_SIZE;gangmember++)
 {
  format(dinistring,MAX_STRING,"Member%d" ,gangmember);
  if(strlen(dini_Get(filename,dinistring)) > 0) return false;
 }
return true;
}


