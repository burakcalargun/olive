#ifndef __TRK_MESSAGEDEFINITIONS_H__
#define __TRK_MESSAGEDEFINITIONS_H__

typedef enum trk_messages
{
   msg_FirstMessage = 0x00,   //default message
   msg_ProcessMessages,       //default message
   msg_1msTimer,              //default message

   msg_KeyPressed,
   
   msg_LastMessage            //default message
} trk_messages;

#endif
