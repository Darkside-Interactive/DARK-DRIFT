//
// Created:     05.09.06
// Aurthor:    Iain Gilbert
//

#if defined _gtoutils_included
  #endinput
#endif

#define _gtoutils_included
#pragma library gtoutils
#include "base"
#include "lang"

forward SendPlayerScrollingText(playerid,text[]);
forward TextScroller();
forward strcharsplit(string[], &index,seperator);
forward strchar(string[2]);
forward charstr(character);
forward CharReplace(findchar,newchar,string[MAX_STRING]);
forward Vary(source,varyamount);
forward strcomp(str1[],str2[],bool:ignorecase);
forward NameCharCheck(string[MAX_STRING]);
forward StringCharCheck(string[MAX_STRING]);
forward SendPlayerFormattedText(playerid, const str[], define, colour);
forward SendAllFormattedText(const str[], define);
forward SendClientMessageToRegistered(colour, message[]);
forward ConvertSeconds(time);
forward encryptbykey(string[],key[MAX_STRING]);
forward PlayerCount();
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward GetPointDistanceToPointEx(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2);
forward IsPlayerInSphere(playerid,Float:x,Float:y,Float:z,radius);

EncodeName(nickname[])
{
	new tmp[MAX_STRING];
	set(tmp,nickname);
	new newchar = strchar("_");

	for (new i=0;i<MAX_STRING;i++)
	{
		if (tmp[i]==0) break; // null
	    if (((tmp[i]>=strchar("a")) && (tmp[i]<=strchar("z"))) || ((tmp[i]>=strchar("A")) && (tmp[i]<=strchar("Z"))) || ((tmp[i]>=strchar("0")) && (tmp[i]<=strchar("9"))))
	    {
			continue;
	    }
	    else
	    {
	        if (tmp[i] == strchar(".")) continue; // temp fix until new db handler is finished
	        tmp[i] = newchar;
		}
	}
	tmp=CharReplace(DBSeperator,newchar,tmp);
	tmp=CharReplace(strchar(" "),newchar,tmp);
	tmp=CharReplace(strchar("\n"),newchar,tmp);
	return tmp;
}


ovalstr(value)
{
	new temp[MAX_STRING];
	valstr(temp,value); // level
	return temp;
}

PlaySoundForPlayer(playerid,soundid)
{
	new Float:playerx,Float:playery,Float:playerz;
	GetPlayerPos(playerid,playerx,playery,playerz);
	PlayerPlaySound(playerid,soundid,playerx,playery,playerz);
}

FormatPosition(position)
{
	new string[MAX_STRING];
	if (position == 1)
	{
	    format(string, sizeof(string), "%dst!",position);
	}
	else if (position == 2)
	{
		format(string, sizeof(string), "%dnd!",position);
	}
	else if (position == 3)
	{
		format(string, sizeof(string), "%drd!",position);
	}
	else
	{
		format(string, sizeof(string), "%dth",position);
	}
	return string;
}


#define TEXT_SCROLL_SPEED 1000
#define TEXT_SCROLL_SIZE 1023
new ScrollingText[MAX_PLAYERS][TEXT_SCROLL_SIZE]; // hmmmmm
public SendPlayerScrollingText(playerid,text[])
{
	for (new i = 0;i<strlen(text);i++)
	{
	    if (text[i] == 0) break;
	    if (text[i] == strchar("\n")) text[i] = strchar("_");
	}

	if (strlen(text) > 150) //  not allowed
	{
		SendClientMessage(playerid, COLOUR_MISC, text);
  		return;
	}
	new wbreak;
	while ((strlen(ScrollingText[playerid]) > (TEXT_SCROLL_SIZE  - strlen(text))) && (wbreak < 5))
	{
		ScrollText(playerid);
		wbreak++;
	}
	if (wbreak >=5)
	{
		strdel(ScrollingText[playerid], 0, strlen(ScrollingText[playerid])-1);
	}
	strins(ScrollingText[playerid],text,strlen(ScrollingText[playerid]),TEXT_SCROLL_SIZE-1);
	strins(ScrollingText[playerid],"\n",strlen(ScrollingText[playerid]),TEXT_SCROLL_SIZE-1);
}

ScrollText(id)
{
	if (IsPlayerConnected(id))
	{
	    if (strlen(ScrollingText[id]) == 0) return;
		new string[MAX_STRING];
	    new idx;
	    set(string,strcharsplit(ScrollingText[id],idx,strchar("\n")));
	    if (strlen(string) < 1) return;
	    new colour;
	    if ((string[0] == strchar("~")) && (string[2] == strchar("~")))
	    {
	        if (string[1] == strchar("r")) colour = COLOUR_RED;
	        else if (string[1] == strchar("g")) colour = COLOUR_GREEN;
            else if (string[1] == strchar("b")) colour = COLOUR_BLUE;
            else if (string[1] == strchar("y")) colour = COLOUR_YELLOW;
            strdel(string, 0, 3);
        }
        if (colour != 0)
        {
        	SendClientMessage(id, colour, string);
        }
        else
        {
	       	SendClientMessage(id, COLOUR_MISC, string);
	  	}
		strdel(ScrollingText[id], 0, idx);
			
	}
	else
	{
		strdel(ScrollingText[id], 0, strlen(ScrollingText[id])-1);
	}
	return;
}

public TextScroller()
{
	for (new id = 0;id<MAX_PLAYERS;id++)
	{
		if (IsPlayerConnected(id))
		{
		    ScrollText(id);
		}
	}
}

/*
strstrsplit(const string[],index,seperator[20])
{
	new result[MAX_STRING];
	for (new i=index;i<strlen(string);i++)
	{
		if (string[i] == 0) break;
		if (string[i] == seperator[0])
		{
		    new isseperator;
		    for (new i2=1;i<strlen(seperator);i++)
		    {
				if (string[i+i2] != seperator[i2]) break;
				
				if (i == strlen(seperator) - 1)
				{
				    isseperator = 1;
				}
		    }
		    
		    if (isseperator)
		    {
		    	for (new i2=0;i<strlen(seperator);i++)
		    	{
		    		result[i-index] = string[i];
		}
		else
		{
		    continue;
		}
		
		
	}
	return result;
}
*/
strcharsplit(string[], &index,seperator)
{
	new result[MAX_STRING];
	new idxpos = index;
	for (new i=index;i<strlen(string);i++)
	{
	    index++;
		if (string[i] == seperator) break;
		if (string[i] == 0) break;
		result[i-idxpos] = string[i];
		
	}
	return result;
}

public strchar(string[2])
{
	return string[0];
}

charstr(character)
{
	new string[2];
	string[0] = character;
	return string;
}

CharReplace(findchar,newchar,string[MAX_STRING])
{
	for (new i = 0;i<MAX_STRING;i++)
	{
		if (string[i] == findchar)
		{
		    if (string[i] == 0) break;
		    string[i] = newchar;
		}
	}
	return string;
}

public Vary(source,varyamount)
{
	new rnd = random((varyamount*2)+1) - varyamount;
	source = source + rnd;
	return source;
}

// strcmp() returns are fucked, this is an override to fix returns
// will return 1/true if strings are equal
public strcomp(str1[],str2[],bool:ignorecase)
{
	if ((!strlen(str1)) && (!strlen(str2))) return 1;
	if (!strlen(str1)) return 0;
	if (!strlen(str2)) return 0;
	if (strcmp(str1,str2,ignorecase) == 0)
	{
	    return 1;
	}
	return 0;
}

public NameCharCheck(string[MAX_STRING])
{
	for (new i=0;i<MAX_STRING;i++)
	{
	    if (string[i]==0) return 1; // null
		if (string[i] < 32) return 0;
		if (string[i] > 125) return 0;
	}
	return 1;
}

public StringCharCheck(string[MAX_STRING])
{
	for (new i=0;i<MAX_STRING;i++)
	{
	    if (string[i]==0) return 1; // null
		if ((string[i]<48) && (string[i]!=32)) return 0;
		if (string[i]>57 && string[i]<65) return 0;
		if (string[i]>90 && string[i]<97) return 0;
		if (string[i]>122) return 0;
	}
	return 1;
}

public SendPlayerFormattedText(playerid, const str[], define, colour)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessage(playerid, colour, tmpbuf);
}

public SendAllFormattedText(const str[], define)
{
	new tmpbuf[256];
	format(tmpbuf, sizeof(tmpbuf), str, define);
	SendClientMessageToAll(COLOUR_MISC, tmpbuf);
}

public SendClientMessageToRegistered(colour, message[])
{
	for (new playerid=0;playerid<MAX_PLAYERS;playerid++)
	{
	    if (IsPlayerConnected(playerid))
	    {
	        if (IsPlayerRegistered(playerid))
	        {
	        	SendClientMessage(playerid, colour, message);
			}
		}
	}
}


//ConvertSeconds by El Presy
//Converts an ammount of seconds into hours/minutes/seconds
ConvertSeconds(time)
{
new string[40];
//Less than 1 minute
if(time < 60)
format(string, sizeof(string), "%d seconds", time);
//1 minute
else if(time == 60)
string = "1 minute";
//From 1 minute to 59 minutes
else if(time > 60 && time < 3600){
new Float: minutes;
new seconds;
minutes = time / 60;
seconds = time % 60;
format(string, sizeof(string), "%.0f minutes and %d seconds", minutes, seconds);
//1 hour
}else if(time == 3600)
string = "1 hour";
//More than 1 hour
else if(time > 3600){
new Float: hours;
new minutes_int;
new Float: minutes;
new seconds;
hours = time / 3600;
minutes_int = time % 3600;
minutes = minutes_int / 60;
seconds = minutes_int % 60;
format(string, sizeof(string), "%.0f hours, %.0f minutes and %d seconds", hours, minutes, seconds);
}
return string;
}

// encrypt(string[]) by Alex "Y_Less" Cole, Based on code by Jeremy Cole
//
// slightly modified by Iain for use with GTO - 03.11.06
stock encryptbykey(string[],key[MAX_STRING])
{
	new size = strlen(key);
	//static size = sizeof(key) - 1;
	// Theres a slight bug, you don't want to count the end \0

	new retval[64];
	// Passwords limited to 48 chars (64 - 16 for rounding)

	new j, k, sum, tmp[] = {0, 0};
	// Initialise the variables

	j = strlen(string);
	sum = j;
	// Get the length of the source string

	k = ((j >> 4) + 1) << 4;
	// Round up to the nearest 16 (trust me, it does)

	for (new i = 0; i < k; i++)
	{
		if (i < j)
		{
			tmp[0] = string[i];
			// Get the next character
		}
		else
		{
			tmp[0] = ' ';
			// Add the padding
		}

		sum = ((sum + strfind(key, tmp) + 1) % size);
		// Add the new position to the running total and limit
		// it to the size of the array (thus carrying character
		// data over to the next)

		retval[i] = key[sum];
		// Add the new character to the running array.
	}
	return retval;
}

public PlayerCount()
{
	new count = 0;

	for (new playerid=0; playerid<MAX_PLAYERS;playerid++)
	{
        if (IsPlayerConnected(playerid)) count++;
	}
	return count;
}

stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}

stock Float:Distance(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2,bool:noz) {
  new Float:result;
  if (!noz) result=floatsqroot((x2-x)*(x2-x)+(y2-y)*(y2-y)+(z2-z)*(z2-z)); else
      result=floatsqroot((x2-x)*(x2-x)+(y2-y)*(y2-y));
  if (result<0) { result=(-1)*result; }
  return result;
}

stock Float:PlayerDistanceTo(playerid,Float:x,Float:y,Float:z,bool:noz) {
	new Float:px,Float:py,Float:pz;
	GetPlayerPos(playerid,px,py,pz);
  	return Distance(x,y,z,px,py,pz,noz);
}

stock GetPlayerDistanceToPointEx(playerid,Float:x,Float:y,Float:z) //By Sacky (Edited by Smugller)
{
new Float:x1,Float:y1,Float:z1;
new Float:dis;
GetPlayerPos(playerid,x1,y1,z1);
dis = floatsqroot((x-x1)*(x-x1)+(y-y1)*(y-y1)+(z-z1)*(z-z1));
return floatround(dis);
}

Report(playerid,reason[])
{
	new string[MAX_STRING];
	format(string,sizeof(string),lang_texts[537],oGetPlayerName(playerid),reason);
        			
	for (new id=0;id<MAX_PLAYERS;id++)
	{
    		if (IsPlayerConnected(id))
    		{
        		if (IsPlayerAdmin(id) || IsPlayerAdm(id) || IsPlayerMod(id))
        		{
				SendClientMessage(id,COLOUR_BLUE,string);
			}
		}
	}
}


stock GetDistanceBetweenVehicles(vehicleid, vehicleid2) //Based on code By Slick (Edited by Smugller thx for Y_Less )
{
new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
new Float:dis;
GetVehiclePos(vehicleid,x1,y1,z1);
GetVehiclePos(vehicleid2,x2,y2,z2);
dis = floatsqroot((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1));
return floatround(dis);
}

public GetPointDistanceToPointEx(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2) //By Sacky
{
new Float:tmpdis;
tmpdis = floatsqroot(floatpower(floatabs(floatsub(x,x2)),2)+floatpower(floatabs(floatsub(y,y2)),2)+floatpower(floatabs(floatsub(z,z2)),2));
return floatround(tmpdis);
}

public IsPlayerInSphere(playerid,Float:x,Float:y,Float:z,radius) //By Sacky
{
if(GetPlayerDistanceToPointEx(playerid,x,y,z) < radius){
return 1;
}
return 0;
}