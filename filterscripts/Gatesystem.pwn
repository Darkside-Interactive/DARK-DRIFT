/*Version : 1.3
-Updates , bug fixes.
-New!!! Password system added.
-Fixed , some old mistakes
-Fixed Delete all gates bug
-Fixed Re-load all gates bug
-Fixed Delete gate bug
-Fixed Gateinfo command.*/
#define FILTERSCRIPT
#include <a_samp>
#include <YSI\y_commands>
#include <YSI\y_ini>
#include <easyDialog>
#define GatePath  "gates/%d.ini"
#define MAX_GATES 500//You can edit but not recommended through looping to all gates.
#if defined FILTERSCRIPT
new
	gateedit;
enum ginfo
{
    gID,
    gModel,
    gOpened,
    gClosed,
    Float:gPosx,
    Float:gPosy,
    Float:gPosz,
    Float:gRox,
    Float:gRoy,
    Float:gRoz,
    gText1[20],
    Gatepass,
	ghavepass
}
new GateInfo[MAX_GATES][ginfo];

public OnFilterScriptInit()
{
   	for(new i = 0; i <= MAX_GATES; i++)
  	{
  	    new
		  	gFile[35];
		format(gFile, 35, GatePath ,i);
		if(fexist(gFile))
		{
			INI_ParseFile(gFile, "LoadGates", .bExtra = true, .extra = i);
			Loadgate(i);
		}
	}
 	if(!fexist("gates"))
    {
    print("  [Gate system] - Warning!!! You haven't create folder 'gates' yet.");
    }
	if(fexist("gates"))
	{
	print("  [Gate system] - has been loaded , Creator : Electric.");
	print("  [Gate system] - please make sure this filterscript name is 'Gatesystem'");
	print("  [Gate system] - don't try to change because it won't load the objects.");
	}
	return 1;
}
stock Loadgate(i)
{
	GateInfo[i][gModel] = CreateObject(GateInfo[i][gModel],GateInfo[i][gPosx],GateInfo[i][gPosy],GateInfo[i][gPosz],GateInfo[i][gRox],GateInfo[i][gRoy],GateInfo[i][gRoz],90.0);
	GateInfo[i][gText1] = SetObjectMaterialText(GateInfo[i][gModel], "{FFFFFF}Press {FF0000}Y{FFFFFF} to open", 0, OBJECT_MATERIAL_SIZE_256x128,\"Arial", 28, 0, 0xFFFF8200, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
}
public OnFilterScriptExit()
{

	return 1;
}
forward LoadGates(id, name[], value[]);
public LoadGates(id, name[], value[])
{
    INI_Int("Model", GateInfo[id][gModel]);
    INI_Int("Opened", GateInfo[id][gOpened]);
    INI_Int("Closed", GateInfo[id][gClosed]);
    INI_Int("Password", GateInfo[id][Gatepass]);
    INI_Float("gPosx", GateInfo[id][gPosx]);
    INI_Float("gPosy", GateInfo[id][gPosy]);
    INI_Float("gPosz", GateInfo[id][gPosz]);
    INI_Float("gRox", GateInfo[id][gRox]);
    INI_Float("gRoy", GateInfo[id][gRoy]);
    INI_Float("gRoz", GateInfo[id][gRoz]);
  	INI_String("Text1", GateInfo[id][gText1],20);
  	INI_Int("Havepass", GateInfo[id][ghavepass]);
    return 1;
}
YCMD:gate(playerid,params[],help)
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,-1,"{FF0000}ERROR: �� �� ������������ � ������� ����� ������������ ��� �������!");
    Dialog_Show(playerid, Gate, DIALOG_STYLE_LIST, "{05A300}���� �����", "{FFFFFF}������� ������\n{FFFFFF}������������� ������\n{FFFFFF}������� ������\n{FFFFFF}������� ��� ������\n{FFFFFF}������������� ��� ������\n{FFFFFF}�������� ������ �� ������\n{FFFFFF}��������� ������ �� ������\n{FFFFFF}�������� ������ �����", "�������", "������");
	return 1;
}
YCMD:gateinfo(playerid, params[], help)
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,-1,"{FF0000}ERROR: �� �� ������������ � ������� ����� ������������ ��� �������!");
	for( new i = 0; i != MAX_GATES; i++ )
	{
		if(IsPlayerInRangeOfPoint( playerid, 10.0, GateInfo[i][gPosx], GateInfo[i][gPosy], GateInfo[i][gPosz]))
		{
			new
				string[128];
			format(string,128, "{FFFFFF}�� �����: %d |������ �����: %d | ������� X: %.0f |������� Y:%.0f |������� Z:%.0f| ����� �����: %s",GateInfo[i][gID],GateInfo[i][gModel],GateInfo[i][gPosx],GateInfo[i][gPosy],GateInfo[i][gPosz],GateInfo[i][gText1]);
			SendClientMessage(playerid, -1, string);
			return 1;
		}
	}
	return 1;
}
Dialog:Gate(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    if(listitem == 0)
	    {
			Dialog_Show(playerid,gatecreate,DIALOG_STYLE_LIST,"{05A300}Choose gate","{FFFFFF}Gate 1\n{FFFFFF}Gate 2\n{FFFFFF}Gate 3\n{FFFFFF}Gate 4","Select","Cancel");
	    }
	    if(listitem == 1)
	    {
	        Dialog_Show(playerid,editgate,DIALOG_STYLE_INPUT ,"{05A300}Edit gate","{FFFFFF}Please insert gate id you want to edit.\n�{FFCC00}Note{FFFFFF}: Do not exceed the maximum gate id otherwise may cause a crash.","Select","");
	    }
	    if(listitem == 2)
	    {
	        Dialog_Show(playerid,delconfirm2,DIALOG_STYLE_INPUT ,"{05A300}Delete confirmation","�{FFCC00}Insert {FFFFFF}the gate you wish to delete!","Select","");
	    }
	    if(listitem == 3)
	    {
        	Dialog_Show(playerid, delconfirm, DIALOG_STYLE_MSGBOX, "{05A300}Delete confirmation", "{FFFFFF}Are you sure you want to delete all gates ?\n�{FFCC00}Note {FFFFFF}: You can't restore gates , also all created gates will be deleted.", "Select", "Cancel");
	    }
	    if(listitem == 4)
	    {
  			for(new i; i<MAX_GATES; i++)
			{
     			if(IsValidObject(i))
          		DestroyObject(i);
			}
			new
			    string[64];
			format(string,sizeof(string),"reloadfs Gatesystem");
			SendRconCommand(string);
			for(new i = 0; i < 50; i++) SendClientMessage(playerid,-1," ");
			SendClientMessage(playerid,-1,"�{FFCC00}Gate -{FFFFFF} All gates has been re-loaded");
	    }
	    if(listitem == 5)
	    {
			Dialog_Show(playerid,addpass,DIALOG_STYLE_INPUT,"{05A300}Enable passsword","{FFFFFF}Please insert the GateID you with to add password for.","Select","");
	    }
	    if(listitem == 6)
	    {
			Dialog_Show(playerid,disablepass,DIALOG_STYLE_INPUT,"{05A300}Disable passsword","{FFFFFF}Please insert the GateID you with to disable password for.","Select","");
	    }
	    if(listitem == 7)
	    {
		    Dialog_Show(playerid,changepass,DIALOG_STYLE_INPUT,"{05A300}Change passsword","{FFFFFF}Please enter your new password.","Select","");
	    }
	}
	return 1;
}
Dialog:changepass(playerid, response, listitem, inputtext[])
{
	if(response)
	{
 		new
			string[64];
     	format(string, sizeof(string), GatePath, strval(inputtext));
		if(strval(inputtext) >= MAX_GATES) return SendClientMessage(playerid,-1,"�{FFCC00}Gate {FFFFFF} - You've exceed the maximum limits of gates allowed.");
     	if(!strval(inputtext)) return SendClientMessage( playerid, -1, "�{FFCC00}Gate {FFFFFF} - Insert numbers only please." );
		if(!fexist(string)) return SendClientMessage(playerid, -1, "�{FFCC00}Gate {FFFFFF} - You've entered wrong gate id (not exists).");
        new INI:File = INI_Open(string);
    	INI_WriteInt(File,"Password", strval(inputtext));
    	INI_Close(File);
    	SendClientMessage(playerid, -1, "�{FFCC00}Gate {FFFFFF} - You've sucusfully change password for this gate.");
	}
	return 1;
}
Dialog:disablepass(playerid, response, listitem, inputtext[])
{
	if(response)
	{
 		new
			string[64];
     	format(string, sizeof(string), GatePath, strval(inputtext));
		if(strval(inputtext) >= MAX_GATES) return SendClientMessage(playerid,-1,"�{FFCC00}Gate {FFFFFF} - You've exceed the maximum limits of gates allowed.");
     	if(!strval(inputtext)) return SendClientMessage( playerid, -1, "�{FFCC00}Gate {FFFFFF} - Insert numbers only please." );
		if(!fexist(string)) return SendClientMessage(playerid, -1, "�{FFCC00}Gate {FFFFFF} - You've entered wrong gate id (not exists).");
        new INI:File = INI_Open(string);
    	INI_WriteInt(File,"Havepass", 0);
    	INI_Close(File);
    	SendClientMessage(playerid, -1, "�{FFCC00}Gate {FFFFFF} - You've sucussfully disabled password for this gate.");
	}
	return 1;
}
Dialog:addpass(playerid, response, listitem, inputtext[])
{
	if(response)
	{
 		new
			string[64];
     	format(string, sizeof(string), GatePath, strval(inputtext));
		if(strval(inputtext) >= MAX_GATES) return SendClientMessage(playerid,-1,"�{FFCC00}Gate {FFFFFF} - You've exceed the maximum limits of gates allowed.");
     	if(!strval(inputtext)) return SendClientMessage( playerid, -1, "�{FFCC00}Gate {FFFFFF} - Insert numbers only please." );
		if(!fexist(string)) return SendClientMessage(playerid, -1, "�{FFCC00}Gate {FFFFFF} - You've entered wrong gate id (not exists).");
        new INI:File = INI_Open(string);
    	INI_WriteInt(File,"Havepass", 1);
    	INI_Close(File);
    	SendClientMessage(playerid, -1, "�{FFCC00}Gate {FFFFFF} - You've sucussfully enabled password for this gate, default gate pass is :{FFCC00} 1234");
	}
	return 1;
}
Dialog:delconfirm2(playerid, response, listitem, inputtext[])
{
	if(response)
	{
 		new
			string[64];
     	format(string, sizeof(string), GatePath, strval(inputtext));
		if(strval(inputtext) >= MAX_GATES) return SendClientMessage(playerid,-1,"�{FFCC00}Gate {FFFFFF} - You've exceed the maximum limits of gates allowed.");
     	if(!strval(inputtext)) return SendClientMessage( playerid, -1, "�{FFCC00}Gate {FFFFFF} - Insert numbers only please." );
		if(!fexist(string)) return SendClientMessage(playerid, -1, "�{FFCC00}Gate {FFFFFF} - You've entered wrong gate id (not exists).");
		new
		    string2[64],string3[126];
		format(string2,sizeof(string2),"/gates/%d.ini",strval(inputtext));
        fremove(string2);
        format(string3,sizeof(string3),"�{FFCC00}Gate -{FFFFFF} You've sucussfully deleted GateID :{FFCC00} %d",strval(inputtext));
        SendClientMessage(playerid,-1,string3);
	}
	return 1;
}
Dialog:delconfirm(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		for(new i = 0; i <= MAX_GATES; i++)
  		{
  	    	new
		  		gFile[35];
			format(gFile, 35, GatePath ,i);
			if(fexist(gFile))
			{
                fremove(gFile);
                SendClientMessage(playerid,-1,"�{FFCC00}Gate - {FFFFFF}All gates has sucussfully removed.");
 				if(IsValidObject(i))
  				DestroyObject(i);
			}
		}
	}
	return 1;
}
Dialog:editgate(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    new
			string[64];
     	format(string, sizeof(string), GatePath, strval(inputtext));
		if(strval(inputtext) >= MAX_GATES) return SendClientMessage(playerid,-1,"�{FFCC00}Gate {FFFFFF} - You've exceed the maximum limits of gates allowed.");
     	if(!strval(inputtext)) return SendClientMessage( playerid, -1, "�{FFCC00}Gate {FFFFFF} - Insert numbers only please." );
		if(!fexist(string)) return SendClientMessage(playerid, -1, "�{FFCC00}Gate {FFFFFF} - You've entered wrong gate id (not exists).");
		new
		    string2[64];
		format(string2,sizeof(string2),"{FFFFFF}GateID :%d",strval(inputtext));
		Dialog_Show(playerid,editgate22,DIALOG_STYLE_LIST,string2,"Move gate\nDelete gate","Select","");
		SetPVarInt(playerid,"gatedeleteid",strval(inputtext));
	}
	return 1;
}
Dialog:editgate22(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    if(listitem == 0)
	    {

	    }
		if(listitem == 1)
		{
			new
		    	string2[64],string3[64];
			format(string2,sizeof(string2),"/gates/%d.ini",GetPVarInt(playerid,"gatedeleteid"));
        	fremove(string2);
        	format(string3,sizeof(string3),"�{FFCC00}Gate - {FFFFFF}You've sucussfully deleted GateID :{FFCC00} %d",GetPVarInt(playerid,"gatedeleteid"));
        	SendClientMessage(playerid,-1,string3);
        	for(new i = 0; i <= MAX_GATES; i++)
        	{
				DestroyObject(GetPVarInt(playerid,"gatedeleteid"));
        	}
		}
	}
	return 1;
}
Dialog:gatecreate(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	    if(listitem == 0)
	    {
			Dialog_Show(playerid,confirm1,DIALOG_STYLE_INPUT,"{05A300}GateID","{FFFFFF}Please choose new gate id not created before for\n�{FFCC00}Note {FFFFFF}: Don't create id already created in gates path.\nChoosen GateID :{FFCC00} Gate 1","Select","");
	    }
	    if(listitem == 1)
	    {
			Dialog_Show(playerid,confirm2,DIALOG_STYLE_INPUT,"{05A300}GateID","{FFFFFF}Please choose new gate id not created before\n�{FFCC00}Note {FFFFFF}: Don't create id already created in gates path.\nChoosen GateID :{FFCC00} Gate 2","Select","");
	    }
	    if(listitem == 2)
	    {
			Dialog_Show(playerid,confirm3,DIALOG_STYLE_INPUT,"{05A300}GateID","{FFFFFF}Please choose new gate id not created before\n�{FFCC00}Note {FFFFFF}: Don't create id already created in gates path.\nChoosen GateID :{FFCC00} Gate 3","Select","");
	    }
	    if(listitem == 3)
	    {
        	Dialog_Show(playerid,confirm4,DIALOG_STYLE_INPUT,"{05A300}GateID","{FFFFFF}Please choose new gate id not created before\n�{FFCC00}Note {FFFFFF}: Don't create id already created in gates path.\nChoosen GateID :{FFCC00} Gate 3","Select","");
	    }
	    return 1;
	}
	return 1;
}
Dialog:confirm1(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
   			string[64],string2[64];
		format(string2,sizeof(string2),"�{FFCC00}Gate {FFFFFF}- Insert number between 1-%d",MAX_GATES);
     	format(string, sizeof(string), GatePath, strval(inputtext));
		if(strval(inputtext) >= MAX_GATES) return SendClientMessage(playerid,-1,string2);
     	if(!strval(inputtext)) return SendClientMessage( playerid, -1, "�{FFCC00}Gate - {FFFFFF}Insert numbers only please." );
		if(fexist(string)) return SendClientMessage(playerid, -1, "�{FFCC00}Gate - {FFFFFF} A gate already created on the same id , choose another one.");
  		new Float:x,Float:y,Float:z;
    	GetPlayerPos(playerid,x,y,z);
     	gateedit = CreateObject(988, x, y+2.5, z, 0.0, 0.0, 0.0);
      	EditObject(playerid,gateedit);
       	SetPVarInt(playerid, "gatemodel", 988);
        SetPVarInt(playerid,"file",strval(inputtext));
	}
	return 1;
}
Dialog:confirm2(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
   			string[64],string2[64];
		format(string2,sizeof(string2),"Gate - Insert number between 1-%d",MAX_GATES);
     	format(string, sizeof(string), GatePath, strval(inputtext));
		if(strval(inputtext) >= MAX_GATES) return SendClientMessage(playerid,-1,string2);
    	if(!strval(inputtext)) return SendClientMessage( playerid, -1, "Gate - Insert numbers only please." );
		if(fexist(string)) return SendClientMessage(playerid, -1, "�{FFCC00}Gate {FFFFFF} - A gate already created on the same id , choose another one.");
		new
			Float:x,Float:y,Float:z;
  		GetPlayerPos(playerid,x,y,z);
    	gateedit = CreateObject(985, x, y+2.5, z, 0.0, 0.0, 0.0);
     	EditObject(playerid,gateedit);
      	SetPVarInt(playerid, "gatemodel", 985);
       	SetPVarInt(playerid,"file",strval(inputtext));
	}
	return 1;
}
Dialog:confirm3(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
   			string[64],string2[64];
		format(string2,sizeof(string2),"Gate - Insert number between 1-%d",MAX_GATES);
     	format(string, sizeof(string), GatePath, strval(inputtext));
		if(strval(inputtext) >= MAX_GATES) return SendClientMessage(playerid,-1,string2);
    	if(!strval(inputtext)) return SendClientMessage( playerid, -1, "�{FFCC00}Gate {FFFFFF} - Insert numbers only please." );
		if(fexist(string)) return SendClientMessage(playerid, -1, "�{FFCC00}Gate {FFFFFF}- A gate already created on the same id , choose another one.");
		new Float:x,Float:y,Float:z;
  		GetPlayerPos(playerid,x,y,z);
    	gateedit = CreateObject(986, x, y+2.5, z, 0.0, 0.0, 0.0);
     	EditObject(playerid,gateedit);
      	SetPVarInt(playerid, "gatemodel", 986);
       	SetPVarInt(playerid,"file",strval(inputtext));
	}
	return 1;
}
Dialog:confirm4(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		new
   			string[64],string2[64];
		format(string2,sizeof(string2),"Gate - Insert number between 1-%d",MAX_GATES);
     	format(string, sizeof(string), GatePath, strval(inputtext));
		if(strval(inputtext) >= MAX_GATES) return SendClientMessage(playerid,-1,string2);
      	if(!strval(inputtext)) return SendClientMessage( playerid, -1, "�{FFCC00}Gate {FFFFFF} - Insert numbers only please." );
		if(fexist(string)) return SendClientMessage(playerid, -1, "�{FFCC00}Gate {FFFFFF} - A gate already created on the same id , choose another one.");
		new Float:x,Float:y,Float:z;
    	GetPlayerPos(playerid,x,y,z);
     	gateedit = CreateObject(971, x, y+2.5, z, 0.0, 0.0, 0.0);
      	EditObject(playerid,gateedit);
       	SetPVarInt(playerid, "gatemodel", 971);
        SetPVarInt(playerid,"file",strval(inputtext));
	}
	return 1;
}
/*Some fixes after OnPlayerEditObject.*/
public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	if(response == EDIT_RESPONSE_FINAL)
	{
	    new fileid[30];
		Create3DTextLabel("Press 'Y' To Open", -1, fX, fY, fZ, 20.0, 0, 0);
 		SendClientMessage(playerid,-1,"�{FFCC00}Gate {FFFFFF} - You've sucussfully placed gate");
    	GetPVarString(playerid, "file", fileid, 30);
 		CreateGate(GetPVarInt(playerid, "file"), playerid, fX, fY, fZ, fRotX, fRotY, fRotZ);
	    SendClientMessage(playerid,-1,"�{FFCC00}Gate {FFFFFF} - Gate has been sucussfully saved!");
   		DeletePVar(playerid,"gatemodel");
		for(new i; i<MAX_GATES; i++)
		{
			if(IsValidObject(i))
 			DestroyObject(i);
		}
		new
 			string[64];
		format(string,sizeof(string),"reloadfs Gatesystem");
		SendRconCommand(string);
		SendClientMessage(playerid,-1,"�{FFCC00}Gate {FFFFFF} - Gate has been loaded , press 'y' to open.");
	}
	if(response == EDIT_RESPONSE_CANCEL)
	{
		DestroyObject(objectid);
	}
}
CreateGate(fileid, playerid, Float: fX, Float: fY, Float: fZ, Float: fRotX, Float: fRotY, Float: fRotZ)
{
    new file[35];
    format(file, 35, GatePath, fileid);
    new INI:File = INI_Open(file);
    INI_WriteInt(File,"Model", GetPVarInt(playerid, "gatemodel"));
    INI_WriteInt(File,"Password", 1234);
    INI_WriteInt(File,"Opened", 0);
    INI_WriteInt(File,"Closed", 1);
    INI_WriteFloat(File,"gPosx", fX);
    INI_WriteFloat(File,"gPosy", fY);
    INI_WriteFloat(File,"gPosz", fZ);
    INI_WriteFloat(File,"gRox", fRotX);
    INI_WriteFloat(File,"gRoy", fRotY);
    INI_WriteFloat(File,"gRoz", fRotZ);
    INI_WriteString(File,"Text1", "Press 'Y' to open!");
    INI_WriteString(File,"Text2", "Changeme");
    INI_Close(File);
}
#else
main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_YES)
	{
		for(new i = 0; i <= MAX_GATES; i++)
		{
  			if( IsPlayerInRangeOfPoint( playerid, 10.0, GateInfo[i][gPosx], GateInfo[i][gPosy], GateInfo[i][gPosz] ) )
            if(GateInfo[i][ghavepass] == 1) return Dialog_Show(playerid,gatepass,DIALOG_STYLE_INPUT ,"{05A300}������ �����","{FFFFFF}�������� ������ �� �����\n�{FFCC00}��������� {FFFFFF}:����������� ������: {FFCC00}1234. ","Select","");
  			{
  			    if(GateInfo[i][gClosed] == 1)
  			    {
  			    MoveObject(GateInfo[i][gModel],GateInfo[i][gPosx], GateInfo[i][gPosy], GateInfo[i][gPosz]-7,3.5);
  			    GameTextForPlayer(playerid,"~g~Gate open",1000,3);
  			    GateInfo[i][gOpened] =1;
  			    GateInfo[i][gClosed] =0;
  			    }
  			    else if(GateInfo[i][gOpened] == 1)
  			    {
   			    MoveObject(GateInfo[i][gModel],GateInfo[i][gPosx], GateInfo[i][gPosy], GateInfo[i][gPosz],3.5);
  			    GameTextForPlayer(playerid,"~r~Close gate",1000,3);
				GateInfo[i][gClosed] =1;
				GateInfo[i][gOpened] =0;
  			    }
  			}
		}
	}
	return 1;
}
Dialog:gatepass(playerid, response, listitem, inputtext[])
{
	if(response)
	{
	for( new i = 0; i != MAX_GATES; i++ )
    if( strval( inputtext ) == GateInfo[i][Gatepass] )
    {
		if( IsPlayerInRangeOfPoint( playerid, 10.0, GateInfo[i][gPosx], GateInfo[i][gPosy], GateInfo[i][gPosz] ) )

		{
 		if(GateInfo[i][gClosed] == 1)
   		{
	    	MoveObject(GateInfo[i][gModel],GateInfo[i][gPosx], GateInfo[i][gPosy], GateInfo[i][gPosz]-7,3.5);
		    GameTextForPlayer(playerid,"~g~Opening gate",1000,3);
		    GateInfo[i][gOpened] =1;
		    GateInfo[i][gClosed] =0;
	    }
	    else if(GateInfo[i][gOpened] == 1)
	    {
	    	MoveObject(GateInfo[i][gModel],GateInfo[i][gPosx], GateInfo[i][gPosy], GateInfo[i][gPosz],3.5);
	    	GameTextForPlayer(playerid,"~r~Closing gate",1000,3);
			GateInfo[i][gClosed] =1;
			GateInfo[i][gOpened] =0;
   		}
		}
	}
	if(!strval(inputtext)) return SendClientMessage( playerid, -1, "�{FFCC00}������{FFFFFF} - ������ ������." );
	}
	return 1;
}

public OnGameModeExit()
{
	return 1;
}
public OnRconLoginAttempt(ip[], password[], success)
{
	if(success)
	{
	    SetTimer("rcon",300,false);
	}
	return 1;
}
forward rcon(playerid);
public rcon(playerid)
{
    SendClientMessage(playerid,-1,"�{FFCC00}Gate rcon {FFFFFF}-Gate system has detected your rcon login , use {FFCC00}/gate {FFFFFF}- {FFCC00}/gateinfo.");
}

