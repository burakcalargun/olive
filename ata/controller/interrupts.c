#include "ata_project.h"
#include "stm8s.h"
#include "stm8s_gpio.h"
#include "ata_main.h"
#include "trk_misc.h"
#include "ata_project.h"
#include "ata_controller.h"
#include "low_level_initialization.h"
#include "ata_key.h"
#include "trk_message.h"
#include "ata_message.h"
#include "trk_app.h"
#include "trk_main.h"


NEAR unsigned char trigState = 0;
NEAR unsigned char downKeyMightBePushed = FALSE;
NEAR unsigned char upKeyMightBePushed = FALSE;

NEAR unsigned char power_off_button_pressed = FALSE;
NEAR unsigned char power_on_button_pressed  = FALSE;

@interrupt void TIM4_UPD_OVF_IRQHandler(void)           //wil occur every 2 mili-seconds
{
   ata_TimerFlag++;
   TIM4->SR1 &= 0xFE;          //clear UIF flag first.
}

@interrupt void UART1_TX_IRQHandler(void)
{
   UART1->SR &=0xBF;
}

@interrupt void TIM2_UPD_OVF_IRQHandler(void)           //wil occur every 2 mili-seconds
 {
    TIM2->SR1 &= 0xFE;
    
    if(trigState == 1)
    {
        GPIO_WriteHigh(GPIOB, GPIO_PIN_4);
        GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
        TIM2_Set(10);
        trigState = 2;
    }    
    else
    {
        TIM2->CR1 = 0;
        GPIO_WriteLow(GPIOB, GPIO_PIN_4);
        GPIO_WriteLow(GPIOA, GPIO_PIN_3);
        trigState = 0;
    }
}

unsigned char brk = 0;
@interrupt void TIM1_UPD_OVF_IRQ_Handler(void)    
{
   #if 0
   if(brk)
   {
      brk = 0;
      GPIO_WriteHigh(GPIOC, GPIO_PIN_1);
   }
   else
   {
      brk = 1;
      GPIO_WriteLow(GPIOC, GPIO_PIN_1);
   }
   #else
   stepping();
   #endif
   TIM1->SR1 &= 0xFE;
}

unsigned long controlThread(void)
{
   return msg_ProcessStopped;
}

@interrupt void @svlreg ZeroCross_IntHandler(void)
{  
 
}

@interrupt  void @svlreg  RemoteControl_IntHandler(void)
{
   if(GPIO_ReadInputPin(GPIOB, GPIO_PIN_0) == GPIO_PIN_0)
   {
      GPIO_WriteHigh(GPIOB, GPIO_PIN_6);
   }
   else
   {
      GPIO_WriteLow(GPIOB, GPIO_PIN_6);
   }
}


@interrupt void @svlreg Key_IntHandler(void)
{

}



