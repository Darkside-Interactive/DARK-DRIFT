/*
*	Created:			11.02.10
*	Author:				009
*	Last Modifed:		-
*	Description:		Сеть
*/

#if defined _network_included
	#endinput
#endif

#define _network_included
#pragma library network

// --------------------------------------------------
// includes
// --------------------------------------------------
#include "mode_debug"
#include "mode_property"

// --------------------------------------------------
// defines
// --------------------------------------------------
#define SQUARE_SIZE 60

// --------------------------------------------------
// statics
// --------------------------------------------------
static Squares[SQUARE_SIZE * SQUARE_SIZE];

// --------------------------------------------------
// natives list (for pawno functions list)
// --------------------------------------------------
/*
native CreateNetwork(networkid,name[]);
native GetNetworkName(networkid);
native GetSquareIdForXY(Float:X,Float:Y);
native SetSquareNetworkStatus(squareid,networkid,bool:ishave);
native IsSquareHaveNetwork(squareid,networkid);
native GetSquareNetworkStatus(squareid,networkid);
*/

// --------------------------------------------------
// stocks
// --------------------------------------------------
stock CreateNetwork(name[])
{
	Debug(DEBUG_START,"CreateNetwork('%s')",name);
	new networkid = MySQL_GetMinimalFreeSlot("id","Networks") + 1;
	Debug(DEBUG_ACTION,"add network in base");
	format(query,sizeof(query),"INSERT INTO `Networks` (`id`,`Name`) VALUES (%d,'%s')",networkid,name);
	samp_mysql_query(query);
	Debug(DEBUG_END,"CreateNetwork(reason: complete)");
	return networkid;
}

stock GetNetworkName(networkid)
{
	Debug(DEBUG_START,"GetNetworkName('%s')",networkid);
	nullstr(result);
	format(query,sizeof(query),"SELECT `Name` FROM `Networks` WHERE `id`=%d",networkid);
	samp_mysql_query(query);
	samp_mysql_store_result();
	if(!samp_mysql_fetch_row(result))
	{
		Debug(DEBUG_END,"GetNetworkName(reason: error)");
		printf("[ERROR] Network -> GetNetworkName (not find network %d)",networkid);
		result = "Unknown";
		return result;
	}
	Debug(DEBUG_END,"GetNetworkName(reason: complete)");
	return strval(result);
}

stock GetSquareIdForXY(Float:X,Float:Y)
{
	Debug(DEBUG_START,"GetSquareIdForXY(%f,%f)",X,Y);
	if(X < 0) X = 3000.0 - X;
	if(Y < 0) Y = 3000.0 - Y;
	Debug(DEBUG_END,"GetSquareIdForXY(reason: complete)");
	return (SQUARE_SIZE * (floatround(Y / 100.0) - 1)) + floatround(X / 100.0);
}

stock SetSquareNetworkStatus(squareid,networkid,bool:ishave)
{
	Debug(DEBUG_START,"SetSquareNetworkStatus(%d,%d,%b)",squareid,networkid,ishave);
	if(ishave) Squares[squareid][networkid]++;
	else Squares[squareid][networkid]--;
	Debug(DEBUG_END,"SetSquareNetworkStatus(reason: complete)");
}

stock GetSquareNetworkStatus(squareid,networkid)
{
	Debug(DEBUG_START,"GetSquareNetworkStatus(%d,%d)",squareid,networkid);
	Debug(DEBUG_END,"GetSquareNetworkStatus(reason: complete)");
	return Squares[squareid][networkid];
}

stock SetSquareRangeNetworkStatus(squareid,range,networkid,bool:ishave)
{
	Debug(DEBUG_START,"SetSquareRangeNetworkStatus(%d,%d,%d,%b)",squareid,range,networkid,ishave);
	new tmp = squareid - (SQUARE_SIZE * range) - range,
		i,
		j;
	while(j >= 0)
	{
		if(ishave) Squares[tmp][networkid]++;
		else Squares[tmp][networkid]--;
		i++;
		if(i <= range) tmp += 1;
		else 
		{
			tmp += SQUARE_SIZE - (range * 2);
			j++;
			i = 0;
			if(j > (range * 2)) break;
		}
	}
	Debug(DEBUG_END,"SetSquareRangeNetworkStatus(reason: complete)");
}

stock IsSquareHaveNetwork(squareid,networkid)
{
	Debug(DEBUG_START,"IsSquareHaveNetwork(%d,%d)",squareid,networkid);
	Debug(DEBUG_END,"IsSquareHaveNetwork(reason: complete)");
	if(Squares[squareid][networkid] > 0) return 1;
	return 0;
}