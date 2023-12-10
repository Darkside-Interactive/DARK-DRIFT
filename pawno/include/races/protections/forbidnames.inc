//Anti-Idle module
//Created by _Sneaky
//Modder: MadCat

#define MAX_FORBIDDENNAMES 50

new ForbiddenNames[MAX_FORBIDDENNAMES][MAX_NAME+10];

new num_forbidnames = 0;

forward ForbiddenNames_OnGameModeInit();
forward IsGangNameForbidden(tempname[]);

new Forbidden_Names_Enabled = 1;
new Forbidden_Names_DB[MAX_STRING] = "GTO/Forbidden_Names.txt";

public ForbiddenNames_OnGameModeInit(){
	AntiForbidNamesConfig();
	if (Forbidden_Names_Enabled == 1){
		LoadForbiddenNames();
		new logstring[256];
		format(logstring, sizeof (logstring), "%d forbidden names loaded from DB.",num_forbidnames);
		WriteLog(logstring);
	}
	return 0;
}

AntiForbidNamesConfig()
{
	new temp[MAX_STRING];
	if (!dini_Exists(SecurityDB)) dini_Create(SecurityDB);

	set(temp,dini_Get(SecurityDB,"Forbidden_Names_Enabled"));
	if (strlen(temp) > 0) Forbidden_Names_Enabled = strval(temp);
	else { valstr(temp,Forbidden_Names_Enabled); dini_Set(SecurityDB,"Forbidden_Names_Enabled",temp);  }
	set(temp,nullstr);

	set(temp,dini_Get(ConfigDB,"Forbidden_Names_DB"));
	if (strlen(temp) > 0) Forbidden_Names_DB = temp; 
	else { set(temp,Forbidden_Names_DB); dini_Set(ConfigDB,"Forbidden_Names_DB",temp);  }
	set(temp,nullstr);

	return;
}

LoadForbiddenNames()
{
	if (!dini_Exists(Forbidden_Names_DB)){ dini_Create(Forbidden_Names_DB); return 0;}
	new string[MAX_NAME+10], File:file = fopen(Forbidden_Names_DB,io_read);
	if(file)
	{
		while(fread(file,string))
		{
			if (num_forbidnames >= MAX_FORBIDDENNAMES) continue;

		   	StripNewLine(string);
            		set(ForbiddenNames[num_forbidnames],string);
            		num_forbidnames++;
		}
		fclose(file);
	}
	return 0;
}

stock IsNameForbidden(playerid)
{
new pName[MAX_NAME];
set(pName,oGetPlayerName(playerid));
for(new i = 0; i < num_forbidnames; i++)
{
        if(strcomp(pName,ForbiddenNames[i],false) == 1) //Not ignore case
        {
            return 1;
        }
	
	if(strcomp(pName,ForbiddenNames[i],false) == 1) //Ignore case. Double protection :)
        {
            return 1;
        }
}
return 0;
}


public IsGangNameForbidden(tempname[])
{
for(new i = 0; i < num_forbidnames; i++)
{
        if(strcomp(tempname,ForbiddenNames[i],false) == 1) //Not ignore case
        {
            return 1;
        }
	
	if(strcomp(tempname,ForbiddenNames[i],false) == 1) //Ignore case. Double protection :)
        {
            return 1;
        }
}
return 0;
}
