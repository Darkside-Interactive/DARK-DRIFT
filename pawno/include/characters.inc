/*
*	Created:			08.01.10
*	Author:				009
*	Last Modifed:		-
*/

#if defined _charaters_included
	#endinput
#endif

#define _charaters_included
#pragma library characters

// --------------------------------------------------
// includes
// --------------------------------------------------

// --------------------------------------------------
// defines
// --------------------------------------------------

// --------------------------------------------------
// enums
// --------------------------------------------------
enum CharactersPlayerInfo {
	bool:pInCharacter
};

// --------------------------------------------------
// news
// --------------------------------------------------
static
	Characters_Player[MAX_PLAYERS][CharactersPlayerInfo],
	char_name_tmp[MAX_PLAYER_NAME];

// --------------------------------------------------
// natives list (for pawno functions list)
// --------------------------------------------------
/*
native oGetCharacterName(playerid);
native GetCharacterVarInt(playerid,varname[]);
native SetCharacterVarInt(playerid,varname[],value);
native Float:GetCharacterVarFloat(playerid,varname[]);
native SetCharacterVarFloat(playerid,varname[],Float:value);
native GetCharacterVarString(playerid,varname[]);
native SetCharacterVarString(playerid,varname[],value[]);
*/

// --------------------------------------------------
// stocks
// --------------------------------------------------
stock oGetCharacterName(playerid)
{
	Debug(DEBUG_START,"oGetCharacterName(%d)",playerid);
	nullstr(char_name_tmp);
	if(!IsPlayerConnected(playerid))
	{
		Debug(DEBUG_END,"oGetCharacterName(reason: error)");
		printf("[ERROR] Characters -> oGetCharacterName (invalid player - %d)",playerid);
		return char_name_tmp;
	}
	if(Characters_Player[playerid][pInCharacter] == false)
	{
		Debug(DEBUG_END,"oGetCharacterName(reason: error)");
		printf("[ERROR] Characters -> oGetCharacterName (player not in character ,player - %d)",playerid);
		return char_name_tmp;
	}
	GetPlayerName(playerid,char_name_tmp,sizeof(char_name_tmp));
	Debug(DEBUG_END,"oGetCharacterName(reason: complete)");
	return char_name_tmp;
}

stock GetCharacterVarInt(playerid,varname[])
{
	Debug(DEBUG_START,"GetCharacterVarInt(%d,'%s')",playerid,varname);
	if(!IsPlayerConnected(playerid))
	{
		Debug(DEBUG_END,"GetCharacterVarInt(reason: error)");
		printf("[ERROR] Characters -> GetCharacterVarInt (invalid player - %d)",playerid);
		return 0;
	}
	if(Characters_Player[playerid][pInCharacter] == false)
	{
		Debug(DEBUG_END,"GetCharacterVarInt(reason: error)");
		printf("[ERROR] Characters -> GetCharacterVarInt (player not in character ,player - %d)",playerid);
		return 0;
	}
	GetPlayerName(playerid,char_name_tmp,sizeof(char_name_tmp));
	Debug(DEBUG_ACTION,"Get var by name '%s'",char_name_tmp);
	format(query,sizeof(query),"SELECT `%s` FROM `Characters` WHERE `Name`='%s'",varname,char_name_tmp);
	samp_mysql_query(query);
	samp_mysql_store_result();
	samp_mysql_fetch_row(result);
	Debug(DEBUG_END,"GetCharacterVarInt(reason: complete)");
	return strval(result);
}

stock SetCharacterVarInt(playerid,varname[],value)
{
	Debug(DEBUG_START,"SetCharacterVarInt(%d,'%s',%d)",playerid,varname,value);
	if(!IsPlayerConnected(playerid))
	{
		Debug(DEBUG_END,"SetCharacterVarInt(reason: error)");
		printf("[ERROR] Characters -> SetCharacterVarInt (invalid player - %d)",playerid);
		return 0;
	}
	if(Characters_Player[playerid][pInCharacter] == false)
	{
		Debug(DEBUG_END,"SetCharacterVarInt(reason: error)");
		printf("[ERROR] Characters -> SetCharacterVarInt (player not in character ,player - %d)",playerid);
		return 0;
	}
	GetPlayerName(playerid,char_name_tmp,sizeof(char_name_tmp));
	Debug(DEBUG_ACTION,"Get var by name '%s'",char_name_tmp);
	format(query,sizeof(query),"UPDATE `Characters` SET `%s`='%d' WHERE `Name`='%s'",varname,value,char_name_tmp);
	samp_mysql_query(query);
	Debug(DEBUG_END,"SetCharacterVarInt(reason: complete)");
	return 1;
}

stock Float:GetCharacterVarFloat(playerid,varname[])
{
	Debug(DEBUG_START,"GetCharacterVarFloat(%d,'%s')",playerid,varname);
	if(!IsPlayerConnected(playerid))
	{
		Debug(DEBUG_END,"GetCharacterVarFloat(reason: error)");
		printf("[ERROR] Characters -> GetCharacterVarFloat (invalid player - %d)",playerid);
		return 0.0;
	}
	if(Characters_Player[playerid][pInCharacter] == false)
	{
		Debug(DEBUG_END,"GetCharacterVarFloat(reason: error)");
		printf("[ERROR] Characters -> GetCharacterVarFloat (player not in character ,player - %d)",playerid);
		return 0.0;
	}
	GetPlayerName(playerid,char_name_tmp,sizeof(char_name_tmp));
	Debug(DEBUG_ACTION,"Get var by name '%s'",char_name_tmp);
	format(query,sizeof(query),"SELECT `%s` FROM `Characters` WHERE `Name`='%s'",varname,char_name_tmp);
	samp_mysql_query(query);
	samp_mysql_store_result();
	samp_mysql_fetch_row(result);
	Debug(DEBUG_END,"GetCharacterVarFloat(reason: complete)");
	return floatstr(result);
}

stock SetCharacterVarFloat(playerid,varname[],Float:value)
{
	Debug(DEBUG_START,"SetCharacterVarFloat(%d,'%s',%f)",playerid,varname,value);
	if(!IsPlayerConnected(playerid))
	{
		Debug(DEBUG_END,"SetCharacterVarFloat(reason: error)");
		printf("[ERROR] Characters -> SetCharacterVarFloat (invalid player - %d)",playerid);
		return 0;
	}
	if(Characters_Player[playerid][pInCharacter] == false)
	{
		Debug(DEBUG_END,"SetCharacterVarFloat(reason: error)");
		printf("[ERROR] Characters -> SetCharacterVarFloat (player not in character ,player - %d)",playerid);
		return 0;
	}
	GetPlayerName(playerid,char_name_tmp,sizeof(char_name_tmp));
	Debug(DEBUG_ACTION,"Get var by name '%s'",char_name_tmp);
	format(query,sizeof(query),"UPDATE `Characters` SET `%s`='%f' WHERE `Name`='%s'",varname,value,char_name_tmp);
	samp_mysql_query(query);
	Debug(DEBUG_END,"SetCharacterVarFloat(reason: complete)");
	return 1;
}

stock GetCharacterVarString(playerid,varname[])
{
	Debug(DEBUG_START,"GetCharacterVarString(%d,'%s')",playerid,varname);
	nullstr(result);
	if(!IsPlayerConnected(playerid))
	{
		Debug(DEBUG_END,"GetCharacterVarString(reason: error)");
		printf("[ERROR] Characters -> GetCharacterVarString (invalid player - %d)",playerid);
		return result;
	}
	if(Characters_Player[playerid][pInCharacter] == false)
	{
		Debug(DEBUG_END,"GetCharacterVarString(reason: error)");
		printf("[ERROR] Characters -> GetCharacterVarString (player not in character ,player - %d)",playerid);
		return result;
	}
	GetPlayerName(playerid,char_name_tmp,sizeof(char_name_tmp));
	Debug(DEBUG_ACTION,"Get var by name '%s'",char_name_tmp);
	format(query,sizeof(query),"SELECT `%s` FROM `Characters` WHERE `Name`='%s'",varname,char_name_tmp);
	samp_mysql_query(query);
	samp_mysql_store_result();
	samp_mysql_fetch_row(result);
	Debug(DEBUG_END,"GetCharacterVarString(reason: complete)");
	return result;
}

stock SetCharacterVarString(playerid,varname[],value[])
{
	Debug(DEBUG_START,"SetCharacterVarString(%d,'%s','%s')",playerid,varname,value);
	if(!IsPlayerConnected(playerid))
	{
		Debug(DEBUG_END,"SetCharacterVarString(reason: error)");
		printf("[ERROR] Characters -> SetCharacterVarString (invalid player - %d)",playerid);
		return 0;
	}
	if(Characters_Player[playerid][pInCharacter] == false)
	{
		Debug(DEBUG_END,"SetCharacterVarString(reason: error)");
		printf("[ERROR] Characters -> SetCharacterVarString (player not in character ,player - %d)",playerid);
		return 0;
	}
	GetPlayerName(playerid,char_name_tmp,sizeof(char_name_tmp));
	Debug(DEBUG_ACTION,"Get var by name '%s'",char_name_tmp);
	format(query,sizeof(query),"UPDATE `Characters` SET `%s`='%s' WHERE `Name`='%s'",varname,value,char_name_tmp);
	samp_mysql_query(query);
	Debug(DEBUG_END,"SetCharacterVarString(reason: complete)");
	return 1;
}