//THIS IS EDITED BY ANAK for his NPC.
// A Driver NPC that goes around a path continuously
// Kye 2009
//

#include <a_npc>

#define NUM_PLAYBACK_FILES 3
new gPlaybackFileCycle=0;

//------------------------------------------

main(){}

//------------------------------------------

NextPlayback()
{
	// Reset the cycle count if we reach the max
	if(gPlaybackFileCycle==NUM_PLAYBACK_FILES) gPlaybackFileCycle = 0;

	if(gPlaybackFileCycle==0) {
		StartRecordingPlayback(PLAYER_RECORDING_TYPE_DRIVER,"anak_plane_lv_to_sf");
	}
	else if(gPlaybackFileCycle==1) {
	    StartRecordingPlayback(PLAYER_RECORDING_TYPE_DRIVER,"anak_plane_sf_to_ls");
	}
	else if(gPlaybackFileCycle==2) {
	    StartRecordingPlayback(PLAYER_RECORDING_TYPE_DRIVER,"anak_plane_ls_to_lv");
	}

	gPlaybackFileCycle++;
}


//------------------------------------------

public OnRecordingPlaybackEnd()
{
    NextPlayback();
}

//------------------------------------------

public OnNPCEnterVehicle(vehicleid, seatid)
{
    NextPlayback();
}

//------------------------------------------

public OnNPCExitVehicle()
{
    StopRecordingPlayback();
    gPlaybackFileCycle = 0;
}

//------------------------------------------
