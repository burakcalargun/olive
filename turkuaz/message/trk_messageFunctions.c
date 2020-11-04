
#include "trk_messageDefinitions.h"
#include "trk_message.h"
#include "trk_messageFunctions.h"


const trk_MessageFunctions_t trk_messageFunctionsArray[] = 
{     
   {msg_LastMessage, &trk_ProcessNull}
};



unsigned long trk_ProcessNull(void)
{
   return msg_ProcessStopped;
}


