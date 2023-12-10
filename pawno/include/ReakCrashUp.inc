/*
	Инклуд Для Работы Сервера
	1-Ый Основной Инклуд
	Made By [KrYpToDeN]©
	All Rights Reserved
*/



#if defined _ReakCrashUp_included
  #endinput
#endif

#define _ReakCrashUp_included
#pragma library ReakCrashUp

#include <a_samp>

#define MAX_FORBIDDEN_WEAPONS 20
#define MAX_WEAPONS 47

#define RED 0xFB0000AA

enum MainZone
{
Zone_Name[28],
Float:Zone_Area[6]
};

enum MainCity
{
City_Name[28],
Float:City_Area[6]
};


/*mini_strtok(const string[], &index, seperator=' ')//Переделанный! Работает быстрее!  
{  
    new result[32], i = 0;  
    if (index != 0 && string[index] != '\0') index++;  
    while (string[index] && string[index] != seperator && string[index] != '\r' && string[index] != '\n')  
    {  
        result[i++] = string[index++];  
    }  
    return result;  
}  */

stock IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

