#include <a_samp>
new wantkiss[MAX_PLAYERS]; 
new wantsex[MAX_PLAYERS];
public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256], idx, tmp[30];
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/kiss", true) == 0)
	{
		new
			PlayerName[30],
			string[256]
		;
		tmp = strtok(cmdtext, idx);
		new otherplayer = strval(tmp);
		if(GetDistanceBetweenPlayers(playerid, otherplayer) > 2) return SendClientMessage(playerid, 0xFF0000AA, "Вы слишком далеко!");
		if(IsSkinFemale(otherplayer) && !IsSkinFemale(playerid))
		{
			wantkiss[playerid] = 1;
			wantkiss[otherplayer] = 1;
			GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
			format(string, sizeof(string), "Игрок %s предлагает вам поцеловаться. (/accpoc [id] - принять, /dispoc [id] - отказать)",PlayerName);
			SendClientMessage(otherplayer, 0xFFFF00AA, string);
		}
		else return SendClientMessage(playerid, 0xFF0000AA, "Ваш оппонент такого же пола!");
		return 1;
	}
	if(strcmp(cmd, "/acckiss", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		new otherplayer = strval(tmp);
		if(wantkiss[playerid] == 0 || wantkiss[otherplayer] == 0) return SendClientMessage(playerid, 0x00FF00AA, "Вам не предлагали целоваться!");
		if(GetDistanceBetweenPlayers(playerid, otherplayer) > 2) return SendClientMessage(playerid, 0xFF0000AA, "Вы слишком далеко!");
		SendClientMessage(playerid, 0x00FF00AA, " Вы поцеловались!");
		SendClientMessage(otherplayer, 0x00FF00AA, "Вы поцеловались!");
		wantkiss[playerid] = 0;
		ApplyAnimation(otherplayer, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 1, 1, 1, 1, 1);
		ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 1, 1, 1, 1, 1);
		wantkiss[otherplayer] = 0;
		return 1;
	}
	if(strcmp(cmd, "/dispoc", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		new otherplayer = strval(tmp);
		if(GetDistanceBetweenPlayers(playerid, otherplayer) > 2) return SendClientMessage(playerid, 0xFF0000AA, "Вы слишком далеко!");
		if(wantkiss[playerid] == 0 || wantkiss[otherplayer] == 0) return SendClientMessage(playerid, 0x00FF00AA, "Вам не предлагали целоваться!");
		SendClientMessage(playerid, 0xFF0000AA, "Вы отказались поцеловаться!");
		SendClientMessage(otherplayer, 0x00FF00AA, "С вами отказались поцеловаться!");
		wantkiss[playerid] = 0;
		wantkiss[otherplayer] = 0;
		return 1;
	}
	if(strcmp(cmd, "/iznas", true) == 0)
	{
		tmp = strtok(cmdtext,idx);
		new otherplayer = strval(tmp);
		if(GetDistanceBetweenPlayers(playerid, otherplayer) > 2) return SendClientMessage(playerid, 0xFF0000AA, "Вы слишком далеко!");
		if(IsSkinFemale(otherplayer))
		{
			SendClientMessage(playerid, 0xFF0000AA, "Вы изнасиловали игрока!");
			SendClientMessage(otherplayer, 0x00FF00AA, "Вас изнасиловали!");
			LoopingAnim(otherplayer, "SNM", "SPANKINGW", 4.1, 0, 1, 1, 1, 1, 1);
			LoopingAnim(playerid, "SNM", "SPANKEDW", 4.1, 0, 1, 1, 1, 1, 1);
		}
		else return SendClientMessage(playerid, 0xFF0000AA, "Ваш оппонент такого же пола!");
		return 1;
	}
	if(strcmp(cmd, "/sexon", true) == 0)
	{
	    new
			PlayerName[MAX_PLAYER_NAME],
			string[128]
		;
		tmp = strtok(cmdtext,idx);
		new otherplayer = strval(tmp);
		if(GetDistanceBetweenPlayers(playerid, otherplayer) > 2) return SendClientMessage(playerid, 0xFF0000AA, "Вы слишком далеко!");
		if(IsSkinFemale(otherplayer))
		{
			wantsex[playerid] = 1;
			wantsex[otherplayer] = 1;
			GetPlayerName(playerid,PlayerName,sizeof(PlayerName));
			format(string, sizeof(string), "Игрок %s предлагает вам заняться сексом. (/accsex [id] - принять, /dissex [id] - отказать)",PlayerName);
			SendClientMessage(otherplayer, 0xFFFF00AA, string);
		}
		else return SendClientMessage(playerid, 0xFF0000AA, "Ваш оппонент такого же пола!");
		return 1;
	}
	if(strcmp(cmd, "/accsex", true) == 0)
	{
		tmp = strtok(cmdtext,idx);
		new otherplayer = strval(tmp);
		if(wantsex[playerid] == 0 || wantsex[otherplayer] == 0) return SendClientMessage(playerid, 0x00FF00AA, "Вам не предлагали заняться сексом!");
		if(GetDistanceBetweenPlayers(playerid, otherplayer) > 2) return SendClientMessage(playerid, 0xFF0000AA, "Вы слишком далеко!");
		{
			SendClientMessage(playerid, 0x00FF00AA, "Вы занялись сексом!");
			SendClientMessage(otherplayer, 0x00FF00AA, "Вы занялись сексом!");
			wantsex[playerid] = 0;
			wantsex[otherplayer] = 0;
			ApplyAnimation(otherplayer, "SNM", "SPANKING_IDLEW", 4.1, 0, 1, 1, 1, 1, 1);
			LoopingAnim(playerid, "SNM", "SPANKINGP", 4.1, 0, 1, 1, 1, 1, 1);
		}
		return 1;
	}
	if(strcmp(cmd, "/dissex ", true) == 0)
	{
		tmp = strtok(cmdtext,idx);
		new otherplayer = strval(tmp);
		if(wantsex[playerid] == 0 || wantsex[otherplayer] == 0) return SendClientMessage(playerid, 0x00FF00AA, "Вам не предлагали заняться сексом!");
		if(GetDistanceBetweenPlayers(playerid, otherplayer) > 2) return SendClientMessage(playerid, 0xFF0000AA, "Вы слишком далеко!");
		SendClientMessage(playerid, 0xFF0000AA, "Вы отказались заняться сексом!");
		SendClientMessage(otherplayer, 0x00FF00AA, "С вами отказались заняться сексом!");
		wantsex[playerid] = 0;
		wantsex[otherplayer] = 0;
		return 1;
	}
	return 0;
}
LoopingAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp, sync)
{
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp, sync);
}
stock GetDistanceBetweenPlayers(playerid, playerid2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerPos(playerid2,x2,y2,z2);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(tmpdis);
}
stock IsSkinFemale(skinid)
{
	new Skins[] = {
	9, 10, 11, 12, 13, 31, 39, 40, 41, 54, 55,
	56, 63, 64, 69, 75, 76, 77, 85, 86, 87,
	88, 89, 90, 92, 93, 129, 130, 131, 138,
	140, 141, 145, 148, 150, 151, 152, 157,
	169, 172, 178, 190, 191, 192, 193, 194,
	195, 196, 197, 198, 199, 201, 205, 207,
	211, 214, 215, 216, 218, 219, 224, 225,
	226, 231, 232, 233, 237, 238, 243, 244,
	245, 246, 251, 256, 257, 263, 298
	};
	for(new i = 0; i < sizeof(Skins); i++)
	{
		if(skinid == i) return 1;
	}
	#pragma unused Skins
return 0;
}
strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' ')) index++;
	new offset = index, result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
