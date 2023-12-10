   ///////////////////////////////////////////////////////////////////
  /// Приветствия при възде на выбранную территорию v 0.1 ///                       
 ///     CopyRight © 2010 DizeL[ZR] SAMP-RUS TEAM                   ////
/////////////////////////////////////////////////////////////////

#if defined _maps_included
	#endinput
#endif
#include <a_samp>

#define MAX_POS 10
#define MAX_TERS 15

stock LoadWelcomeFiles()return CallRemoteFunction("d_LoadWelcomeFiles","i",1);
