#include <a_samp>

#define VAA 4
#define MAX_IPR 10 // Максимальное число реклам после чего идёт смена рекламируемого IP на новый неверный IP адресс.
/* Массивы */
#if VAA < 3
new Oldip[13], Newip[30];
#endif
new IPReklama[MAX_PLAYERS];


public OnPlayerText(playerid, text[])
{
	#if VAA == 0    // Если #define VAA 0 - Смена IP при выводе MAX_IPR (Стандартно - 10) сообщений
	if(strfind(text,GetStrIP(text),true) != -1)
	{
	    if(IPReklama[playerid] == 0) IPAdressAnother(text,Oldip,sizeof(Oldip),Newip,sizeof(Newip));
		if(strcmp(Oldip,GetStrIP(text),true) == 0)
		{
		    VAA0:
	    	new ns = strfind(text,Oldip,true);
			strdel(text,ns,ns+strlen(Oldip));
			strins(text,Newip,ns,sizeof(Newip));
			IPReklama[playerid]++;
            format(text,65,"{FF0000}AntiReklama: Вы подозреваетесь в рекламе нубо серверов");
			if(IPReklama[playerid] == MAX_IPR) IPReklama[playerid] = 0;
		}
		else
		{
			IPAdressAnother(text,Oldip,sizeof(Oldip),Newip,sizeof(Newip));
			format(text,65,"{FF0000}AntiReklama: Вы подозреваетесь в рекламе нубо серверов");
			goto VAA0;
		}
	}
	#elseif VAA == 4   // Если #define VAA 4 - При нахождении в сообщении IP адреса Бан
	if(strfind(text,GetStrIP(text),true) != -1)
	{
		new vaanam[MAX_PLAYER_NAME];
		GetPlayerName(playerid,vaanam,sizeof(vaanam));
		new varmsg[128];
		format(varmsg,sizeof(varmsg),"[AntiRekl] %s[%d]: попытался рекламитировать свой нубо сервер",vaanam,playerid); // Бан сообщение
		SendClientMessageToAll(0xFF0000AA,varmsg);
		return 0;
	}
	#endif
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	IPReklama[playerid] = 0;
	return 1;
}

stock IPAdressAnother(const string[],oldip[],oldiplen,newip[],newiplen)
{
	new IP[6];
	IP[0] = -1,
	IP[1] = -1,
	IP[2] = -1;
	for(new t=-1,c[3],x=strlen(string),j=0,i=0;i!=x;i++)
	switch(string[i])
	{   // Символы стоящие между цифрами вместо
				case '.','*','_','^','#','№','&','<','>','|',' ',',','-','=','+','%','$','!','@','(',')','[',']','{','}','\"','\'','/','A'..'Z','a'..'z','А'..'я':
		{
			if(t == 0 || t == 1) { j = 0; IP[t] = strval(c); c[0] = '\0'; c[1] = '\0'; c[2] = '\0'; }
			t++;
			IP[t+3] = string[i];
			if((string[i+1] >= '0' && string[i+1] <= '9') && (string[i-1] >= '0' && string[i-1] <= '9')) continue;
			else t=-1;
		}
		case '0'..'9':
		{
			if(t == -1) continue;
			c[j]=string[i];
			j++;
			if(t == 2)
			{
				if(string[i+1] >= '0' && string[i+1] <= '9') continue;
				if((j == 1 || j == 2 || j == 3) && (IP[0] != -1 && IP[1] != -1 && IP[2] == -1))
				{
					IP[t] = strval(c);
					c[0] = '\0'; c[1] = '\0'; c[2] = '\0';
					j = 0;
					t = -1;
					break;
				}
			}
		}
		default:
		{
		    j = 0;
		    t = -1;
			IP[0] = -1,
			IP[1] = -1,
			IP[2] = -1,
			IP[3] = '\0',
			IP[4] = '\0',
			IP[5] = '\0';
		}
	}
	format(oldip,oldiplen,"%c%d%c%d%c%d",IP[3],IP[0],IP[4],IP[1],IP[5],IP[2]);

	for(new i2=0;i2!=3;i2++)
	switch(IP[i2])
	{
		case 0..6: { IP[i2] -= random(5)+1; continue; }
		case 7..9: { IP[i2] -= random(5)+1; continue; }
		case 10..16: { IP[i2] += random(2)+1; continue; }
		case 17..19: { IP[i2] -= random(5)+1; continue; }
		case 20..26: { IP[i2] += random(2)+1; continue; }
		case 27..29: { IP[i2] -= random(5)+1; continue; }
		case 30..36: { IP[i2] += random(2)+1; continue; }
		case 37..39: { IP[i2] -= random(5)+1; continue; }
		case 40..46: { IP[i2] += random(2)+1; continue; }
		case 47..49: { IP[i2] -= random(5)+1; continue; }
		case 50..56: { IP[i2] += random(2)+1; continue; }
		case 57..59: { IP[i2] -= random(5)+1; continue; }
		case 60..66: { IP[i2] += random(2)+1; continue; }
		case 67..69: { IP[i2] -= random(5)+1; continue; }
		case 70..76: { IP[i2] += random(2)+1; continue; }
		case 77..79: { IP[i2] -= random(5)+1; continue; }
		case 80..86: { IP[i2] += random(2)+1; continue; }
		case 87..89: { IP[i2] -= random(5)+1; continue; }
		case 90..96: { IP[i2] += random(2)+1; continue; }
		case 97..99: { IP[i2] -= random(5)+1; continue; }
		case 100..106: { IP[i2] += random(2)+1; continue; }
		case 107..109: { IP[i2] -= random(5)+1; continue; }
		case 110..116: { IP[i2] += random(2)+1; continue; }
		case 117..119: { IP[i2] -= random(5)+1; continue; }
		case 120..126: { IP[i2] += random(2)+1; continue; }
		case 127..129: { IP[i2] -= random(5)+1; continue; }
		case 130..136: { IP[i2] += random(2)+1; continue; }
		case 137..139: { IP[i2] -= random(5)+1; continue; }
		case 140..146: { IP[i2] += random(2)+1; continue; }
		case 147..149: { IP[i2] -= random(5)+1; continue; }
		case 150..156: { IP[i2] += random(2)+1; continue; }
		case 157..159: { IP[i2] -= random(5)+1; continue; }
		case 160..166: { IP[i2] += random(2)+1; continue; }
		case 167..169: { IP[i2] -= random(5)+1; continue; }
		case 170..176: { IP[i2] += random(2)+1; continue; }
		case 177..179: { IP[i2] -= random(5)+1; continue; }
		case 180..186: { IP[i2] += random(2)+1; continue; }
		case 187..189: { IP[i2] -= random(5)+1; continue; }
		case 190..196: { IP[i2] += random(2)+1; continue; }
		case 197..199: { IP[i2] -= random(5)+1; continue; }
		case 200..206: { IP[i2] += random(2)+1; continue; }
		case 207..209: { IP[i2] -= random(5)+1; continue; }
		case 210..216: { IP[i2] += random(2)+1; continue; }
		case 217..219: { IP[i2] -= random(5)+1; continue; }
		case 220..226: { IP[i2] += random(2)+1; continue; }
		case 227..229: { IP[i2] -= random(5)+1; continue; }
		case 230..236: { IP[i2] += random(2)+1; continue; }
		case 237..239: { IP[i2] -= random(5)+1; continue; }
		case 240..246: { IP[i2] += random(2)+1; continue; }
		case 247..249: { IP[i2] -= random(5)+1; continue; }
		case 250..252: { IP[i2] += random(2)+1; continue; }
		case 253..255: { IP[i2] -= random(4)+1; continue; }
	}
	format(newip,newiplen,"%s",IP[3]);
}

stock GetStrIP(const string[])
{
	new IP[6];
	IP[0] = -1,
	IP[1] = -1,
	IP[2] = -1;
	for(new t=-1,c[3],x=strlen(string),j=0,i=0;i!=x;i++)
	switch(string[i])
	{   // Символы стоящие между цифрами вместо
		case '.','*','_','^','#','№','&','<','>','|',' ',',','-','=','+','%','$','!','@','(',')','[',']','{','}','\"','\'','/','A'..'Z','a'..'z','А'..'я':
		{
			if(t == 0 || t == 1) { j = 0; IP[t] = strval(c); c[0] = '\0'; c[1] = '\0'; c[2] = '\0'; }
			t++;
			IP[t+3] = string[i];
			if((string[i+1] >= '0' && string[i+1] <= '9') && (string[i-1] >= '0' && string[i-1] <= '9')) continue;
			else t=-1;
		}
		case '0'..'9':
		{
			if(t == -1) continue;
			c[j] = string[i];
			j++;
			if(t == 2)
			{
				if(string[i+1] >= '0' && string[i+1] <= '9') continue;
				if((j == 1 || j == 2 || j == 3) && (IP[0] != -1 && IP[1] != -1 && IP[2] == -1))
				{
					IP[t] = strval(c);
					c[0] = '\0'; c[1] = '\0'; c[2] = '\0';
					j = 0;
					t = -1;
					break;
				}
			}
		}
		default:
		{
		    j = 0;
		    t = -1;
			IP[0] = -1,
			IP[1] = -1,
			IP[2] = -1,
			IP[3] = '\0',
			IP[4] = '\0',
			IP[5] = '\0';
		}
	}
	new strip[13];
	format(strip,sizeof(strip),"%c%d%c%d%c%d",IP[3],IP[0],IP[4],IP[1],IP[5],IP[2]);
	return strip;
}
