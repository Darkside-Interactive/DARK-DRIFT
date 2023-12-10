#include <a_samp>

#define MAX_LINES 10
#define MAX_LENGTH 96
#define TD_OFFSET 8.5
#define LETTER_SIZE_X 0.25
#define LETTER_SIZE_Y 0.90

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

new DOC_Message[MAX_PLAYERS][MAX_LINES][MAX_LENGTH];
new DOC_MessageColor[MAX_PLAYERS][MAX_LINES];
new Text:DOC_MessageTextDraw[MAX_PLAYERS][MAX_LINES];

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

public OnPlayerConnect(playerid)
{
	if(!IsPlayerNPC(playerid))
	{
		for(new i=0;i<40;i++)
		    SendClientMessage(playerid,0,"\n");

		for(new i=0;i<MAX_LINES;i++)
		{
		    DOC_Message[playerid][i][0]='_';
		    DOC_MessageTextDraw[playerid][i] = TextDrawCreate(19.000000,(MAX_LINES*TD_OFFSET)-(i*MAX_LINES)+11.000000,"_");
			TextDrawAlignment(DOC_MessageTextDraw[playerid][i],0);
			TextDrawFont(DOC_MessageTextDraw[playerid][i],1);
			TextDrawLetterSize(DOC_MessageTextDraw[playerid][i],LETTER_SIZE_X,LETTER_SIZE_Y);
			TextDrawSetOutline(DOC_MessageTextDraw[playerid][i],1);
			TextDrawSetProportional(DOC_MessageTextDraw[playerid][i],1);
			TextDrawSetShadow(DOC_MessageTextDraw[playerid][i],1);
			TextDrawShowForPlayer(playerid,DOC_MessageTextDraw[playerid][i]);
		}
	}
	return CallLocalFunction("DOC_OnPlayerConnect","i",playerid);
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect DOC_OnPlayerConnect

forward DOC_OnPlayerConnect(playerid);

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

public OnPlayerDisconnect(playerid,reason)
{
    if(!IsPlayerNPC(playerid))
	{
		for(new i=0;i<MAX_LINES;i++)
		    TextDrawDestroy(DOC_MessageTextDraw[playerid][i]);
	}
	return CallLocalFunction("DOC_OnPlayerDisconnect","ii",playerid,reason);
}

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect DOC_OnPlayerDisconnect

forward DOC_OnPlayerDisconnect(playerid,reason);

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

public OnPlayerText(playerid,text[])
{
	if(CallLocalFunction("DOC_OnPlayerText","is",playerid,text))
		DOC_SendPlayerMessageToAll(playerid,text);
		
	for(new i=0;i<10;i++)
	    SendClientMessage(playerid,0,"\n");
	return 0;
}

#if defined _ALS_OnPlayerText
	#undef OnPlayerText
#else
	#define _ALS_OnPlayerText
#endif
#define OnPlayerText DOC_OnPlayerText

forward DOC_OnPlayerText(playerid,text[]);

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

forward DOC_SendClientMessage(playerid,color,message[]);
public DOC_SendClientMessage(playerid,color,message[])
{
	if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid) && message[0])
	{
		for(new i=0;i<10;i++)
	    	SendClientMessage(playerid,0,"\n");
	    	
	    for(new i=MAX_LINES-1;i>0;i--)
	    {
	        DOC_Message[playerid][i]=DOC_Message[playerid][i-1];
	        DOC_MessageColor[playerid][i]=DOC_MessageColor[playerid][i-1];
	        
	        TextDrawHideForPlayer(playerid,DOC_MessageTextDraw[playerid][i]);
	        TextDrawSetString(DOC_MessageTextDraw[playerid][i],DOC_Message[playerid][i]);
	        TextDrawColor(DOC_MessageTextDraw[playerid][i],DOC_MessageColor[playerid][i]);
	        TextDrawShowForPlayer(playerid,DOC_MessageTextDraw[playerid][i]);
	    }
	    
	    format(DOC_Message[playerid][0],MAX_LENGTH,message);
	    DOC_MessageColor[playerid][0]=color;
	    
	    TextDrawHideForPlayer(playerid,DOC_MessageTextDraw[playerid][0]);
	    TextDrawSetString(DOC_MessageTextDraw[playerid][0],DOC_Message[playerid][0]);
		TextDrawColor(DOC_MessageTextDraw[playerid][0],DOC_MessageColor[playerid][0]);
		TextDrawShowForPlayer(playerid,DOC_MessageTextDraw[playerid][0]);
	    return 1;
	}
	return 0;
}

forward DOC_SendClientMessageToAll(color,message[]);
public DOC_SendClientMessageToAll(color,message[])
{
	if(message[0])
	{
		for(new i=0;i<MAX_PLAYERS;i++)
			DOC_SendClientMessage(i,color,message);
		return 1;
	}
	return 0;
}

forward DOC_SendPlayerMessageToPlayer(playerid,senderid,message[]);
public DOC_SendPlayerMessageToPlayer(playerid,senderid,message[])
{
	if(IsPlayerConnected(playerid) && IsPlayerConnected(senderid) && message[0])
	{
	    for(new i=0;i<strlen(message);i++)
	        if(message[i]=='~')
	            message[i]='_';
	            
	    new string[MAX_LENGTH];
		GetPlayerName(senderid,string,sizeof(string));
		format(string,sizeof(string),"%s:~w~ %s",string,message);
		
		new r,g,b,a;
		DOC_HexToRGBA(GetPlayerColor(senderid),r,g,b,a);
		DOC_SendClientMessage(playerid,DOC_RGBAToHex(r,g,b,255),string);
		return 1;
	}
	return 0;
}

forward DOC_SendPlayerMessageToAll(senderid,message[]);
public DOC_SendPlayerMessageToAll(senderid,message[])
{
	if(IsPlayerConnected(senderid) && message[0])
	{
	    for(new i=0;i<strlen(message);i++)
	        if(message[i]=='~')
	            message[i]='_';

	    new string[MAX_LENGTH];
		GetPlayerName(senderid,string,sizeof(string));
		format(string,sizeof(string),"%s:~w~ %s",string,message);

		new r,g,b,a;
		DOC_HexToRGBA(GetPlayerColor(senderid),r,g,b,a);
		DOC_SendClientMessageToAll(DOC_RGBAToHex(r,g,b,255),string);
		return 1;
	}
	return 0;
}

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

stock DOC_RGBAToHex(red, green, blue, a) //By Betamaster
{
	return (red<<24 | green<<16 | blue<<8 | a);
}

stock DOC_HexToRGBA(colour, &red, &green, &blue, &a) //By Betamaster
{
	red   = (colour >> 24) & 0xFF;
	green = (colour >> 16) & 0xFF;
	blue  = (colour >> 8) & 0xFF;
	a = colour & 0xFF;
}

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

#define SendClientMessage DOC_SendClientMessage
#define SendClientMessageToAll DOC_SendClientMessageToAll
#define SendPlayerMessageToPlayer DOC_SendPlayerMessageToPlayer
#define SendPlayerMessageToAll DOC_SendPlayerMessageToAll