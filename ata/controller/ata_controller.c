#include "ata_controller.h"
#include "stm8s.h"

void ata_SetInterruptStatus(unsigned char status)
{
   if (status == DisableAllInterrupts)
   {
      disableInterrupts();
   }
   else if (status == EnableAllInterrupts)
   {
      enableInterrupts();
   }
}


