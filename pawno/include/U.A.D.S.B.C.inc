#if !defined _samp_included
#error Include 'U.A.D.S.B.C.inc' after 'a_samp.inc' !
#endif
stock LGShowPlayerDialog(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
	if(GetPVarInt(playerid, "DialogID") != -1) return 1;
	SetPVarInt(playerid, "DialogID", dialogid);
	ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
	return true;
}
stock LGHideMenuForPlayer(Menu:menuid, playerid) return CallRemoteFunction("OnHideMenuForPlayer", "dd", _:menuid, playerid);

stock LGShowMenuForPlayer(Menu:menuid, playerid) return CallRemoteFunction("OnShowMenuForPlayer", "dd", _:menuid, playerid);

#define ShowPlayerDialog LGShowPlayerDialog
#define HideMenuForPlayer LGHideMenuForPlayer
#define ShowMenuForPlayer LGShowMenuForPlayer
