#ifndef __TRK_MESSAGE_H__
#define __TRK_MESSAGE_H__

#include "trk_messageDefinitions.h"


typedef enum
{
   msg_ProcessStopped = 60013,
   msg_ProcessInstant = 60017,
   msg_ProcessForever = 60029,
   msg_ProcessPause = 60037,
   msg_ProcessResume = 60041,
   msg_ProcessNextCheck = 60077,
   msg_ProcessAfter1ms = 1,
   msg_ProcessAfter1s = (unsigned long)msg_ProcessAfter1ms * (unsigned long)1000,
   msg_ProcessAfter1m = (unsigned long)msg_ProcessAfter1s * (unsigned long)60

} trk_msgProcessTime;

typedef struct
{
   unsigned char MinuteCounter:5;
   unsigned char stopped:1;
   unsigned char paused:1;
   unsigned char isprotected:1;
} trk_8BitProperty;

typedef unsigned long (*trk_MessageFunction)(void);


typedef void (*trk_MessageCallback)(trk_messages message, trk_msgProcessTime ProcessTime);
typedef unsigned char (*trk_PushMessageCallback)(trk_MessageFunction messagefunction, trk_msgProcessTime ProcessTime);

typedef struct trk_MessageFunctions_t
{
   trk_messages message;
   trk_MessageFunction messageFunction;
}trk_MessageFunctions_t;


typedef struct trk_MessageCounter_t
{
   trk_MessageFunction messagefunction;
   unsigned int TimeToProcess;
   trk_8BitProperty property;
}trk_MessageCounter_t;


extern unsigned long trk_GetRefreshTime(void);

extern void trk_PushMessage1ms(trk_MessageFunction messagefunction);
extern void trk_PushMessageLong(trk_MessageFunction messagefunction, unsigned long ProcessTime);
extern unsigned char trk_PushMessage(trk_MessageFunction messagefunction, trk_msgProcessTime ProcessTime);
extern void trk_Message(trk_messages message, trk_msgProcessTime ProcessTime);
extern void trk_MessageInit(void);
extern void trk_KillAllMessages(void);
extern void trk_StopMessage(trk_MessageFunction messagefunction);
extern unsigned char trk_IsMessagePushed(trk_MessageFunction function);
extern unsigned long trk_GetMessageRemainingTime(trk_MessageFunction function);
extern unsigned char trk_GetMaxMessegeCounter(void);
extern unsigned long trk_SystemClock;


#endif
