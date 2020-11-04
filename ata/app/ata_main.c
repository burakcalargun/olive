#include "ata_main.h"
#include "ata_project.h"
#include "ata_message.h"
#include "ata_controller.h"
#include "trk_messageDefinitions.h"
#include "trk_message.h"
#include "stm8s_flash.h"
#include "trk_message.h"
#include "low_level_initialization.h"
#include "ata_key.h"
#include "trk_app.h"

unsigned char ata_TimerFlag;
unsigned char ata_Let_ZeroCrossHandle  = FALSE;

void WatchdogKick(void)
{
   IWDG->KR = (unsigned char)0xCC; /* Write Access */   
   IWDG->KR = (unsigned char)0x55; /* Write Access */   
   IWDG->PR = (unsigned char)0x06;
   IWDG->RLR = (unsigned char)0xFF;
   IWDG->KR = 0xAA;
}

unsigned long ata_KickWatchdogThread(void)
{
   WatchdogKick();
   return msg_ProcessAfter1ms * 10;
}

void ata_WatchdogInit(void)
{
   trk_PushMessage(&ata_KickWatchdogThread, msg_ProcessAfter1ms*5);
}

unsigned long ata_ZC_Control_Thread(void)
{
   ata_Let_ZeroCrossHandle = TRUE;
   return msg_ProcessStopped;
}

unsigned char ata_Get_ZC_Handle(void)
{
   return ata_Let_ZeroCrossHandle;
}

void ata_Init(void)
{
   /* Hardware Initializations*/
   ata_StartTimer4();
   ata_SetInterruptStatus(EnableAllInterrupts);
   ata_WatchdogInit();
   ata_KeyInit();
   trk_PushMessage(&ata_ZC_Control_Thread, msg_ProcessAfter1s);
}

void ata_1mstimer(void)
{
}

void ata_Run(void)
{
   while(1)
   {
      msg_callback(msg_ProcessMessages, msg_ProcessInstant); //msg_ProcessForever is used only for msg_ProcessMessages
      if(ata_TimerFlag >= 1)
      {
         msg_callback(msg_1msTimer, msg_ProcessInstant);
         ata_TimerFlag--;
      }
   }
}

