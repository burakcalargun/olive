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

    if(interruptFunctionAvailable == TRUE)
    {
        if(++phaseLossCounter >= 250)
        {
            phaseIsLost = TRUE;
            startStopMotor(FALSE);
            phaseLossCounter = 0;
        }
    }
    TIM4->SR1 &= 0xFE;          //clear UIF flag first.
}

@interrupt void UART1_TX_IRQHandler(void)
{
   UART1->SR &=0xBF;
}

@interrupt void TIM2_UPD_OVF_IRQHandler(void)           //wil occur every 2 mili-seconds
 {
    TIM2->SR1 &= 0xFE;
}

unsigned char brk = 0;
unsigned char toggle = FALSE;
@interrupt void TIM1_UPD_OVF_IRQ_Handler(void)    
{
    if(toggle == TRUE)
    {
        toggle = FALSE;
        GPIO_WriteHigh(GPIOB, GPIO_PIN_7);
        GPIO_WriteHigh(GPIOB, GPIO_PIN_6);
    }
    else
    {
        toggle = TRUE;
        GPIO_WriteLow(GPIOB, GPIO_PIN_7);
        GPIO_WriteHigh(GPIOB, GPIO_PIN_6);
    }

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
   interruptFunction();
}

unsigned char keypress = 0;
@interrupt void @svlreg Key_IntHandler(void)
{
    keypress++;
}



