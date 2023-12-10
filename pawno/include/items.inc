/*
*	Created:			06.10.09
*	Author:				009
*	Last Modifed:		09.02.10
*
*	09.02.10:
*	1.Добавлена функция GetItemsMassForOwner
*	2.При выкладывании вещи в транспорт считается и вес мебели в транспорте
*
*	01.02.10:
*	1.Сделаны типы владельцев вещи: персонаж,транспорт,мебель
*
*	08.01.10:
*	1.Добавлен дебаг
*	2.Добавлен вес вещей
*	3.Новая генерация строки действий и использование вещей
*
*	01.11.09:
*	1.Функции мобильника вынесены в gsm.inc
*/

#if defined _items_included
  #endinput
#endif

#define _items_included
#pragma library items

// --------------------------------------------------
// includes
// --------------------------------------------------
#include "mode_debug"
#include "mode_property"
#include "mode_dialogs"
#include "mode_pickups"
#include "furniture"

// --------------------------------------------------
// defines
// --------------------------------------------------
#define ITEMS_TABLE "`Items`"

#define MAX_ITEM_NAME 30
#define ItemOwnerRemove(%1) SetItemOwner(%1,INVALID_ITEM_OWNER,0)
#define INVALID_ITEM_ID 0

// --------------------------------------------------
// enums
// --------------------------------------------------
enum ItemsPlayerInfo {
	pDialogSelectedItem,
	pDialogSelectedType,
	pTypeOwnerShowedItems,
	pIdOwnerShowedItems,
	pItemDialogListitemId,
	pIdItemAction
};

enum ItemsInfo {
	iName[MAX_ITEM_NAME],
	iPickupModel,
	Float:iMass
};

enum {
	INVALID_ITEM_OWNER,
	ITEM_OWNER_CHARACTER,
	ITEM_OWNER_VEHICLE,
	ITEM_OWNER_FURNITURE
};

// --------------------------------------------------
// news
// --------------------------------------------------
static
	Items_Player[MAX_PLAYERS][ItemsPlayerInfo],
	Items[][ItemsInfo] = {
		{"Ключ",2352,0.1},
		{"Бумага",2953,0.05},
		{"Мобильник",3081,0.5},
		{"Записная книжка",3081,0.3},
		{"Бутылка",1487,1.0},
		{"Сигарета",3027,0.01},
		{"Аптечка",1580,1.5},
		{"Наручники",2680,0.8},
		{"Повязка",2487,0.1},
		{"Отмычка",2750,0.5},
		{"SIM-карта",1277,0.01},
		{"Канистра",1650,2.0},
		{"Рация",3080,0.3},
		{"Бита",336,1.5},
		{"Нож",341,0.5},
		{"Дубинка",334,1.0},
		{"Пистолет 9мм",346,2.5},
		{"Пистолет с глушителем",347,3.0},
		{"'Desert Eagle'",348,4.0},
		{"Дробовик",349,6.0},
		{"Обрез",350,10.0},
		{"Боевой дробовик",351,10.0},
		{"Микро UZI",352,6.0},
		{"TEK9",372,8.0},
		{"MP5",353,5.0},
		{"AK-47",355,7.0},
		{"M-4",356,8.0},
		{"Винтовка",357,10.0},
		{"Снайперская винтовка",358,15.0},
		{"Цветы",325,0.5},
		{"Фотоаппарат",367,1.0}
	};

// --------------------------------------------------
// forwards
// --------------------------------------------------
forward OnItemsSystemLoaded();
forward BuildTypeListItems(ownerid,ownertype,type,var0[],dest[],size);
forward BuildItemActionsString(playerid,ownerid,ownertype,itemid,type,dest[],size);
forward OnPlayerUseItem(playerid,ownerid,ownertype,itemid,type,itemdialogid,action[]);

// --------------------------------------------------
// natives list (for pawno functions list)
// --------------------------------------------------
/*
native CreateItem(type);
native DestroyItem(itemid);
native GetItemType(itemid);
native GetItemTypeName(type);
native GetItemVarInt(itemid,varid);
native SetItemVarInt(itemid,varid,var);
native GetItemVarString(itemid,varid);
native SetItemVarString(itemid,varid,var[]);
native Float:GetItemVarFloat(itemid,varid);
native SetItemVarFloat(itemid,varid,Float:var);
native IsOwnerHaveAnyItem(ownertype,ownerid);
native IsOwnerHaveItem(ownertype,ownerid,itemid);
native GetItemOwnerType(itemid);
native GetItemOwnerId(itemid);
native SetItemOwner(itemid,ownertype,ownerid);
native ItemOwnerRemove(itemid);
native GetItemPos(itemid,&Float:X,&Float:Y,&Float:Z);
native SetItemPos(itemid,Float:X,Float:Y,Float:Z);
native GetItemPremise(itemid);
native SetItemPremise(itemid,premise);
native GetOwnerItems(ownertype,ownerid,dest[]);
native ShowOwnerItemsListForPlayer(playerid,ownertype,ownerid);
native ShowOwnerItemsTypeListForPlayer(playerid,ownertype,ownerid,type);
native RemoveItemPickupInfo(itemid);
native Float:GetMaxMassForOwner(ownertype,ownerid);
native Float:GetItemsMassForOwner(ownertype,ownerid);
native ShowItemsListDialog(playerid,itemdialogid,source[]);
native ShowItemsMessageDialog(playerid,itemdialogid,source[]);
native ShowItemsInputDialog(playerid,itemdialogid,source[]);
native GetItemsDialogSelectedListitem(playerid);
*/

// --------------------------------------------------
// stocks
// --------------------------------------------------
stock CreateItem(type)
{
	Debug(DEBUG_START,"CreateItem(%d)",type);
	if((type < 0) || (type >= sizeof(Items)))
	{
		Debug(DEBUG_END,"CreateItem(reason: error)");
		printf("[ERROR] Items -> CreateItem (try create invalid item type - %d)",type);
		return 0;
	}
	new itemid = MySQL_GetMinimalFreeSlot("id",ITEMS_TABLE) + 1;
	Debug(DEBUG_ACTION,"add item in base");
	format(query,sizeof(query),"INSERT INTO "ITEMS_TABLE" (`id`,`Type`) VALUES (%d,%d)",itemid,type);
	samp_mysql_query(query);
	Debug(DEBUG_END,"CreateItem(reason: complete)");
	return itemid;	
}

stock DestroyItem(itemid)
{
	Debug(DEBUG_START,"DestroyItem(%d)",itemid);
	format(query,sizeof(query),"DELETE FROM "ITEMS_TABLE" WHERE `id`=%d",itemid);
	samp_mysql_query(query);
	if(ExistModeProperty(MODE_PROPERTY_ITEMS_MAIN,itemid,0)) 
	{
		DestroyModePickup(GetModePropertyInt(MODE_PROPERTY_ITEMS_MAIN,itemid,0));
		DeleteModeProperty(MODE_PROPERTY_ITEMS_MAIN,itemid,0);
	}
	Debug(DEBUG_END,"DestroyItem(reason: complete)");
	return 1;
}
	
stock GetItemType(itemid)
{
	Debug(DEBUG_START,"GetItemType(%d)",itemid);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"GetItemType(reason: error)");
		printf("[ERROR] Items -> GetItemType (try get type invalid item - %d)",itemid);
		return 0;
	}
	Debug(DEBUG_ACTION,"get type from base");
	format(query,sizeof(query),"SELECT `Type` FROM "ITEMS_TABLE" WHERE `id`=%d",itemid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(!samp_mysql_fetch_row(result))
	{
		Debug(DEBUG_END,"GetItemType(reason: error)");
		printf("[ERROR] Items -> GetItemType (try get type not created item - %d)",itemid);
		return 0;
	}
	Debug(DEBUG_END,"GetItemType(reason: complete)");
	return strval(result);
}

stock GetItemTypeName(type)
{
	return Items[type][iName];
}

stock GetItemVarInt(itemid,varid)
{
	Debug(DEBUG_START,"GetItemVarInt(%d,%d)",itemid,varid);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"GetItemVarInt(reason: error)");
		printf("[ERROR] Items -> GetItemVarInt (try get var invalid item - %d)",itemid);
		return 0;
	}
	if((varid < 0) || (varid >= MAX_ITEM_VARS))
	{
		Debug(DEBUG_END,"GetItemVarInt(reason: error)");
		printf("[ERROR] Items -> GetItemVarInt (try get var invalid varid - %d)",varid);
		return 0;
	}
	Debug(DEBUG_ACTION,"get var from base");
	format(query,sizeof(query),"SELECT `Var_%d` FROM "ITEMS_TABLE" WHERE `id`=%d",varid,itemid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(!samp_mysql_fetch_row(result))
	{
		Debug(DEBUG_END,"GetItemVarInt(reason: error)");
		printf("[ERROR] Items -> GetItemVarInt (try get var not created item - %d)",itemid);
		return 0;
	}
	Debug(DEBUG_END,"GetItemVarInt(reason: complete)");
	return strval(result);
}

stock SetItemVarInt(itemid,varid,var)
{
	Debug(DEBUG_START,"SetItemVarInt(%d,%d,%d)",itemid,varid,var);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"SetItemVarInt(reason: error)");
		printf("[ERROR] Items -> SetItemVarInt (try get var invalid item - %d)",itemid);
		return 0;
	}
	if((varid < 0) || (varid >= MAX_ITEM_VARS))
	{
		Debug(DEBUG_END,"SetItemVarInt(reason: error)");
		printf("[ERROR] Items -> SetItemVarInt (try get var invalid varid - %d)",varid);
		return 0;
	}
	Debug(DEBUG_ACTION,"set var in base");
	format(query,sizeof(query),"UPDATE "ITEMS_TABLE" SET `Var_%d`='%d' WHERE `id`=%d",varid,var,itemid);
	samp_mysql_query(query);
	Debug(DEBUG_END,"SetItemVarInt(reason: complete)");
	return 1;
}

stock GetItemVarString(itemid,varid)
{
	Debug(DEBUG_START,"GetItemVarString(%d,%d)",itemid,varid);
	nullstr(result);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"GetItemVarString(reason: error)");
		printf("[ERROR] Items -> GetItemVarString (try get var invalid item - %d)",itemid);
		return result;
	}
	if((varid < 0) || (varid >= MAX_ITEM_VARS))
	{
		Debug(DEBUG_END,"GetItemVarString(reason: error)");
		printf("[ERROR] Items -> GetItemVarString (try get var invalid varid - %d)",varid);
		return result;
	}
	Debug(DEBUG_ACTION,"get var from base");
	format(query,sizeof(query),"SELECT `Var_%d` FROM "ITEMS_TABLE" WHERE `id`=%d",varid,itemid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(!samp_mysql_fetch_row(result))
	{
		Debug(DEBUG_END,"GetItemVarString(reason: error)");
		printf("[ERROR] Items -> GetItemVarString (try get var not created item - %d)",itemid);
		return result;
	}
	Debug(DEBUG_END,"GetItemVarString(reason: complete)");
	return result;
}

stock SetItemVarString(itemid,varid,var[])
{
	Debug(DEBUG_START,"SetItemVarString(%d,%d,'%s')",itemid,varid,var);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"SetItemVarString(reason: error)");
		printf("[ERROR] Items -> SetItemVarString (try get var invalid item - %d)",itemid);
		return 0;
	}
	if((varid < 0) || (varid >= MAX_ITEM_VARS))
	{
		Debug(DEBUG_END,"SetItemVarString(reason: error)");
		printf("[ERROR] Items -> SetItemVarString (try get var invalid varid - %d)",varid);
		return 0;
	}
	Debug(DEBUG_ACTION,"set var in base");
	format(query,sizeof(query),"UPDATE "ITEMS_TABLE" SET `Var_%d`='%s' WHERE `id`=%d",varid,var,itemid);
	samp_mysql_query(query);
	Debug(DEBUG_END,"SetItemVarString(reason: complete)");
	return 1;
}

stock Float:GetItemVarFloat(itemid,varid)
{
	Debug(DEBUG_START,"GetItemVarFloat(%d,%d)",itemid,varid);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"GetItemVarFloat(reason: error)");
		printf("[ERROR] Items -> GetItemVarFloat (try get var invalid item - %d)",itemid);
		return 0.0;
	}
	if((varid < 0) || (varid >= MAX_ITEM_VARS))
	{
		Debug(DEBUG_END,"GetItemVarFloat(reason: error)");
		printf("[ERROR] Items -> GetItemVarFloat (try get var invalid varid - %d)",varid);
		return 0.0;
	}
	Debug(DEBUG_ACTION,"get var from base");
	format(query,sizeof(query),"SELECT `Var_%d` FROM "ITEMS_TABLE" WHERE `id`=%d",varid,itemid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(!samp_mysql_fetch_row(result))
	{
		Debug(DEBUG_END,"GetItemVarFloat(reason: error)");
		printf("[ERROR] Items -> GetItemVarFloat (try get var not created item - %d)",itemid);
		return 0.0;
	}
	Debug(DEBUG_END,"GetItemVarFloat(reason: complete)");
	return floatstr(result);
}

stock SetItemVarFloat(itemid,varid,Float:var)
{
	Debug(DEBUG_START,"SetItemVarFloat(%d,%d,%f)",itemid,varid,var);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"SetItemVarFloat(reason: error)");
		printf("[ERROR] Items -> SetItemVarFloat (try get var invalid item - %d)",itemid);
		return 0;
	}
	if((varid < 0) || (varid >= MAX_ITEM_VARS))
	{
		Debug(DEBUG_END,"SetItemVarFloat(reason: error)");
		printf("[ERROR] Items -> SetItemVarFloat (try get var invalid varid - %d)",varid);
		return 0;
	}
	Debug(DEBUG_ACTION,"set var in base");
	format(query,sizeof(query),"UPDATE "ITEMS_TABLE" SET `Var_%d`='%.3f' WHERE `id`=%d",varid,var,itemid);
	samp_mysql_query(query);
	Debug(DEBUG_END,"SetItemVarFloat(reason: complete)");
	return 1;
}

stock IsOwnerHaveAnyItem(ownertype,ownerid)
{
	Debug(DEBUG_START,"IsOwnerHaveAnyItem(%d,%d)",ownertype,ownerid);
	switch(ownertype)
	{
		case ITEM_OWNER_CHARACTER: format(query,sizeof(query),"SELECT * FROM "ITEMS_TABLE" WHERE `OwnerId`='%s' AND `OwnerType`=%d",oGetCharacterName(ownerid),ownertype);
		default: format(query,sizeof(query),"SELECT * FROM "ITEMS_TABLE" WHERE `OwnerId`='%d' AND `OwnerType`=%d",ownerid,ownertype);
	}	
	Debug(DEBUG_ACTION,"find items with this owner");
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(!samp_mysql_fetch_row(result))
	{
		Debug(DEBUG_END,"IsOwnerHaveAnyItem(reason: complete)");
		return 0;
	}
	Debug(DEBUG_END,"IsOwnerHaveAnyItem(reason: complete)");
	return 1;	
}

stock IsOwnerHaveItem(ownertype,ownerid,itemid)
{
	Debug(DEBUG_START,"IsOwnerHaveItem(%d,%d,%d)",ownertype,ownerid,itemid);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"IsOwnerHaveItem(reason: error)");
		printf("[ERROR] Items -> IsOwnerHaveItem (invalid item - %d)",itemid);
		return 0;
	}
	switch(ownertype)
	{
		case ITEM_OWNER_CHARACTER: format(query,sizeof(query),"SELECT * FROM "ITEMS_TABLE" WHERE `OwnerId`='%s' AND `OwnerType`=%d AND `id`=%d",oGetCharacterName(ownerid),ownertype,itemid);
		default: format(query,sizeof(query),"SELECT * FROM "ITEMS_TABLE" WHERE `OwnerId`='%d' AND `OwnerType`=%d AND `id`=%d",ownerid,ownertype,itemid);
	}
	Debug(DEBUG_ACTION,"try get item with this owner");
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(!samp_mysql_fetch_row(result))
	{
		Debug(DEBUG_END,"IsOwnerHaveItem(reason: complete)");
		return 0;
	}
	Debug(DEBUG_END,"IsOwnerHaveItem(reason: complete)");
	return 1;	
}

stock GetItemOwnerType(itemid)
{
	Debug(DEBUG_START,"GetItemOwnerType(%d)",itemid);
	nullstr(result);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"GetItemOwnerType(reason: error)");
		printf("[ERROR] Items -> GetItemOwnerType (invalid item - %d)",itemid);
		return INVALID_ITEM_OWNER;
	}
	Debug(DEBUG_ACTION,"get item owner type");
	format(query,sizeof(query),"SELECT `OwnerType` FROM "ITEMS_TABLE" WHERE `id`=%d",itemid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(!samp_mysql_fetch_row(result))
	{
		Debug(DEBUG_END,"GetItemOwnerType(reason: error)");
		printf("[ERROR] Items -> GetItemOwnerType (item not finded,itemid - %d)",itemid);
		return INVALID_ITEM_OWNER;
	}
	Debug(DEBUG_END,"GetItemOwnerType(reason: complete)");
	return strval(result);	
}

stock GetItemOwnerId(itemid)
{
	Debug(DEBUG_START,"GetItemOwnerId(%d)",itemid);
	nullstr(result);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"GetItemOwnerId(reason: error)");
		printf("[ERROR] Items -> GetItemOwnerId (invalid item - %d)",itemid);
		return result;
	}
	Debug(DEBUG_ACTION,"get item owner id");
	format(query,sizeof(query),"SELECT `OwnerId` FROM "ITEMS_TABLE" WHERE `id`=%d",itemid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(!samp_mysql_fetch_row(result))
	{
		Debug(DEBUG_END,"GetItemOwnerId(reason: error)");
		printf("[ERROR] Items -> GetItemOwnerId (item not finded,itemid - %d)",itemid);
		return result;
	}
	Debug(DEBUG_END,"GetItemOwnerId(reason: complete)");
	return result;	
}

stock SetItemOwner(itemid,ownertype,ownerid)
{
	Debug(DEBUG_START,"SetItemOwner(%d,%d,%d)",itemid,ownertype,ownerid);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"SetItemOwner(reason: error)");
		printf("[ERROR] Items -> SetItemOwner (invalid item - %d)",itemid);
		return 0;
	}
	Debug(DEBUG_ACTION,"if invalid owner type - delete data about last owner");
	if(ownertype == INVALID_ITEM_OWNER)
	{
		format(query,sizeof(query),"UPDATE "ITEMS_TABLE" SET (`OwnerType`,`OwnerId`) VALUES (0,'') WHERE `id`=%d",itemid);
		samp_mysql_query(query);
		Debug(DEBUG_END,"SetItemOwner(reason: complete)");
		return 1;
	}
	Debug(DEBUG_ACTION,"get current mass of owner's items");
	switch(ownertype)
	{
		case ITEM_OWNER_CHARACTER: format(query,sizeof(query),"SELECT `Type` FROM "ITEMS_TABLE" WHERE `OwnerType`=%d AND `OwnerId`='%s'",ownertype,oGetCharacterName(ownertype));
		default: format(query,sizeof(query),"SELECT `Type` FROM "ITEMS_TABLE" WHERE `OwnerType`=%d AND `OwnerId`=%d",ownertype,ownerid);
	}
	samp_mysql_query(query);
	samp_mysql_store_result();
	new Float:mass;
	while(samp_mysql_fetch_row(result)) mass += Items[strval(result)][iMass];
	if(ownertype == ITEM_OWNER_VEHICLE) mass += GetFurnituresMassForVehicle(ownerid);
	Debug(DEBUG_ACTION,"compare mass");
	if((mass + Items[itemid][iMass]) > GetMaxMassForOwner(ownertype,ownerid)) {Debug(DEBUG_END,"SetItemOwner(reason: complete)");return 0;}
	Debug(DEBUG_ACTION,"set item owner");
	switch(ownertype)
	{
		case ITEM_OWNER_CHARACTER: format(query,sizeof(query),"UPDATE "ITEMS_TABLE" SET (`OwnerType`,`OwnerId`) VALUES (%d,'%s') WHERE `id`=%d",ownertype,oGetCharacterName(ownerid),itemid);
		default: format(query,sizeof(query),"UPDATE "ITEMS_TABLE" SET (`OwnerType`,`OwnerId`) VALUES (%d,'%d') WHERE `id`=%d",ownertype,ownerid,itemid);
	}
	samp_mysql_query(query);
	Debug(DEBUG_END,"SetItemOwner(reason: complete)");
	return 1;	
}

stock GetItemPos(itemid,&Float:X,&Float:Y,&Float:Z)
{
	Debug(DEBUG_START,"GetItemPos(%d)",itemid);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"GetItemPos(reason: error)");
		printf("[ERROR] Items -> GetItemPos (invalid item - %d)",itemid);
		return 0;
	}
	Debug(DEBUG_ACTION,"get item pos");
	format(query,sizeof(query),"SELECT * FROM "ITEMS_TABLE" WHERE `id`=%d",itemid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(!samp_mysql_fetch_row(result))
	{
		Debug(DEBUG_END,"GetItemPos(reason: error)");
		printf("[ERROR] Items -> GetItemPos (item not finded in base, item - %d)",itemid);
		return 0;
	}
	new tmp[15];
	samp_mysql_get_field("X",tmp);
	X = floatstr(tmp);
	samp_mysql_get_field("Y",tmp);
	Y = floatstr(tmp);
	samp_mysql_get_field("Z",tmp);
	Z = floatstr(tmp);
	Debug(DEBUG_END,"GetItemPos(reason: complete)");
	return 1;
}

stock SetItemPos(itemid,Float:X,Float:Y,Float:Z)
{
	Debug(DEBUG_START,"SetItemPos(%d,%f,%f,%f)",itemid,X,Y,Z);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"SetItemPos(reason: error)");
		printf("[ERROR] Items -> SetItemPos (invalid item - %d)",itemid);
		return 0;
	}
	Debug(DEBUG_ACTION,"get pickup id if exist");
	Debug(DEBUG_ACTION,"set item pos");
	format(query,sizeof(query),"UPDATE "ITEMS_TABLE" SET (`X`,`Y`,`Z`) VALUES (%f,%f,%f) WHERE `id`=%d",X,Y,Z,itemid);
	samp_mysql_query(query);
	if(ExistModeProperty(MODE_PROPERTY_ITEMS_MAIN,itemid,0)) SetModePickupPos(GetModePropertyInt(MODE_PROPERTY_ITEMS_MAIN,itemid,0),X,Y,Z);
	else SetModePropertyInt(MODE_PROPERTY_ITEMS_MAIN,itemid,0,CreateModePickup(Items[GetItemType(itemid)][iPickupModel],42,X,Y,Z,-1,-1,PICKUP_ITEM,itemid));
	Debug(DEBUG_END,"SetItemPos(reason: complete)");
	return 1;
}

stock GetItemPremise(itemid)
{
	Debug(DEBUG_START,"GetItemPremise(%d)",itemid);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"GetItemPremise(reason: error)");
		printf("[ERROR] Items -> GetItemPremise (invalid item - %d)",itemid);
		return 0;
	}
	Debug(DEBUG_ACTION,"get item premise");
	format(query,sizeof(query),"SELECT `Premise` FROM "ITEMS_TABLE" WHERE `id`=%d",itemid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(!samp_mysql_fetch_row(result))
	{
		Debug(DEBUG_END,"GetItemPremise(reason: error)");
		printf("[ERROR] Items -> GetItemPremise (item not finded in base, item - %d)",itemid);
		return 0;
	}
	Debug(DEBUG_END,"GetItemPremise(reason: complete)");
	return strval(result);
}

stock SetItemPremise(itemid,premise)
{
	Debug(DEBUG_START,"SetItemPremise(%d,%d)",itemid,premise);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"SetItemPremise(reason: error)");
		printf("[ERROR] Items -> SetItemPremise (invalid item - %d)",itemid);
		return 0;
	}
	Debug(DEBUG_ACTION,"get pickup id if exist");
	if(ExistModeProperty(MODE_PROPERTY_ITEMS_MAIN,itemid,0)) SetModePickupPremise(GetModePropertyInt(MODE_PROPERTY_ITEMS_MAIN,itemid,0),premise);
	Debug(DEBUG_ACTION,"set item premise");
	format(query,sizeof(query),"UPDATE "ITEMS_TABLE" SET (`Premise`) VALUES (%d) WHERE `id`=%d",premise,itemid);
	samp_mysql_query(query);
	Debug(DEBUG_END,"SetItemPremise(reason: complete)");
	return 1;
}

stock GetOwnerItems(ownertype,ownerid,dest[])
{
	Debug(DEBUG_START,"GetOwnerItems(%d,%d)",ownertype,ownerid);
	switch(ownertype)
	{
		case ITEM_OWNER_CHARACTER: format(query,sizeof(query),"SELECT `id` FROM "ITEMS_TABLE" WHERE `OwnerType`=%d AND `OwnerId`='%s'",ownertype,oGetCharacterName(ownerid));
		default: format(query,sizeof(query),"SELECT `id` FROM "ITEMS_TABLE" WHERE `OwnerType`=%d AND `OwnerId`='%d'",ownertype,ownerid);
	}
	Debug(DEBUG_ACTION,"get owner items");
	samp_mysql_query(query);
	samp_mysql_store_result();
	new slot;
	while(samp_mysql_fetch_row(result))
	{
		dest[slot] = strval(result);
		slot++;
	}
	Debug(DEBUG_END,"GetOwnerItems(reason: complete)");
	return slot;
}

stock ShowOwnerItemsListForPlayer(playerid,ownertype,ownerid)
{
	Debug(DEBUG_START,"ShowOwnerItemsListForPlayer(%d,%d,%d)",playerid,ownertype,ownerid);
	if(!IsPlayerConnected(playerid))
	{
		Debug(DEBUG_END,"ShowOwnerItemsListForPlayer(reason: error)");
		printf("[ERROR] Items -> ShowOwnerItemsListForPlayer (invalid player - %d)",playerid);
		return 0;
	}
	nullstr(DialogString);
	Debug(DEBUG_ACTION,"get owner all items list");
	switch(ownertype)
	{
		case ITEM_OWNER_CHARACTER: format(query,sizeof(query),"SELECT `Type` FROM "ITEMS_TABLE" WHERE `OwnerId`='%s' AND `OwnerType`=%d AND `id`=%d",oGetCharacterName(ownerid),ownertype,itemid);
		default: format(query,sizeof(query),"SELECT `Type` FROM "ITEMS_TABLE" WHERE `OwnerId`='%d' AND `OwnerType`=%d AND `id`=%d",ownerid,ownertype,itemid);
	}
	samp_mysql_query(query);
	samp_mysql_store_result();
	new pitems[sizeof(Items)],
		listid;
	while(samp_mysql_fetch_row(result)) pitems[strval(result)]++;
	for(new i = 0;i < sizeof(Items);i++)
	{
		if(pitems[i] == 0) continue;
		format(DialogString,sizeof(DialogString),"%s%s\t\t[количество: %d,вес: %.2f]\n",DialogString,Items[i][iName],pitems[i],(pitems[i] * Items[i][iMass]));
		SetPlayerModeDialogListData(playerid,listid,i);
		listid++;
	}
	if(listid == 0)
	{
		ShowPlayerModeDialog(playerid,DIALOG_ITEM_END,DIALOG_STYLE_MSGBOX,"Инвентарь","Пусто","Ok","Ok");
		Debug(DEBUG_END,"ShowOwnerItemsListForPlayer(reason: complete)");
		return 1;
	}
	ShowPlayerModeDialog(playerid,DIALOG_ITEM_LIST,DIALOG_STYLE_LIST,"Инвентарь",DialogString,"Выбрать","Закрыть");
	Items_Player[playerid][pTypeOwnerShowedItems] = ownertype;
	Items_Player[playerid][pIdOwnerShowedItems] = ownerid;
	if((ownertype == ITEM_OWNER_CHARACTER) && (ownerid != playerid)) 
	{
		SetPlayerAction(ownerid,ACTION_SHOW_ITEMS);
		TogglePlayerControllableEx(ownerid,false);
	}
	SetPlayerAction(playerid,ACTION_SEE_ITEMS);
	TogglePlayerControllableEx(playerid,false);
	Debug(DEBUG_END,"ShowOwnerItemsListForPlayer(reason: complete)");
	return 1;
}

stock ShowOwnerItemsTypeListForPlayer(playerid,ownertype,ownerid,type)
{
	Debug(DEBUG_START,"ShowOwnerItemsTypeListForPlayer(%d,%d,%d,%d)",playerid,ownertype,ownerid,type);
	new listid,
		tmp_s[5],
		tmp[30];
	nullstr(DialogString);
	if(!IsPlayerConnected(playerid))
	{
		Debug(DEBUG_END,"ShowOwnerItemsTypeListForPlayer(reason: error)");
		printf("[ERROR] Items -> ShowOwnerItemsTypeListForPlayer (invalid player - %d)",playerid);
		return 0;
	}
	if((type < 0) || (type >= sizeof(Items)))
	{
		Debug(DEBUG_END,"ShowOwnerItemsTypeListForPlayer(reason: error)");
		printf("[ERROR] Items -> ShowOwnerItemsTypeListForPlayer (invalid item type - %d)",type);
		return 0;
	}
	Debug(DEBUG_ACTION,"get owner all items list by type");
	switch(ownertype)
	{
		case ITEM_OWNER_CHARACTER: format(query,sizeof(query),"SELECT * FROM "ITEMS_TABLE" WHERE `OwnerId`='%s' AND `OwnerType`=%d AND `Type`=%d ORDER BY `id` ASC",oGetCharacterName(ownerid),ownertype,type);
		default: format(query,sizeof(query),"SELECT * FROM "ITEMS_TABLE" WHERE `OwnerId`='%d' AND `OwnerType`=%d AND `Type`=%d ORDER BY `id` ASC",ownerid,ownertype,type);
	}
	samp_mysql_query(query);
	samp_mysql_store_result();
	Debug(DEBUG_ACTION,"write list");
	while(samp_mysql_fetch_row(result))
	{
		samp_mysql_get_field("Var_0",tmp_s);
		BuildTypeListItems(ownerid,ownertype,type,tmp_s,tmp,sizeof(tmp))
		format(DialogString,sizeof(DialogString),"%s%s %s\t[вес: %.2f]\n",DialogString,,Items[type][iName],tmp,Items[type][iMass]);
		samp_mysql_get_field("id",tmp_s);
		SetPlayerModeDialogListData(playerid,listid,strval(tmp_s));
		listid++;
	}
	if(listid == 0)
	{
		ShowOwnerItemsListForPlayer(playerid,ownertype,ownerid);
		Debug(DEBUG_END,"ShowOwnerItemsTypeListForPlayer(reason: complete)");
		return 1;
	}
	ShowPlayerModeDialog(playerid,DIALOG_ITEM_TYPE_LIST,DIALOG_STYLE_LIST,"Инвентарь",DialogString,"Действия","Назад");
	Items_Player[playerid][pTypeOwnerShowedItems] = ownertype;
	Items_Player[playerid][pIdOwnerShowedItems] = ownerid;
	Debug(DEBUG_END,"ShowOwnerItemsTypeListForPlayer(reason: complete)");
	return 1;
}

stock RemoveItemPickupInfo(itemid)
{
	Debug(DEBUG_START,"RemoveItemPickupInfo(%d)",itemid);
	if(itemid == INVALID_ITEM_ID)
	{
		Debug(DEBUG_END,"RemoveItemPickupInfo(reason: error)");
		printf("[ERROR] Items -> RemoveItemPickupInfo (invalid item - %d)",itemid);
		return 0;
	}
	Debug(DEBUG_ACTION,"change data");
	if(ExistModeProperty(MODE_PROPERTY_ITEMS_MAIN,itemid,0)) DeleteModeProperty(MODE_PROPERTY_ITEMS_MAIN,itemid,0);
	Debug(DEBUG_END,"RemoveItemPickupInfo(reason: complete)");
	return 1;
}

stock Float:GetMaxMassForOwner(ownertype,ownerid)
{
	Debug(DEBUG_START,"GetMaxMassForOwner(%d,%d)",ownertype,ownerid);
	new Float:res = 0.0;
	switch(ownertype)
	{
		case ITEM_OWNER_CHARACTER: res = MAX_CHARACTER_ITEMS_MASS;
		case ITEM_OWNER_VEHICLE: res = GetModeVehicleMaxLuggage(ownerid);
		case ITEM_OWNER_FURNITURE: res = GetFurnitureMaxLuggage(ownerid);
	}
	Debug(DEBUG_END,"GetMaxMassForOwner(reason: complete)");
	return res;
}

stock Float:GetItemsMassForOwner(ownertype,ownerid)
{
	Debug(DEBUG_START,"GetItemsMassForOwner(%d,%d)",ownertype,ownerid);
	new Float:res = 0.0;
	switch(ownertype)
	{
		case ITEM_OWNER_CHARACTER: format(query,sizeof(query),"SELECT `Type` FROM "ITEMS_TABLE" WHERE `OwnerType`=%d AND `OwnerId`='%s'",ownertype,oGetCharacterName(ownerid));
		default: format(query,sizeof(query),"SELECT `Type` FROM "ITEMS_TABLE" WHERE `OwnerType`=%d AND `OwnerId`=%d",ownertype,ownerid);
	}
	samp_mysql_query(query);
	samp_mysql_store_result();
	while(samp_mysql_fetch_row(result)) res += Items[strval(result)][iMass];
	Debug(DEBUG_END,"GetItemsMassForOwner(reason: complete)");
	return res;
}

stock ShowItemsListDialog(playerid,itemdialogid,source[])
{
	Debug(DEBUG_START,"ShowItemsListDialog(%d,%d,'%s')",playerid,itemdialogid,source);
	ShowPlayerModeDialog(playerid,DIALOG_ITEM_ACTIONS,DIALOG_STYLE_LIST,"Инвентарь",source,"Выбрать","Назад");
	Items_Player[playerid][pIdItemAction] = itemdialogid;
	Debug(DEBUG_END,"ShowItemsListDialog(reason: complete)");
}

stock ShowItemsMessageDialog(playerid,itemdialogid,source[])
{
	Debug(DEBUG_START,"ShowItemsMessageDialog(%d,%d,'%s')",playerid,itemdialogid,source);
	ShowPlayerModeDialog(playerid,DIALOG_ITEM_ACTIONS,DIALOG_STYLE_MSGBOX,"Инвентарь",source,"Выбрать","Назад");
	Items_Player[playerid][pIdItemAction] = itemdialogid;
	Debug(DEBUG_END,"ShowItemsMessageDialog(reason: complete)");
}

stock ShowItemsInputDialog(playerid,itemdialogid,source[])
{
	Debug(DEBUG_START,"ShowItemsInputDialog(%d,%d,'%s')",playerid,itemdialogid,source);
	ShowPlayerModeDialog(playerid,DIALOG_ITEM_ACTIONS,DIALOG_STYLE_INPUT,"Инвентарь",source,"Выбрать","Назад");
	Items_Player[playerid][pIdItemAction] = itemdialogid;
	Debug(DEBUG_END,"ShowItemsInputDialog(reason: complete)");
}

stock GetItemsDialogSelectedListitem(playerid)
{
	Debug(DEBUG_START,"GetItemsDialogSelectedListitem(%d)",playerid);
	Debug(DEBUG_END,"GetItemsDialogSelectedListitem(reason: complete)");
	return Items_Player[playerid][pItemDialogListitemId];
}

// --------------------------------------------------
// Obligatory functions
// --------------------------------------------------
Items_OnGameModeInit()
{
	Debug(DEBUG_START,"Items_OnGameModeInit()");
	AddActionSelectRow(RusToGame("Посмотреть~n~инвентарь"),ACTION_SHOW_ITEM);
	AddActionSelectRow(RusToGame("Подобрать~n~вещь"),ACTION_TAKE_ITEM);
	Debug(DEBUG_ACTION,"load items from base");
	new itemid,
		type,
		premise,
		Float:X,
		Float:Y,
		Float:Z,
		tmp[5];
	samp_mysql_query("SELECT `id`,`Type`,`X`,`Y`,`Z`,`Premise` FROM "ITEMS_TABLE" WHERE `OwnerType`=0");
	samp_mysql_store_result();
	while(samp_mysql_fetch_row(result))
	{
		samp_mysql_get_field("id",tmp);
		itemid = strval(tmp);
		samp_mysql_get_field("Type",tmp);
		type = strval(tmp);
		samp_mysql_get_field("X",tmp);
		X = floatstr(tmp);
		samp_mysql_get_field("Y",tmp);
		Y = floatstr(tmp);
		samp_mysql_get_field("Z",tmp);
		Z = floatstr(tmp);
		samp_mysql_get_field("Premise",tmp);
		premise = strval(tmp);
		SetModePropertyInt(MODE_PROPERTY_ITEMS_MAIN,itemid,0,CreateModePickup(Items[type][iPickupModel],42,X,Y,Z,-1,premise,PICKUP_ITEM,itemid));
	}
	Debug(DEBUG_ACTION,"load items specials");
	OnItemsSystemLoaded();
	print("Items system loaded.");
	Debug(DEBUG_END,"Items_OnGameModeInit(reason: complete)");
}

Items_OnPlayerActionCheck(playerid,actionid)
{
	Debug(DEBUG_START,"Items_OnPlayerActionCheck(%d,%d)",playerid,actionid);
	switch(actionid)
	{
		case ACTION_SHOW_ITEM:
		{
			Debug(DEBUG_ACTION,"ACTION_SHOW_ITEM");
			if(GetPlayerAction(playerid) != ACTION_NONE) {Debug(DEBUG_END,"Items_OnPlayerActionCheck(reason: complete)");return 0;}
			Debug(DEBUG_END,"Items_OnPlayerActionCheck(reason: complete)");
			return 1;
		}
		case ACTION_TAKE_ITEM:
		{
			Debug(DEBUG_ACTION,"ACTION_TAKE_ITEM");
			if(GetPlayerAction(playerid) != ACTION_NONE) {Debug(DEBUG_END,"Items_OnPlayerActionCheck(reason: complete)");return 0;}
			if(GetPlayerPickupOn(playerid) == INVALID_MODE_PICKUP_ID) {Debug(DEBUG_END,"Items_OnPlayerActionCheck(reason: complete)");return 0;}
			if(GetModePickupTypeEx(GetPlayerPickupOn(playerid)) != PICKUP_ITEM) {Debug(DEBUG_END,"Items_OnPlayerActionCheck(reason: complete)");return 0;}
			Debug(DEBUG_END,"Items_OnPlayerActionCheck(reason: complete)");
			return 1;
		}
	}
	Debug(DEBUG_END,"Items_OnPlayerActionCheck(reason: complete)");
	return 0;
}

Items_OnPlayerActionSelect(playerid,actionid)
{
	Debug(DEBUG_START,"Items_OnPlayerActionSelect(%d,%d)",playerid,actionid);
	switch(actionid)
	{
		case ACTION_SHOW_ITEM:
		{
			Debug(DEBUG_ACTION,"ACTION_SHOW_ITEM");
			if(GetPlayerAction(playerid) != ACTION_NONE) {Debug(DEBUG_END,"Items_OnPlayerActionSelect(reason: complete)");return 0;}
			new checkobj = GetPlayerClosestModeVehicle(playerid);
			if(IsPlayerAroundLuggageModeVehicl(playerid,checkobj)) 
			{
				Debug(DEBUG_ACTION,"player around vehicle,show vehicle's items");
				ShowOwnerItemsListForPlayer(playerid,ITEM_OWNER_VEHICLE,checkobj);
				SetPlayerAction(playerid,ACTION_ITEMS_SEE);
				Debug(DEBUG_END,"Items_OnPlayerActionSelect(reason: complete)");
				return 1;
			}
			checkobj = GetPlayerClosestModeObject(playerid);
			if((IsPlayerRangeOfModeObject(playerid,checkobj) == 1) && (GetModeObjectType(checkobj) == MODE_OBJECT_TYPE_FURNITURE) && (GetFurnitureMaxLuggage(GetModeObjectTypeParam(checkobj)) > 0.0))
			{
				Debug(DEBUG_ACTION,"player around furniture,show furniture's items");
				ShowOwnerItemsListForPlayer(playerid,ITEM_OWNER_FURNITURE,checkobj);
				SetPlayerAction(playerid,ACTION_ITEMS_SEE);
				Debug(DEBUG_END,"Items_OnPlayerActionSelect(reason: complete)");
				return 1;
			}
			Debug(DEBUG_ACTION,"player not around any checked object,show his items");
			ShowOwnerItemsListForPlayer(playerid,ITEM_OWNER_CHARACTER,playerid);
			SetPlayerAction(playerid,ACTION_ITEMS_SEE);
			Debug(DEBUG_END,"Items_OnPlayerActionSelect(reason: complete)");
			return 1;
		}
		case ACTION_TAKE_ITEM:
		{
			Debug(DEBUG_ACTION,"ACTION_TAKE_ITEM");
			if(GetPlayerAction(playerid) != ACTION_NONE) {Debug(DEBUG_END,"Items_OnPlayerActionSelectCheck(reason: complete)");return 0;}
			if(GetPlayerPickupOn(playerid) == INVALID_MODE_PICKUP_ID) {Debug(DEBUG_END,"Items_OnPlayerActionSelectCheck(reason: complete)");return 0;}
			if(GetModePickupTypeEx(GetPlayerPickupOn(playerid)) != PICKUP_ITEM) {Debug(DEBUG_END,"Items_OnPlayerActionSelectCheck(reason: complete)");return 0;}
			new itemid = GetModePickupTypeExParam(GetPlayerPickupOn(playerid));
			if(SetItemOwner(itemid,ITEM_OWNER_CHARACTER,playerid))
			{
				DestroyModePickup(GetPlayerPickupOn(playerid));
				RemoveItemPickupInfo(itemid);
				PlayerMessage(playerid,PLAYER_MESSAGE_ACTION,"подобрал что-то");
				ModeMessage(playerid,MODE_MESSAGE_IC,"Я взял %s",ItemsNames[MySQL_GetItemType(itemid)]);
				PlayerAction(playerid,ACTION_TAKE_ITEM);
				Debug(DEBUG_END,"Items_OnPlayerActionSelect(reason: complete)");
				return 1;
			}
			else
			{
				ModeMessage(playerid,MODE_MESSAGE_IC,"Мне некуда положить это");
				Debug(DEBUG_END,"Items_OnPlayerActionSelect(reason: complete)");
				return 1;
			}
		}
	}
	Debug(DEBUG_END,"Items_OnPlayerActionSelect(reason: complete)");
	return 0;
}

Items_OnModeDialogResponse(playerid,dialogid,response,listitem,inputtext[])
{
	Debug(DEBUG_START,"Items_OnModeDialogResponse(%d,%d,%d,%d,'%s')",playerid,dialogid,response,listitem,inputtext);
	switch(dialogid)
	{
		case DIALOG_ITEM_END:
		{
			Debug(DEBUG_ACTION,"DIALOG_ITEM_END");
			SetPlayerAction(playerid,ACTION_NONE);
			Debug(DEBUG_END,"Items_OnModeDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_ITEM_LIST:
		{
			Debug(DEBUG_ACTION,"DIALOG_ITEM_LIST");
			if(!response)
			{
				SetPlayerAction(playerid,ACTION_NONE);
				Debug(DEBUG_END,"Items_OnModeDialogResponse(reason: complete)");
				return 1;
			}
			new type = GetPlayerModeDialogListData(playerid,listitem);
			Items_Player[playerid][pDialogSelectedType] = type;
			ShowOwnerItemsTypeListForPlayer(playerid,Items_Player[playerid][pTypeOwnerShowedItems],Items_Player[playerid][pIdOwnerShowedItems],type);
			Debug(DEBUG_END,"Items_OnModeDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_ITEM_TYPE_LIST:
		{
			Debug(DEBUG_ACTION,"DIALOG_ITEM_TYPE_LIST");
			if(!response)
			{
				ShowOwnerItemsListForPlayer(playerid,Items_Player[playerid][pTypeOwnerShowedItems],Items_Player[playerid][pIdOwnerShowedItems]);
				Debug(DEBUG_END,"Items_OnModeDialogResponse(reason: complete)");
				return 1;
			}
			Items_Player[playerid][pDialogSelectedItem] = GetPlayerModeDialogListData(playerid,listitem);
			nullstr(DialogString);
			BuildItemActionsString(playerid,Items_Player[playerid][pTypeOwnerShowedItems],Items_Player[playerid][pIdOwnerShowedItems],Items_Player[playerid][pDialogSelectedItem],Items_Player[playerid][pDialogSelectedType],DialogString,sizeof(DialogString));
			ShowPlayerModeDialog(playerid,DIALOG_ITEM_ACTIONS,DIALOG_STYLE_LIST,"Инвентарь",DialogString,"Выбрать","Назад");
			Items_Player[playerid][pIdItemAction] = 0;
			Debug(DEBUG_END,"Items_OnModeDialogResponse(reason: complete)");
			return 1;
		}
		case DIALOG_ITEM_ACTIONS:
		{
			Debug(DEBUG_ACTION,"DIALOG_ITEM_ACTIONS");
			if(!response)
			{
				ShowOwnerItemsTypeListForPlayer(playerid,Items_Player[playerid][pTypeOwnerShowedItems],Items_Player[playerid][pIdOwnerShowedItems],Items_Player[playerid][pDialogSelectedType]);
				Debug(DEBUG_END,"Items_OnModeDialogResponse(reason: complete)");
				return 1;
			}
			Items_Player[playerid][pItemDialogListitemId] = listitem;
			if(OnPlayerUseItem(playerid,Items_Player[playerid][pTypeOwnerShowedItems],Items_Player[playerid][pIdOwnerShowedItems],Items_Player[playerid][pDialogSelectedItem],Items_Player[playerid][pDialogSelectedType],Items_Player[playerid][pIdItemAction],inputtext))
			{
				if((Items_Player[playerid][pTypeOwnerShowedItems] == ITEM_OWNER_CHARACTER) && (Items_Player[playerid][pIdOwnerShowedItems] != playerid)) 
				{
					if(GetPlayerAction(Items_Player[playerid][pIdOwnerShowedItems],ACTION_SHOW_ITEMS)) SetPlayerAction(Items_Player[playerid][pIdOwnerShowedItems],ACTION_NONE);
					TogglePlayerControllableEx(Items_Player[playerid][pIdOwnerShowedItems],true);
				}
				if(GetPlayerAction(playerid,ACTION_SEE_ITEMS)) SetPlayerAction(playerid,ACTION_NONE);
				TogglePlayerControllableEx(playerid,true);
			}
			Debug(DEBUG_END,"Items_OnModeDialogResponse(reason: complete)");
			return 1;
		}
	}
	Debug(DEBUG_END,"Items_OnModeDialogResponse(reason: complete)");
	return 0;
}