#include "trk_app.h"
#include "trk_message.h"
#include "ata_key.h"
#include "trk_misc.h"
#include "stm8s.h"
#include "stm8s_gpio.h"
#include "low_level_initialization.h"
#include "trk_main.h"

void trk_KeyCallback(unsigned char Key, unsigned char Pressed)
{     
   if(Pressed == TRUE)
   {
      if(Key == POWERBUTTON)
      {
         startStopMotor(getMotorState() ? FALSE : TRUE);
      }
      else if(Key == LEVELBUTTON)
      {
         if(getMotorState() == TRUE)
         {
            setTargetSpeed((getTargetSpeed() == LEVEL1) ? (LEVEL2) : (LEVEL1));
         }
      }
   }
}

void trk_appInit(void)
{  
   ata_KeyOpen(&trk_KeyCallback);
}


