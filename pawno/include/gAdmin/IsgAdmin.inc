/*
 $ Latest Update :			 1/ 6/ 2008
 $ gAdmin by :				Goldkiller (gta-goldkiller@web.de)
 $ DINI,Dudb & DUtils :	 	Dracoblue
 $ YSI Itter                Y_less (Alex)
 $ gAdmin Version :			0.8a
 $ Supported SAMP Version:  0.2.2
 $ Languages :              English / German
 $ Usefull Functions :      Simon,breadfish,dracoblue,Sacky,Smuggler,Unnamend,Luby,Y_Less,Iain Gilbert,
 $ IRC Plugin :            	http://forum.sa-mp.com/index.php?topic=22354.0 by Jacob
 $ Visit :                  www.san-vice.de.vu
*/

#if defined _gAdmin_included
	#endinput
#endif
#define _gAdmin_included
#pragma library gAdmin
#include <a_samp>
#include <gAdmin\dfiles>


stock IsPlayergAdmin(playerid) {
	new ThePlayer[MAX_PLAYER_NAME],lev;
	GetPlayerName(playerid,ThePlayer,MAX_PLAYER_NAME);
	lev=dUserINT(ThePlayer).("AdminLevel");
	return lev>=2 ? true : false;
}
stock IsPlayergAdminLevel(playerid, level) {
	new ThePlayer[MAX_PLAYER_NAME],lev;
	GetPlayerName(playerid,ThePlayer,MAX_PLAYER_NAME);
	lev=dUserINT(ThePlayer).("AdminLevel");
	return lev>=level ? true : false;
}
stock GetPlayergAdminLevel(playerid) {
	new ThePlayer[MAX_PLAYER_NAME],lev;
	GetPlayerName(playerid,ThePlayer,MAX_PLAYER_NAME);
	lev=dUserINT(ThePlayer).("AdminLevel");
	return lev;
}
#pragma unused ret_memcpy
