#include <YSI\y_hooks>
#include <sscanf2>

#define FS_VERS 0.2

#define EVENT_SINGLE_CLICK		( 212 )
#define EVENT_DOUBLE_CLICK		( 213 )

#define MAX_CHARS_PER_ROW		( 32 )

new PlayerText:Textdraw[71][MAX_PLAYERS];

#define sisnull(%1) \
    ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))


new PlayerLastClick[MAX_PLAYERS] = {0, ...};
new Current_MENU[ MAX_PLAYERS ] = {-1, ...};

new HUDTIMER[MAX_PLAYERS];

forward public OnPlayerClickGVMenu( playerid, menu_id, column, row, mouse_event );

#define MAX_TMENUS 50

#define INVALID_SPRITE "mylordyouaresodamngreatblessme"

hook OnPlayerDisconnect( playerid, reason )
{
	PlayerLastClick[playerid] = 0;
	Current_MENU[playerid] = -1;
	HUDTIMER[playerid] = -1;
	return 1;
}

hook OnPlayerConnect(playerid)
{
	CreatePlayerTextDraws(playerid);
	return 1;
}


stock CreatePlayerTextDraws(playerid)
{
	Textdraw[0][playerid] = CreatePlayerTextDraw(playerid,304.000000, 59.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[0][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[0][playerid], 16777215);
	PlayerTextDrawFont(playerid,Textdraw[0][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[0][playerid], 0.500000, 3.699997);
	PlayerTextDrawColor(playerid,Textdraw[0][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[0][playerid], 1);
	PlayerTextDrawSetProportional(playerid,Textdraw[0][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[0][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[0][playerid], 219025332);
	PlayerTextDrawTextSize(playerid,Textdraw[0][playerid], 97.000000, 369.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[0][playerid], 0);

	Textdraw[1][playerid] = CreatePlayerTextDraw(playerid,124.000000, 61.000000, "Greenwich Mean Time");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[1][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[1][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[1][playerid], 0.280000, 1.800000);
	PlayerTextDrawColor(playerid,Textdraw[1][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[1][playerid], 1);
	PlayerTextDrawSetProportional(playerid,Textdraw[1][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[1][playerid], 0);

	Textdraw[2][playerid] = CreatePlayerTextDraw(playerid,125.000000, 77.000000, "The race starts at 8:00 AM. Make sure you get there soon.");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[2][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[2][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[2][playerid], 0.250000, 1.300000);
	PlayerTextDrawColor(playerid,Textdraw[2][playerid], 1364680191);
	PlayerTextDrawSetOutline(playerid,Textdraw[2][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[2][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[2][playerid], 0);

	Textdraw[3][playerid] = CreatePlayerTextDraw(playerid,179.000000, 96.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[3][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[3][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[3][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[3][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[3][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[3][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[3][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[3][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[3][playerid], 21862630);
	PlayerTextDrawTextSize(playerid,Textdraw[3][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[3][playerid], 0);

	Textdraw[4][playerid] = CreatePlayerTextDraw(playerid,304.000000, 96.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[4][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[4][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[4][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[4][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[4][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[4][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[4][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[4][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[4][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[4][playerid], 21862630);
	PlayerTextDrawTextSize(playerid,Textdraw[4][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[4][playerid], 0);

	Textdraw[5][playerid] = CreatePlayerTextDraw(playerid,429.000000, 96.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[5][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[5][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[5][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[5][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[5][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[5][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[5][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[5][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[5][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[5][playerid], 21862630);
	PlayerTextDrawTextSize(playerid,Textdraw[5][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[5][playerid], 0);

	Textdraw[6][playerid] = CreatePlayerTextDraw(playerid,151.000000, 96.000000, "COL1_DESC");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[6][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[6][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[6][playerid], 0.239999, 1.100000);
	PlayerTextDrawColor(playerid,Textdraw[6][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[6][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[6][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[6][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[6][playerid], 0);

	Textdraw[7][playerid] = CreatePlayerTextDraw(playerid,277.000000, 96.000000, "COL2_DESC");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[7][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[7][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[7][playerid], 0.239999, 1.100000);
	PlayerTextDrawColor(playerid,Textdraw[7][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[7][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[7][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[7][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[7][playerid], 0);

	Textdraw[8][playerid] = CreatePlayerTextDraw(playerid,399.000000, 96.000000, "COL3_DESC");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[8][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[8][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[8][playerid], 0.239999, 1.100000);
	PlayerTextDrawColor(playerid,Textdraw[8][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[8][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[8][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[8][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[8][playerid], 0);

	Textdraw[9][playerid] = CreatePlayerTextDraw(playerid,179.000000, 115.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[9][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[9][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[9][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[9][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[9][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[9][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[9][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[9][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[9][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[9][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[9][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[9][playerid], 1);

	Textdraw[10][playerid] = CreatePlayerTextDraw(playerid,179.000000, 134.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[10][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[10][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[10][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[10][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[10][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[10][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[10][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[10][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[10][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[10][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[10][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[10][playerid], 1);

	Textdraw[11][playerid] = CreatePlayerTextDraw(playerid,179.000000, 153.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[11][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[11][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[11][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[11][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[11][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[11][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[11][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[11][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[11][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[11][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[11][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[11][playerid], 1);

	Textdraw[12][playerid] = CreatePlayerTextDraw(playerid,179.000000, 172.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[12][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[12][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[12][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[12][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[12][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[12][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[12][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[12][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[12][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[12][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[12][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[12][playerid], 1);

	Textdraw[13][playerid] = CreatePlayerTextDraw(playerid,179.000000, 191.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[13][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[13][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[13][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[13][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[13][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[13][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[13][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[13][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[13][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[13][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[13][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[13][playerid], 1);

	Textdraw[14][playerid] = CreatePlayerTextDraw(playerid,179.000000, 210.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[14][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[14][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[14][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[14][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[14][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[14][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[14][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[14][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[14][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[14][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[14][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[14][playerid], 1);

	Textdraw[15][playerid] = CreatePlayerTextDraw(playerid,179.000000, 229.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[15][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[15][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[15][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[15][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[15][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[15][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[15][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[15][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[15][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[15][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[15][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[15][playerid], 1);

	Textdraw[16][playerid] = CreatePlayerTextDraw(playerid,179.000000, 248.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[16][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[16][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[16][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[16][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[16][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[16][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[16][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[16][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[16][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[16][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[16][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[16][playerid], 1);

	Textdraw[17][playerid] = CreatePlayerTextDraw(playerid,179.000000, 267.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[17][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[17][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[17][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[17][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[17][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[17][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[17][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[17][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[17][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[17][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[17][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[17][playerid], 1);

	Textdraw[18][playerid] = CreatePlayerTextDraw(playerid,179.000000, 286.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[18][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[18][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[18][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[18][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[18][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[18][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[18][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[18][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[18][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[18][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[18][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[18][playerid], 1);

	Textdraw[19][playerid] = CreatePlayerTextDraw(playerid,304.000000, 115.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[19][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[19][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[19][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[19][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[19][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[19][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[19][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[19][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[19][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[19][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[19][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[19][playerid], 1);

	Textdraw[20][playerid] = CreatePlayerTextDraw(playerid,304.000000, 134.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[20][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[20][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[20][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[20][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[20][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[20][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[20][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[20][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[20][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[20][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[20][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[20][playerid], 1);

	Textdraw[21][playerid] = CreatePlayerTextDraw(playerid,304.000000, 153.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[21][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[21][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[21][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[21][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[21][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[21][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[21][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[21][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[21][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[21][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[21][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[21][playerid], 1);

	Textdraw[22][playerid] = CreatePlayerTextDraw(playerid,304.000000, 172.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[22][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[22][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[22][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[22][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[22][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[22][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[22][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[22][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[22][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[22][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[22][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[22][playerid], 1);

	Textdraw[23][playerid] = CreatePlayerTextDraw(playerid,304.000000, 191.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[23][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[23][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[23][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[23][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[23][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[23][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[23][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[23][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[23][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[23][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[23][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[23][playerid], 1);

	Textdraw[24][playerid] = CreatePlayerTextDraw(playerid,304.000000, 210.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[24][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[24][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[24][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[24][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[24][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[24][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[24][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[24][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[24][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[24][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[24][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[24][playerid], 1);

	Textdraw[25][playerid] = CreatePlayerTextDraw(playerid,304.000000, 229.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[25][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[25][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[25][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[25][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[25][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[25][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[25][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[25][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[25][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[25][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[25][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[25][playerid], 1);

	Textdraw[26][playerid] = CreatePlayerTextDraw(playerid,304.000000, 248.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[26][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[26][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[26][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[26][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[26][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[26][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[26][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[26][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[26][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[26][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[26][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[26][playerid], 1);

	Textdraw[27][playerid] = CreatePlayerTextDraw(playerid,304.000000, 267.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[27][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[27][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[27][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[27][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[27][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[27][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[27][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[27][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[27][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[27][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[27][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[27][playerid], 1);

	Textdraw[28][playerid] = CreatePlayerTextDraw(playerid,304.000000, 286.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[28][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[28][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[28][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[28][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[28][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[28][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[28][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[28][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[28][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[28][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[28][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[28][playerid], 1);

	Textdraw[29][playerid] = CreatePlayerTextDraw(playerid,368.000000, 113.000000, "loadsc7:loadsc7");
	PlayerTextDrawAlignment(playerid,Textdraw[29][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[29][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[29][playerid], 4);
	PlayerTextDrawLetterSize(playerid,Textdraw[29][playerid], 0.400000, 7.999997);
	PlayerTextDrawColor(playerid,Textdraw[29][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[29][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[29][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[29][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[29][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[29][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[29][playerid], 123.000000, 111.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[29][playerid], 0);

	Textdraw[30][playerid] = CreatePlayerTextDraw(playerid,430.000000, 229.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[30][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[30][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[30][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[30][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[30][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[30][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[30][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[30][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[30][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[30][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[30][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[30][playerid], 1);

	Textdraw[31][playerid] = CreatePlayerTextDraw(playerid,430.000000, 248.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[31][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[31][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[31][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[31][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[31][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[31][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[31][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[31][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[31][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[31][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[31][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[31][playerid], 1);

	Textdraw[32][playerid] = CreatePlayerTextDraw(playerid,430.000000, 267.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[32][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[32][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[32][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[32][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[32][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[32][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[32][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[32][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[32][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[32][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[32][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[32][playerid], 1);

	Textdraw[33][playerid] = CreatePlayerTextDraw(playerid,430.000000, 286.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[33][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[33][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[33][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[33][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[33][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[33][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[33][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[33][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[33][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[33][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[33][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[33][playerid], 1);

	Textdraw[34][playerid] = CreatePlayerTextDraw(playerid,122.000000, 117.000000, "C1_R1:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[34][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[34][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[34][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[34][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[34][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[34][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[34][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[34][playerid], 0);

	Textdraw[35][playerid] = CreatePlayerTextDraw(playerid,122.000000, 135.000000, "C1_R2:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[35][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[35][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[35][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[35][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[35][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[35][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[35][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[35][playerid], 0);

	Textdraw[36][playerid] = CreatePlayerTextDraw(playerid,122.000000, 154.000000, "C1_R3:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[36][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[36][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[36][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[36][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[36][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[36][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[36][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[36][playerid], 0);

	Textdraw[37][playerid] = CreatePlayerTextDraw(playerid,122.000000, 173.000000, "C1_R4");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[37][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[37][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[37][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[37][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[37][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[37][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[37][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[37][playerid], 0);

	Textdraw[38][playerid] = CreatePlayerTextDraw(playerid,122.000000, 192.000000, "C1_R5:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[38][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[38][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[38][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[38][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[38][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[38][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[38][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[38][playerid], 0);

	Textdraw[39][playerid] = CreatePlayerTextDraw(playerid,122.000000, 211.000000, "C1_R6:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[39][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[39][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[39][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[39][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[39][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[39][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[39][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[39][playerid], 0);

	Textdraw[40][playerid] = CreatePlayerTextDraw(playerid,122.000000, 229.000000, "C1_R7:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[40][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[40][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[40][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[40][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[40][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[40][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[40][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[40][playerid], 0);

	Textdraw[41][playerid] = CreatePlayerTextDraw(playerid,122.000000, 248.000000, "C1_R8:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[41][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[41][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[41][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[41][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[41][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[41][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[41][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[41][playerid], 0);

	Textdraw[42][playerid] = CreatePlayerTextDraw(playerid,122.000000, 267.000000, "C1_R9:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[42][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[42][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[42][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[42][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[42][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[42][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[42][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[42][playerid], 0);

	Textdraw[43][playerid] = CreatePlayerTextDraw(playerid,122.000000, 287.000000, "C1_R10:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[43][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[43][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[43][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[43][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[43][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[43][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[43][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[43][playerid], 0);

	Textdraw[44][playerid] = CreatePlayerTextDraw(playerid,246.000000, 116.000000, "C2_R1:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[44][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[44][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[44][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[44][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[44][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[44][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[44][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[44][playerid], 0);

	Textdraw[45][playerid] = CreatePlayerTextDraw(playerid,246.000000, 135.000000, "C2_R2:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[45][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[45][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[45][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[45][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[45][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[45][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[45][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[45][playerid], 0);

	Textdraw[46][playerid] = CreatePlayerTextDraw(playerid,246.000000, 154.000000, "C2_R3:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[46][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[46][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[46][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[46][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[46][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[46][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[46][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[46][playerid], 0);

	Textdraw[47][playerid] = CreatePlayerTextDraw(playerid,246.000000, 173.000000, "C2_R4:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[47][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[47][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[47][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[47][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[47][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[47][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[47][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[47][playerid], 0);

	Textdraw[48][playerid] = CreatePlayerTextDraw(playerid,246.000000, 192.000000, "C2_R5:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[48][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[48][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[48][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[48][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[48][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[48][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[48][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[48][playerid], 0);

	Textdraw[49][playerid] = CreatePlayerTextDraw(playerid,246.000000, 211.000000, "C2_R6:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[49][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[49][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[49][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[49][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[49][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[49][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[49][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[49][playerid], 0);

	Textdraw[50][playerid] = CreatePlayerTextDraw(playerid,246.000000, 230.000000, "C2_R7:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[50][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[50][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[50][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[50][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[50][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[50][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[50][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[50][playerid], 0);

	Textdraw[51][playerid] = CreatePlayerTextDraw(playerid,246.000000, 249.000000, "C2_R8:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[51][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[51][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[51][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[51][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[51][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[51][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[51][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[51][playerid], 0);

	Textdraw[52][playerid] = CreatePlayerTextDraw(playerid,246.000000, 268.000000, "C2_R9:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[52][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[52][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[52][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[52][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[52][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[52][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[52][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[52][playerid], 0);

	Textdraw[53][playerid] = CreatePlayerTextDraw(playerid,246.000000, 287.000000, "C2_R10:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[53][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[53][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[53][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[53][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[53][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[53][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[53][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[53][playerid], 0);

	Textdraw[54][playerid] = CreatePlayerTextDraw(playerid,371.000000, 230.000000, "C3_R1:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[54][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[54][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[54][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[54][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[54][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[54][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[54][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[54][playerid], 0);

	Textdraw[55][playerid] = CreatePlayerTextDraw(playerid,371.000000, 249.000000, "C3_R2:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[55][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[55][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[55][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[55][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[55][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[55][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[55][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[55][playerid], 0);

	Textdraw[56][playerid] = CreatePlayerTextDraw(playerid,371.000000, 268.000000, "C3_R3:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[56][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[56][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[56][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[56][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[56][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[56][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[56][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[56][playerid], 0);

	Textdraw[57][playerid] = CreatePlayerTextDraw(playerid,371.000000, 287.000000, "C3_R4:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[57][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[57][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[57][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[57][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[57][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[57][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[57][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[57][playerid], 0);

	Textdraw[58][playerid] = CreatePlayerTextDraw(playerid,430.000000, 210.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[58][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[58][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[58][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[58][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[58][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[58][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[58][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[58][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[58][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[58][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[58][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[58][playerid], 1);

	Textdraw[59][playerid] = CreatePlayerTextDraw(playerid,430.000000, 191.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[59][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[59][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[59][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[59][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[59][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[59][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[59][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[59][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[59][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[59][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[59][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[59][playerid], 1);

	Textdraw[60][playerid] = CreatePlayerTextDraw(playerid,430.000000, 172.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[60][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[60][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[60][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[60][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[60][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[60][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[60][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[60][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[60][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[60][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[60][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[60][playerid], 1);

	Textdraw[61][playerid] = CreatePlayerTextDraw(playerid,430.000000, 153.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[61][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[61][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[61][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[61][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[61][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[61][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[61][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[61][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[61][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[61][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[61][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[61][playerid], 1);

	Textdraw[62][playerid] = CreatePlayerTextDraw(playerid,430.000000, 134.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[62][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[62][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[62][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[62][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[62][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[62][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[62][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[62][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[62][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[62][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[62][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[62][playerid], 1);

	Textdraw[63][playerid] = CreatePlayerTextDraw(playerid,430.000000, 115.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[63][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[63][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[63][playerid], 1);
	PlayerTextDrawLetterSize(playerid,Textdraw[63][playerid], 0.500000, 1.399999);
	PlayerTextDrawColor(playerid,Textdraw[63][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[63][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[63][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[63][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[63][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[63][playerid], 185339246);
	PlayerTextDrawTextSize(playerid,Textdraw[63][playerid], 2.000000, 120.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[63][playerid], 1);

	Textdraw[64][playerid] = CreatePlayerTextDraw(playerid,371.000000, 116.000000, "C3_NOIMAGE_R1:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[64][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[64][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[64][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[64][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[64][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[64][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[64][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[64][playerid], 0);

	Textdraw[65][playerid] = CreatePlayerTextDraw(playerid,371.000000, 135.000000, "C3_NOIMAGE_R2:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[65][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[65][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[65][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[65][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[65][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[65][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[65][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[65][playerid], 0);

	Textdraw[66][playerid] = CreatePlayerTextDraw(playerid,371.000000, 154.000000, "C3_NOIMAGE_R3:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[66][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[66][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[66][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[66][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[66][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[66][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[66][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[66][playerid], 0);

	Textdraw[67][playerid] = CreatePlayerTextDraw(playerid,371.000000, 173.000000, "C3_NOIMAGE_R4:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[67][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[67][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[67][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[67][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[67][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[67][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[67][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[67][playerid], 0);

	Textdraw[68][playerid] = CreatePlayerTextDraw(playerid,371.000000, 192.000000, "C3_NOIMAGE_R5:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[68][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[68][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[68][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[68][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[68][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[68][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[68][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[68][playerid], 0);

	Textdraw[69][playerid] = CreatePlayerTextDraw(playerid,371.000000, 211.000000, "C3_NOIMAGE_R6:");
	PlayerTextDrawBackgroundColor(playerid,Textdraw[69][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[69][playerid], 2);
	PlayerTextDrawLetterSize(playerid,Textdraw[69][playerid], 0.170000, 1.000000);
	PlayerTextDrawColor(playerid,Textdraw[69][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[69][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[69][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[69][playerid], 1);
	PlayerTextDrawSetSelectable(playerid,Textdraw[69][playerid], 0);

	Textdraw[70][playerid] = CreatePlayerTextDraw(playerid,368.000000, 113.000000, "_");
	PlayerTextDrawAlignment(playerid,Textdraw[70][playerid], 2);
	PlayerTextDrawBackgroundColor(playerid,Textdraw[70][playerid], 255);
	PlayerTextDrawFont(playerid,Textdraw[70][playerid], 5);
	PlayerTextDrawLetterSize(playerid,Textdraw[70][playerid], 1.440000, -8.100000);
	PlayerTextDrawColor(playerid,Textdraw[70][playerid], -1);
	PlayerTextDrawSetOutline(playerid,Textdraw[70][playerid], 0);
	PlayerTextDrawSetProportional(playerid,Textdraw[70][playerid], 1);
	PlayerTextDrawSetShadow(playerid,Textdraw[70][playerid], 1);
	PlayerTextDrawUseBox(playerid,Textdraw[70][playerid], 1);
	PlayerTextDrawBoxColor(playerid,Textdraw[70][playerid], -16776961);
	PlayerTextDrawTextSize(playerid,Textdraw[70][playerid], 123.000000, 111.000000);
	PlayerTextDrawSetSelectable(playerid,Textdraw[70][playerid], 0);
}

forward public RepeatLevel( playerid );

public RepeatLevel( playerid )
{
	if(Current_MENU[playerid] != -1 ) {
	SetPlayerDrunkLevel( playerid, 5 ); }
	else KillTimer( HUDTIMER[playerid] );
	return 1;
}

stock HideHUD( playerid )
{
	SetPlayerDrunkLevel( playerid, 5 );
	HUDTIMER[playerid] = SetTimerEx( "RepeatLevel", 1000, 1, "d", playerid );
	return 1;
}


public OnPlayerClickPlayerTextDraw( playerid, PlayerText: playertextid )
{
	new column = 0, row = 0;
	new result;
	for(new i = 9; i < 19; i++)
	{
		if( playertextid == Textdraw[ i ][ playerid ] )
		{
			column = 1;
			row = i - 8;
			result = i;
			goto label;
		}
	}
	for(new m = 19; m < 29; m++)
	{
		if( playertextid == Textdraw[ m ][ playerid ] )
		{
			column = 2;
			row = m - 18;
			result = m;
			goto label;
		}
	}
	for(new j = 30; j < 34; j++)
	{
		if( playertextid == Textdraw[ j][ playerid ] )
		{
			column = 3;
			row = j - 29;
			result = j;
			goto label;
		}
	}
	for(new a = 63; a > 57; a--)
	{
		if( playertextid == Textdraw[ a ][ playerid ] )
		{
			column = 3;
			row = 64 - a;
			result = a;
			goto label;
		}
	}
	
	
	
	label: if( ( gettime() - PlayerLastClick[ playerid ] ) > 600 )
	{
		if(PlayerLastClick[playerid] != 0)
		{
			PlayerLastClick[playerid] = gettime();
			PlayerTextDrawBoxColor(playerid, Textdraw[result][playerid], 0x8965EB88);
			OnPlayerClickGVMenu(playerid, Current_MENU[playerid], column, row, 212); 
			return 1;
		}
	}
	
	else
	{
		if(PlayerLastClick[playerid] != 0)
		{
			PlayerLastClick[playerid] = gettime();
			PlayerTextDrawBoxColor(playerid, Textdraw[result][playerid], 0xEB444488);
			OnPlayerClickGVMenu(playerid, Current_MENU[playerid], column, row, 213);
			return 1;
		}
	}
	PlayerLastClick[playerid] = gettime();
	return 1;
}

enum tI
{
	menuID,
	_title[30],
	_desc[128],
	_first_col_rows,
	_sec_col_rows,
	_third_col_rows,
	bool: image,
	bool: model_preview,
	_first_col_title[30],
	_sec_col_title[30],
	_third_col_title[30],
	
}
new TextInfo[ MAX_TMENUS ][ tI ];

stock gtaV_CreateMenu( const MENU_ID, first_col_rows, sec_col_rows, third_col_rows, const title[], const description[], const first_col_title[], const sec_col_title[], const third_col_title[], bool: use_image, bool: use_model_preview)
{
	{
		TextInfo[ MENU_ID ][ menuID ] = MENU_ID;
		TextInfo[ MENU_ID ][ _first_col_rows ] = first_col_rows;
		TextInfo[ MENU_ID ][ _sec_col_rows ] = sec_col_rows;
		TextInfo[ MENU_ID ][ _third_col_rows ] = third_col_rows;
		TextInfo[ MENU_ID ][ image ] = use_image;
		TextInfo[ MENU_ID ][ model_preview ] = use_model_preview;
		format(TextInfo[ MENU_ID ][ _first_col_title ], 30, "%s", first_col_title );
		format(TextInfo[ MENU_ID ][ _sec_col_title ], 30, "%s", sec_col_title );
		format(TextInfo[ MENU_ID ][ _third_col_title ], 30, "%s", third_col_title );
		format(TextInfo[ MENU_ID ][ _title ], 30, "%s", title );
		format(TextInfo[ MENU_ID ][ _desc ], 128, "%s", description );
	}
	return 1;
}

stock gtaV_ShowMenuToPlayer( playerid, MENU_ID, bool: cursor_on, string[], sprite_name[31] = #INVALID_SPRITE, preview_model = -1, Float: preview_model_rotX = 0.0, Float: preview_model_rotY = 0.0, Float: preview_model_rotZ = 0.0, Float: preview_model_zoom = 0.0)
{
	// SHOWING FIRST BASIC TDs
	
	PlayerTextDrawSetString( playerid, Textdraw[ 1 ][ playerid ], TextInfo[ MENU_ID ][ _title ]);
	PlayerTextDrawSetString( playerid, Textdraw[ 2 ][ playerid ], TextInfo[ MENU_ID ][ _desc ] );
	PlayerTextDrawSetString( playerid, Textdraw[ 6 ][ playerid ], TextInfo[ MENU_ID ][ _first_col_title ]);
	PlayerTextDrawSetString( playerid, Textdraw[ 7 ][ playerid ], TextInfo[ MENU_ID ][ _sec_col_title ] );
	PlayerTextDrawSetString( playerid, Textdraw[ 8 ][ playerid ], TextInfo[ MENU_ID ][ _third_col_title ]);
	
	for(new A = 0; A < 9; A++)
	{
		PlayerTextDrawShow( playerid, Textdraw[A][playerid]);
	}
	
	
	
	// SORTING OUT STRING USING SSCANF
	new first_row_labels = TextInfo[ MENU_ID ][ _first_col_rows ];
	new sec_row_labels = TextInfo[ MENU_ID ][ _sec_col_rows ];
	new third_row_labels = TextInfo[ MENU_ID ][ _third_col_rows ];
	new str[30][MAX_CHARS_PER_ROW];
	new ssc_specifiers[ 4 + ( 30 * 5 ) ];
	format(ssc_specifiers, sizeof(ssc_specifiers), "p<|>");
	for(new count = 0; count < (first_row_labels + sec_row_labels + third_row_labels); count++)
	{
		strcat(ssc_specifiers, "s[32]" );
	}
	sscanf(string, ssc_specifiers, str[0], str[1],str[2], str[3],str[4], str[5],str[6], str[7],str[8], str[9],str[10], str[11],str[12], str[13], str[14],
	str[15],str[16],str[17],str[18],str[19],str[20],str[21],str[22],str[23],str[24],str[25],str[26],str[27],str[28], str[29] );
	
	
	new str_count;
	for(new ZS = 0; ZS < 30; ZS++)
	{
		if(!sisnull( str[ZS] )) str_count++;
		else continue;
	}
	// CHECKING NULL STRINGS DONE
	
	// SETTING STRINGS FOR FIRST TWO COLUMNS
	
	for( new u = 34; u < (34 + first_row_labels); u++) 
	{
		PlayerTextDrawSetString( playerid, Textdraw[ u ][ playerid ], str[u - 34]);
	}
	for(new p = 44; p < (44 + sec_row_labels); p++ )
	{
		PlayerTextDrawSetString( playerid, Textdraw[ p ][ playerid ], str[ p - 44 + first_row_labels ] );
	}
	// SHOWING FIRST COLUMN
	
	for(new i = 9; i < 9 + (TextInfo[ MENU_ID ][ _first_col_rows ]); i++ )
	{
		PlayerTextDrawShow( playerid, Textdraw[ i ][ playerid ] );
		PlayerTextDrawShow( playerid, Textdraw[ i + 25 ][ playerid ] );
	}
	// SHOWING SECOND COLUMN
	
	for(new m = 19; m < 19 + (TextInfo[ MENU_ID ][ _sec_col_rows ]); m++ )
	{
		PlayerTextDrawShow( playerid, Textdraw[ m ][ playerid ] );
		PlayerTextDrawShow( playerid, Textdraw[ m + 25 ][ playerid ] );
	}
	// IF USING SPRITE, SETTING STRING TO NAME
	// SHOWING THE SPRITE AND THIRD ROW AFTER SETTING STRING
	
	if( TextInfo[ MENU_ID ][ image ] && !TextInfo[ MENU_ID ][ model_preview] )
	{
		if( strcmp( sprite_name, INVALID_SPRITE, false ) != 0)
		{
			printf("SPRITE NAME: %s", sprite_name);
			PlayerTextDrawFont(playerid, Textdraw[29][playerid], 3);
			PlayerTextDrawSetString( playerid, Textdraw[ 29 ][ playerid], sprite_name );
			PlayerTextDrawFont(playerid, Textdraw[29][playerid], 4);
			
			for(new ZC = 54; ZC < ( 54 + third_row_labels ); ZC++)
			{
				PlayerTextDrawSetString( playerid, Textdraw[ ZC ][ playerid ], str[ ZC - 54 + (first_row_labels + sec_row_labels) ] );
			}
			
			PlayerTextDrawShow( playerid, Textdraw[ 29 ][ playerid ] );
			for(new Z = 30; Z < (30 + TextInfo[ MENU_ID ][ _third_col_rows ] ); Z++ )
			{
				PlayerTextDrawShow( playerid, Textdraw[ Z ][ playerid ] );
				PlayerTextDrawShow( playerid, Textdraw[ Z + 24 ][ playerid ] );
			}
		}
	}
	// IF USING MODEL PREVIEW, SETTING MODEL, SETTING STRING AND SHOWING
	
	if( TextInfo[ MENU_ID ][ model_preview ] && !TextInfo[ MENU_ID ][ image ])
	{
		if( preview_model != -1 ) 
		{ 
			PlayerTextDrawFont(playerid, Textdraw[ 70 ][ playerid ], TEXT_DRAW_FONT_MODEL_PREVIEW);
			PlayerTextDrawSetPreviewModel( playerid, Textdraw[ 70 ][ playerid ], preview_model); 
			PlayerTextDrawSetPreviewRot( playerid, Textdraw[ 70 ][ playerid ], preview_model_rotX, preview_model_rotY, preview_model_rotZ, preview_model_zoom ); 
			PlayerTextDrawShow( playerid, Textdraw[ 70 ][ playerid ]);
		}
		for(new ZC = 54; ZC < ( 54 + third_row_labels ); ZC++)
		{
			PlayerTextDrawSetString( playerid, Textdraw[ ZC ][ playerid ], str[ ZC - 54 + (first_row_labels + sec_row_labels) ] );
		}
		for(new Z = 30; Z < (30 + TextInfo[ MENU_ID ][ _third_col_rows ] ); Z++ )
		{
			PlayerTextDrawShow( playerid, Textdraw[ Z ][ playerid ] );
			PlayerTextDrawShow( playerid, Textdraw[ Z + 24 ][ playerid ] );
		}
	}
	// IF USING ONLY ROWS, THEN SETTING STRINGS FOR ALL AND SHOWING
	
	if( !TextInfo[ MENU_ID ][ model_preview ] && !TextInfo[ MENU_ID ][ image ] )
	{
		//63 - 58 NO IMAGE ROWS
		//64 - 69 NO IMAGE ROW LABELS
		//30 - 33 ROWS
		//54 - 57 ROW LABELS
		for(new ZS = 64; ZS < ( 64 + third_row_labels ); ZS++) // 10, < 74
		{
			if(ZS < 70) {PlayerTextDrawSetString( playerid, Textdraw[ ZS ][ playerid ], str[ ZS - 64 + (first_row_labels + sec_row_labels) ] );}
			else 
				PlayerTextDrawSetString( playerid, Textdraw[ ZS - 16 ][ playerid ], str[ ZS - 70 + (first_row_labels + sec_row_labels) + 6 ] );
			{
			}
		}
		
		for( new counter = 58; counter < (58 + TextInfo[ MENU_ID ][ _third_col_rows ] );  counter++)
		{
			if( counter < 64 )
			{ 	
				PlayerTextDrawShow( playerid, Textdraw[ counter ][ playerid ] );
				PlayerTextDrawShow( playerid, Textdraw[ counter + 6 ][ playerid ] );
			}
			else
			{ 
				PlayerTextDrawShow( playerid, Textdraw[ counter - 34 ][ playerid] );
				PlayerTextDrawShow( playerid, Textdraw[ counter - 10][ playerid ] );	
			}
				
		}
	}
	if(cursor_on)
	{
		SelectTextDraw( playerid, 0x673FE088);
	}	
	
	HideHUD(playerid);
	Current_MENU[ playerid ] = MENU_ID; 
	
	return 1;
}

stock gtaV_HideMenuForPlayer( playerid )
{
	if( Current_MENU[ playerid ] == -1 ) return 0;
	else
	{
		for(new i = 0; i < 71; i++)
		{
			PlayerTextDrawHide( playerid, Textdraw[ i ][ playerid ] );
			KillTimer(HUDTIMER[playerid]);
		}
		Current_MENU[ playerid ] = -1;
	}
	return 1;
}

hook OnFilterScriptInit()
{
	print("\n\n");
	print("---------------------------------------------");
	print("|	    I know, lots of gay symbols.        ");
	print("|      But I gotta catch your attention.     ");
	print("|                                            ");
	print("|      PROJECT: gtaV_MENU for SA-MP          ");
    print("|          VERSION:  v"#FS_VERS"              ");
	print("|         AUTHOR: Rajat_Pawar                ");
	print("|    LAST REV-DATE: 09/ 10/ 2013             ");
	print("|                                            ");
	print("|   I know, the textdraws rock. I know !     ");
	print("|          Time for gay symbols!             ");
	print("---------------------------------------------");
	print("\n\n");
	
	
	return 1;
}
