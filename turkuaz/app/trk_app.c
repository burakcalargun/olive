#include "trk_app.h"
#include "trk_message.h"
#include "ata_key.h"
#include "trk_misc.h"
#include "stm8s.h"
#include "stm8s_gpio.h"
#include "low_level_initialization.h"

void trk_KeyCallback(unsigned char Key, unsigned char Pressed, RemoteControlKeyState RemotePressed)
{     
   if(Pressed == TRUE)
   {
      if(Key == 0x00)
      {
         
      }
   }
}

void trk_appInit(void)
{  
   ata_KeyOpen(&trk_KeyCallback);
}


