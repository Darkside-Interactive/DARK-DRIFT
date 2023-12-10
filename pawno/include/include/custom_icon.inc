/**
--------------------------------------------------------------------------
|           |==============================================|             |
|           |               Custom Map Icons               |             |
|           |============================ v1.0 RC 5 =======|             |
|                                                                        |
|		    |=== Authors: =================================|             |
|		    |=> Aleks10           (Aleksey.al09@gmail.com) |             |
|           |=> Romanius               (romanius@namba.kg) |             |
|		    |==============================================|             |
|                                                                        |
|  This script is free software: you can redistribute it and/or modify   |
|  it under the terms of the GNU General Public License as published by  |
|  the Free Software Foundation, either version 3 of the License, or     |
|  (at your option) any later version.                                   |
|                                                                        |
|  This script is distributed in the hope that it will be useful,        |
|  but WITHOUT ANY WARRANTY; without even the implied warranty of        |
|  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         |
|  GNU General Public License for more details.                          |
|                                                                        |
|  You should have received a copy of the GNU General Public License     |
|  along with this script.  If not, see <http://www.gnu.org/licenses/>.  |
|																		 |
--------------------------------------------------------------------------
**/

#if defined _cust_ico_included
	#endinput
#endif
#define _cust_ico_included

#include <a_samp>
#include <r_io>

#define MAX_CUSTOM_MAP_ICONS 3 // Пока что.

enum cMapIconInfo
{
	gangzid[256],
	pixel[256],
//	Float:px,
//	Float:py,
	bool:isUsed,
	len,
}

static stock customMapIcon[MAX_CUSTOM_MAP_ICONS][cMapIconInfo];

stock DestroyCustomMapIcon(iconid)
{
	if(!customMapIcon[iconid][isUsed]) return;

	for(new i; i < customMapIcon[iconid][len]; i++)
	{
		GangZoneDestroy(customMapIcon[iconid][gangzid][i]);
		
		customMapIcon[iconid][pixel][i] = 0x00000000;
	}
	
	customMapIcon[iconid][isUsed] = false;
}

stock CreateCustomMapIcon(filename[], Float:X, Float:Y, Float:Size = 24.0)
{
	new curentIconId;
	
	while(customMapIcon[curentIconId][isUsed]) curentIconId++;

	if(curentIconId >= MAX_CUSTOM_MAP_ICONS) return -1;

	new File:f = fopen(filename, io_read);
	
	new reserved = readInt16(f);
	new type	 = readInt16(f);
	new count	 = readInt16(f);
	
	if((reserved != 0 && type != 1) || count <= 0)
	{
		printf("[Custom Icon] -> Invalid ICO file! Filename %s", filename);
		
		fclose(f);
		
		return -1;
	}
	
	new width;
	new heigth;
	
	new image_offset;
	
	for(new i; i < count; i++)
	{
		width = readByte(f);
		heigth = readByte(f);
		
		fseek(f, 4, seek_current);
		
		new bit_count = readInt16(f);
		
		fseek(f, 4, seek_current);
		
		image_offset = readInt32(f);
		
		if(bit_count != 32 || (width != 16 && heigth != 16))
		{
			continue;
		}
		
		fseek(f, image_offset + 40);
		
		new Float:x = X-Size, Float:y = Y-Size;
	
		new c = 0;
	
		for(new j; j < 256; j++)
		{
			new B = readByte(f);
			new G = readByte(f);
			new R = readByte(f);
			new A = readByte(f);
			
			if(A > 0x10)
			{
				customMapIcon[curentIconId][pixel][c] = (R << 24 | G << 16 | B << 8 | A);
			
				customMapIcon[curentIconId][gangzid][c] = GangZoneCreate(x, y, x + Size / 8, y + Size / 8);
				
				c++;
			}
			
			x += Size / 8;
			
			if (x >= X + Size && y < Y + Size)
			{
				x = X - Size;
				y += Size / 8;
			}
		}
		
		fclose(f);
		
		customMapIcon[curentIconId][isUsed] = true;
		customMapIcon[curentIconId][len] = c;
		
		printf("[Custom Icon] -> Icon %s created! Gangzones used: %d (%.1f%%)", filename, c, (100.0 / 256.0) * float(c));
		
		return curentIconId;
	}
	
	fclose(f);
	
	printf("[Custom Icon] -> Cant find any 16x16 32bit icon");
	
	return -1;
}

public OnPlayerSpawn(playerid)
{
	for(new j; j < MAX_CUSTOM_MAP_ICONS; j++)
	{
		if(!customMapIcon[j][isUsed]) continue;
		
		for(new i; i < customMapIcon[j][len]; i++)
		{
			GangZoneShowForPlayer(playerid, customMapIcon[j][gangzid][i], customMapIcon[j][pixel][i]);
		}
	}
}


#undef MAX_CUSTOM_MAP_ICONS


#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerSpawn CustmIcons_OnPlayerSpawn

forward CustmIcons_OnPlayerSpawn(playerid);