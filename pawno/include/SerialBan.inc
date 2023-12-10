////////////////// Serial Ban Sistemi YAPIMCI: Bilinmiyor ///////
////////////////// Paylaþým : by_h424n ///////////////////////

/*
	@title C-Serial
	@author Carlton
	@copyright (2010)
	
	@functions
	native SerialBanPlayer(playerid, BanPlayer=true);
        	native GetPlayerSerial(playerid);
	native RemoveSerialBan(serial[]);
	native IsPlayerSerialBanned(playerid);
	native OnPlayerSerialBanned(playerid);
	native AddSerialBan(serial[]);
*/
//=====================================
#define STORAGE_POSITION    	("SerialBans.txt")
#define SERIAL_SIZE   			(25)
#define FILE_SIZE               (516)
#define STR_SIZE                (90)
//=====================================
native gpci ( playerid, serial [ ], maxlen );
//=====================================
forward OnPlayerSerialBanned(playerid);
//=====================================
static
	File:SerialFile,
	PlayerSerial[SERIAL_SIZE],
	cserialstring[STR_SIZE],
	Bans[FILE_SIZE]
;
//=====================================
stock AddSerialBan(serial[]) {
    if(!fexist(STORAGE_POSITION)) return 0;
   	SerialFile = fopen(STORAGE_POSITION, io_append);
   	gpci(playerid, PlayerSerial, sizeof PlayerSerial);
 	format(cserialstring, sizeof cserialstring, "%s\r\n", PlayerSerial);

  	fwrite(SerialFile, cserialstring);
   	fclose(SerialFile);
}
stock GetPlayerSerial(playerid) {
        gpci(playerid, PlayerSerial, sizeof PlayerSerial);
 	return PlayerSerial;
}
stock SerialBanPlayer(playerid, BanPlayer=true) {
	if(!fexist(STORAGE_POSITION))
		SerialFile = fopen(STORAGE_POSITION, io_write);
	else
		SerialFile = fopen(STORAGE_POSITION, io_append);
	
	gpci(playerid, PlayerSerial, sizeof PlayerSerial);
 	format(cserialstring, sizeof cserialstring, "%s\r\n", PlayerSerial);
 	
  	fwrite(SerialFile, cserialstring);
   	fclose(SerialFile);
   	OnPlayerSerialBanned(playerid);
   	if(BanPlayer == true) return BanEx(playerid, "Serial Numaran Sunucu Tarafýndan Yasaklandý. N*h Girersin.!");
}
stock RemoveSerialBan(serial[]) {
    if(!fexist(STORAGE_POSITION)) return 0;
    
    SerialFile = fopen(STORAGE_POSITION, io_read);
	fread(SerialFile, Bans);
	fclose(SerialFile);
	
	strdel(Bans, strfind(Bans, serial), strlen(serial));
	fremove(STORAGE_POSITION);
	
	SerialFile = fopen(STORAGE_POSITION, io_write);
	fwrite(SerialFile, Bans);
   	fclose(SerialFile);
   	return 1;
}

stock IsPlayerSerialBanned(playerid) {
	if(!fexist(STORAGE_POSITION)) return 0;
	
 	gpci(playerid, PlayerSerial, sizeof PlayerSerial);
	SerialFile = fopen(STORAGE_POSITION, io_read);
	fread(SerialFile, Bans);
	fclose(SerialFile);
	
	if(strfind(Bans, PlayerSerial, true) != -1) return 1;
	return 0;
}
