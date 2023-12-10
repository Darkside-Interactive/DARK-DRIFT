/*Антиреклама by Burger
Специально для Dark Drift Team
Версия: 1.5.2
*/

/*
forward GetPlayerAdminLevel(playerid);
public GetPlayerAdminLevel(playerid) return pInfo[playerid][pAdmin]; // вставить в мод, pInfo[playerid][pAdmin]; заменить на своё. Должно вернуть уровень админки. ОБАЗЯТЕЛЬНО! Иначе админы не будут видеть рекламу!
*/

#include <a_samp>
//
#define FILTERSCRIPT
#define GetPlayerAdminLevel(%0) CallRemoteFunction("GetPlayerAdminLevel", "i", %0)
//
new cfix[MAX_PLAYERS];

public OnFilterScriptInit()
{
        printf("Антиреклама by Dark Drift Team загруженна!");
        printf("Разработчик скрипта: Burger");
        printf("Версия: v1.5.2");
        return 1;
}

public OnFilterScriptExit()
{
        printf("Антиреклама by Dark Drift Team выгруженна!");
        return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])//скрипт рекомендуется вшить в мод, для избежания ложных срабатываний, т.к. некоторые команды используют числа.
{
	cfix[playerid] = 0;
	if(!AntiReklama(playerid, cmdtext)) return 1;//эту строку нужно использовать только в той команде, которую хотим проверить на рекламу. В проиивном случае при вводе цифр в командах будет блокировать.
	return 0;
}
public OnPlayerText(playerid, text[])
{
	cfix[playerid] = 1;
	if(AntiReklama(playerid, text))return 1;
	return 0;
}

stock AntiReklama(playerid, str[])
{
	new stringer[250], r, test, name[MAX_PLAYER_NAME];
 	new dsp[250];
 	GetPlayerName(playerid, name, sizeof(name));
 	for(r = strlen(str); r != 0; r--)
	switch(str[r])
	{
	        case '0'..'9': test++;
	}
	if(cfix[playerid] == 1 && test+1 >= 3)//-> при обнаружении 3 и более цифр в чате, в одном сообщении, игрок подозревается в рекламе.
	{
	        format(stringer, sizeof(stringer), "{aa3333}Администрация, данный игрок подозревается в рекламе! %s[%d] ", name, playerid);
	        FS4AMes(-1, stringer);
	        format(stringer, sizeof(stringer), "{aa3333}Вот что он написал: %s", str);
	        FS4AMes(-1, stringer);
			//в данном случае сообщение будет отправлено, проверка тут зависит только от администраторов, которые получат сообщение о подозрении
			cfix[playerid] = 0;
	        return 1;
	}
	if(cfix[playerid] == 0 && test >= 3)// При обнаружении 3 и более цифр после '/' игрок станет подозреваемым
	{
	        format(stringer, sizeof(stringer), "{aa3333}Администрация, данный игрок подозревается в рекламе! %s[%d]", name, playerid);
	        FS4AMes(-1, stringer);
	        format(stringer, sizeof(stringer), "{aa3333}Вот что он написал: %s", str);
	        FS4AMes(-1, stringer);
			//в данном случае сообщение будет отправлено, проверка тут зависит только от администраторов, которые получат сообщение о подозрении
	        return 1;
	}
 	strmid(dsp, str, 0, strlen(str), sizeof(dsp));
 	DeleteSpaces(dsp);
 	TextToRussia(dsp);
 	//все слова для проверки писать СЛИТНО,  МАЛЕНЬКИМИ РУССКИМИ буквами, НЕ используя символы (запятые, точки и т.д.)
 	if(strfind(dsp, "хуй", true) != -1 || strfind(dsp, "пиздаебанная", true) != -1 ||
    strfind(dsp, "пошелнахуй", true) != -1 || strfind(dsp, "переехали", true) != -1 ||
    strfind(dsp, "ебалврот", true) != -1 || strfind(dsp, "мамкуебал", true) != -1 ||
    strfind(dsp, "сука", true) != -1 || strfind(dsp, "точка", true) != -1 || strfind(dsp, "7777", true) != -1
    || strfind(dsp, "бля", true) != -1
	|| strfind(dsp, "пиздец", true) != -1 || strfind(dsp, "два", true) != -1 || strfind(dsp, "три", true) != -1 || strfind(dsp, "четыре", true) != -1 || strfind(dsp, "пять", true) != -1
 	|| strfind(dsp, "чтозахуйня", true) != -1 || strfind(dsp, "семь", true) != -1 || strfind(dsp, "восемь", true) != -1 || strfind(dsp, "девять", true) != -1 || strfind(dsp, "десять", true) != -1
  	|| strfind(dsp, "десять", true) != -1 || strfind(dsp, "двадцать", true) != -1 || strfind(dsp, "тридцать", true) != -1 || strfind(dsp, "сорок", true) != -1 || strfind(dsp, "пятьдесят", true) != -1
   	|| strfind(dsp, "шестьдесят", true) != -1 || strfind(dsp, "семьдесят", true) != -1 || strfind(dsp, "восемьдесят", true) != -1 || strfind(dsp, "девяноста", true) != -1 || strfind(dsp, "сто", true) != -1
    || strfind(dsp, "двести", true) != -1 || strfind(dsp, "триста", true) != -1 || strfind(dsp, "четыреста", true) != -1 || strfind(dsp, "пятьсот", true) != -1 || strfind(dsp, "шестьсот", true) != -1
 	|| strfind(dsp, "семьсот", true) != -1 || strfind(dsp, "восемьсот", true) != -1 || strfind(dsp, "девятьсот", true) != -1)
    {
	    format(stringer, sizeof(stringer), "{aa3333}Администрация, данный игрок подозревается в рекламе! %s[%d] ", name, playerid);
	    FS4AMes(-1, stringer);
	    format(stringer, sizeof(stringer), "{aa3333}Вот что он написал: %s", str);
	    FS4AMes(-1, stringer);
  		format(stringer, sizeof(stringer), "- %s (%s)[%d]", str, name, playerid);//чтобы не палить, что сообщение не отправлено. Оформление делайте под свой чат.
        SendClientMessage(playerid, -1, stringer);
    	if(!IsPlayerInAnyVehicle(playerid))
		{
			ApplyAnimation(playerid, "PED", "IDLE_CHAT", 8.1, 0, 1, 1, 1, 1);
		}
        return 0;
    }
    cfix[playerid] = 0;
	return 1;
}

stock FS4AMes(color, str[])
{
	for(new i = GetMaxPlayers()-1; i != -1; --i)
	{
		if(GetPlayerAdminLevel(i) >= 1) SendClientMessage(i, color, str);
	}
	return 1;
}

stock DeleteSpaces(String[])
{
    new i;
    static ii;
    for(ii = 0; String[ii] != '\0'; ii++)
    {
        switch(String[ii])
        {
            case 'А'..'Я', 'а'..'я', 'A'..'Z', 'a'..'z', '@', '/', '\\': String[i++] = String[ii];
        }
    }
    String[i] = '\0';
}

stock TextToRussia(string[])
{
    new i;
	static ii;
    for (ii = 0; string[ii] != '\0'; ii++)
    {
        switch (string[ii])
        {
        case 'a': string[ii] = 'а';
        case 'A': string[ii] = 'а';
        case 'b': string[ii] = 'б';
        case 'B': string[ii] = 'в';
        case 'c': string[ii] = 'с';
        case 'C': string[ii] = 'с';
        case 'd': string[ii] = 'д';
        case 'D': string[ii] = 'д';
        case 'e': string[ii] = 'е';
        case 'E': string[ii] = 'е';
        case 'f': string[ii] = 'ф';
        case 'F': string[ii] = 'ф';
        case 'g': string[ii] = 'г';
        case 'G': string[ii] = 'г';
        case 'h': string[ii] = 'х';
        case 'H': string[ii] = 'н';
        case 'i': string[ii] = 'и';
        case 'I': string[ii] = 'и';
        case 'j': string[ii] = 'ж';
        case 'J': string[ii] = 'ж';
        case 'k': string[ii] = 'к';
        case 'K': string[ii] = 'к';
        case 'l': string[ii] = 'л';
        case 'L': string[ii] = 'л';
        case 'm': string[ii] = 'м';
        case 'M': string[ii] = 'м';
        case 'n': string[ii] = 'н';
        case 'N': string[ii] = 'н';
        case 'o': string[ii] = 'о';
        case 'O': string[ii] = 'о';
        case 'p': string[ii] = 'р';
        case 'P': string[ii] = 'р';
        case 'r': string[ii] = 'р';
        case 'R': string[ii] = 'р';
        case 's': string[ii] = 'с';
        case 'S': string[ii] = 'с';
        case 't': string[ii] = 'т';
        case 'T': string[ii] = 'т';
        case 'u': string[ii] = 'и';
        case 'U': string[ii] = 'ю';
        case 'v': string[ii] = 'в';
        case 'V': string[ii] = 'в';
        case 'q': string[ii] = 'ю';
        case 'Q': string[ii] = 'ю';
        case 'x': string[ii] = 'х';
        case 'X': string[ii] = 'х';
        case 'y': string[ii] = 'у';
        case 'Y': string[ii] = 'у';
        case 'z': string[ii] = 'з';
        case 'Z': string[ii] = 'з';
        case '@': string[ii] = 'а';
        //
        case 'А': string[ii] = 'а';
		case 'Б': string[ii] = 'б';
        case 'В': string[ii] = 'в';
        case 'Г': string[ii] = 'г';
        case 'Д': string[ii] = 'д';
        case 'Е': string[ii] = 'е';
        case 'Ё': string[ii] = 'ё';
        case 'Ж': string[ii] = 'ж';
        case 'З': string[ii] = 'з';
        case 'И': string[ii] = 'и';
        case 'Й': string[ii] = 'й';
        case 'К': string[ii] = 'к';
        case 'Л': string[ii] = 'л';
        case 'М': string[ii] = 'м';
        case 'Н': string[ii] = 'н';
        case 'О': string[ii] = 'о';
        case 'П': string[ii] = 'п';
        case 'Р': string[ii] = 'р';
        case 'С': string[ii] = 'с';
        case 'Т': string[ii] = 'т';
        case 'У': string[ii] = 'у';
        case 'Ф': string[ii] = 'ф';
        case 'Х': string[ii] = 'х';
        case 'Ц': string[ii] = 'ц';
        case 'Ч': string[ii] = 'ч';
        case 'Ш': string[ii] = 'ш';
        case 'Щ': string[ii] = 'щ';
        case 'Ь': string[ii] = 'ь';
        case 'Ъ': string[ii] = 'ъ';
        case 'Ы': string[ii] = 'ы';
        case 'Э': string[ii] = 'э';
        case 'Ю': string[ii] = 'ю';
        case 'Я': string[ii] = 'я';
        
		/*case '/':// это я не тестировал, задача определить /\ как 'л' - если есть желание - раскомментируйте и проверьте
		{
			if(!strcmp(string[ii+1], "\\", false, 1))
			{
			    string[ii] = 'л';
			    strdel(string[ii], string[ii+1], string[ii+1]);
			}
		}*/
        }
    }
    return string[i];
}
