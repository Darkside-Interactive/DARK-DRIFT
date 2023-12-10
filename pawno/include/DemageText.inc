#define COLOR_3DTEXT 0xFFFF00FF
#define DISTANCE 150

new KillTimeForShowDamage[MAX_PLAYERS];
new KillTimeForShowDamage2[MAX_PLAYERS];
new CountDamage[MAX_PLAYERS];
new Text:heal44[MAX_PLAYERS];
new Float:healthy[MAX_PLAYERS];
new Float:Armor[MAX_PLAYERS];
new Float:Armor2[MAX_PLAYERS];
new Float:healthy2[MAX_PLAYERS];
new Text3D:Damage[MAX_PLAYERS];

forward PlayerDemage3DText(playerid);
public PlayerDemage3DText(playerid)
{
    GetPlayerArmour(playerid,Armor[playerid]);
    if(Armor[playerid] != Armor2[playerid])
	{
	new stringF[10];
    new cba = floatround(Armor2[playerid])-floatround(Armor[playerid]);
    if(cba > 0)
	{
    KillTimer(KillTimeForShowDamage[playerid]);
    KillTimeForShowDamage[playerid] = SetTimerEx("HideDamageForPlayer", 2000, 0, "i", playerid);
    CountDamage[playerid] += cba;
    format(stringF,sizeof(stringF),"-%d",CountDamage[playerid]);
    Update3DTextLabelText(Damage[playerid],COLOR_3DTEXT,stringF);
    KillTimer(KillTimeForShowDamage2[playerid]);
    KillTimeForShowDamage2[playerid] = SetTimerEx("HideTDDamage", 5000, 0, "i", playerid);
    }
	Armor2[playerid] = Armor[playerid];
	}
	GetPlayerHealth(playerid,healthy[playerid]);
    if(healthy[playerid] != healthy2[playerid])
	{
    new stringF[10];
    new abc = floatround(healthy2[playerid])-floatround(healthy[playerid]);
    if(abc > 0)  {
    KillTimer(KillTimeForShowDamage[playerid]);
    KillTimeForShowDamage[playerid] = SetTimerEx("HideDamageForPlayer", 2000, 0, "i", playerid);
    CountDamage[playerid] += abc;
    format(stringF,sizeof(stringF),"-%d",CountDamage[playerid]);
    Update3DTextLabelText(Damage[playerid],COLOR_3DTEXT,stringF);
    KillTimer(KillTimeForShowDamage2[playerid]);
    KillTimeForShowDamage2[playerid] = SetTimerEx("HideTDDamage", 5000, 0, "i", playerid);
    }
    healthy2[playerid] = healthy[playerid];
    }
	return 1;
	}
	
forward HideDamageForPlayer(playerid);
public HideDamageForPlayer(playerid)
{
Update3DTextLabelText(Damage[playerid],COLOR_3DTEXT," ");
CountDamage[playerid] = 0;
return 1;
}

forward HideTDDamage(playerid);
public HideTDDamage(playerid)
{
TextDrawHideForPlayer(playerid,heal44[playerid]);
return 1;
}