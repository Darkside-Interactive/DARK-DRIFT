//Автор сего чуда - DeimoS
//Спасибо Daniel Cortez за предоставленную идею для реализации

static dh_ac_player_dialog_ids[MAX_PLAYERS] = {-1, ...};

// перехватчик
stock dh_ac__ShowPlayerDialog(playerid, dialogid, type, header[], text[], button1[], button2[])
{
	SetPVarInt(playerid, "USEDIALOGID", dialogid);
    dh_ac_player_dialog_ids[playerid] = dialogid;
    return ShowPlayerDialog(playerid, dialogid, type, header, text, button1, button2);
}
#if defined _ALS_ShowPlayerDialog
    #undef    ShowPlayerDialog
#else
    #define    _ALS_ShowPlayerDialog
#endif
#define    ShowPlayerDialog    dh_ac__ShowPlayerDialog

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dh_ac_player_dialog_ids[playerid] != dialogid) OnPlayerUseDialogHeader(playerid, dialogid);
    dh_ac_player_dialog_ids[playerid] = -1;
#if defined dh_ac__OnDialogResponse
    return dh_ac__OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
#endif
}
#if defined _ALS_OnDialogResponse
    #undef    OnDialogResponse
#else
    #define    _ALS_OnDialogResponse
#endif
#define    OnDialogResponse    dh_ac__OnDialogResponse
#if defined dh_ac__OnDialogResponse
forward dh_ac__OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif


forward OnPlayerUseDialogHeader(playerid, dialogid);
public OnPlayerUseDialogHeader(playerid, dialogid)
{
	SendClientMessage(playerid, -1, "Вы были кикнуты по подозрению в использовании <Dialog Hider>");
	Kick(playerid);

	printf("Игрок с ID %d был кикнут по подозрению в использовании <Dialog Hider> (dialogid: %d)", playerid, dialogid);
	return 1;
}
