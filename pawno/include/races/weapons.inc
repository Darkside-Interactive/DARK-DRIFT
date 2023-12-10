//
// Created: 05.09.06
// Aurthor: Iain Gilbert
//


#if defined _weapons_included
#endinput
#endif

#define _weapons_included
#pragma library weapons
#include "base"

forward AmmunationInit();
forward IsPlayerAtAmmunation(playerid);
forward OnPlayerEnterAmmoCheckpoint(playerid);
forward IsPlayerAllowedWeapon(playerid,weaponid);
forward BuyWeapon(playerid,weaponid,bullets);
forward AmmunationCommandHandler(playerid,text[]);



#define MAX_WEAPONS 47
#define MAX_BULLETS 1200

enum WeaponInfo {
	Weapon_ID, // id number of weapon
	Weapon_Name[MAX_NAME], // weapon name
	Weapon_Allowed, // is weapon allowed
	Weapon_MaxBullets, // max bullets
	Weapon_Cost, // cost per bullet
	Weapon_Level // player level required to buy this weapon
}
#define WeaponsSize 47
new Weapons[WeaponsSize][WeaponInfo] = {

	//id, "Name" ,Allowed,bullets, cost , level
	{0, "No Weapon" , 0 , 1 , 0 , 0},

	{1, "Brass Knuckles" , 0 , 1 , 60 , 3},
	{2, "Golf Club" , 1 , 1 , 6000 , 2},
	{3, "Night Stick" , 0 , 1 , 1000 , 18},
	{4, "Knife" , 1 , 1 , 100 , 4},
	{5, "Baseball Bat" , 1 , 1 , 1500 , 7},
	{6, "Shovel" , 0 , 1 , 1000 , 0},
	{7, "Pool cue" , 1 , 1 , 4000 , 11},
	{8, "Katana" , 1 , 1 , 2000 , 8},
	{9, "Chainsaw" , 1 , 1 , 27500 , 6},
	{10, "Purple Dildo" , 0 , 1 , 5000 , 9},
	{11, "White Dildo" , 1 , 1 , 5000 , 13},
	{12, "Long White Dildo" , 0 , 1 , 7000 , 25},
	{13, "White Dildo 2" , 1 , 1 , 5000 , 24},
	{14, "Flowers" , 1 , 1 , 1000 , 12},
	{15, "Cane" , 1 , 1 , 1000 , 8},
	{16, "Grenades" , 1 , 5 , 360 , 16},
	{17, "Tear Gas" , 1 , 5 , 6000 , 23},
	{18, "Molotovs" , 1 , 5 , 1200 , 26},

	{19, "noname" , 0 , 1 , 1000 , 99},
	{20, "noname" , 0 , 1 , 1000 , 99},
	{21, "noname" , 0 , 1 , 1000 , 99},

	{22, "Pistol" , 1 , 30 , 240 , 0},
	{23, "Silenced Pistol" , 1 , 30 , 720 , 10},
	{24, "Desert Eagle" , 1 , 15 , 1440 , 12},
	{25, "Shotgun" , 1 , 15 , 720 , 5},
	{26, "Sawn Off Shotgun" , 1 , 15 , 960 , 14},
	{27, "Combat Shotgun" , 1 , 10 , 1200 , 15},
	{28, "Micro Uzi" , 1 , 60 , 360 , 5},
	{29, "MP5 (NK5)" , 1 , 60 , 600 , 18},
	{30, "AK47" , 1 , 120 , 4200 , 17},
	{31, "M4" , 1 , 150 , 5400 , 19},
	{32, "Tec9" , 1 , 90 , 2400 , 7},
	{33, "Rifle" , 1 , 20 , 1200 , 20},
	{34, "Sniper Rifle" , 1 , 10 , 6000 , 26},
	{35, "RPG" , 1 , 5 , 2519000 , 51},
	{36, "Missile Launcher" , 1 , 5 , 2519000 , 51},
	{37, "Flame Thrower" , 1 , 500 , 17000 , 21},
	{38, "Minigun" , 1 , 250 , 2519000 , 51},

	{39, "Sachel Charges" , 1 , 1 , 2400 , 27},
	{40, "Detonator" , 1 , 1 , 100 , 27},

	{41, "Spray Paint" , 1 , 250 , 40 , 23},
	{42, "Fire Extinguisher" , 1 , 5 , 100 , 5},
	{43, "Camera" , 0 , 25 , 6000 , 24},
	{44, "Nightvision Goggles", 0 , 1 , 1000 , 90},
	{45, "Thermal Goggles" , 0 , 1 , 1000 , 90},
	{46, "Parashute" , 1 , 1 , 990000 , 20}
};

#define AmmunationsCount 4
new Ammunations[AmmunationsCount][CoordInfo] = {
	{291.0004,-84.5168,1001.5156}, // LVammunation1
	{293.2710,-108.9645,1001.5156}, // LSAmmunation1
	{290.3177,-38.7184,1001.5156}, // LSAmmunation2
	{308.186737,-165.923736,999.593750}
};

new WeaponDB[MAX_STRING] = "GTO/Weapon/";

WeaponLoadAll()
{
	if (ForceOverwrite) return;
	new temp[MAX_STRING];
	if (!dini_Exists(ConfigDB)) dini_Create(ConfigDB);
	set(temp,dini_Get(ConfigDB,"Weapon_DB"));
	if (strlen(temp) > 0) set(WeaponDB,temp);

	if (!dini_Exists(WeaponDB))
	{

		WeaponSaveAll();

		return;
	}
	for (new i=0;i<WeaponsSize;i++)
	{
		new weapondbname[MAX_STRING];
		format(weapondbname,sizeof(weapondbname),"%sGTO.Weapon.%s.txt",WeaponDB,Weapons[i][Weapon_Name]);
		set(temp,dini_Get(weapondbname,"Name"));
		if (strlen(temp) > 0) set(Weapons[i][Weapon_Name],temp);
		set(temp,nullstr);
		set(temp,dini_Get(weapondbname,"IsAllowed"));
		if (strlen(temp) > 0) Weapons[i][Weapon_Allowed] = strval(temp);
		set(temp,nullstr);
		set(temp,dini_Get(weapondbname,"Level"));
		if (strlen(temp) > 0) Weapons[i][Weapon_Level] = strval(temp);
		set(temp,nullstr);
		set(temp,dini_Get(weapondbname,"Price"));
		if (strlen(temp) > 0) Weapons[i][Weapon_Cost] = strval(temp);
		set(temp,nullstr);
	}
	return;
}

WeaponSaveAll()
{

	new temp[MAX_STRING];
	if (dini_Exists(ConfigDB))
	{
		dini_Set(ConfigDB,"Weapon_DB",WeaponDB);
	}

	for (new i=0;i<WeaponsSize;i++)
	{
		new weapondbname[MAX_STRING];
		format(weapondbname,sizeof(weapondbname),"%sGTO.Weapon.%s.txt",WeaponDB,Weapons[i][Weapon_Name]);
		if (!dini_Exists(weapondbname)) dini_Create(weapondbname);
		dini_Set(weapondbname,"Name",Weapons[i][Weapon_Name]);
		valstr(temp,Weapons[i][Weapon_Allowed]);
		dini_Set(weapondbname,"IsAllowed",temp);
		set(temp,nullstr);
		valstr(temp,Weapons[i][Weapon_Level]);
		dini_Set(weapondbname,"Level",temp);
		set(temp,nullstr);
		valstr(temp,Weapons[i][Weapon_Cost]);
		dini_Set(weapondbname,"Price",temp);
		set(temp,nullstr);
	}
	return;
}

public AmmunationInit()
{
	for (new id=0;id<AmmunationsCount;id++)
	{
		AddActiveCheckpoint(Ammunations[id][Coord_X],Ammunations[id][Coord_Y],Ammunations[id][Coord_Z],20,2);
	}
	WriteLog("Ammunition checkpoints initialised");
}

public IsPlayerAtAmmunation(playerid)
{
	for (new id=0;id<AmmunationsCount;id++)
	{
		if (oIsPlayerInCheckpoint(playerid,Ammunations[id][Coord_X],Ammunations[id][Coord_Y],Ammunations[id][Coord_Z],10))
		{
			return 1;
		}
	}
	return 0;
}

public OnPlayerEnterAmmoCheckpoint(playerid)
{
	if (playerid == INVALID_PLAYER_ID) return;
	if (!IsPlayerConnected(playerid)) return;
	if (!IsPlayerAtAmmunation(playerid)) return;
	SendPlayerFormattedText(playerid,  lang_texts[655]  , 0,COLOUR_GREEN);
	SendPlayerFormattedText(playerid,  lang_texts[656]  , 0,COLOUR_GREEN);
	SendPlayerFormattedText(playerid,  lang_texts[657]  , 0,COLOUR_GREEN);
	SendPlayerFormattedText(playerid,  lang_texts[658]  , 0,COLOUR_GREEN);

}

oGetWeaponName(weaponid)
{
	new name[MAX_NAME];
	new lookupid=GetWeaponLookupID(weaponid);
	if (lookupid == -1) return name;
	set(name,Weapons[lookupid][Weapon_Name]);
	return name;
}

GetWeaponMaxAmmo(weaponid)
{
	new ammo;
	new lookupid=GetWeaponLookupID(weaponid);
	if (lookupid == -1) return ammo;
	ammo = Weapons[lookupid][Weapon_MaxBullets];
	return ammo;
}

public IsPlayerAllowedWeapon(playerid,weaponid)
{
	new lookupid=GetWeaponLookupID(weaponid);
	if (lookupid == -1) return 0;
	if (Weapons[lookupid][Weapon_Allowed] == 0) return 0;
	if (Weapons[lookupid][Weapon_Level] > GetPlayerLevel(playerid)) return 0;
	return 1;
}

IsWeaponHandToHand(weaponid)
{
	new weaponlookupid=GetWeaponLookupID(weaponid);
	if (weaponlookupid == -1) return 0;
	if (Weapons[weaponlookupid][Weapon_MaxBullets] == 1) return 1;
	return 0;
}

GetWeaponCost(weaponid)
{
	new weaponlookupid=GetWeaponLookupID(weaponid);
	if (weaponlookupid == -1) return 0;
	return Weapons[weaponlookupid][Weapon_Cost];
}

GetWeaponLookupID(weaponid)
{
	new lookupid=-1;
	for (new i=0;i<WeaponsSize;i++)
	{
		if (weaponid == Weapons[i][Weapon_ID])
		{
			lookupid = i;
		}
	}
	return lookupid;
}

IsWeapon(weaponid)
{
	if ( (weaponid >= 0) && (weaponid <47) ) return 1;
	return 0;
}

IsStoreWeapon(weaponid)
{

	if ( ((weaponid >= 22) && (weaponid <=34)) || ((weaponid >= 16) && (weaponid <=18)) || ((weaponid >= 41) && (weaponid <=43)) || (weaponid=37) || (weaponid=39) ) return 1;
	return 0;
	/*
22 Pistol, 
23 Silenced Pistol, 
24 Desert Eagle, 
25 Shotgun, 
26 Sawn Off Shotgun, 
27 Combat Shotgun, 
28 Micro Uzi (Mac 10), 
29 MP5, 
30 AK47, 
31 M4, 
32 Tec9,
16-18, 33,34, 37, 39, 41-43, 46
*/
}

SendPlayerVendorWeapons(playerid)
{
	new string[MAX_STRING];
	SendPlayerFormattedText(playerid,  lang_texts[659]  , 0,COLOUR_GREEN);
	for (new weaponid=1;weaponid<MAX_WEAPONS;weaponid++)
	{
		if (IsPlayerAllowedWeapon(playerid,weaponid))
		{
			format(string,sizeof(string), lang_texts[660] ,oGetWeaponName(weaponid),GetWeaponCost(weaponid),weaponid);
//			SendPlayerScrollingText(playerid, string);
			SendPlayerFormattedText(playerid, string, 0, COLOUR_GREY);
		}
	}
}

public BuyWeapon(playerid,weaponid,bullets)
{
	new string[MAX_STRING];
	if ((weaponid < 1) || (weaponid > 46))
	{
		SendPlayerFormattedText(playerid,  lang_texts[661]  , 0,COLOUR_RED);
		return 0;
	}
	if ((bullets < 1) || (bullets > MAX_BULLETS))
	{
		SendPlayerFormattedText(playerid,  lang_texts[662]  , 0,COLOUR_RED);
		return 0;
	}
	if (!IsPlayerAtAmmunation(playerid))
	{
		SendPlayerFormattedText(playerid,  lang_texts[663]  , 0,COLOUR_RED);
		return 0;
	}

	if (!IsPlayerAllowedWeapon(playerid,weaponid))
	{
		format(string,sizeof(string), lang_texts[664] ,oGetWeaponName(weaponid));
		SendPlayerFormattedText(playerid,string,0,COLOUR_RED);
		return 0;
	}
	new purchasecost;
	purchasecost = GetWeaponCost(weaponid) * bullets;
	if (purchasecost < 1)
	{
		format(string,sizeof(string), lang_texts[665] ,oGetWeaponName(weaponid));
		SendPlayerFormattedText(playerid, string,0,COLOUR_RED);
		return 0;
	}
	if (oGetPlayerMoney(playerid) < purchasecost)
	{
		format(string,sizeof(string), lang_texts[666]  , purchasecost);
		SendPlayerFormattedText(playerid, string,0,COLOUR_RED);
		return 0;
	}

	oGivePlayerMoney(playerid,0-purchasecost,1);
	oGivePlayerWeapon(playerid,weaponid,bullets);
	if (bullets > 1)
	{
		format(string,sizeof(string), lang_texts[667] ,bullets,oGetWeaponName(weaponid),purchasecost);
	}
	else
	{
		format(string,sizeof(string), lang_texts[668] ,oGetWeaponName(weaponid),purchasecost);
	}
	SendPlayerFormattedText(playerid, string, 0,COLOUR_GREEN);
	SendPlayerFormattedText(playerid,  lang_texts[669]  , 0,COLOUR_GREEN);
	return 1;
}

public AmmunationCommandHandler(playerid,text[]) // process player commands
{
	if (!IsPlayerRegistered(playerid))
	{
		return 0; // non registered players dont use weapon commands
	}

	new cmd[20];
	new idx;

	set(cmd,strcharsplit(text, idx,strchar(" ")));
	if (strlen(cmd) == 0) return 0;

	if(strcomp(cmd, "/weapons", true) == 1)
	{

		SendPlayerOwnedWeapons(playerid);
		return 1;
	}

	if((strcomp(cmd, "/wl", true) == 1) || (strcomp(cmd, "/weaponlist", true) == 1))
	{
		if (!IsPlayerAtAmmunation(playerid))
		{
			SendPlayerFormattedText(playerid,  lang_texts[670]  , 0,COLOUR_RED);
			return 1;
		}
		SendPlayerVendorWeapons(playerid);
		return 1;
	}


	if((strcomp(cmd, "/wb", true) == 1) || (strcomp(cmd, "/weaponbuy", true) == 1))
	{
		if (!IsPlayerAtAmmunation(playerid))
		{
			SendPlayerFormattedText(playerid,  lang_texts[671]  , 0,COLOUR_RED);
			return 1;
		}

		// get weaponid
		new weaponid;
		set(cmd,strcharsplit(text, idx,strchar(" ")));
		if (strlen(cmd) == 0)
		{
			SendPlayerVendorWeapons(playerid);
			//SendPlayerFormattedText(playerid,  lang_texts[672]  , 0,COLOUR_RED);
			return 1;
		}
		weaponid = strval(cmd);
		if (weaponid <= 0)
		{
			SendPlayerFormattedText(playerid,  lang_texts[673]  , 0,COLOUR_RED);
			return 1;
		}

		// get bullets
		new bullets;
		set(cmd,strcharsplit(text, idx,strchar(" ")));
		if (strlen(cmd) == 0)
		{
			bullets=1;
		}
		else
		{
			bullets = strval(cmd);
		}
		if (bullets < 0)
		{
			SendPlayerFormattedText(playerid,  lang_texts[674]  , 0,COLOUR_RED);
			return 1;
		}
		BuyWeapon(playerid,weaponid,bullets);
		return 1;
	}

	if(strcomp(cmd, "/weapon", true) == 1)
	{
		set(cmd,strcharsplit(text, idx,strchar(" ")));

		if(strcomp(cmd, "help", true) == 1)
		{
			SendPlayerFormattedText(playerid,  lang_texts[675]  , 0,COLOUR_RED);
			return 1;
		}

		if (strcomp(cmd, "list", true) == 1)
		{
			if (!IsPlayerAtAmmunation(playerid))
			{
				SendPlayerFormattedText(playerid,  lang_texts[676]  , 0,COLOUR_RED);
				return 1;
			}
			SendPlayerVendorWeapons(playerid);
			return 1;
		}

		if(strcomp(cmd, "buy", true) == 1)
		{
			if (!IsPlayerAtAmmunation(playerid))
			{
				SendPlayerFormattedText(playerid,  lang_texts[677]  , 0,COLOUR_RED);
				return 1;
			}

			// get weaponid
			new weaponid;
			set(cmd,strcharsplit(text, idx,strchar(" ")));
			if (strlen(cmd) == 0)
			{
				SendPlayerVendorWeapons(playerid);
				//SendPlayerFormattedText(playerid,  lang_texts[678]  , 0,COLOUR_RED);
				return 1;
			}
			weaponid = strval(cmd);
			if (weaponid <= 0)
			{
				SendPlayerFormattedText(playerid,  lang_texts[679]  , 0,COLOUR_RED);
				return 1;
			}

			// get bullets
			new bullets;
			set(cmd,strcharsplit(text, idx,strchar(" ")));
			if (strlen(cmd) == 0)
			{
				bullets=1;
			}
			else
			{
				bullets = strval(cmd);
			}
			if (bullets < 0)
			{
				SendPlayerFormattedText(playerid,  lang_texts[680]  , 0,COLOUR_RED);
				return 1;
			}
			BuyWeapon(playerid,weaponid,bullets);
			return 1;
		}
	}
	return 0;
}


