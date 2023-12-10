/*
 *            VW_UsefulFunctions 1.0
 *       (c) Copyright 2009-2010 by Hidden -=DANGER=-
 *
 * @author    : DANGER1979 (http://dracoblue.com)
 * @date      : 18.10.2009
 * @update    : 11.09.2010
 *
 * This file is provided as is (no warranties).
 *
 */
/*#if defined _samp_included
	#endinput
#endif
#define _samp_included
#pragma library samp*/

#include <a_samp>
/*#if !defined _samp_included
	#tryinclude <a_samp>
	#if !defined _samp_included
		#error could not locate a_samp.inc file, please check your server includes
	#endif
#endif*/

//#define _VW_UsefulFunctions_included
//#pragma library VW_UsefulFunctions

#define MAX_STRING 256
#define COLOR_RED 0xFF0000FF//красный для запрещающих сообщений 255 0 0
#define COLOR_MAROON 0x800000FF//бордовый для админских оповещений 128 0 0

forward Float: CalculateArea(Float:x1,Float:y1,Float:x2,Float:y2,Float:x3,Float:y3);
//forward Float: Distance(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2);
forward Float: GetDistanceBetweenPlayers(playerid, targetid);
//#define DisableBadword(%1) for(new i=0; i<strlen(text); i++) if(strfind(text[i], %1, true) == 0) for(new a=0; a<256; a++) if(a >= i && a < i+strlen(%1)) text[a]='*'
//##############################################################################//
//                                                                              //
//                             ПЕРЕГРУЖЕННЫЕ ФУНКЦИИ                            //
//                                                                              //
//##############################################################################//
stock PlaySoundForPlayer(playerid, soundid)
{   //проигрывает звук soundid по координатам игрока  playerid
	if(IsValidSound(soundid))
	{
		new Float:pX, Float:pY, Float:pZ;
		GetPlayerPos(playerid, pX, pY, pZ);
		PlayerPlaySound(playerid, soundid, pX, pY, pZ);
	}
}
stock PlaySoundForObject(objectid, soundid)
{   //проигрывает звук soundid по координатам объекта objectid
	if(IsValidSound(soundid))
	{
		new Float:pX, Float:pY, Float:pZ;
		GetObjectPos(objectid, pX, pY, pZ);
		for(new i=0; i<GetMaxPlayers(); i++)
		{
			if(IsPlayerConnected(i) && !IsPlayerNPC(i))
			{
				if(IsPlayerInRangeOfPoint(i, 100.0, pX, pY, pZ)) PlayerPlaySound(i, soundid, pX, pY, pZ);
			}
		}
	}
}

//##############################################################################//
//                                                                              //
//                                ФУНКЦИИ ПРОВЕРКИ                              //
//                                                                              //
//##############################################################################//
stock IsValidSound(soundid)
{
	new Sounds[] = 	{ 	1002, 1009, 1027, 1035, 1036, 1039, 1052, 1053,
   					1054, 1055, 1056, 1057, 1058, 1062, 1063, 1068,
   					1069, 1076, 1077, 1083, 1084, 1085, 1097, 1098,
   					1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137,
					1138, 1139, 1140, 1141, 1142, 1143, 1144, 1145,
   					1146, 1147, 1148, 1149, 1150, 1153, 1154, 1163,
   					1165, 1166, 1169, 1183, 1184, 1185, 1186, 1187,
   					1188
				};
    for(new i = 0; i < sizeof(Sounds); i++)
    {
        if(Sounds[i] == soundid) return 1;
    }
    return 0;
}

stock CheckValidSkin(SkinID)
{
	if( (SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||
		(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID <= 73)||
		(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||
		(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||
		(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||
		(SkinID >= 290 && SkinID <= 299)
	  )
	{
		return 1;
	}
	return 0;
}
stock SetPlayerSkinEx(playerid, skinid)
{
	if(CheckValidSkin(skinid)) SetPlayerSkin(playerid, skinid);
	else
	{
	    new string[MAX_STRING];
		format(string, sizeof(string), "Error: playerid %s[%d], reason: Use Invalid Skin %d", PlayerName(playerid), playerid, skinid);
		//ABroadCast(COLOR_MAROON, string, 1);
		SendClientMessageToAll(COLOR_MAROON, string);
	}
}
stock IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}
/*//Has also a fix to use "-" and "+" in the beginning of the number.
isNumeric(const string[])
{
	new length = strlen(string);
	if(length == 0) return false;
	for(new i = 0; i < length; i++)
    {
		if((string[i] > '9' || string[i] < '0' && string[i]!='-' && string[i]!='+') // Not a number,'+' or '-'
             || (string[i]=='-' && i!=0)                                             // A '-' but not at first.
             || (string[i]=='+' && i!=0)                                             // A '+' but not at first.
		   ) return false;
    }
	if(length==1 && (string[0]=='-' || string[0]=='+')) return false;
	return true;
}*/

stock GetSeatVehiclePlayer(vehicleid, seatid)
{   //получить ID игрока который сидит на данном месте
//не работает в одном месте с PutPlayerInVehicle, только в следующей проверке
	for(new i=0; i<GetMaxPlayers(); i++)
	{
		if(IsPlayerConnected(i) && IsPlayerInVehicle(i, vehicleid))//IsPlayerInAnyVehicle(i)
		{	//сканируем всех кто находится в данной тачке
       		if(GetPlayerVehicleSeat(i) == seatid && GetPlayerVehicleSeat(i) != -1)
       		{   //Will also return 0 if the player is not in a vehicle!
   	        	//ИНФОРМИРОВАНИЕ
				//new string[256];
				//format(string, sizeof(string), "GetPlayerVehicleSeat(playerid: %d) = %d", i, GetPlayerVehicleSeat(i));
				//SendClientMessageToAll(COLOR_YELLOW, string);
   	        	return i;
			}
	    }
	}
	return INVALID_PLAYER_ID;
}
//##############################################################################//
//                                                                              //
//                               БЛОКИ АВТОЗАМЕНЫ                               //
//                                                                              //
//##############################################################################//
stock PlayerName(playerid)
{  //для получения имя игрока
	new pName[MAX_PLAYER_NAME+1];//20+1
	GetPlayerName(playerid, pName, sizeof(pName));
	return pName;
}
stock WeaponName(weaponid)
//weaponid,const weapon[],len)
{  //для получения имя оружия
	new gunname[256];
	GetWeaponName(weaponid, gunname, sizeof(gunname));
	return gunname;
}
stock TimeConverter(seconds)//Конвертер секунды в минуты и секунды
{
	new string[6];//объявляем символьную переменную
 	new minutes = floatround(seconds/60);//кол. целых минут
	seconds -= minutes*60; 	//остаток
	format(string, sizeof(string), "%02d:%02d", minutes, seconds);//преобразовываем
	return string;//возвращаем строку символов
}
stock timeconvert(Time, &Minutes, &Seconds, &rMSeconds)//для гонок конвертор мс в мин:сек.мсек
{   //Time - кол-во процесорных тиков с момента старта, в мс
	new Float:fTime = floatdiv(Time, 60000);//Делит вещественное число на значение, указанное вещественным числом, делителем.
    Minutes = floatround(fTime, floatround_tozero);//Округляет вещественное число указанным методом.
    //Round downwards for positive values and upwards for negative values (“truncate”).
    //Округлить вниз для положительных величин и вверх для отрицательных величин
    Seconds = floatround(floatmul(fTime - Minutes, 60), floatround_tozero);
						//Перемножает два вещественных числа и возвращает произведение.
    rMSeconds = floatround(floatmul(floatmul(fTime - Minutes, 60) - Seconds, 1000), floatround_tozero);
}
stock ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while(text[pos] < 0x21) // Strip out leading spaces //Удаляет свободное место
	{
		if(text[pos] == 0) return INVALID_PLAYER_ID; // No passed text //Нет текста на входе
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if(IsNumeric(text[pos])) // Check whole passed string - Проверьте целую прошедшую строку
	{   //если строка представлена в виде числа
		// If they have a numeric name you have a problem (although names are checked on id failure)
		// Если у них есть числовое имя у вас есть проблема (хотя имена проверены в неудаче)
		userid = strval(text[pos]);
		if(userid >= 0 && userid < MAX_PLAYERS)// && !IsPlayerNPC(userid)
		{
			if(!IsPlayerConnected(userid))	userid = INVALID_PLAYER_ID;
			else return userid; // A player was found
		}
	}
	// They entered [part of] a name or the id search failed (check names just incase)
	new len = strlen(text[pos]);
	new count = 0;
	new name[MAX_PLAYER_NAME+1];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
			GetPlayerName(i, name, sizeof(name));
			if(strcmp(name, text[pos], true, len) == 0) // Check segment of name
			{   //проверяем совпадает ли введенное имя с одним из онлайн игроков
				if(len == strlen(name)) // Exact match //более Точная проверка
				{   //если длина также совпадает
					return i; // Return the exact player on an exact match
					//Возвращает точного указанного игрока ID и выходит из ф-ии
				}
				else // Partial match //Частичная проверка
				//В противном случае если есть два игрока:
				//Me и MeYou всякий раз, когда Вы ввели Me это должно найти оба
				//И никогда не быть способным возвращать просто Me id
				{   //если введена не полная часть имени, то совпадение частичное
					count++;
					userid = i;//записываем userid =
				}
			}
		}
	}
	if(count != 1)
	{
		if(playerid != INVALID_PLAYER_ID)// && !IsPlayerNPC(playerid)
		{
			if(count) ABroadCast(COLOR_RED, "Error: Multiple users found, please narrow earch", 1);
			else ABroadCast(COLOR_RED, "Error: No matching user found", 1);
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid; // INVALID_USER_ID for bad return
}

//------------------------------------------------------------------------------
stock GetDistanceToPoint(playerid, Float:x2, Float:y2, Float:z2)//возвращает растояние от игрока до машины
{
	new Float:x1, Float:y1, Float:z1, Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatsub(x2,x1),2)+floatpower(floatsub(y2,y1),2)+floatpower(floatsub(z2,z1),2));
	return floatround(tmpdis);
}
public Float:GetDistanceBetweenPlayers(playerid, targetid)
{   //ф-ия получения растояние между игроками
	new Float:x1,Float:y1,Float:z1, Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return -1.00;
	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerPos(targetid,x2,y2,z2);
	//new Float: fDistance =
	return floatsqroot(floatpower(floatsub(x2,x1),2)+floatpower(floatsub(y2,y1),2)+floatpower(floatsub(z2,z1),2));
			//floatsqroot - Вычисляет квадратный корень данного вещественного числа.
						//floatpower - Возводит вещественное число в степень.
								//floatabs - Возвращает абсолютное значение вещественного числа.
										//floatsub - Уменьшает первое число oper1 на число, указанное в oper2.
	//return fDistance;
}
/*GetDistanceBetweenPlayers(playerid, playerid2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerPos(playerid2,x2,y2,z2);
	tmpdis = floatsqroot(floatpower(floatsub(x2,x1),2)+floatpower(floatsub(y2,y1),2)+floatpower(floatsub(z2,z1),2));
	return floatround(tmpdis);//возвращает целое
}*/

public Float: CalculateArea(Float:x1,Float:y1,
					Float:x2,Float:y2,
					Float:x3,Float:y3)
{   //возвращает площадь треугольника
    new Float: ab = x1*y2 - y1*x2;
    new Float: bc = x2*y3 - y2*x3;
	new Float: ca = x3*y1 - y3*x1;
	new Float: S = floatabs((ab + bc + ca)/2);
	//printf("ab:%.1f, bc:%.1f, ca:%.1f, S=%.1f",ab, bc, ca, S);
	return S;
}//Проверка: //S = 1/2 * a * h = 1921
//S = 1/2 * a * b * sin(gamma) = 1820;

stock IsPlayerInRangeOfPlayer(Float:radi, playerid, targetid)
{   //возвращает верно в случаи если растояние от playerid до targetid меньше указанного
	if(IsPlayerConnected(playerid) && IsPlayerConnected(targetid) &&
		!IsPlayerNPC(playerid) && !IsPlayerNPC(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		GetPlayerPos(targetid, posx, posy, posz);
		//new Float:oldposx, Float:oldposy, Float:oldposz;
		//new Float:tempposx, Float:tempposy, Float:tempposz;
		//GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//tempposx = (oldposx -posx);
		//tempposy = (oldposy -posy);
		//tempposz = (oldposz -posz);
		//if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
   		if(IsPlayerInRangeOfPoint(playerid, radi, posx, posy, posz))
		{
			return 1;
		}
	}
	return 0;
}

//для УСТАНОВКИ КОНТРОЛЬНЫХ МЕТОК и для УСТАНОВКИ ИКОНОК НА КАРТЕ
stock IsPlayerInArea(playerid, Float:area[6])//возвращает верно каждую секунду
{   //если игрок находится в прямоугольном кубе ограниченной координатами из массива area
	if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		if (x > area[0] && x < area[3] && y > area[1] && y < area[4] && z > area[2] && z < area[5]) return 1;
		//если текущие координаты находятся между координатами из массива checkCoords
	}
	return 0;
}
stock GetDistanceToCar(playerid, vehicleid)
//stock GetDistanceFromPlayerToVehicle(playerid, vehicleid)
{	//возвращает растояние от игрока до машины
	new Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	GetVehiclePos(vehicleid,x2,y2,z2);
	tmpdis = floatsqroot(floatpower(floatsub(x2,x1),2)+floatpower(floatsub(y2,y1),2)+floatpower(floatsub(z2,z1),2));
						//Возводит вещественное число в степень.
											//Уменьшает первое число oper1 на число, указанное в oper2.
	return floatround(tmpdis);
}

stock GetXYInfrontOfPlayer(playerid, Float:distance, &Float:x, &Float:y)
{   //получить координаты перед игроком
    new Float:z, Float:angle;
 	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);
    x += (distance * floatsin(-angle, degrees));
    y += (distance * floatcos(-angle, degrees));
}

stock GetXYInrear(Float:distance, Float:angle, &Float:x, &Float:y)
{   //получить координаты за указанной точкой
    //new Float:z, Float:angle;
 	//GetPlayerPos(playerid, x, y, z);
	//GetVehicleZAngle(LastCar[playerid], A);
    x -= (distance * floatsin(-angle, degrees));
    y -= (distance * floatcos(-angle, degrees));
}

stock IsVehicleAttachedToTrailer(vehicleid)
{   //получить ID тачки прицепленной к чему либо
	for(new car = 1; car<(MAX_VEHICLES-1); car++)
	{
		if(IsTrailerAttachedToVehicle(car))
		{   //работает правильно толко тогда когда в тягаче сидит человек
	     	if( vehicleid == GetVehicleTrailer(car) )
       		{
				//ИНФОРМИРОВАНИЕ
				//new string[MAX_STRING];
				//format(string, sizeof(string), "IsVehicleAttachedToTrailer(%d) - %d", vehicleid, car);
				//ABroadCast(COLOR_MAROON, string, 9);
   	        	return car;//если данная тачка к чему то прицеплена то вернуть верно
			}
	    }
	}
	return 0;
}
stock RespawnAllCars()
{
	new unoccupied[MAX_VEHICLES-1];
	for(new i=0; i<GetMaxPlayers(); i++)
	{
       	if(IsPlayerInAnyVehicle(i))	unoccupied[GetPlayerVehicleID(i)] = 1;
    }
	for(new car = 1; car<(MAX_VEHICLES-1); car++)
	{
		//VehicleName[GetVehicleModel(car)-400][Category] != Trailers)
		//ВНИМАНИЕ: трейлер не считаетс прицепленным когда игрок не сидит за рулём тягача
		if(unoccupied[car] == 1 || (unoccupied[IsVehicleAttachedToTrailer(car)] == 1)) { }
		else
		{
			SetVehicleToRespawn(car);//ВНИМАНИЕ: тачка также починится полностью и востановит здоровье на 1000
		}
	}
}

stock IsEvenNumber(number)
{   //узнаем, четное число или нет.
	if(number % 2 == 0) return 1;
	return 0;
}

stock CheckFireArm(weaponid)
{
	if(weaponid >= 22 && weaponid <= 39) return 1;
	return 0;
}

stock GetWeaponSlot(weaponid)
{
	if(weaponid == 0 || weaponid == 1) return 0;
	else if(2 <= weaponid <= 9) return 1;
	else if(22 <= weaponid <= 24) return 2;
	else if(25 <= weaponid <= 27) return 3;
	else if(weaponid == 28 || weaponid == 29 || weaponid == 32) return 4;
	else if(weaponid == 30 || weaponid == 31) return 5;
	else if(weaponid == 33 || weaponid == 34) return 6;
	else if(35 <= weaponid <= 38) return 7;
	else if(16 <= weaponid <= 18 || weaponid == 39) return 8;
	else if(41 <= weaponid <= 43) return 9;
	else if(10 <= weaponid <= 15) return 10;
	else if(44 <= weaponid <= 46) return 11;
	else if(weaponid == 40) return 12;
	else return 0;
}
//##############################################################################//
//                                                                              //
//                         ФУНКЦИИ ДЛЯ РАБОТЫ С ТЕКСТОМ                         //
//                                                                              //
//##############################################################################//
stock ini_GetKey( line[] )//вызывается из ф-ии PlayerLogin
{   //возвращает значение до разделителя "=" во входной строке line
	new keyRes[256];
	keyRes[0] = 0;
    if ( strfind(line, "=", true) == -1 ) return keyRes;
    strmid( keyRes, line, 0, strfind(line, "=", true), sizeof( keyRes) );
    return keyRes;
}
stock ini_GetValue( line[] )//вызывается из ф-ии PlayerLogin
{	//возвращает значение после разделителя "=" во входной строке line
	new valRes[256];
	valRes[0] = 0;
	if ( strfind( line , "=" , true ) == -1 ) return valRes;
	strmid( valRes, line, strfind(line, "=", true)+1 , strlen( line ) , sizeof( valRes ) );
	return valRes;
}

stock strtok(const string[], &index)//Сканирует строку на наличие символа 'пробел'
//и возвращает аргумент номер которого указан в переменной (&index).
//Применяется в основном для команд, чтобы чтобы получать параметры после пробела.
//string[] - Строка, которую нужно разделить.
//&index - Номер аргумента который вы хотите вернуть.
//Возвращает  аргумент номер которого указан в в переменной &index
//stock - блоком автозамен, жрет меньше памяти
//stock - выполняется только в пределах массива
//stock - это функция компилятора, т.е. при компиляции все функции stock, а точнее в места где вы их прописали вписывается код который в них объявлен.
//public - аппаратная функция, т.е. она компилируеться как отдельный скрипт, а в места где вы её вызываете вписываеться адрес где находиться public в памяти,
//forward - это так сказать адресная книга которая при начале обработки срипта указывает адреса на ваш public
{
   new length = strlen(string);//записали длину полученной входной строки
   while ((index < length) && (string[index] <= ' '))   index++;//подсчитали сколько символов до пробела
   //если позиция символа < длины строки и позиции символа находится до пробела, то перейти на следующий
   new offset = index;//записать позицию пробела
   new result[20];//20 объявляем новую символьную переменную с размерностью 20
   while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
   {	//покуда позиция символа меньше длины строки и символы находится за пробелом
		// и разница между позицие символа и позицией пробела < меньше покуда размера строки result, т.е. меньше 20 в данном случаи
		result[index - offset] = string[index];//записали символ в ячейку со смещением на величину позиции пробела, тем самым сформировав строку после пробела
		index++;//перешли на следующий символ
   }
   result[index - offset] = EOS;//обнулили данные в строке result начиная с позиции последнего записанного символа
   return result;//возвращаем строку из символов начиная от указаной позиции до пробела
}
stock strtoko(const string[], &index, seperator=' ')
{
	new length = strlen(string);//записали длину полученной входной строки
	new offset = index;//записать позицию пробела
	new result[128];//объявляем новую символьную переменную с размерностью 256
	while(  (index < length) && (string[index] != seperator) &&
			( (index - offset) < (sizeof(result) - 1)      )
	     )
	{   //покуда позиция символа меньше длины строки и символ не равен разделителю
		// и разница между позицие символа и позицией пробела < меньше размера строки result, т.е. меньше 256 в данном случаи
		result[index - offset] = string[index];//записали символ в ячейку со смещением на величину позиции пробела, тем самым сформировав строку после разделителя
		index++;//перешли на следующий символ
	}
	result[index - offset] = EOS;////обнулили данные в строке result начиная с позиции последнего записанного символа
	if ((index < length) && (string[index] == seperator))
	{   //если позиция символа < длины строки и строка равна разделителю
		index++;//подсчитали сколько символов до пробела
	}
	return result;//возвращаем строку из символов начиная от указаной позиции до пробела
}
//Возвращает элемент строки разделенной ' ', встроенный индекс - 0.
/*strtoko(const string[], &index, separator)
{   //для загрузки настроек
	new length = strlen(string);
	while ((index < length) && (string[index] <= separator)) index++;
	new offset = index;
	new result[256];//64//20
	while ((index < length) && (string[index] > separator) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];	index++;
	}
	result[index - offset] = EOS;
	return result;
}*/

stock split(const strsrc[], strdest[][], delimiter)
{   //разделяет первый параметр на части и заносит их во второй параметр массив
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc))//strcmp("male", tmp, true, strlen(tmp)
	{   //пока i <= длины строки strsrc
	    if(strsrc[i]==delimiter || i==strlen(strsrc))
		{   //если значение strsrc[i] == '/' или  i == длине строки strsrc
	        len = strmid(strdest[aNum], strsrc, li, i, 128);//Извлекает диапазон символов из строки.
			//li - Позиция первого символа, i - Позиция последнего символа, 128 - Максимальная длина строки-назначения для копирования.
	        //записать в strdest[aNum] значение strsrc
	        strdest[aNum][len] = 0;
	        li = i+1;//
	        aNum++;//обычный счётчик
		}
		i++;
	}
	return 1;
}
//------------------------------------------------------------------------------
stock strrest(const string[], &index)
{   //string[] - Строка, длину которой вы хотите знать в виде целого числа.
	new length = strlen(string);//Эта функция может быть использована для проверки длины указанной строки.
	while ((index < length) && (string[index] <= ' '))
	{
		index++;//Номер позиции пробела
	}
	new offset = index;//записываем позицию пробела в полученной строке
	new result[128];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];//в переменную result записать символы с позиции после пробела
		index++;
	}
	result[index - offset] = EOS;//обнулили данные в строке result начиная с позиции последнего записанного символа
	return result;
}

stock RusToGame(string[])
{
	new result[256];
	for(new i=0; i < 256; i++)
	{
		switch(string[i])
		{
			case 'а':result[i] = 'a';
			case 'А':result[i] = 'A';
			case 'б':result[i] = '—';
			case 'Б':result[i] = 'Ђ';
			case 'в':result[i] = 'ў';
			case 'В':result[i] = '‹';
			case 'г':result[i] = '™';
			case 'Г':result[i] = '‚';
			case 'д':result[i] = 'љ';
			case 'Д':result[i] = 'ѓ';
			case 'е':result[i] = 'e';
			case 'Е':result[i] = 'E';
			case 'ё':result[i] = 'e';
			case 'Ё':result[i] = 'E';
			case 'ж':result[i] = '›';
			case 'Ж':result[i] = '„';
			case 'з':result[i] = 'џ';
			case 'З':result[i] = '€';
			case 'и':result[i] = 'њ';
			case 'И':result[i] = '…';
			case 'й':result[i] = 'ќ';
			case 'Й':result[i] = '…';
			case 'к':result[i] = 'k';
			case 'К':result[i] = 'K';
			case 'л':result[i] = 'ћ';
			case 'Л':result[i] = '‡';
			case 'м':result[i] = 'Ї';
			case 'М':result[i] = 'M';
			case 'н':result[i] = '®';
			case 'Н':result[i] = '­';
			case 'о':result[i] = 'o';
			case 'О':result[i] = 'O';
			case 'п':result[i] = 'Ј';
			case 'П':result[i] = 'Њ';
			case 'р':result[i] = 'p';
			case 'Р':result[i] = 'P';
			case 'с':result[i] = 'c';
			case 'С':result[i] = 'C';
			case 'т':result[i] = '¦';
			case 'Т':result[i] = 'Џ';
			case 'у':result[i] = 'y';
			case 'У':result[i] = 'Y';
			case 'ф':result[i] = '';
			case 'Ф':result[i] = 'Ѓ';
			case 'х':result[i] = 'x';
			case 'Х':result[i] = 'X';
			case 'ц':result[i] = ' ';
			case 'Ц':result[i] = '‰';
			case 'ч':result[i] = '¤';
			case 'Ч':result[i] = 'Ќ';
			case 'ш':result[i] = 'Ґ';
			case 'Ш':result[i] = 'Ћ';
			case 'щ':result[i] = 'Ў';
			case 'Щ':result[i] = 'Љ';
			case 'ь':result[i] = '©';
			case 'Ь':result[i] = '’';
			case 'ъ':result[i] = 'ђ';
			case 'Ъ':result[i] = '§';
			case 'ы':result[i] = 'Ё';
			case 'Ы':result[i] = '‘';
			case 'э':result[i] = 'Є';
			case 'Э':result[i] = '“';
			case 'ю':result[i] = '«';
			case 'Ю':result[i] = '”';
			case 'я':result[i] = '¬';
			case 'Я':result[i] = '•';
			default:result[i] = string[i];
		}
	}
	return result;
}
