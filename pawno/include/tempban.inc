//Temporary ban system
//Created by d.wine
//Converted for GTO by MadCat

forward BanCheck();
forward TempBan_OnGameModeInit();
forward BanPlayer(playerid,days,reason[]);

public TempBan_OnGameModeInit(){

	SetTimer("BanCheck",900000,1);//15 mins
	WriteLog("Temporary ban system loaded");
	return 0;
}

public BanPlayer(playerid,days,reason[])
{
	if (days < 1) return;
	if (!IsPlayerConnected(playerid)) return;
	new string[MAX_STRING];
	if (!strlen(reason)) set (reason,lang_texts[714]);
	
	format(string,sizeof(string),lang_texts[712],days,reason);
	SendClientMessage(playerid,COLOUR_RED,string);
	format(string,sizeof(string),lang_texts[713],oGetPlayerName(playerid),days,reason);
	SendClientMessageToRegistered(COLOUR_YELLOW,string);
	new File:bans;
	bans=fopen(BansDB, io_append);
	new unban = Now() + floatround(days*86400);
	new entry[MAX_STRING];
	new playerip[50]; GetPlayerIp(playerid, playerip, 50);
	format(entry,MAX_STRING,"%d %s %s %s", unban, playerip, oGetPlayerName(playerid), reason);
	fwrite(bans, entry);
	fwrite(bans, "\r\n");
	fclose(bans);
	BanEx(playerid,reason);

	return;
}

public BanCheck()
{
new mtime=Now();
new unset[100];
new cntset = 0;

new File: file = fopen(BansDB, io_read);
if (file)
{
	new Data[256], key[256], ip[256];
	while (fread(file, Data, sizeof(Data) ))
	{
	new idx;
	StripNewLine(Data);
	if (strlen(Data)!=0)
	{
		key = strtok( Data, idx);
		if(strval(key) <= mtime) {
			ip = strtok( Data, idx );
			Unban(ip);
			unset[cntset]=strval(key);
			cntset++;
		}
	}
	}
	fclose(file);
	for (new i=0;i<cntset;i++)
	{
	Unset(BansDB,unset[i]);
	}
}
}

Unban(ip[])
{
new string[64];
format(string, 64, "unbanip %s", ip);
SendRconCommand(string);
new logstring[MAX_STRING];
format(logstring,MAX_STRING,"%s unbanned", ip);
WriteLog(logstring);
}

stock Unset(filename[],key) { //modified dini_Unset
	new File:fohnd, File:fwhnd;
	new tmpres[256];
	new data[256];
	format(tmpres,sizeof(tmpres),"%s.part",filename);
	fohnd=fopen(filename,io_read);
	if (fexist(tmpres)) fremove(tmpres);
	fwhnd=fopen(tmpres,io_write);
	while (fread(fohnd,tmpres))
	{
		StripNewLine(tmpres);
		new idx;
		data = strtok(tmpres,idx);
		if ((strlen(data)!=0) && (strval(data)!=key)) {
			format(tmpres,sizeof(tmpres),"%s\r\n",tmpres);
			fwrite(fwhnd,tmpres);
		}
	}
	fclose(fohnd);
	fclose(fwhnd);
	format(tmpres,sizeof(tmpres),"%s.part",filename);
	if (fcopytextfile(tmpres,filename)) {
		return fremove(tmpres);
	}
	return false;
}