#if defined _maccer_anticheat_included
	#endinput
#endif
#define _maccer_anticheat_included

#define	MAX_MONEY_ADDS_IGNORE	(1)        	// ������������ ���������, ��� ��� ����� ���� �������� �� ����
#define	MAX_MONEY_ADDS			(90)      	// ���� ���-�� ����� ������� ����� �������� � ������
#define MONEY_BAN_LEVEL			(100000)		// ������ ���� ���� �������� ������ MONEY_BAN_LEVEL
#define MAX_TRIALS        		(5)             // ������ MAX_TRIALS ��� ������
#define	UPDATE_INTERVAL			(10)      	// �������� ��������, ��� ���� - ��� �����
#define	CHEATERS_LOG_FILE		"cheaters.log"  // ��� ����

new PlayerMoney[MAX_PLAYERS];
new CheatTrial[MAX_PLAYERS];
new anticheattimerid;

forward ___OnGameModeInit();
forward ___OnGameModeExit();
forward ___OnPlayerConnect(playerid);
forward PlayersMoneyUpdate();

GetWelcomeMoney(playerid){
	return PlayerMoney[playerid];
}

GiveWelcomerMoney(playerid, money){
	PlayerMoney[playerid] += money;
	GivePlayerMoney(playerid,PlayerMoney[playerid]-GetPlayerMoney(playerid));
}
ResetWelcomeMoney(playerid){
	PlayerMoney[playerid] = 0;
	ResetPlayerMoney(playerid);
}
_CheateLog(playerid, startmoney, endmoney, isdeleted)
{
	new CheatLogStr[256];
	new PlName[MAX_PLAYER_NAME];
	new IpStr[16];
	GetPlayerName(playerid, PlName, sizeof(PlName));
	GetPlayerIp(playerid, IpStr, sizeof(IpStr));
	format(CheatLogStr, sizeof(CheatLogStr), " %s[%d](%s): ���� %d ����� %d (+$%d)",
	PlName, playerid, IpStr, startmoney, endmoney, endmoney-startmoney);
	if(isdeleted) format(CheatLogStr, sizeof(CheatLogStr), "%s <=", CheatLogStr);
	for(new i=0;i<MAX_PLAYERS;i++)	if(IsPlayerAdmin(i))	SendClientMessage(i, 0xFFFF00AA, CheatLogStr);
	format(CheatLogStr, sizeof(CheatLogStr), "%s\n", CheatLogStr);
	new File:file=fopen(CHEATERS_LOG_FILE, io_append);
	fwrite(file, CheatLogStr);
	fclose(file);
}
_BanLog(playerid)
{
	new BanLogStr[256];
	new PlName[MAX_PLAYER_NAME];
	new IpStr[16];
	GetPlayerName(playerid, PlName, sizeof(PlName));
	GetPlayerIp(playerid, IpStr, sizeof(IpStr));
	format(BanLogStr, sizeof(BanLogStr), " %s[%d](%s) ������� �� ���� (�������� ���)", PlName, playerid, IpStr);
	for(new i=0;i<MAX_PLAYERS;i++)	if(IsPlayerAdmin(i))	SendClientMessage(i, 0xAA3333AA, BanLogStr);
	format(BanLogStr, sizeof(BanLogStr), "%s\n", BanLogStr);
	new File:file=fopen(CHEATERS_LOG_FILE, io_append);
	fwrite(file, BanLogStr);
	fclose(file);
}
UpdateGameMoney(playerid){
	new gamemoney = GetPlayerMoney(playerid);
	if(gamemoney < PlayerMoney[playerid])
	{
	    PlayerMoney[playerid] = gamemoney;
	    return;
	}
	if(gamemoney > PlayerMoney[playerid])
	{
	    if( gamemoney-PlayerMoney[playerid] < MAX_MONEY_ADDS_IGNORE ){
	        return;
	    }
	    if(gamemoney - PlayerMoney[playerid] > MAX_MONEY_ADDS){
	        _CheateLog(playerid, PlayerMoney[playerid], gamemoney, 1);
	        if(gamemoney - PlayerMoney[playerid] > MONEY_BAN_LEVEL){
	            CheatTrial[playerid]++;
	        }
	        if(CheatTrial[playerid] > MAX_TRIALS){
	            _BanLog(playerid);
				Ban(playerid);
	            CheatTrial[playerid]=0;
	        }
	        GivePlayerMoney(playerid, PlayerMoney[playerid] - gamemoney);
	    }
	    else{
	        _CheateLog(playerid, PlayerMoney[playerid], gamemoney, 0);
	        PlayerMoney[playerid] = gamemoney;
	    }
	}
}

public PlayersMoneyUpdate(){
	for(new i=0;i<MAX_PLAYERS;i++){
	    if(IsPlayerConnected(i)){
			UpdateGameMoney(i);
	    }
	}
}

public OnGameModeInit()
{
	anticheattimerid = SetTimer("PlayersMoneyUpdate", UPDATE_INTERVAL, 1);
	return CallLocalFunction("___OnGameModeInit","");
}

public OnGameModeExit()
{
	KillTimer(anticheattimerid);
	return CallLocalFunction("___OnGameModeExit","");
}

public OnPlayerConnect(playerid)
{
	CheatTrial[playerid] = 0;
	PlayerMoney[playerid] = 0;
	return CallLocalFunction("___OnPlayerConnect","i",playerid);
}

#define GetPlayerMoney(%1) (GetWelcomeMoney(%1))
#define GivePlayerMoney(%1,%2) (GiveWelcomerMoney(%1,%2))
#define ResetPlayerMoney(%1) (ResetWelcomeMoney(%1))

#define OnGameModeInit() ___OnGameModeInit()
#define OnGameModeExit() ___OnGameModeExit()
#define OnPlayerConnect(%1) ___OnPlayerConnect(%1)
