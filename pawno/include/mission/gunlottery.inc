// GUN Lottery
//
//

#if defined _lottery_included
  #endinput
#endif

#define _littery_included
#pragma library lottery

#include "base"
#include "player"

forward Lottery();
public Lottery()
{
if (syslotto==1) {
new randr = random(20);
if (randr == 1)
	{
	new randid = random(MAX_PLAYERS);
	if (IsPlayerConnected(randid)) // && (PlayerGangid[randid] == 0))
		{
		if (Player[randid][Jailed] == 1) {return;}
		new randam = random(13)+22;
		new randpat = random(100)+60;
		
		if (randam == 34) {randam=33;}	//Если Снайперка, то просто Винтяль
		if (randam == 35) {randpat=1;}  //Если РПГ, то 1 патрон
		new string[MAX_STRING];
		format(string, sizeof(string), lang_texts[681], oGetWeaponName(randam), randam, randpat);
		SendClientMessage(randid, COLOUR_YELLOW, string);
		format(string, sizeof(string), lang_texts[682],oGetPlayerName(randid), randid, oGetWeaponName(randam), randam);
		SendClientMessageToAll(COLOUR_LIGHTRED, string);
		PlaySoundForPlayer(randid, 1083);
		GivePlayerWeapon(randid,randam,randpat);
		printf("[ LOTTERY ]: %s has win Ammo ID %d and %d amounts with him", oGetPlayerName(randid), randam, randpat);
		}
	}
	else if (randr == 2)
	{
	new randid = random(MAX_PLAYERS);
	if (IsPlayerConnected(randid))
		{
		if (Player[randid][Jailed] == 1) {return;}
		new string[MAX_STRING];
		format(string, sizeof(string), lang_texts[683]);
		SendClientMessage(randid, COLOUR_YELLOW, string);
//		format(string, sizeof(string), lang_texts[684], oGetPlayerName(randid), randid);
//		SendClientMessageToAll(COLOUR_LIGHTRED, string);
		PlaySoundForPlayer(randid, 1190);
		PlaySoundForPlayer(randid, 1101);
		SetPlayerArmour(randid,100);
		printf("[ LOTTERY ]: %s has won 100 Armour",oGetPlayerName(randid));
		}
	}
	else if (randr == 3)
	{
	new randid = random(MAX_PLAYERS);
	if (IsPlayerConnected(randid))
		{
		if (Player[randid][Jailed] == 1) {return;}

		new randmoney = (random(6789)*(random(10)+1));
		new string[MAX_STRING];
		format(string, sizeof(string), lang_texts[685], randmoney);
		SendClientMessage(randid, COLOUR_YELLOW, string);

		if (randmoney>700)
		{
		format(string, sizeof(string), lang_texts[686],oGetPlayerName(randid), randid, randmoney);
		SendClientMessageToAll(COLOUR_LIGHTRED, string);
		}
		oSetPlayerMoney(randid,Player[randid][Money] + randmoney);
		PlaySoundForPlayer(randid, 1190);
		PlaySoundForPlayer(randid, 1101);

//		GetPlayerMoney(randid,randmoney);
		printf("[ LOTTERY ]: %s has won $%d Money",oGetPlayerName(randid),randmoney);
		}
	}

	else if (randr == 4)
	{
	new randid = random(MAX_PLAYERS);
	if (IsPlayerConnected(randid))
		{
		if (Player[randid][Jailed] == 1) {return;}
		if (Player[randid][Money] > 1700000) {return;}
		new string[MAX_STRING];
		format(string, sizeof(string), lang_texts[687]);
		SendClientMessage(randid, COLOUR_YELLOW, string);

		if ( (GetPlayerMoney(randid)*2) < MAX_MONEY )
		{
		oSetPlayerMoney(randid, (Player[randid][Money]*2));
		} else  {
			oSetPlayerMoney(randid,MAX_MONEY );
			}
		if (GetPlayerMoney(randid) > 3000)
		{
		format(string, sizeof(string), lang_texts[688],oGetPlayerName(randid), randid, GetPlayerMoney(randid));
		SendClientMessageToAll(COLOUR_LIGHTRED, string);
		}

		PlaySoundForPlayer(randid, 1190);
		PlaySoundForPlayer(randid, 1101);
		PlaySoundForPlayer(randid, 1190);
		PlaySoundForPlayer(randid, 1101);
		printf("[ LOTTERY ]: %s has won SUPERBONUS",oGetPlayerName(randid));
		}
	}



} //SYSLOTTO==1
}
