#include <dini> 
#include <a_samp>

IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while (text[pos] < 0x21) // Strip out leading spaces
	{
		if (text[pos] == 0) return INVALID_PLAYER_ID; // No passed text
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if (IsNumeric(text[pos])) // Check whole passed string
	{
		// If they have a numeric name you have a problem (although names are checked on id failure)
		userid = strval(text[pos]);
		if (userid >=0 && userid < MAX_PLAYERS)
		{
			if(!IsPlayerConnected(userid))
			{
				/*if (playerid != INVALID_PLAYER_ID)
				{
					SendClientMessage(playerid, 0xFF0000AA, "User not connected");
				}*/
				userid = INVALID_PLAYER_ID;
			}
			else
			{
				return userid; // A player was found
			}
		}
		/*else
		{
			if (playerid != INVALID_PLAYER_ID)
			{
				SendClientMessage(playerid, 0xFF0000AA, "Invalid user ID");
			}
			userid = INVALID_PLAYER_ID;
		}
		return userid;*/
		// Removed for fallthrough code
	}
	// They entered [part of] a name or the id search failed (check names just incase)
	new len = strlen(text[pos]);
	new count = 0;
	new name[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i, name, sizeof (name));
			if (strcmp(name, text[pos], true, len) == 0) // Check segment of name
			{
				if (len == strlen(name)) // Exact match
				{
					return i; // Return the exact player on an exact match
					// Otherwise if there are two players:
					// Me and MeYou any time you entered Me it would find both
					// And never be able to return just Me's id
				}
				else // Partial match
				{
					count++;
					userid = i;
				}
			}
		}
	}
	if (count != 1)
	{
		if (playerid != INVALID_PLAYER_ID)
		{
			if (count)
			{
				SendClientMessage(playerid, 0xFF0000AA, "Multiple users found, please narrow earch");
			}
			else
			{
				SendClientMessage(playerid, 0xFF0000AA, "No matching user found");
			}
		}
		userid = INVALID_PLAYER_ID;
	}
	return userid; // INVALID_USER_ID for bad return
}

// Список цветов
//-------------------------------------------------------------------------
#define BACKGROUNG 0x0000008A
#define BLACK_PLUS 0x000000AB
#define FIELD_BACKGROUND 0xF60000A6
#define CGRADD 		0x65969AAA
#define CISPOLZUY 	0x7FB151FF
#define CBOX   		0x00000050
#define CBLUEE 		0x0080FFAA
#define CBLUE 		0x6495EDFF
#define CUSE 		0x00A8A8AA
#define CREDD 		0xFF0000AA
#define CXZXZXZ 	0x9AD226F6
#define CTWHITE 	0x0AA8DAFF
#define CWANTED 	0xF04D0FAA
#define CCOMAND 	0x3F99FCAA
//-------------------------------------------------------------------------
// Список градиентных цветов
#define CGRAD2 0xBFC0C2FF
#define CGRAD3 0xCBCCCEFF
#define CGRAD4 0xD8D8D8FF
#define CGRAD5 0xE3E3E3FF
#define CGRAD6 0xF0F0F0FF

#define OBJECTIVE_COLOR 0x64000064
#define TEAM_GREEN_COLOR 0xFFFFFFAA
#define TEAM_JOB_COLOR 0xFFB6C1AA
#define TEAM_HIT_COLOR 0xFFFFFF00
#define TEAM_BLUE_COLOR 0x8D8DFF00
#define CADD 0x63FF60AA
#define TEAM_GROVE_COLOR 0x00D900C8
#define TEAM_VAGOS_COLOR 0xFFC801C8
#define TEAM_BALLAS_COLOR 0xD900D3C8
#define TEAM_AZTECAS_COLOR 0x01FCFFC8
#define TEAM_CYAN_COLOR 0xFF8282AA
#define TEAM_ORANGE_COLOR 0xFF830000
#define TEAM_COR_COLOR 0x39393900
#define TEAM_BAR_COLOR 0x00D90000
#define TEAM_TAT_COLOR 0xBDCB9200
#define TEAM_CUN_COLOR 0xD900D300
#define TEAM_STR_COLOR 0x01FCFF00
#define TEAM_ADMIN_COLOR 0x00808000
#define CINVIS 0xAFAFAF00
#define CSPEC 0xBFC0C200
#define CXD 0xA9C4E4AA
#define CGREEN2 0x0D74FFF
#define CRED2 0xFF5F3CFF
#define CORANGE 0xFF9900AA
#define CLIME 0x10F441AA
#define CMAGENTA 0xFF00FFFF
#define CNAVY 0x000080AA
#define COLOUR_MONEY_BAD 0xDAA520AA
#define CAQUA 0xF0F8FFAA
#define CCRIMSON 0xDC143CAA
#define CFLBLUE 0x6495EDAA
#define CBISQUE 0xFFE4C4AA
#define CBLACK 0x000000AA
#define CCHARTREUSE 0x7FFF00AA
#define CBROWN 0xA52A2AAA
#define CCORAL 0xFF7F50AA
#define CGOLD 0xB8860BAA
#define CGREENYELLOW 0xADFF2FAA
#define CINDIGO 0x4B00B0AA
#define CIVORY 0xFFFF82AA
#define CLAWNGREEN 0x7CFC00AA
#define CLIMEGREEN 0x32CD32AA
#define CMIDNIGHTBLUE 0x191970AA
#define CMAROON 0x800000AA
#define COLIVE 0x808000AA
#define CORANGERED 0xFF4500AA
#define CPINK 0xFFC0CBAA
#define CSPRINGGREEN 0x00FF7FAA
#define CTOMATO 0xFF6347AA
#define CYELLOWGREEN 0x9ACD32AA
#define CMEDIUMAQUA 0x83BFBFAA
#define CMEDIUMMAGENTA 0x8B008BAA
#define CBRIGHTRED 0xDC143CAA
#define CSYSTEM 0xEFEFF7AA

#define CGREY 0xAFAFAFAA
#define CGREEN 0x33AA33AA
#define CRED 0xAA3333AA
#define CLIGHTRED 0xFF6347AA
#define CLIGHTBLUE 0x33CCFFAA
#define CLIGHTGREEN 0x9ACD32AA
#define CYELLOW 0xFFFF00AA
#define CYELLOW2 0xF5DEB3AA
#define CWHITE 0xFFFFFFAA
#define CFADE1 0xE6E6E6E6
#define CFADE2 0xC8C8C8C8
#define CFADE3 0xAAAAAAAA
#define CFADE4 0x8C8C8C8C
#define CFADE5 0x6E6E6E6E
#define CPURPLE 0xFF80FFAA
#define CDBLUE 0x2641FEAA
#define CALLDEPT 0xFF8282AA
#define CNEWS 0xFFA500AA
#define COOC 0xE0FFFFAA
#define CYELLOW3d 0xFFFF00FF
#define CISPOLZUY 0x7FB151FF
#define CGRAD1 0xB4B5B7FF
#define CSINIY 0x00004FAA
#define CBLUE 0x6495EDFF
#define CKHAKI 0xF0E68CAA
#define CINDIGO 0x4B00B0AA
#define CIVORY 0xFFFF82AA
#define CBLACK 0x000000AA
#define CGREY 0xAFAFAFAA
#define CGREEN 0x33AA33AA
#define CBLUEGREEN 0x46BBAA00
#define CORANGE 0xFF9900AA
#define CRED 0xAA3333AA

//#define CLIGHTRED 0xFF6347AA
#define CLIGHTBLUE 0x33CCFFAA
#define CLIGHTGREEN 0x9ACD32AA
#define CYELLOW 0xFFFF00AA
#define CYELLOW2 0xF5DEB3AA
#define CWHITE 0xFFFFFFAA
#define CREDD 0xFF0000AA
#define CBROW 0xA85400AA
#define CDBLUE 0x2641FEAA
#define CALLDEPT 0xFF8282AA
#define CNEWS 0xFFA500AA
#define CLIFE 0xFEBC41AA
#define COOC 0xE0FFFFAA
#define TEAM_CYAN 1
#define TEAM_HIT_COLOR 0xFFFFFF00
#define TEAM_BLUE_COLOR 0x8D8DFF00
#define CADD 0x63FF60AA
#define TEAM_GROVE_COLOR 0x00D900C8
#define TEAM_VAGOS_COLOR 0xFFC801C8
#define TEAM_BALLAS_COLOR 0xD900D3C8
#define TEAM_AZTECAS_COLOR 0x01FCFFC8
#define TEAM_CYAN_COLOR 0xFF8282AA
#define CINVIS 0xAFAFAF00
