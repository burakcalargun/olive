#include "trk_messageDefinitions.h"
#include "trk_message.h"
#include "trk_messageFunctions.h"
#include "ata_message.h"
#include "trk_misc.h"

#ifndef MAX_MESSAGE_NUMBER
   #define MAX_MESSAGE_NUMBER 20
#endif

#ifndef GOZCU_ENABLED
   #define GOZCU_ENABLED FALSE
#endif

#ifndef SYSTEM_CLOCK_ENABLED
   #define SYSTEM_CLOCK_ENABLED TRUE
#endif

static trk_MessageCounter_t trk_Messages[MAX_MESSAGE_NUMBER];
#ifdef SYSTEM_CLOCK_ENABLED
unsigned long trk_SystemClock = 0;
#endif
static unsigned char trk_MaxMessageCounter = 0;
#if (GOZCU_ENABLED == TRUE)
static unsigned char trk_1msTimerFired = FALSE;
#endif


unsigned char trk_GetMaxMessegeCounter(void)
{
   return trk_MaxMessageCounter;
}


void trk_FindAndPushMessage(trk_messages message, trk_msgProcessTime ProcessTime)
{
   const trk_MessageFunctions_t *ptr = trk_messageFunctionsArray;
   do
   {
      if (ptr->message == message)
      {
         if (ProcessTime == msg_ProcessInstant)
         {
            ptr->messageFunction();
         }
         else
         {
            trk_PushMessage(ptr->messageFunction, ProcessTime);
         }
      }
      ptr++;
   }
   while (ptr->message != msg_LastMessage);
}

unsigned char trk_FindMessagePosition(trk_MessageFunction function)
{
   unsigned char messagepos = 0;
   unsigned char firststoppedfunction = 0xFF;

   while ( (messagepos != MAX_MESSAGE_NUMBER) && 
           ( (trk_Messages[messagepos].messagefunction != 0x0000) || (trk_Messages[messagepos].property.isprotected == TRUE) ) && 
           ( (trk_Messages[messagepos].messagefunction != function) || (trk_Messages[messagepos].property.stopped == TRUE) ) 
         )
   {
      if ( (trk_Messages[messagepos].property.stopped == TRUE) && (firststoppedfunction == 0xFF) &&
           (trk_Messages[messagepos].property.isprotected == FALSE) )
      {
         firststoppedfunction = messagepos;
      }
      messagepos++;
   }   
   if (trk_Messages[messagepos].messagefunction == function)
   {
      return messagepos;
   }
   else if (firststoppedfunction != 0xFF)
   {
      return firststoppedfunction;
   }
   return messagepos;
}

unsigned char trk_IsMessagePushed(trk_MessageFunction function)
{
   unsigned char position = trk_FindMessagePosition(function);
   if (trk_Messages[position].messagefunction == function)
   {
      return (trk_Messages[position].property.stopped == FALSE);
   }
   else
   {
      return FALSE;
   }
}

unsigned long trk_GetMessageRemainingTime(trk_MessageFunction function)
{
   unsigned char position = trk_FindMessagePosition(function);
   if ( (trk_Messages[position].messagefunction == function) && (trk_Messages[position].property.stopped == FALSE) )
   {
      return (trk_Messages[position].TimeToProcess + ((unsigned long)trk_Messages[position].property.MinuteCounter)*((unsigned long)msg_ProcessAfter1m));
   }
   else
   {
      return 0;
   }
}

unsigned char trk_CheckMessage(unsigned char counter)
{
   unsigned long messageRefreshTime;
   trk_MessageFunction messagefunction;
   if ( (trk_Messages[counter].property.paused == FALSE) && (trk_Messages[counter].property.stopped == FALSE) )
   {
      if ((trk_Messages[counter].TimeToProcess == 0) && (trk_Messages[counter].property.MinuteCounter == 0))
      {
         messagefunction = trk_Messages[counter].messagefunction;
         messageRefreshTime = messagefunction();
         
         if (messagefunction != trk_Messages[counter].messagefunction)
         {
            // in message function, message array is changed, so don't do anything.
         }
         else if ((trk_Messages[counter].TimeToProcess > 0) || (trk_Messages[counter].property.MinuteCounter > 0))
         {
            // in message function, this message is pushed again, so don't do anything.
         }
         else if (messageRefreshTime == msg_ProcessStopped)
         {
            trk_Messages[counter].property.stopped = TRUE;
         }
         else if (messageRefreshTime == msg_ProcessPause)
         {
            trk_Messages[counter].property.stopped = TRUE; // after execution of message, pause means nothing, stop it.
         }
         else 
         {
            if (messageRefreshTime == msg_ProcessNextCheck)
            {
               messageRefreshTime = 0x00;
            }
            
            trk_Messages[counter].TimeToProcess = (unsigned int)(messageRefreshTime % msg_ProcessAfter1m);
            trk_Messages[counter].property.MinuteCounter = (unsigned char)(messageRefreshTime / msg_ProcessAfter1m);
         }
      }
   }
   return counter;
}

void trk_PushMessage1ms(trk_MessageFunction messagefunction)
{
   trk_PushMessage(messagefunction, msg_ProcessAfter1ms);
}

void trk_PushMessageLong(trk_MessageFunction messagefunction, unsigned long ProcessTime)
{
   unsigned char messageCount = trk_PushMessage(messagefunction, ProcessTime % msg_ProcessAfter1m);
   if ((trk_Messages[messageCount].messagefunction == messagefunction) && 
       (trk_Messages[messageCount].property.stopped == FALSE))
   {
      trk_Messages[messageCount].property.MinuteCounter = (unsigned char)(ProcessTime / msg_ProcessAfter1m);
   }
}
unsigned char trk_PushMessage(trk_MessageFunction messagefunction, trk_msgProcessTime ProcessTime)
{
   static unsigned char trk_pushmessagecounter = 0;
   unsigned char trk_messagepos = 0xFF;
   unsigned char trk_pushmessagecountertemporary;


   /* if any interrupt which has a pushmessage has been fired during findposition function, a new message position should be found */
   /* Because this messagepos may already been used by the pushmessage fired in the interrupt */
   do
   {
      if (trk_messagepos != 0xFF)
      {
         trk_Messages[trk_messagepos].property.isprotected = FALSE; // to clear previous wrong protected message
      }
      trk_pushmessagecountertemporary = trk_pushmessagecounter;
      trk_messagepos = trk_FindMessagePosition(messagefunction);
      trk_Messages[trk_messagepos].property.isprotected = TRUE;
   }
   while (trk_pushmessagecountertemporary != trk_pushmessagecounter); 

   trk_pushmessagecounter++;

   if (trk_messagepos == MAX_MESSAGE_NUMBER)
   {
      ata_MessageStackOverflow();
   }
   else
   {
      if (ProcessTime == msg_ProcessStopped)
      {
         if (trk_Messages[trk_messagepos].messagefunction != 0x0000)
         {
            trk_Messages[trk_messagepos].property.stopped = TRUE;
         }
      }
      else if (ProcessTime == msg_ProcessPause)
      {
         trk_Messages[trk_messagepos].property.paused = TRUE;
      }
      else if (ProcessTime == msg_ProcessResume)
      {
         if (trk_Messages[trk_messagepos].messagefunction != 0x0000)
         {
            trk_Messages[trk_messagepos].property.paused = FALSE;
         }
      }   
      else
      {
         trk_Messages[trk_messagepos].messagefunction = messagefunction;
         trk_Messages[trk_messagepos].property.paused = FALSE;
         trk_Messages[trk_messagepos].property.stopped = FALSE;
         
         if (ProcessTime == msg_ProcessNextCheck)
         {
            ProcessTime = 0;
         }

         trk_Messages[trk_messagepos].TimeToProcess = (unsigned int)(ProcessTime % msg_ProcessAfter1m);
         trk_Messages[trk_messagepos].property.MinuteCounter = 0;
      }

      if (trk_messagepos > trk_MaxMessageCounter)
      {
         trk_MaxMessageCounter = trk_messagepos;
      }
   }
   trk_Messages[trk_messagepos].property.isprotected = FALSE;
   return trk_messagepos;
}

void trk_Fire1msTimer(void)
{
   unsigned char counter;
   #if (GOZCU_ENABLED == TRUE)      
   if (trk_1msTimerFired == TRUE)
   #endif
   {
      #ifdef SYSTEM_CLOCK_ENABLED
      trk_SystemClock += msg_ProcessAfter1ms;
      #endif
      #if (GOZCU_ENABLED == TRUE)      
      trk_1msTimerFired = FALSE;
      ata_SetSystemClock(trk_SystemClock);
      #endif
      for (counter = 0; counter <= trk_MaxMessageCounter; counter++)
      {
         if ((trk_Messages[counter].property.stopped == FALSE) && (trk_Messages[counter].property.paused == FALSE))
         {
            if ((trk_Messages[counter].TimeToProcess >= msg_ProcessAfter1ms) || (trk_Messages[counter].property.MinuteCounter > 0))
            {
               if (trk_Messages[counter].TimeToProcess >= msg_ProcessAfter1ms)
               {
                  trk_Messages[counter].TimeToProcess -= msg_ProcessAfter1ms;
               }
               else
               {
                  trk_Messages[counter].TimeToProcess = msg_ProcessAfter1m;
                  trk_Messages[counter].property.MinuteCounter--;
               }  
            }
         }
      }
   }
}

void trk_ProcessMessages(unsigned long ProcessTime)
{
   static unsigned char counter = 0;

   do
   { 
      if (counter >= MAX_MESSAGE_NUMBER)
      {
         counter = 0;
         #if (GOZCU_ENABLED == TRUE)
         trk_Fire1msTimer();
         #endif
      }
      
      if (trk_Messages[counter].messagefunction != 0x0000)
      {
         counter = trk_CheckMessage(counter);
         counter++;
         if (trk_Messages[counter].messagefunction == 0x0000)
         {
            counter = 0;
            #if (GOZCU_ENABLED == TRUE)
            trk_Fire1msTimer();
            #endif
         }
      }
      else
      {
         counter = 0;
         #if (GOZCU_ENABLED == TRUE)
         trk_Fire1msTimer();
         #endif
      }
   }
   #if (GOZCU_ENABLED == TRUE)   
   while ((ProcessTime == msg_ProcessForever) && (drv_getShouldStop() == 0));
   #else
   while (ProcessTime == msg_ProcessForever);
   #endif   
   
}

void trk_Message(trk_messages message, trk_msgProcessTime ProcessTime)
{
   if (message == msg_1msTimer)
   {
      #if (GOZCU_ENABLED == TRUE)      
      trk_1msTimerFired = TRUE;
      #else
      trk_Fire1msTimer();
      #endif
   }
   else if (message == msg_ProcessMessages)
   {
      trk_ProcessMessages(ProcessTime);
   }
   else
   {
      trk_FindAndPushMessage(message,ProcessTime);
   }
}


void trk_KillAllMessages(void)
{
   unsigned char counter;
   for (counter = 0; counter < MAX_MESSAGE_NUMBER; counter++)
   {
      trk_Messages[counter].messagefunction = 0x0000;
   }
}

void trk_MessageInit(void)
{
   ata_MessageOpen(&trk_Message, &trk_PushMessage);
   trk_KillAllMessages();
}

void trk_StopMessage(trk_MessageFunction messagefunction)
{
   trk_PushMessage(messagefunction, msg_ProcessStopped);
}
