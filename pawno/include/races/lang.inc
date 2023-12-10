//Language module
//Created by GTO Dev Team
//Modified by MadCat

new lang_texts[728][MAX_STRING];

forward LanguageConfig();
forward Language_OnGameModeInit();
forward lang_read(filename[]);

new Languages_DB[MAX_STRING] = "GTO/";
new Language[MAX_STRING] = "GTO";

public LanguageConfig()
{
//	Debug("language.inc > LanguageConfig - Start");
	if (ForceOverwrite) return;
	if (!dini_Exists(ConfigDB)) dini_Create(ConfigDB);
	new temp[MAX_STRING];
	set(temp,dini_Get(ConfigDB,"Languages_DB"));
	if (strlen(temp) > 0) set(Languages_DB,temp); 
	else { set(temp,Languages_DB); dini_Set(ConfigDB,"Languages_DB",temp);  }
	set(temp,nullstr);
	set(temp,dini_Get(ConfigDB,"Language"));
	if (strlen(temp) > 0) set(Language,temp); 
	else { set(temp,Language); dini_Set(ConfigDB,"Language",temp);  }
	set(temp,nullstr);
//	Debug("language.inc > LanguageConfig - Stop");
	return;
}

public Language_OnGameModeInit(){
	LanguageConfig();
	new langfile[MAX_STRING];
	format(langfile,MAX_STRING,"%sLanguage.%s.txt",Languages_DB,Language);
	lang_read(langfile);
	return 0;
}

public lang_read(filename[]) {
	new File:fohnd, tmpres[MAX_STRING], tmp1[MAX_STRING], tmp2[MAX_STRING];
	fohnd=fopen(filename,io_read);
	if (!fohnd){WriteLog("Cannot open language file!"); SendRconCommand("exit"); return;}
	while (fread(fohnd,tmpres,sizeof(tmpres))){
		if (strlen(tmpres) == 0) return;
		if (strfind(tmpres, "//",true) != -1) continue;
		if (strfind(tmpres, ";", true) != -1) 
		{
			strmid(tmp1, tmpres, 0, strfind(tmpres, ";", true));
			new idx;
			strcharsplit(tmpres, idx,strchar(";"));
//			strcat(tmp2," ");
//			strcat(tmp2,strcharsplit(tmpres, idx,strchar(";")));
			set(tmp2,strcharsplit(tmpres, idx,strchar(";")));
			new l = strlen(tmp2);
			while (l-- && tmp2[l] <= ' ') tmp2[l] = '\0';
			set(lang_texts[strval(tmp1)],tmp2);
//			set(tmp2,nullstr);
		}
	}
	fclose(fohnd);
	WriteLog("Language Loaded");
}