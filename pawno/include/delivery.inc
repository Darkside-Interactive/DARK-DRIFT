/*
*	Created:			27.08.09
*	Aurthor:			009
*	Last Modifed:		-
*/

#if defined _delivery_included
#endinput
#endif

#define _delivery_included
#pragma library delivery

// --------------------------------------------------
// includes
// --------------------------------------------------
#include "items"
#include "mode_vehicles"
#include "computers"
#include "active_objects"
#include "furniture"
//#include "active_objects_list"

// --------------------------------------------------
// defines
// --------------------------------------------------
#define MAX_DELIVERY_ORDERS 5
#define DELIVERY_OBJECT_MODEL 2934
#define DELIVERY_COLOUR 0x33AA33AA

// --------------------------------------------------
// enums
// --------------------------------------------------
enum DeliveryCitysInfo {
	Float:dBoxCoord[4],
	Float:dCoord[4],
	Float:dOffset[2]
};
enum DeliveryObjectsInfo {
	bool:dState,
	dActiveObjectId,
	dCityNumber,
	Text3D:d3DTextId
};

// --------------------------------------------------
// news
// --------------------------------------------------
new LastSecond;
new DeliveryCitys[2][DeliveryCitysInfo] = {
	{{2601.245361,-2233.979736,13.766880,180.0},{2618.454101,-2218.167236,13.816881,180.0},{-5.0,0.0}},
	{{-1559.555053,133.682159,3.894687,44.0},{-1572.470458,133.038314,3.554687,228.0},{-3.5,-3.5}}
};
new DeliveryObjects[2*MAX_DELIVERY_ORDERS][DeliveryObjectsInfo];
new fakeTime[3];

// --------------------------------------------------
// forwards
// --------------------------------------------------
forward RegisterDelivery(type,goods_id,colour,count,time,city);
forward DeliveryTick();

// --------------------------------------------------
// publics
// --------------------------------------------------
public RegisterDelivery(type,goods_id,colour,count,time,city)
{
	new curtime[3],
		currentcount = MySQL_GetDeliveryCount(city,time);
	if(currentcount > (MAX_DELIVERY_ORDERS-1)) return 0;
//	gettime(curtime[0],curtime[1],curtime[2]);
	GetFakeTime(curtime[0],curtime[1],curtime[2]);
	if((curtime[0] == time) && (curtime[1] > 40)) return 1;
	return MySQL_AddDelivery(city,time,type,goods_id,colour,count);
}

public DeliveryTick()
{
	new curtime[3];
//	gettime(curtime[0],curtime[1],curtime[2]);
	GetFakeTime(curtime[0],curtime[1],curtime[2]);
	if(LastSecond == curtime[2]) return;
	LastSecond = curtime[2];
	if((curtime[1] == 0) && (curtime[2] == 0))
	{
		new dinfo[5],
			i,
			k,
			Float:offset[2],
			tmp[20];
		for(new c = 0;c < 2;c++)
		{
			offset[0] = 0.0;
			offset[1] = 0.0;
			k = 0;
			while(MySQL_GetDeliveryInfo(c,curtime[0],dinfo[0],dinfo[1],dinfo[2],dinfo[3],dinfo[4]))
			{
				DeliveryObjects[i][dState] = true;
				DeliveryObjects[i][dActiveObjectId] = AddActiveObject(DELIVERY_OBJECT_MODEL,(DeliveryCitys[c][dCoord][0] + offset[0]),(DeliveryCitys[c][dCoord][1] + offset[1]),DeliveryCitys[c][dCoord][2],0.0,0.0,DeliveryCitys[c][dCoord][3],-1,2.0,0,ACTION_SELECT_OPEN_DELIVERY,5,dinfo[0],dinfo[1],dinfo[2],dinfo[3],(-1 * dinfo[4]));
				DeliveryObjects[i][dCityNumber] = k + 1;
				format(tmp,sizeof(tmp),"Контейнер №%d",DeliveryObjects[i][dCityNumber]);
				DeliveryObjects[i][d3DTextId] = Create3DTextLabel(tmp,DELIVERY_COLOUR,(DeliveryCitys[c][dCoord][0] + offset[0]),(DeliveryCitys[c][dCoord][1] + offset[1]),(DeliveryCitys[c][dCoord][2] + 3.0),20.0,0,0);
				i++;
				k++;
				offset[0]+=DeliveryCitys[c][dOffset][0];
				offset[1]+=DeliveryCitys[c][dOffset][1];
			}
		}
	}
	if((curtime[1] == 20) && (curtime[2] == 0))
	{
		for(new i = 0;i < 2*MAX_DELIVERY_ORDERS;i++)
		{
			if(DeliveryObjects[i][dState] == false) continue;
			DelActiveObject(DeliveryObjects[i][dActiveObjectId]);
			Delete3DTextLabel(DeliveryObjects[i][d3DTextId]);
			DeliveryObjects[i][dState] = false;
		}
	}	
}

// --------------------------------------------------
// stocks
// --------------------------------------------------
stock Delivery_OnGameModeInit()
{
	AddActionSelectRow(RusToGame("Открыть~n~контейнер"),ACTION_SELECT_OPEN_DELIVERY);
	AddActionSelectRow(RusToGame("Узнать~n~номер~n~контейнера"),ACTION_SELECT_SEL_CONT);
	for(new c = 0;c < 2;c++) AddActiveObject(1684,DeliveryCitys[c][dBoxCoord][0],DeliveryCitys[c][dBoxCoord][1],DeliveryCitys[c][dBoxCoord][2],0.0,0.0,DeliveryCitys[c][dBoxCoord][3],-1,2.0,0,ACTION_SELECT_SEL_CONT,0);
	SetTimer("DeliveryTick",500,1);
	fakeTime[1] = 1;
	print("Delivery system loaded.");
}

stock Delivery_OnPlayerActionSelect(playerid,actionid)
{
	switch(actionid)
	{
		case ACTION_SELECT_OPEN_DELIVERY: return ShowPlayerDialog(playerid,DIALOG_DELIVERY_OPEN,DIALOG_STYLE_INPUT,"Открыть контейнер","Введите номер заказа","Ок","Отмена");
		case ACTION_SELECT_SEL_CONT: 
		{
			new curtime[3];
//			gettime(curtime[0],curtime[1],curtime[2]);
			GetFakeTime(curtime[0],curtime[1],curtime[2]);
			if(curtime[1] >= 20) return ShowPlayerDialog(playerid,DIALOG_WITHOUT_ACTIONS,DIALOG_STYLE_MSGBOX,"Информация","Сейчас никаких товаров не поступало\nПриходите в первые 20 минут каждого часа","Ок","Отмена");
			ShowPlayerDialog(playerid,DIALOG_DELIVERY_SEL_CONT,DIALOG_STYLE_INPUT,"Узнать номер контейнера","Введите номер заказа","Ок","Отмена");
			return 1;
		}
	}
	return 1;
}

stock Delivery_OnDialogResponse(playerid,dialogid,response,listitem,inputtext[])
{
	#pragma unused listitem
	if(GetPlayerActiveObject(playerid) == INVALID_ACTIVE_OBJECT_ID) return 0;
	switch(dialogid)
	{
		case DIALOG_DELIVERY_SEL_CONT:
		{
			if(!response) return 0;
			new code = strval(inputtext);
			for(new i = 0;i < 2*MAX_DELIVERY_ORDERS;i++)
			{
				if(DeliveryObjects[i][dState] == false) continue;
				if(GetActiveObjectParam(DeliveryObjects[i][dActiveObjectId],4) == -code)
				{
					new tmp[60],
						cost = MySQL_GetDeliveryCost(GetActiveObjectParam(DeliveryObjects[i][dActiveObjectId],0),GetActiveObjectParam(DeliveryObjects[i][dActiveObjectId],1));
					if(GetActiveObjectParam(DeliveryObjects[i][dActiveObjectId],3) > 0)	cost*=GetActiveObjectParam(DeliveryObjects[i][dActiveObjectId],3);
					if(oGetPlayerMoney(playerid) < cost) 
					{
						format(tmp,sizeof(tmp),"Вам не хватает денег на оплату товара\nТребуется %d$",cost);
						return ShowPlayerDialog(playerid,DIALOG_WITHOUT_ACTIONS,DIALOG_STYLE_MSGBOX,"Информация",tmp,"Ок","Отмена");
					}
					oGivePlayerMoney(playerid,-cost,1);
					PlayerMessage(playerid,PLAYER_MESSAGE_ACTION,"передал деньги");
					SetActiveObjectParam(DeliveryObjects[i][dActiveObjectId],4,-GetActiveObjectParam(DeliveryObjects[i][dActiveObjectId],4));
					format(tmp,sizeof(tmp),"Ваш товар в контейнере №%d",DeliveryObjects[i][dCityNumber]);
					return ShowPlayerDialog(playerid,DIALOG_WITHOUT_ACTIONS,DIALOG_STYLE_MSGBOX,"Информация",tmp,"Ок","Отмена");
				}
				if(GetActiveObjectParam(DeliveryObjects[i][dActiveObjectId],4) == code)
				{
					new tmp[60];
					format(tmp,sizeof(tmp),"Ваш товар в контейнере №%d",DeliveryObjects[i][dCityNumber]);
					return ShowPlayerDialog(playerid,DIALOG_WITHOUT_ACTIONS,DIALOG_STYLE_MSGBOX,"Информация",tmp,"Ок","Отмена");
				}
			}
			return ShowPlayerDialog(playerid,DIALOG_WITHOUT_ACTIONS,DIALOG_STYLE_MSGBOX,"Информация","Такого заказа не поступало","Ок","Отмена");
		}
		case DIALOG_DELIVERY_OPEN:
		{
			if(!response) return 0;
			if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_DELIVERY_OPEN,DIALOG_STYLE_INPUT,"Открыть контейнер","Введите номер заказа","Ок","Отмена");
			new cont = GetPlayerActiveObject(playerid),
				type = GetActiveObjectParam(cont,0),
				goods = GetActiveObjectParam(cont,1),
				colour = GetActiveObjectParam(cont,2),
//				count = GetActiveObjectParam(cont,3),
				pass = GetActiveObjectParam(cont,4);
			if(pass < 0) return ShowPlayerDialog(playerid,DIALOG_WITHOUT_ACTIONS,DIALOG_STYLE_MSGBOX,"Информация","Товар не оплачен\nоплата производится в будке рядом с контейнерами","Ок","Отмена");
			if(strval(inputtext) != pass) return ShowPlayerDialog(playerid,DIALOG_DELIVERY_OPEN,DIALOG_STYLE_INPUT,"Открыть контейнер","Введите номер заказа","Ок","Отмена");
			if(type == -1) return ShowPlayerDialog(playerid,DIALOG_WITHOUT_ACTIONS,DIALOG_STYLE_MSGBOX,"Информация","Контейнер пуст","Ок","Отмена");
			new Float:pos[6],
				mi;
			GetModeObjectPos(GetActiveObjectModeObjectId(cont),mi,pos[0],pos[1],pos[2],pos[3],pos[4],pos[5]);
			pos[0] += (8.0 * floatsin(-pos[5], degrees));
			pos[1] += (8.0 * floatcos(-pos[5], degrees));
			SetActiveObjectParam(cont,0,-1);
			switch(type)
			{
				case 0: // Транспорт
				{
					if(IsVehicleNeedFuel(goods))
					{
						new item,
							key = 10000 + random(89999);
						while(GetItemWhithVar(ITEM_TYPE_KEY,1,inttostr(key),item))
						{
							key = 10000 + random(89999);
							GetItemWhithVar(ITEM_TYPE_KEY,1,inttostr(key),item);
						}
						item = CreateItem(ITEM_TYPE_KEY,"sd",oGetVehicleName(goods),key);
						CreateModeVehicle(goods,pos[0],pos[1],pos[2],pos[5],colour,colour,key);
						if(!SetItemOwner(item,oGetPlayerName(playerid))) 
						{
							pos[0] += (2.0 * floatsin(-pos[5]+90.0, degrees));
							pos[1] += (2.0 * floatcos(-pos[5]+90.0, degrees));
							SetItemPosition(item,pos[0],pos[1],pos[2],0);
							ModeMessage(playerid,MODE_MESSAGE_IC,"Я не могу взять ключ");
						}
						else ModeMessage(playerid,MODE_MESSAGE_IC,"Я взял ключ");
						return 1;
					}
					else CreateModeVehicle(goods,pos[0],pos[1],pos[2],pos[5],colour,colour,0);
				}
				case 1: // Мебель
				{
					CreateFurniture(goods,pos[0],pos[1],pos[2],0.0,0.0,pos[5],0);
				}
				case 2: // Компьютер
				{
					CreateComputer(pos[0],pos[1],pos[2],0.0,0.0,pos[5],0);
				}

				case 3: // Вещь
				{
					new item = CreateItem(goods,"");
					if(!SetItemOwner(item,oGetPlayerName(playerid))) 
					{
						pos[0] += (2.0 * floatsin(-pos[5]+90.0, degrees));
						pos[1] += (2.0 * floatcos(-pos[5]+90.0, degrees));
						SetItemPosition(item,pos[0],pos[1],pos[2],0);
						ModeMessage(playerid,MODE_MESSAGE_IC,"Я не могу взять товар");
					}
					else ModeMessage(playerid,MODE_MESSAGE_IC,"Я взял товар");
				}

			}
		}
	}
	return 1;	
}

stock SetFakeTime(hour,minut,secun)
{
	fakeTime[0] = hour;
	fakeTime[1] = minut;
	fakeTime[2] = secun;
}

stock GetFakeTime(&hour,&minut,&secun)
{
	hour = fakeTime[0];
	minut = fakeTime[1];
	secun = fakeTime[2];
}