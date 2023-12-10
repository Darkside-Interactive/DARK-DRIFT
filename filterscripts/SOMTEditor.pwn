/* Scripted by RIDE2DAY */
/* Official thread: http://forum.sa-mp.com/showthread.php?t=614667 */


#include <a_samp>


/* =============================== | [DEFINES] | ================================ */
// - Settings - //
#define MAX_SOMT_OBJECTS            (10)

// - Dialogs - //
#define SOMT_MAIN_MENU              (100)
#define SOMT_EDIT_MENU              (101)
#define SOMT_EDIT_OBJECT_MODEL      (102)
#define SOMT_EDIT_TEXT              (103)
#define SOMT_EDIT_MATERIAL_INDEX    (104)
#define SOMT_EDIT_MATERIAL_SIZE     (105)
#define SOMT_EDIT_FONT_FACE         (106)
#define SOMT_EDIT_FONT_SIZE         (107)
#define SOMT_EDIT_BOLD              (108)
#define SOMT_EDIT_COLOR             (109)
#define SOMT_WRITE_COLOR            (110)
#define SOMT_SELECT_COLOR           (111)
#define SOMT_EDIT_TEXT_ALIGNMENT    (112)
//#define SOMT_EDIT_OBJECTS           (113)
#define SOMT_EXPORT_OBJECTS         (114)

// - Colors - //
#define RED_E                       "{FF0000}"
#define BLUE_E                      "{00A7EE}"
#define WHITE_E                     "{FFFFFF}"
#define YELLOW_E                    "{EEEA00}"

#define COLOR_BLUE                  (0x00A7EEFF)

// - Other - //
#define strcpy(%0,%1,%2)            strcat((%0[0] = '\0', %0), %1, %2) /* By Y_Less */


/* =============================== | [VARIABLES] | ================================ */
// - SQLite - //
new DB:sql_index;

// - Objects - //
enum e_Objects
{
    ID,
    ObjectModel,
    Text[129],
    MaterialIndex,
    MaterialSize,
    FontFace[51],
    FontSize,
    Bold,
    FontColor,
    BackgroundColor,
    TextAlignment,
    Float:ObjectCoords[6],
    ObjectID,
    bool:Exists,
    bool:Edited
}
new obj_Info[MAX_SOMT_OBJECTS][e_Objects];

// - Player - //
new p_ObjEditing[MAX_PLAYERS] = {-1, ...};
new bool:p_FontOrBackg[MAX_PLAYERS];

/* =============================== | [CALLBACKS] | ================================ */
public OnFilterScriptInit()
{
    // - Objects - //
    for(new x = 0; x < MAX_SOMT_OBJECTS; x++)
    {
        obj_Info[x][ID] = -1;
        obj_Info[x][Exists] = false;
        obj_Info[x][Edited] = false;
        obj_Info[x][ObjectID] = INVALID_OBJECT_ID;
    }

    // - SQLite - //
    sql_index = db_open("somt.db");

    if(sql_index)
    {
        db_free_result(
            db_query(sql_index,
                "CREATE TABLE IF NOT EXISTS `object_info` (`id` INTEGER NOT NULL,\
                `objmodel` INTEGER NOT NULL,\
                `text` TEXT NOT NULL,\
                `matindex` INTEGER NOT NULL,\
                `matsize` INTEGER NOT NULL,\
                `fontface` TEXT NOT NULL,\
                `fontsize` INTEGER NOT NULL,\
                `bold` NUMERIC NOT NULL,\
                `fontcolor` INTEGER NOT NULL,\
                `backgcolor` INTEGER NOT NULL,\
                `textalign` INTEGER NOT NULL,\
                `ox` REAL NOT NULL,\
                `oy` REAL NOT NULL,\
                `oz` REAL NOT NULL,\
                `rx` REAL NOT NULL,\
                `ry` REAL NOT NULL,\
                `rz` REAL NOT NULL,\
                PRIMARY KEY(`id`))"
            )
        );

        LoadObjectsFromDatabase();
    }
    else
    {
        print("* [SQLite] An error occurred while trying to access the database.");
    }

    // - Credits - //
    print("\n ____________________");
    print("|                    |");
    print("| SOMT Editor Loaded |");
    print("|--------------------|");
    print("|      Scripted      |");
    print("|         by         |");
    print("|      RIDE2DAY      |");
    print("|____________________|\n");
    return 1;
}

public OnFilterScriptExit()
{
    // - Objects - //
    for(new x = 0; x < MAX_SOMT_OBJECTS; x++)
    {
        if(obj_Info[x][Exists] && IsValidObject(obj_Info[x][ObjectID]))
        {
            DestroyObject(obj_Info[x][ObjectID]);
        }
    }

    // - SQLite - //
    db_close(sql_index);
    return 1;
}

public OnPlayerConnect(playerid)
{
    p_ObjEditing[playerid] = -1;
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new idx = p_ObjEditing[playerid];

    if(idx != -1)
    {
        obj_Info[idx][Edited] = false;
    }
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    /*if(!strcmp(cmdtext, "/jetpack", true))
    {
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
        return 1;
    }*/
    if(!strcmp(cmdtext, "/editor", true))
    {
        if(!IsPlayerAdmin(playerid))
        {
            SendClientMessage(playerid, -1, ""RED_E"ERROR: "WHITE_E"you must be an admin in order to use this command.");
            return 1;
        }

        ShowMainMenu(playerid);
        return 1;
    }
    return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case SOMT_MAIN_MENU:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0: /* New Object */
                    {
                        for(new x = 0; x < MAX_SOMT_OBJECTS; x++)
                        {
                            if(!obj_Info[x][Exists])
                            {
                                p_ObjEditing[playerid] = x;
                                obj_Info[x][Exists] = true;
                                obj_Info[x][Edited] = true;
                                break;
                            }
                        }

                        if(p_ObjEditing[playerid] == -1)
                        {
                            SendClientMessage(playerid, -1, ""RED_E"ERROR: "WHITE_E"increase "BLUE_E"MAX_SOMT_OBJECTS "WHITE_E"or delete some objects, the limit has been reached.");
                            ShowMainMenu(playerid);
                            return 1;
                        }

                        new idx = p_ObjEditing[playerid];

                        strcpy(obj_Info[idx][Text], "Scripted by\nRIDE2DAY\nor\nRIDE2MORROW.\nWe are not sure...", 129);
                        obj_Info[idx][ObjectModel] = 19353;
                        obj_Info[idx][MaterialIndex] = 0;
                        obj_Info[idx][MaterialSize] = 140;
                        strcpy(obj_Info[idx][FontFace], "Arial", 51);
                        obj_Info[idx][FontSize] = 70;
                        obj_Info[idx][Bold] = 0;
                        obj_Info[idx][FontColor] = 0xFFFFFFFF;
                        obj_Info[idx][BackgroundColor] = 0xFFB40404;
                        obj_Info[idx][TextAlignment] = OBJECT_MATERIAL_TEXT_ALIGN_CENTER;

                        new Float:x, Float:y, Float:z, Float:ang;

                        GetPlayerPos(playerid, x, y, z);
                        GetPlayerFacingAngle(playerid, ang);

                        obj_Info[idx][ObjectCoords][0] = x + (10.0 * floatsin(-ang, degrees));
                        obj_Info[idx][ObjectCoords][1] = y + (10.0 * floatcos(-ang, degrees));
                        obj_Info[idx][ObjectCoords][2] = z + 1.5;
                        obj_Info[idx][ObjectCoords][3] = 0.0;
                        obj_Info[idx][ObjectCoords][4] = 0.0;
                        obj_Info[idx][ObjectCoords][5] = ang - 90.0;

                        obj_Info[idx][ObjectID] = CreateObject(obj_Info[idx][ObjectModel], obj_Info[idx][ObjectCoords][0], obj_Info[idx][ObjectCoords][1], obj_Info[idx][ObjectCoords][2], obj_Info[idx][ObjectCoords][3], obj_Info[idx][ObjectCoords][4], obj_Info[idx][ObjectCoords][5]);

                        SetObjectMaterialText(
                            obj_Info[idx][ObjectID],
                            obj_Info[idx][Text],
                            obj_Info[idx][MaterialIndex],
                            obj_Info[idx][MaterialSize],
                            obj_Info[idx][FontFace],
                            obj_Info[idx][FontSize],
                            obj_Info[idx][Bold],
                            obj_Info[idx][FontColor],
                            obj_Info[idx][BackgroundColor],
                            obj_Info[idx][TextAlignment]
                        );

                        new info[65];
                        format(info, sizeof(info), ""BLUE_E"INFO: "WHITE_E"new object created ("YELLOW_E"%d"WHITE_E").", idx);
                        SendClientMessage(playerid, -1, info);

                        SendClientMessage(playerid, COLOR_BLUE, "INFO: "WHITE_E"set object's position and click the "YELLOW_E"SAVE "WHITE_E"icon, or press "YELLOW_E"ESC "WHITE_E"to go directly to the edition menu.");

                        EditObject(playerid, obj_Info[idx][ObjectID]);
                    }
                    case 1: /* Edit Object */
                    {
                        SelectObject(playerid);
                        SendClientMessage(playerid, -1, ""BLUE_E"INFO: "WHITE_E"click the object you want to edit.");
                        //ShowPlayerDialog(playerid, SOMT_EDIT_OBJECTS, DIALOG_STYLE_LIST, ""BLUE_E"Edit Object", ""YELLOW_E"1. "WHITE_E"Show object list\n"YELLOW_E"2. "WHITE_E"Select with "YELLOW_E"SelectObject", ""WHITE_E"Select", ""WHITE_E"Back");
                    }
                    case 2: /* Export Objects */
                    {
                        ShowPlayerDialog(playerid, SOMT_EXPORT_OBJECTS, DIALOG_STYLE_LIST, ""BLUE_E"How do you want to export the objects?", ""YELLOW_E"1. "WHITE_E"Global objects\n"YELLOW_E"2. "WHITE_E"Player objects", ""WHITE_E"Export", ""WHITE_E"Back");
                    }
                }
            }
        }
        case SOMT_EDIT_MENU:
        {
            new idx = p_ObjEditing[playerid];

            if(response)
            {
                switch(listitem)
                {
                    case 0: /* Object Model */
                    {
                        ShowPlayerDialog(playerid, SOMT_EDIT_OBJECT_MODEL, DIALOG_STYLE_INPUT, ""BLUE_E"Object Model ID", ""WHITE_E"Type the model id you want to use for this object:", ""WHITE_E"Set", ""WHITE_E"Back");
                    }
                    case 1: /* Object Position */
                    {
                        EditObject(playerid, obj_Info[idx][ObjectID]);
                        SendClientMessage(playerid, COLOR_BLUE, "INFO: "WHITE_E"set object's position and click the "YELLOW_E"SAVE "WHITE_E"icon, or press "YELLOW_E"ESC "WHITE_E"to go back to the edition menu.");
                    }
                    case 2: /* Object Text */
                    {
                        ShowPlayerDialog(playerid, SOMT_EDIT_TEXT, DIALOG_STYLE_INPUT, ""BLUE_E"Object Text", ""WHITE_E"Type what you want to write on the object in the next field:", ""WHITE_E"Set", ""WHITE_E"Back");
                    }
                    case 3: /* Material Index */
                    {
                        ShowPlayerDialog(playerid, SOMT_EDIT_MATERIAL_INDEX, DIALOG_STYLE_INPUT, ""BLUE_E"Material Index", ""WHITE_E"Type the material index you want to use for this object:", ""WHITE_E"Set", ""WHITE_E"Back");
                    }
                    case 4: /* Material Size */
                    {
                        new mat_sizes[447];

                        strcat(mat_sizes,
                            ""YELLOW_E"1. "WHITE_E"32x32 (10)\
                            \n"YELLOW_E"2. "WHITE_E"64x32 (20)\
                           \n"YELLOW_E"3. "WHITE_E"64x64 (30)\
                           \n"YELLOW_E"4. "WHITE_E"128x32 (40)\
                           \n"YELLOW_E"5. "WHITE_E"128x64 (50)\
                           \n"YELLOW_E"6. "WHITE_E"128x128 (60)\
                           \n"YELLOW_E"7. "WHITE_E"256x32 (70)"
                        );
                        strcat(mat_sizes,
                            "\n"YELLOW_E"8. "WHITE_E"256x64 (80)\
                           \n"YELLOW_E"9. "WHITE_E"256x128 (90)\
                           \n"YELLOW_E"10. "WHITE_E"256x256 (100)\
                           \n"YELLOW_E"11. "WHITE_E"512x64 (110)\
                           \n"YELLOW_E"12. "WHITE_E"512x128 (120)\
                           \n"YELLOW_E"13. "WHITE_E"512x256 (130)\
                           \n"YELLOW_E"14. "WHITE_E"512x512 (140)"
                        );

                        ShowPlayerDialog(playerid, SOMT_EDIT_MATERIAL_SIZE, DIALOG_STYLE_LIST, ""BLUE_E"Select the material size you want to use:", mat_sizes, ""WHITE_E"Set", ""WHITE_E"Back");
                    }
                    case 5: /* Font Face */
                    {
                        ShowPlayerDialog(playerid, SOMT_EDIT_FONT_FACE, DIALOG_STYLE_INPUT, ""BLUE_E"Font Face", ""WHITE_E"Type below the name of the font you want to use:", ""WHITE_E"Set", ""WHITE_E"Back");
                    }
                    case 6: /* Font Size */
                    {
                        ShowPlayerDialog(playerid, SOMT_EDIT_FONT_SIZE, DIALOG_STYLE_INPUT, ""BLUE_E"Font Size", ""WHITE_E"Type the font size you want to use below (max. "YELLOW_E"255"WHITE_E"):", ""WHITE_E"Set", ""WHITE_E"Back");
                    }
                    case 7: /* Bold */
                    {
                        ShowPlayerDialog(playerid, SOMT_EDIT_BOLD, DIALOG_STYLE_MSGBOX, ""BLUE_E"Bold", ""WHITE_E"Would you like to set the text bold?", ""WHITE_E"Yes", ""WHITE_E"No");
                    }
                    case 8: /* Font Color */
                    {
                        p_FontOrBackg[playerid] = false;
                        ShowPlayerDialog(playerid, SOMT_EDIT_COLOR, DIALOG_STYLE_LIST, ""BLUE_E"Font Color", ""YELLOW_E"1. "WHITE_E"Write color code\n"YELLOW_E"2. "WHITE_E"Select from the list", ""WHITE_E"Select", ""WHITE_E"Back");
                    }
                    case 9: /* Background Color */
                    {
                        p_FontOrBackg[playerid] = true;
                        ShowPlayerDialog(playerid, SOMT_EDIT_COLOR, DIALOG_STYLE_LIST, ""BLUE_E"Background Color", ""YELLOW_E"1. "WHITE_E"Write color code\n"YELLOW_E"2. "WHITE_E"Select from the list", ""WHITE_E"Select", ""WHITE_E"Back");
                    }
                    case 10: /* Text Alignment */
                    {
                        ShowPlayerDialog(playerid, SOMT_EDIT_TEXT_ALIGNMENT, DIALOG_STYLE_LIST, ""BLUE_E"Text Alignment", ""YELLOW_E"1. "WHITE_E"Left\n"YELLOW_E"2. "WHITE_E"Center\n"YELLOW_E"3. "WHITE_E"Right", ""WHITE_E"Set", ""WHITE_E"Back");
                    }
                    case 11: /* Remove Object */
                    {
                        if(obj_Info[idx][ID] != -1)
                        {
                            RemoveObjectFromDatabase(idx);
                        }

                        obj_Info[idx][ID] = -1;
                        obj_Info[idx][Exists] = false;
                        obj_Info[idx][Edited] = false;

                        if(IsValidObject(obj_Info[idx][ObjectID]))
                        {
                            DestroyObject(obj_Info[idx][ObjectID]);
                        }
                        obj_Info[idx][ObjectID] = INVALID_OBJECT_ID;

                        new info[59];
                        format(info, sizeof(info), ""BLUE_E"INFO: "WHITE_E"object "YELLOW_E"%d "WHITE_E"removed.", idx);
                        SendClientMessage(playerid, -1, info);

                        p_ObjEditing[playerid] = -1;
                        ShowMainMenu(playerid);
                    }
                }
            }
            else
            {
                obj_Info[idx][Edited] = false;

                if(obj_Info[idx][ID] == -1)
                {
                    AddObjectToDatabase(idx);
                }
                else
                {
                    UpdateObjectOnDatabase(idx);
                }

                p_ObjEditing[playerid] = -1;
                ShowMainMenu(playerid);
            }
        }
        case SOMT_EDIT_OBJECT_MODEL:
        {
            if(response)
            {
                if(!isNumeric(inputtext))
                {
                    SendClientMessage(playerid, -1, ""RED_E"ERROR: "WHITE_E"the model id must be a valid numeric value.");
                    ShowPlayerDialog(playerid, SOMT_EDIT_OBJECT_MODEL, DIALOG_STYLE_INPUT, ""BLUE_E"Object Model ID", ""WHITE_E"Type the model id you want to use for this object:", ""WHITE_E"Set", ""WHITE_E"Back");
                    return 1;
                }

                obj_Info[p_ObjEditing[playerid]][ObjectModel] = strval(inputtext);
                UpdateObject(p_ObjEditing[playerid], true);
                ShowObjectEditMenu(playerid);
            }
            else
            {
                ShowObjectEditMenu(playerid);
            }
        }
        case SOMT_EDIT_TEXT:
        {
            if(response)
            {
                if(!inputtext[0])
                {
                    SendClientMessage(playerid, -1, ""RED_E"ERROR: "WHITE_E"the text must have at least "YELLOW_E"1 "WHITE_E"character.");
                    ShowPlayerDialog(playerid, SOMT_EDIT_TEXT, DIALOG_STYLE_INPUT, ""BLUE_E"Object Text", ""WHITE_E"Type what you want to write on the object in the next field:", ""WHITE_E"Set", ""WHITE_E"Back");
                    return 1;
                }

                str_replace("\n", "\\n", inputtext, obj_Info[p_ObjEditing[playerid]][Text], false, 129);
                UpdateObject(p_ObjEditing[playerid], true);
                ShowObjectEditMenu(playerid);
            }
            else
            {
                ShowObjectEditMenu(playerid);
            }
        }
        case SOMT_EDIT_MATERIAL_INDEX:
        {
            if(response)
            {
                if(!isNumeric(inputtext))
                {
                    SendClientMessage(playerid, -1, ""RED_E"ERROR: "WHITE_E"the material index must be a valid numeric value.");
                    ShowPlayerDialog(playerid, SOMT_EDIT_MATERIAL_INDEX, DIALOG_STYLE_INPUT, ""BLUE_E"Material Index", ""WHITE_E"Type the material index you want to use for this object:", ""WHITE_E"Set", ""WHITE_E"Back");
                    return 1;
                }

                obj_Info[p_ObjEditing[playerid]][MaterialIndex] = strval(inputtext);
                UpdateObject(p_ObjEditing[playerid], true);
                ShowObjectEditMenu(playerid);
            }
            else
            {
                ShowObjectEditMenu(playerid);
            }
        }
        case SOMT_EDIT_MATERIAL_SIZE:
        {
            if(response)
            {
                obj_Info[p_ObjEditing[playerid]][MaterialSize] = (listitem + 1) * 10;
                UpdateObject(p_ObjEditing[playerid]);
            }

            ShowObjectEditMenu(playerid);
        }
        case SOMT_EDIT_FONT_FACE:
        {
            if(response)
            {
                if(!inputtext[0] || strlen(inputtext) > 50)
                {
                    SendClientMessage(playerid, -1, ""RED_E"ERROR: "WHITE_E"the font face must have at least "YELLOW_E"1 "WHITE_E"character and "YELLOW_E"50 "WHITE_E"characters as maximum.");
                    ShowPlayerDialog(playerid, SOMT_EDIT_FONT_FACE, DIALOG_STYLE_INPUT, ""BLUE_E"Font Face", ""WHITE_E"Type below the name of the font you want to use:", ""WHITE_E"Set", ""WHITE_E"Back");
                    return 1;
                }

                strcpy(obj_Info[p_ObjEditing[playerid]][FontFace], inputtext, 51);
                UpdateObject(p_ObjEditing[playerid]);
                ShowObjectEditMenu(playerid);
            }
            else
            {
                ShowObjectEditMenu(playerid);
            }
        }
        case SOMT_EDIT_FONT_SIZE:
        {
            if(response)
            {
                if(isNumeric(inputtext) && 1 <= strval(inputtext) <= 255)
                {
                    obj_Info[p_ObjEditing[playerid]][FontSize] = strval(inputtext);
                    UpdateObject(p_ObjEditing[playerid]);
                    ShowObjectEditMenu(playerid);
                }
                else
                {
                    SendClientMessage(playerid, -1, ""RED_E"ERROR: "WHITE_E"the font size must be a valid number (min. "YELLOW_E"1 "WHITE_E"- max. "YELLOW_E"255"WHITE_E").");
                    ShowPlayerDialog(playerid, SOMT_EDIT_FONT_SIZE, DIALOG_STYLE_INPUT, ""BLUE_E"Font Size", ""WHITE_E"Type the font size you want to use below (max. "YELLOW_E"255"WHITE_E"):", ""WHITE_E"Set", ""WHITE_E"Back");
                }
            }
            else
            {
                ShowObjectEditMenu(playerid);
            }
        }
        case SOMT_EDIT_BOLD:
        {
            if(response)
            {
                obj_Info[p_ObjEditing[playerid]][Bold] = 1;
            }
            else
            {
                obj_Info[p_ObjEditing[playerid]][Bold] =0;
            }

            UpdateObject(p_ObjEditing[playerid]);
            ShowObjectEditMenu(playerid);
        }
        case SOMT_EDIT_COLOR:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0: /* Write hexadecimal color. */
                    {
                        ShowPlayerDialog(playerid, SOMT_WRITE_COLOR, DIALOG_STYLE_INPUT, (p_FontOrBackg[playerid] == true ? (""BLUE_E"Background Color") : (""BLUE_E"Font Color")), ""WHITE_E"Write the color you want to use in the next field (format "YELLOW_E"0xAARRGGBB"WHITE_E"):", ""WHITE_E"Set", ""WHITE_E"Back");
                    }
                    case 1: /* Select from the list. */
                    {
                        ShowPlayerDialog(playerid, SOMT_SELECT_COLOR, DIALOG_STYLE_LIST, (p_FontOrBackg[playerid] == true ? (""BLUE_E"Background Color") : (""BLUE_E"Font Color")), "{FF0000}Red\n{04B404}Green\n{0000FF}Blue\n{FFFF00}Yellow\n{FF8000}Orange\n{000000}Black\n{FFFFFF}White\n{A4A4A4}Grey", ""WHITE_E"Set", ""WHITE_E"Back");
                    }
                }
            }
            else
            {
                ShowObjectEditMenu(playerid);
            }
        }
        case SOMT_WRITE_COLOR:
        {
            if(response)
            {
                if(!p_FontOrBackg[playerid])
                {
                    obj_Info[p_ObjEditing[playerid]][FontColor] = HexToInt(inputtext);
                }
                else
                {
                    obj_Info[p_ObjEditing[playerid]][BackgroundColor] = HexToInt(inputtext);
                }

                UpdateObject(p_ObjEditing[playerid]);
                ShowObjectEditMenu(playerid);
            }
            else
            {
                ShowPlayerDialog(playerid, SOMT_EDIT_COLOR, DIALOG_STYLE_LIST, (p_FontOrBackg[playerid] == true ? (""BLUE_E"Background Color") : (""BLUE_E"Font Color")), ""YELLOW_E"1. "WHITE_E"Write color code\n"YELLOW_E"2. "WHITE_E"Select from the list", ""WHITE_E"Select", ""WHITE_E"Back");
            }
        }
        case SOMT_SELECT_COLOR:
        {
            if(response)
            {
                new color;
                switch(listitem)
                {
                    case 0: color = 0xFFFF0000; /* Red */
                    case 1: color = 0xFF04B404; /* Green */
                    case 2: color = 0xFF0000FF; /* Blue */
                    case 3: color = 0xFFFFFF00; /* Yellow */
                    case 4: color = 0xFFFF8000; /* Orange */
                    case 5: color = 0xFF000000; /* Black */
                    case 6: color = 0xFFFFFFFF; /* White */
                    case 7: color = 0xFFA4A4A4; /* Grey */
                }

                if(!p_FontOrBackg[playerid])
                {
                    obj_Info[p_ObjEditing[playerid]][FontColor] = color;
                }
                else
                {
                    obj_Info[p_ObjEditing[playerid]][BackgroundColor] = color;
                }

                UpdateObject(p_ObjEditing[playerid]);
                ShowObjectEditMenu(playerid);
            }
            else
            {
                ShowPlayerDialog(playerid, SOMT_EDIT_COLOR, DIALOG_STYLE_LIST, (p_FontOrBackg[playerid] == true ? (""BLUE_E"Background Color") : (""BLUE_E"Font Color")), ""YELLOW_E"1. "WHITE_E"Write color code\n"YELLOW_E"2. "WHITE_E"Select from the list", ""WHITE_E"Select", ""WHITE_E"Back");
            }
        }
        case SOMT_EDIT_TEXT_ALIGNMENT:
        {
            if(response)
            {
                obj_Info[p_ObjEditing[playerid]][TextAlignment] = listitem;
                UpdateObject(p_ObjEditing[playerid]);
            }

            ShowObjectEditMenu(playerid);
        }
        /*case SOMT_EDIT_OBJECTS:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0:
                    {
                    }
                    case 1:
                    {
                        SelectObject(playerid);
                        SendClientMessage(playerid, -1, ""BLUE_E"INFO: "WHITE_E"click the object you want to edit.");
                    }
                }
            }
            else
            {
                ShowMainMenu(playerid);
            }
        }*/
        case SOMT_EXPORT_OBJECTS:
        {
            if(response)
            {
                new data[405];

                new File:somt_file = fopen("SOMT_Objects.txt", io_write);

                if(somt_file)
                {
                    for(new x = 0; x < MAX_SOMT_OBJECTS; x++)
                    {
                        if(obj_Info[x][Exists])
                        {
                            new text[129];
                            str_replace("\\n", "\n", obj_Info[x][Text], text, false, 129);

                            format(data, sizeof(data),
                                "new obj%d = %s%d, %0.4f, %0.4f, %0.4f, %0.4f, %0.4f, %0.4f);\r\n\
                                %sobj%d, \"%s\", %d, %d, \"%s\", %d, %d, 0x%x, 0x%x, %d);\r\n\r\n",
                                x,
                                (listitem == 0 ? ("CreateObject(") : ("CreatePlayerObject(playerid, ")),
                                obj_Info[x][ObjectModel],
                                obj_Info[x][ObjectCoords][0],
                                obj_Info[x][ObjectCoords][1],
                                obj_Info[x][ObjectCoords][2],
                                obj_Info[x][ObjectCoords][3],
                                obj_Info[x][ObjectCoords][4],
                                obj_Info[x][ObjectCoords][5],
                                (listitem == 0 ? ("SetObjectMaterialText(") : ("SetPlayerObjectMaterialText(playerid, ")),
                                x,
                                text,
                                obj_Info[x][MaterialIndex],
                                obj_Info[x][MaterialSize],
                                obj_Info[x][FontFace],
                                obj_Info[x][FontSize],
                                obj_Info[x][Bold],
                                obj_Info[x][FontColor],
                                obj_Info[x][BackgroundColor],
                                obj_Info[x][TextAlignment]
                            );

                            fwrite(somt_file, data);
                        }
                    }

                    fclose(somt_file);

                    SendClientMessage(playerid, -1, ""BLUE_E"INFO: "WHITE_E"objects exported to "YELLOW_E"SOMT_Objects.txt "WHITE_E"(check scriptfiles).");
                }
                else
                {
                    SendClientMessage(playerid, -1, ""RED_E"ERROR: "WHITE_E"the export file couldn't be created.");
                }
            }
            else
            {
                ShowMainMenu(playerid);
            }
        }
    }
    return 0;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    new idx = p_ObjEditing[playerid];

    if(idx != -1 && objectid == obj_Info[idx][ObjectID])
    {
        switch(response)
        {
            case EDIT_RESPONSE_CANCEL:
            {
                /* Set object to its original position if player cancels. */
                SetObjectPos(objectid, obj_Info[idx][ObjectCoords][0], obj_Info[idx][ObjectCoords][1], obj_Info[idx][ObjectCoords][2]);
                SetObjectRot(objectid, obj_Info[idx][ObjectCoords][3], obj_Info[idx][ObjectCoords][4], obj_Info[idx][ObjectCoords][5]);

                ShowObjectEditMenu(playerid);
            }
            case EDIT_RESPONSE_FINAL:
            {
                /* Update object's coordinates. */
                obj_Info[idx][ObjectCoords][0] = fX;
                obj_Info[idx][ObjectCoords][1] = fY;
                obj_Info[idx][ObjectCoords][2] = fZ;
                obj_Info[idx][ObjectCoords][3] = fRotX;
                obj_Info[idx][ObjectCoords][4] = fRotY;
                obj_Info[idx][ObjectCoords][5] = fRotZ;

                ShowObjectEditMenu(playerid);
            }
            case EDIT_RESPONSE_UPDATE:
            {
                /* Sync object for other players. */
                SetObjectPos(objectid, fX, fY, fZ);
                SetObjectRot(objectid, fRotX, fRotY, fRotZ);
            }
        }
    }
    return 1;
}

public OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
    if(type == SELECT_OBJECT_GLOBAL_OBJECT && p_ObjEditing[playerid] == -1)
    {
        for(new x = 0; x < MAX_SOMT_OBJECTS; x++)
        {
            if(obj_Info[x][ObjectID] == objectid)
            {
                if(obj_Info[x][Edited] == false)
                {
                    CancelEdit(playerid);

                    p_ObjEditing[playerid] = x;
                    obj_Info[x][Edited] = true;
                    ShowObjectEditMenu(playerid);

                    new info[59];
                    format(info, sizeof(info), ""BLUE_E"INFO: "WHITE_E"editing object "YELLOW_E"%d"WHITE_E".", x);
                    SendClientMessage(playerid, -1, info);
                }
                else
                {
                    SendClientMessage(playerid, -1, ""RED_E"ERROR: "WHITE_E"someone else is editing that object.");
                }
                return 1;
            }
        }

        SendClientMessage(playerid, -1, ""RED_E"ERROR: "WHITE_E"that object hasn't been created with the SetObjectMaterialText editor.");
    }
    return 1;
}


/* =============================== | [FUNCTIONS] | ================================ */
ShowMainMenu(playerid)
{
    ShowPlayerDialog(playerid, SOMT_MAIN_MENU, DIALOG_STYLE_LIST, ""BLUE_E"SetObjectMaterialText Editor by RIDE2DAY", ""YELLOW_E"1. "WHITE_E"New Object\n"YELLOW_E"2. "WHITE_E"Edit Object\n"YELLOW_E"3. "WHITE_E"Export Objects", ""WHITE_E"Select", ""WHITE_E"Exit");
    return 1;
}

ShowObjectEditMenu(playerid)
{
    new idx = p_ObjEditing[playerid];

    new info[36];
    format(info, sizeof(info), ""BLUE_E"Editing Object: "YELLOW_E"%d", p_ObjEditing[playerid]);

    new f_color[9];
    format(f_color, sizeof(f_color), "%x", obj_Info[idx][FontColor]);
    strdel(f_color, 0, 2);

    new bg_color[9];
    format(bg_color, sizeof(bg_color), "%x", obj_Info[idx][BackgroundColor]);
    strdel(bg_color, 0, 2);

    new alignment[7];
    switch(obj_Info[idx][TextAlignment])
    {
        case 0: alignment = "Left";
        case 1: alignment = "Center";
        case 2: alignment = "Right";
    }

    new options[355];
    format(options, sizeof(options),
        "Option\tValue\n\
        Model ID\t"YELLOW_E"%d\n\
        Position\t"YELLOW_E"X Y Z\n\
        Text\t"YELLOW_E"...\n\
        Material Index\t"YELLOW_E"%d\n\
        Material Size\t"YELLOW_E"%d\n\
        Font Face\t"YELLOW_E"%s\n\
        Font Size\t"YELLOW_E"%d\n\
        Bold\t"YELLOW_E"%s\n\
        Font Color\t{%s}0x%x\n\
        Background Color\t{%s}0x%x\n\
        Text Alignment\t"YELLOW_E"%s\n\
        "RED_E"Remove Object",
        obj_Info[idx][ObjectModel],
        obj_Info[idx][MaterialIndex],
        obj_Info[idx][MaterialSize],
        obj_Info[idx][FontFace],
        obj_Info[idx][FontSize],
        (obj_Info[idx][Bold] == 1 ? ("Yes") : ("No")),
        f_color, obj_Info[idx][FontColor],
        bg_color, obj_Info[idx][BackgroundColor],
        alignment
    );

    ShowPlayerDialog(playerid, SOMT_EDIT_MENU, DIALOG_STYLE_TABLIST_HEADERS, info, options, ""WHITE_E"Edit", ""WHITE_E"Back");
    return 1;
}

UpdateObject(idx, bool:destroy=false)
{
    if(destroy)
    {
        if(IsValidObject(obj_Info[idx][ObjectID]))
        {
            DestroyObject(obj_Info[idx][ObjectID]);
        }

        obj_Info[idx][ObjectID] = CreateObject(obj_Info[idx][ObjectModel], obj_Info[idx][ObjectCoords][0], obj_Info[idx][ObjectCoords][1], obj_Info[idx][ObjectCoords][2], obj_Info[idx][ObjectCoords][3], obj_Info[idx][ObjectCoords][4], obj_Info[idx][ObjectCoords][5]);
    }

    SetObjectMaterialText(
        obj_Info[idx][ObjectID],
        obj_Info[idx][Text],
        obj_Info[idx][MaterialIndex],
        obj_Info[idx][MaterialSize],
        obj_Info[idx][FontFace],
        obj_Info[idx][FontSize],
        obj_Info[idx][Bold],
        obj_Info[idx][FontColor],
        obj_Info[idx][BackgroundColor],
        obj_Info[idx][TextAlignment]
    );
    return 1;
}

LoadObjectsFromDatabase()
{
    new DBResult:res = db_query(sql_index, "SELECT * FROM `object_info`");

    new rows = db_num_rows(res);

    new text[129];

    for(new x = 0; x < rows; x++)
    {
        obj_Info[x][ID] = db_get_field_int(res, 0);
        obj_Info[x][ObjectModel] = db_get_field_int(res, 1);

        db_get_field(res, 2, text, 129);
        str_replace("\n", "\\n", text, obj_Info[x][Text], false, 129);

        obj_Info[x][MaterialIndex] = db_get_field_int(res, 3);
        obj_Info[x][MaterialSize] = db_get_field_int(res, 4);
        db_get_field(res, 5, obj_Info[x][FontFace], 51);
        obj_Info[x][FontSize] = db_get_field_int(res, 6);
        obj_Info[x][Bold] = db_get_field_int(res, 7);
        obj_Info[x][FontColor] = db_get_field_int(res, 8);
        obj_Info[x][BackgroundColor] = db_get_field_int(res, 9);
        obj_Info[x][TextAlignment] = db_get_field_int(res, 10);
        obj_Info[x][ObjectCoords][0] = db_get_field_float(res, 11);
        obj_Info[x][ObjectCoords][1] = db_get_field_float(res, 12);
        obj_Info[x][ObjectCoords][2] = db_get_field_float(res, 13);
        obj_Info[x][ObjectCoords][3] = db_get_field_float(res, 14);
        obj_Info[x][ObjectCoords][4] = db_get_field_float(res, 15);
        obj_Info[x][ObjectCoords][5] = db_get_field_float(res, 16);

        obj_Info[x][Exists] = true;

        UpdateObject(x, true);

        db_next_row(res);
    }

    db_free_result(res);
    return 1;
}

AddObjectToDatabase(idx)
{
    new DBResult:res = db_query(sql_index, "SELECT MAX(`id`) FROM `object_info`");

    if(db_num_rows(res))
    {
        new val[5];
        db_get_field(res, 0, val, sizeof(val));

        db_free_result(res);

        obj_Info[idx][ID] = strval(val) + 1;

        new text[129];
        new query[405];

        str_replace("\\n", "\n", obj_Info[idx][Text], text, false, 129);

        format(query, sizeof(query),
            "INSERT INTO `object_info` VALUES ('%d', '%d', '%q', '%d', '%d', '%q', '%d', '%d', '%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f')",
            obj_Info[idx][ID],
            obj_Info[idx][ObjectModel],
            text,
            obj_Info[idx][MaterialIndex],
            obj_Info[idx][MaterialSize],
            obj_Info[idx][FontFace],
            obj_Info[idx][FontSize],
            obj_Info[idx][Bold],
            obj_Info[idx][FontColor],
            obj_Info[idx][BackgroundColor],
            obj_Info[idx][TextAlignment],
            obj_Info[idx][ObjectCoords][0],
            obj_Info[idx][ObjectCoords][1],
            obj_Info[idx][ObjectCoords][2],
            obj_Info[idx][ObjectCoords][3],
            obj_Info[idx][ObjectCoords][4],
            obj_Info[idx][ObjectCoords][5]
        );

        db_free_result(db_query(sql_index, query));
    }
    else
    {
        print("* [SQLite] An error occurred while trying to add an object to the database.");
    }
    return 1;
}

UpdateObjectOnDatabase(idx)
{
    new text[129];
    new query[405];

    str_replace("\\n", "\n", obj_Info[idx][Text], text, false, 129);

    format(query, sizeof(query),
        "UPDATE `object_info` SET `objmodel`='%d', `text`='%q', `matindex`='%d', `matsize`='%d', `fontface`='%q', `fontsize`='%d', `bold`='%d', `fontcolor`='%d', `backgcolor`='%d', `textalign`='%d', `ox`='%f', `oy`='%f', `oz`='%f', `rx`='%f', `ry`='%f', `rz`='%f' WHERE `id`='%d'",
        obj_Info[idx][ObjectModel],
        text,
        obj_Info[idx][MaterialIndex],
        obj_Info[idx][MaterialSize],
        obj_Info[idx][FontFace],
        obj_Info[idx][FontSize],
        obj_Info[idx][Bold],
        obj_Info[idx][FontColor],
        obj_Info[idx][BackgroundColor],
        obj_Info[idx][TextAlignment],
        obj_Info[idx][ObjectCoords][0],
        obj_Info[idx][ObjectCoords][1],
        obj_Info[idx][ObjectCoords][2],
        obj_Info[idx][ObjectCoords][3],
        obj_Info[idx][ObjectCoords][4],
        obj_Info[idx][ObjectCoords][5],
        obj_Info[idx][ID]
    );

    db_free_result(db_query(sql_index, query));
    return 1;
}

RemoveObjectFromDatabase(idx)
{
    new query[45];
    format(query, sizeof(query), "DELETE FROM `object_info` WHERE `id`='%d'", obj_Info[idx][ID]);
    db_free_result(db_query(sql_index, query));
    return 1;
}

isNumeric(const string[])
{
    new length = strlen(string);

    if(!string[0])
    {
        return 0;
    }

    for (new i = 0; i < length; i++)
    {
        if((string[i] > '9' || string[i] < '0' && string[i] != '-' && string[i] != '+') || (string[i] == '-' && i != 0) || (string[i] == '+' && i != 0))
        {
            return 0;
        }
    }

    if(length == 1 && (string[0] == '-' || string[0] == '+'))
    {
        return 0;
    }
    return 1;
}

stock HexToInt(string[])
{
    if(!string[0])
    {
        return 0;
    }

    new cur = 1;
    new res = 0;

    for(new i = strlen(string); i > 0; i--)
    {
        if(string[i - 1] < 58)
        {
            res= res + cur * (string[i - 1] - 48);
        }
        else
        {
            res = res + cur * (string[i - 1] - 65 + 10);
        }
        cur = cur * 16;
    }
    return res;
}

stock str_replace(newstr[], oldstr[], srcstr[], deststr[], bool: ignorecase = false, size = sizeof(deststr)) /* By Double-O-Seven */
{
    new idx;
    new rep;
    new newlen = strlen(newstr);
    new oldlen = strlen(oldstr);
    new srclen = strlen(srcstr);

    for(new i = 0; i < srclen; ++i)
    {
        if((i + oldlen) <= srclen)
        {
            if(!strcmp(srcstr [i], oldstr, ignorecase, oldlen))
            {
                deststr[idx] = '\0';
                strcat(deststr, newstr, size);

                ++rep;

                idx += newlen;
                i += oldlen - 1;
            }
            else
            {
                if(idx < (size - 1))
                {
                    deststr[idx++] = srcstr[i];
                }
                else
                {
                    return rep;
                }
            }
        }
        else
        {
            if(idx < (size - 1))
            {
                deststr[idx++] = srcstr[i];
            }
            else
            {
                return rep;
            }
        }
    }
    deststr[idx] = '\0';
    return rep;
}
