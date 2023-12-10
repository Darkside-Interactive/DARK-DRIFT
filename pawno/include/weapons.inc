#define DIALOG_WEAPON_LIST 7

#define KNIFE 4
#define BEAT 5
#define KATANA 8
#define DESERT_EAGLE 24
#define A9MM 22
#define SHOTGUN 25
#define COMBAT_SHOTGUN 27
#define MP5 29
#define M4 31
#define AK47 30
#define SNIPER_RIFLE 34

forward DialogWeaponListResponse(playerid, dialogid, response, listitem, inputtext[]);
forward ShowWeaponDialog(playerid);
forward TryBuy(playerid, weaponid);
forward GetPrice(weaponid);
forward GetAmount(weaponid);
forward AddWeapons(playerid, weaponid, amount);
forward GiveSpawnWeapons(playerid);

new weaponPrices[][] = {
	{KNIFE,  2000, 1}, // knife
	{BEAT,  1500, 1}, // bita
	{KATANA,  2000, 1}, // katana
	{DESERT_EAGLE, 2000, 50}, // deagle
	{A9MM, 1000, 50}, // 9mm
	{SHOTGUN, 3500, 20}, // shotgun
	{COMBAT_SHOTGUN, 5000, 20}, // combat
	{MP5, 2500, 100}, // mp5
	{M4, 8000, 50}, // m4
	{AK47, 5000, 50}, // ak-47
	{SNIPER_RIFLE, 10000, 10} // sniper
};

public DialogWeaponListResponse(playerid, dialogid, response, listitem, inputtext[]) {
	if(!response) return 1;
	if(dialogid == DIALOG_WEAPON_LIST) {
		if(listitem == 0) TryBuy(playerid, KNIFE);            else
		if(listitem == 1) TryBuy(playerid, BEAT);             else
		if(listitem == 2) TryBuy(playerid, KATANA);           else
		if(listitem == 3) TryBuy(playerid, DESERT_EAGLE);     else
		if(listitem == 4) TryBuy(playerid, A9MM);              else
		if(listitem == 5) TryBuy(playerid, SHOTGUN);          else
		if(listitem == 6) TryBuy(playerid, COMBAT_SHOTGUN);   else
		if(listitem == 7) TryBuy(playerid, MP5);              else
		if(listitem == 8) TryBuy(playerid, M4);               else
		if(listitem == 9) TryBuy(playerid, AK47);             else
		if(listitem == 10) TryBuy(playerid, SNIPER_RIFLE);
	}
	return 1;
}

public ShowWeaponDialog(playerid) {
	ShowPlayerDialog(playerid, DIALOG_WEAPON_LIST, DIALOG_STYLE_LIST, "Покупка оружия на спавн",
	"Нож {00FF00}$2000\nБита {00FF00}$1500\nКатана {00FF00}$2000\nПустынный орел x50 {00FF00}$2000\n9мм x50 {00FF00}$1000\nДробовик x20 {00FF00}$3500\nБоевой дробовик x20 {00FF00}$5000\nМП5 x100 {00FF00}$2500\nM4 x50 $8000\nAK-47 x50 {00FF00}$5000\nСнайперская винтовка x10 {00FF00}$10000",
	"Ок", "Отмена");
	return 1;
}

public TryBuy(playerid, weaponid) {
	new price = GetPrice(weaponid);
	new amount = GetAmount(weaponid);
	if(DeductMoney(playerid, price)) {
	    AddWeapons(playerid, weaponid, amount);
	} else {
	    SendClientMessage(playerid, COLOR_SYSTEM, " > Недостаточно денег");
	}
	return 1;
}

public GetPrice(weaponid) {
	for(new i = 0; i < sizeof(weaponPrices); i++) {
		if(weaponid == weaponPrices[i][0]) {
		    return weaponPrices[i][1];
		}
	}
	return 0;
}
public GetAmount(weaponid) {
	for(new i = 0; i < sizeof(weaponPrices); i++) {
		if(weaponid == weaponPrices[i][0]) {
		    return weaponPrices[i][2];
		}
	}
	return 0;
}

public AddWeapons(playerid, weaponid, amount) {
	new knife, beat, katana, desert_eagle, a9mm, shotgun, combat_shotgun,
	    mp5, m4, ak47, sniper_rifle;

	knife 	= PlayerGet(playerid, "knife");
	beat    = PlayerGet(playerid, "beat");
	katana  = PlayerGet(playerid, "katana");
	desert_eagle = PlayerGet(playerid, "desert_eagle");
	a9mm    = PlayerGet(playerid, "a9mm");
	shotgun = PlayerGet(playerid, "shotgun");
	combat_shotgun = PlayerGet(playerid, "combat_shotgun");
	mp5     = PlayerGet(playerid, "mp5");
	m4      = PlayerGet(playerid, "m4");
	ak47    = PlayerGet(playerid, "ak47");
	sniper_rifle = PlayerGet(playerid, "sniper_rifle");

	switch (weaponid) {
	    case KNIFE: 		PlayerSet(playerid, "knife", amount + knife);   			
		case BEAT: 			PlayerSet(playerid, "beat", amount + beat);   					
		case KATANA: 		PlayerSet(playerid, "katana", amount + katana);   			
		case DESERT_EAGLE: 	PlayerSet(playerid, "desert_eagle", amount + desert_eagle);    	
		case A9MM: 			PlayerSet(playerid, "a9mm", amount + a9mm);   				
		case SHOTGUN: 		PlayerSet(playerid, "shotgun", amount + shotgun);   			
		case COMBAT_SHOTGUN: PlayerSet(playerid, "combat_shotgun", amount + combat_shotgun); 
		case MP5: 			PlayerSet(playerid, "mp5", amount + mp5);   					
		case M4: 			PlayerSet(playerid, "m4", amount + m4);   						
		case AK47: 			PlayerSet(playerid, "ak47", amount + ak47);   				
		case SNIPER_RIFLE:	PlayerSet(playerid, "sniper_rifle", amount + sniper_rifle);   
	}
	
	if(weaponid == KNIFE) { 	PlayerSet(playerid, "katana", 0); PlayerSet(playerid, "beat", 0); } else
	if(weaponid == BEAT) { 		PlayerSet(playerid, "katana", 0); PlayerSet(playerid, "knife", 0); } else
	if(weaponid == KATANA) { 	PlayerSet(playerid, "knife", 0); PlayerSet(playerid, "beat", 0); } 	else
	if(weaponid == SHOTGUN) { 	PlayerSet(playerid, "combat_shotgun", 0); } 						else
	if(weaponid == COMBAT_SHOTGUN) { PlayerSet(playerid, "shotgun", 0); } 							else
	if(weaponid == M4) { 		PlayerSet(playerid, "ak47", 0); } 									else
	if(weaponid == AK47) { 		PlayerSet(playerid, "m4", 0); } 									else
	if(weaponid == DESERT_EAGLE) { PlayerSet(playerid, "a9mm", 0); } 								else
	if(weaponid == A9MM) { 		PlayerSet(playerid, "desert_eagle", 0); }

	GivePlayerWeapon(playerid, weaponid, amount);
	return 1;
}

public GiveSpawnWeapons(playerid) {
	if(PlayerGet(playerid, "knife")) 		GivePlayerWeapon(playerid, KNIFE, 		PlayerGet(playerid, "knife"));
	if(PlayerGet(playerid, "beat")) 		GivePlayerWeapon(playerid, BEAT, 		PlayerGet(playerid, "beat"));
	if(PlayerGet(playerid, "katana")) 		GivePlayerWeapon(playerid, KATANA, 		PlayerGet(playerid, "katana"));
	if(PlayerGet(playerid, "desert_eagle")) GivePlayerWeapon(playerid, DESERT_EAGLE, PlayerGet(playerid, "desert_eagle"));
	if(PlayerGet(playerid, "a9mm")) 		GivePlayerWeapon(playerid, A9MM, 		PlayerGet(playerid, "a9mm"));
	if(PlayerGet(playerid, "shotgun")) 		GivePlayerWeapon(playerid, SHOTGUN, 	PlayerGet(playerid, "shotgun"));
	if(PlayerGet(playerid, "combat_shotgun")) GivePlayerWeapon(playerid, COMBAT_SHOTGUN, PlayerGet(playerid, "combat_shotgun"));
	if(PlayerGet(playerid, "mp5")) 			GivePlayerWeapon(playerid, MP5, 		PlayerGet(playerid, "mp5"));
	if(PlayerGet(playerid, "m4")) 			GivePlayerWeapon(playerid, M4, 			PlayerGet(playerid, "m4"));
	if(PlayerGet(playerid, "ak47")) 		GivePlayerWeapon(playerid, AK47, 		PlayerGet(playerid, "ak47"));
	if(PlayerGet(playerid, "sniper_rifle")) GivePlayerWeapon(playerid, SNIPER_RIFLE, PlayerGet(playerid, "sniper_rifle"));

	GivePlayerWeapon(playerid, 16, 2);
	return 1;
}

