// Player country lookup by Emmet

#include <a_http>

#if !defined MAX_COUNTRY_NAME
        #define MAX_COUNTRY_NAME    (32)
#endif

forward OnLookupComplete(playerid, country[], region[], city[]);

enum e_LookupData {
        // Packed string containing the name of the country.
        e_LookupCountry[MAX_COUNTRY_NAME char],

        // Packed string containing the name of the region.
        e_LookupRegion[MAX_COUNTRY_NAME char],

        // Packed string containing the name of the city.
        e_LookupCity[MAX_COUNTRY_NAME char]
};

static
        g_asLookupData[MAX_PLAYERS][e_LookupData]
;

public OnPlayerConnect(playerid)
{
        new
            string[64]
        ;

        strpack(g_asLookupData[playerid][e_LookupCountry], "Unknown", MAX_COUNTRY_NAME char);
        strpack(g_asLookupData[playerid][e_LookupRegion], "Unknown", MAX_COUNTRY_NAME char);
        strpack(g_asLookupData[playerid][e_LookupCity], "Unknown", MAX_COUNTRY_NAME char);

        GetPlayerIp(playerid, string, sizeof(string));

        if (!IsPlayerNPC(playerid) && strcmp(string, "127.0.0.1") != 0)
        {
            // Insert the domain at the beginning of the IP.
                strins(string, "www.realip.info/api/p/geoip.php?ip=", 0);

                // Send the lookup request.
                HTTP(playerid, HTTP_GET, string, "", "HTTP_OnLookupResponse");
        }
        #if defined CL_OnPlayerConnect
            return CL_OnPlayerConnect(playerid);
        #else
                return 1;
        #endif
}

forward HTTP_OnLookupResponse(index, response, data[]);
public HTTP_OnLookupResponse(index, response, data[])
{
        new
            pos = -1;

        if (!IsPlayerConnected(index))
        {
                return 0;
        }
        else if (response == 200)
        {
            if (strfind(data, "Reserved", true) != -1 || strlen(data) < 15)
                {
                return 0;
                }
                else
                {
                        new
                                country[MAX_COUNTRY_NAME],
                                region[MAX_COUNTRY_NAME],
                                city[MAX_COUNTRY_NAME]
                        ;

                        if ((pos = strfind(data, "\"country_name\":")) != -1)
                        {
                            pos = pos + 16;

                            strmid(country, data, pos, strfind(data, "\"", true, pos), MAX_COUNTRY_NAME);
                        }
                        if ((pos = strfind(data, "\"region_name\":")) != -1)
                        {
                            pos = pos + 15;

                            strmid(region, data, pos, strfind(data, "\"", true, pos), MAX_COUNTRY_NAME);

                        }
                        if ((pos = strfind(data, "\"city_name\":")) != -1)
                        {
                            pos = pos + 13;

                            strmid(city, data, pos, strfind(data, "\"", true, pos), MAX_COUNTRY_NAME);
                        }

                        if (pos != -1)
                        {
                            // Call our callback, which is called when a lookup has completed.
                            CallLocalFunction("OnLookupComplete", "dsss", index, country, region, city);

                            // Pack the data for later use.
                            strpack(g_asLookupData[index][e_LookupCountry], country, MAX_COUNTRY_NAME char);
                            strpack(g_asLookupData[index][e_LookupRegion], region, MAX_COUNTRY_NAME char);
                            strpack(g_asLookupData[index][e_LookupCity], city, MAX_COUNTRY_NAME char);
                        }
                }
        }
        return 0;
}

stock GetPlayerCountry(playerid, country[], size = sizeof(country))
{
        if (IsPlayerConnected(playerid))
                return strunpack(country, g_asLookupData[playerid][e_LookupCountry], size);

        else
            strunpack(country, !"Unknown", size);

        return 0;
}

stock GetPlayerRegion(playerid, region[], size = sizeof(region))
{
        if (IsPlayerConnected(playerid))
                return strunpack(region, g_asLookupData[playerid][e_LookupRegion], size);

        else
            strunpack(region, !"Unknown", size);

        return 0;
}

stock GetPlayerCity(playerid, city[], size = sizeof(city))
{
        if (IsPlayerConnected(playerid))
                return strunpack(city, g_asLookupData[playerid][e_LookupCity], size);

        else
            strunpack(city, !"Unknown", size);

        return 0;
}

#if defined _ALS_OnPlayerConnect
        #undef OnPlayerConnect
#else
        #define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect CL_OnPlayerConnect

#if defined CL_OnPlayerConnect
        forward CL_OnPlayerConnect(playerid);
#endif
