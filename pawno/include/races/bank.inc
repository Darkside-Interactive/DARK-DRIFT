//
// Created:     17.09.06
// Aurthor:    Iain Gilbert
//


#if defined _bank_included
#endinput
#endif

#define _bank_included
#pragma library bank
#include "base"
#include "player"

forward BankInit();
forward IsPlayerAtBank(playerid);
forward OnPlayerEnterBankCheckpoint(playerid);
forward BankCommandHandler(playerid,text[]);

#define MAX_BANK 2000000000
#define BanksCount 4

new Banks[BanksCount][CoordInfo] = {
	{-22.9578,-54.8951,1003.5469}, // LV 24/7 bank
	{371.2316,-125.5778,1001.4995}, // LS pizza bank
	{368.7201,-72.7097,1001.5078}, // LS burger bank7
	{364.9761,-8.5396,1001.8516} // LS chicken bank5
}; 

public BankInit()
{
	for (new bankid=0;bankid<BanksCount;bankid++)
	{
		AddActiveCheckpoint(Banks[bankid][Coord_X],Banks[bankid][Coord_Y],Banks[bankid][Coord_Z],20,2);
		CreateStreamMapIcon(52,Banks[bankid][Coord_X], Banks[bankid][Coord_Y], Banks[bankid][Coord_Z]);
	}
	WriteLog("Banking checkpoints initialised");
}

public IsPlayerAtBank(playerid)
{
	for (new bankid=0;bankid<BanksCount;bankid++)
	{
		if (oIsPlayerInCheckpoint(playerid,Banks[bankid][Coord_X],Banks[bankid][Coord_Y],Banks[bankid][Coord_Z],10))
		{
			return 1;
		}
	}
	return 0;
}

public OnPlayerEnterBankCheckpoint(playerid)
{
	if (playerid == INVALID_PLAYER_ID) return;
	if (!IsPlayerConnected(playerid)) return;
	if (!IsPlayerAtBank(playerid)) return;
	SendPlayerFormattedText(playerid,  lang_texts[34]  , 0,COLOUR_YELLOW);
	SendPlayerFormattedText(playerid,  lang_texts[35]  , Player[playerid][Bank],COLOUR_YELLOW);
}



public BankCommandHandler(playerid,text[]) // process player commands
{
	if (!IsPlayerConnected(playerid)) return 0;

	new cmd[20];
	new idx;

	set(cmd,strcharsplit(text, idx,strchar(" ")));
	if (strlen(cmd) == 0) return 0;

	if(strcomp(cmd, "/withdraw", true) == 1)
	{
		if (!IsPlayerAtBank(playerid))
		{
			SendPlayerFormattedText(playerid,  lang_texts[36]  , 0,COLOUR_YELLOW);
			return 1;
		}
		
		set(cmd,strcharsplit(text, idx,strchar(" ")));
		if (strlen(cmd) == 0)
		{
			SendPlayerFormattedText(playerid,  lang_texts[37]  , 0,COLOUR_YELLOW);
			return 1;
		}
		new amount = strval(cmd);
		if (amount <= 0)
		{
			SendPlayerFormattedText(playerid,  lang_texts[38]  , 0,COLOUR_YELLOW);
			return 1;
		}
		if (amount > Player[playerid][Bank])
		{
			amount = Player[playerid][Bank];
		}

		oGivePlayerMoney(playerid,amount,0);
		Player[playerid][Bank] = Player[playerid][Bank] - amount;
		new string[MAX_STRING];
		format(string,sizeof(string), lang_texts[39]  ,amount,Player[playerid][Bank]);
		SendPlayerFormattedText(playerid, string,0,COLOUR_YELLOW);
		PlaySoundForPlayer(playerid,1084);

		new logstring[256];
		format(logstring, sizeof (logstring), "player: %d:  %s: withdrawed $%d from the bank. Current balance: $%d ",playerid,oGetPlayerName(playerid),amount,Player[playerid][Bank]);
		WriteLog(logstring);

		return 1;
	}


	if((strcomp(cmd, "/bank", true) == 1) || (strcomp(cmd, "/deposit", true) == 1))
	{
		if (!IsPlayerAtBank(playerid))
		{
			SendPlayerFormattedText(playerid,  lang_texts[40]  , 0,COLOUR_YELLOW);
			return 1;
		}

		set(cmd,strcharsplit(text, idx,strchar(" ")));
		if (strlen(cmd) == 0)
		{
			SendPlayerFormattedText(playerid,  lang_texts[41]  , 0,COLOUR_YELLOW);
			return 1;
		}
		new amount = strval(cmd);
		if (amount <= 0)
		{
			SendPlayerFormattedText(playerid,  lang_texts[42]  , 0,COLOUR_YELLOW);
			return 1;
		}
		if (oGetPlayerMoney(playerid) < amount)
		{
			amount = oGetPlayerMoney(playerid);
		}
		if (Player[playerid][Bank] + amount > MAX_BANK)
		{
			amount = MAX_BANK - Player[playerid][Bank];
		}
		oGivePlayerMoney(playerid,0 - amount,0);
		Player[playerid][Bank] = Player[playerid][Bank] + amount;
		new string[MAX_STRING];
		format(string,sizeof(string), lang_texts[43]  ,amount,Player[playerid][Bank]);
		SendPlayerFormattedText(playerid, string,0,COLOUR_GREEN);
		PlaySoundForPlayer(playerid,1083);

		new logstring[256];
		format(logstring, sizeof (logstring), "player: %d:  %s: deposited $%d at the bank. Current balance: $%d ",playerid,oGetPlayerName(playerid),amount,Player[playerid][Bank]);
		WriteLog(logstring);

		if (Player[playerid][Bank] == MAX_BANK)
		{
			SendPlayerFormattedText(playerid,  lang_texts[44]  , 0,COLOUR_RED);
			set(logstring,nullstr);
			format(logstring, sizeof (logstring), "player: %d:  %s: His bank is full",playerid,oGetPlayerName(playerid));
			WriteLog(logstring);
		}
		return 1;
	}
	return 0;
}

