#include "trk_main.h"
#include "ata_project.h"
#include "ata_main.h"
#include "low_level_initialization.h"
#include "stm8s.h"
#include "trk_message.h"
#include "trk_message.h"
#include "trk_misc.h"
#include "trk_app.h"
#include "ata_controller.h"


unsigned short mainTimerLoad = MAINTIMER;
unsigned short lowSideLoad = 256;
unsigned short lowSideCount = 38;

unsigned char bldc_step = 0;
unsigned char flagClosedLoop = FALSE;
unsigned short rawSpeed = 0;

unsigned short countUsedAsSpeed = 40;
unsigned short countSpeedLimit = 197;
unsigned short totalSpeed = 0;
unsigned char speedCounter = 0;
unsigned short calculatedSpeed = 500;
unsigned short setSpeed = LEVEL2;

unsigned char interruptFunctionAvailable = FALSE;

unsigned short phaseLossCounter = 0;
unsigned char phaseIsLost = FALSE;

unsigned char motorState = FALSE;

void bldc_move(void)
{
   phaseLossCounter = 0;
   rawSpeed = TIM1_Get() / 10;
   TIM1->CNTRH = 0;
   TIM1->CNTRL = 0;
   switch(bldc_step)
   {  
      case 0:
         drive_AB();
         BEMF_C_FALLING();
         break;

      case 1:
         drive_AC();
         BEMF_B_RISING();
         break;
         
      case 2:
         drive_BC();
         BEMF_A_FALLING();
         break;

      case 3:
         drive_BA();
         BEMF_C_RISING();
         break;

      case 4:
         drive_CA();
         BEMF_B_FALLING();
         break;

      case 5:
         drive_CB();
         BEMF_A_RISING();
         break;
   }  

   bldc_step++;
   if(bldc_step >= 6)
   {
      bldc_step = 0;
   }
}

void interruptFunction(void)
{
   unsigned char j;

   if(interruptFunctionAvailable == TRUE)
   {
       // BEMF debounce
       for(j = 0; j < 20; j++) {
         if(bldc_step & 1) 
         {
            if(bldc_step == 1)
            {
                if(GPIO_ReadInputPin(GPIOB, GPIO_PIN_1) == GPIO_PIN_1)
                {
                    j -= DEBOUNCE_ITERATOR;
                }
            }
            if(bldc_step == 3)
            {
                if(GPIO_ReadInputPin(GPIOB, GPIO_PIN_0) == GPIO_PIN_0)
                {
                    j -= DEBOUNCE_ITERATOR;
                }
            }
            if(bldc_step == 5)
            {
                if(GPIO_ReadInputPin(GPIOB, GPIO_PIN_2) == GPIO_PIN_2)
                {
                    j -= DEBOUNCE_ITERATOR;
                }
            }
         }
         else 
         {
             if(bldc_step == 0)
             {
                 if(GPIO_ReadInputPin(GPIOB, GPIO_PIN_0) == 0)
                 {
                     j -= DEBOUNCE_ITERATOR;
                 }
             }
             if(bldc_step == 2)
             {
                 if(GPIO_ReadInputPin(GPIOB, GPIO_PIN_2) == 0)
                 {
                     j -= DEBOUNCE_ITERATOR;
                 }
             }
             if(bldc_step == 4)
             {
                 if(GPIO_ReadInputPin(GPIOB, GPIO_PIN_1) == 0)
                 {
                     j -= DEBOUNCE_ITERATOR;
                 }
             }
         }
       }

       bldc_move();
   }
}

void drive_AB(void)
{
   GPIO_WriteHigh(GPIOC, GPIO_PIN_1);
   GPIO_WriteLow(GPIOC, GPIO_PIN_2);
   GPIO_WriteLow(GPIOC, GPIO_PIN_3);
}

void drive_AC(void)
{
   GPIO_WriteHigh(GPIOC, GPIO_PIN_1);
   GPIO_WriteLow(GPIOC, GPIO_PIN_2);
   GPIO_WriteLow(GPIOC, GPIO_PIN_3);

   TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
   TIM2->CCER2 = 0x00;  // Disable the Channels 3
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   TIM2->CCER2 = 0x03;  // Enable the Channel 3 & Low Polarity
}

void drive_BC(void)
{
   GPIO_WriteLow(GPIOC, GPIO_PIN_1);
   GPIO_WriteHigh(GPIOC, GPIO_PIN_2);
   GPIO_WriteLow(GPIOC, GPIO_PIN_3);
}

void drive_BA(void)
{
   GPIO_WriteLow(GPIOC, GPIO_PIN_1);
   GPIO_WriteHigh(GPIOC, GPIO_PIN_2);
   GPIO_WriteLow(GPIOC, GPIO_PIN_3);

   TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
   TIM2->CCER2 = 0x00;  // Disable the Channels 3
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   TIM2->CCER1 = 0x03;  // Enable the Channel 1 & Low Polarity
}

void drive_CA(void)
{
   GPIO_WriteLow(GPIOC, GPIO_PIN_1);
   GPIO_WriteLow(GPIOC, GPIO_PIN_2);
   GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
}

void drive_CB(void)
{
   GPIO_WriteLow(GPIOC, GPIO_PIN_1);
   GPIO_WriteLow(GPIOC, GPIO_PIN_2);
   GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
   
   TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
   TIM2->CCER2 = 0x00;  // Disable the Channels 3
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   TIM2->CCER1 = 0x30;  // Enable the Channel 2 & Low Polarity
}

void BEMF_A_RISING(void) //(U) _ B2 pin
{
  GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_PU_IT);
  GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_PU_NO_IT);
  EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOB, EXTI_SENSITIVITY_RISE_ONLY);
}
void BEMF_A_FALLING(void) //(U) _ B2 pin
{
  GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_PU_IT);
  GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_PU_NO_IT);
  EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOB, EXTI_SENSITIVITY_FALL_ONLY);
}
void BEMF_B_RISING(void) //(V) _ B1 pin
{
  GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_IN_PU_IT);
  GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_PU_NO_IT);
  EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOB, EXTI_SENSITIVITY_RISE_ONLY);
}
void BEMF_B_FALLING(void) //(V) _ B1 pin
{
  GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_IN_PU_IT);
  GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_PU_NO_IT);
  EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOB, EXTI_SENSITIVITY_FALL_ONLY);
}
void BEMF_C_RISING(void) //(W) _ B0 pin
{
  GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_PU_IT);
  EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOB, EXTI_SENSITIVITY_RISE_ONLY);
}
void BEMF_C_FALLING(void) //(W) _ B0 pin
{
  GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT);
  GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_PU_IT);
  EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOB, EXTI_SENSITIVITY_FALL_ONLY);
}

unsigned short TIM1_Get(void)
{
    return ( ((unsigned short)TIM1->CNTRH << 8) + (unsigned short)TIM1->CNTRL );
}

void TIM1_Set(unsigned short ms)
{
    unsigned char pscr = 5;
    unsigned short cntr = 25*ms;
    
    TIM1->ARRH = cntr >> 8;    // auto reload value is 2000              
    TIM1->ARRL = cntr;                    //default value is 8ms
}

/*timer 1 is the main timer*/
void TIM1_Settings(void)
{
   TIM1->IER   = 0x01;                       
   TIM1->PSCRH = 0x00;
   TIM1->PSCRL = 0x02;                      
   TIM1->ARRH  = (unsigned char)(mainTimerLoad >> 8) & 0xFF;
   TIM1->ARRL  = (unsigned char)mainTimerLoad;                  
   TIM1->CCR2H = 0x00;
   TIM1->CCR2L = 0x00;                        
   TIM1->CR1 = 0x05;                    
}

void setLowSideLoad(unsigned short load)
{
   lowSideLoad = load;
}

unsigned short getLowSideLoad(void)
{
   return lowSideLoad;
}

unsigned short getLowSideCount(void)
{
    return lowSideCount;
}

void setLowSideCount(unsigned short count)
{
    lowSideCount = count;
    
    TIM2->CCR1H = (unsigned char)(lowSideCount >> 8); 
    TIM2->CCR1L = (unsigned char)lowSideCount;    

    TIM2->CCR2H = (unsigned char)(lowSideCount >> 8); 
    TIM2->CCR2L = (unsigned char)lowSideCount;

    TIM2->CCR3H = (unsigned char)(lowSideCount >> 8); 
    TIM2->CCR3L = (unsigned char)lowSideCount;
}

/*timer 2 is the pwm timer for low side switching*/
void Init_Timer2(unsigned short load, unsigned short count) 
{   
   TIM2->PSCR = 0x00;//0x03;    
   TIM2->ARRH = (unsigned char)(load >> 8); 
   TIM2->ARRL = (unsigned char)load;   
 
   TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
   //TIM2->CCER1 = 0x11;  // Enable the Channel 1-2 & Low Polarity
 
   TIM2->CCER2 = 0x00;  // Disable the Channels 3
   //TIM2->CCER2 = 0x01;  // Enable the Channel 3 & Low Polarity
 
   TIM2->CCMR1 = 0x78;  // PWM Mode2(CH1) - Preload  Enabled
   TIM2->CCMR2 = 0x78;  // PWM Mode2(CH2) - Preload  Enabled
   TIM2->CCMR3 = 0x78;  // PWM Mode2(CH3) - Preload  Enabled
 
   TIM2->CCR1H = (unsigned char)(count >> 8); 
   TIM2->CCR1L = (unsigned char)count;    
 
   TIM2->CCR2H = (unsigned char)(count >> 8); 
   TIM2->CCR2L = (unsigned char)count;
 
   TIM2->CCR3H = (unsigned char)(count >> 8); 
   TIM2->CCR3L = (unsigned char)count;
 
   TIM2->CR1  |= 0x80;  // AutoReload aktif durumda.
   TIM2->CR1  |= 0x01;  // Timer çalýþmaya baþlýyor.

}

void delay_us(unsigned short x)
{
    unsigned short i;
    for(i = 0; i < x; i++){}
}

unsigned long calculateSpeedThread(void)
{
    totalSpeed += rawSpeed;
    speedCounter++;

    if(speedCounter >= 32)
    {
        speedCounter = 0;
        calculatedSpeed = totalSpeed >> 5;
        totalSpeed = 0;
    }
    return msg_ProcessAfter1ms*5;
}

unsigned short getTargetSpeed(void)
{
    return setSpeed;
}

void setTargetSpeed(unsigned short set)
{
    setSpeed = set;

    if(setSpeed == LEVEL1)
    {
        setCountLimit(160);
    }
    else
    {
        setCountLimit(190);
    }
}

void setCountLimit(unsigned short set)
{
    countSpeedLimit = set;
}

unsigned long closedLoopPhase(void)
{
    if(flagClosedLoop == FALSE)
    {
        return msg_ProcessAfter1s;
    }

    if(countUsedAsSpeed < countSpeedLimit)
    {
        countUsedAsSpeed++;
    }
    else if(countUsedAsSpeed > countSpeedLimit)
    {
        countUsedAsSpeed--;
    }
    setLowSideCount(countUsedAsSpeed);
    return msg_ProcessAfter1ms*15;
}

#if(MOTOR_TYPE == ORIGINAL_MOTOR)
#define START_COUNT (2500)
#define FINISH_COUNT (650)
#define ITERATOR (35)

void openLoopPhase(void)
{
    unsigned short count = START_COUNT;
    unsigned short j;

    Init_Timer2(getLowSideLoad(), getLowSideCount());

    ata_SetInterruptStatus(DisableAllInterrupts);
    // Motor start
    for(j = 0; j < 100; j++)
    {
        delay_us(1000); 
    }

    while(count > FINISH_COUNT) 
    {
        delay_us(count);    
        bldc_move();
        if(count > 700)
        {
            count -= ITERATOR;
        }
        else
        {
            count--;
        }
    }
    
    interruptFunctionAvailable = TRUE;
    ata_SetInterruptStatus(EnableAllInterrupts);
    flagClosedLoop = TRUE;

}
#else if(MOTOR_TYPE == MY_TEST_MOTOR)
#define START_COUNT (5000)
#define FINISH_COUNT (1200)
#define ITERATOR (25)

void openLoopPhase(void)
{
    unsigned short count = START_COUNT;
    unsigned short j;

    Init_Timer2(getLowSideLoad(), getLowSideCount());

    ata_SetInterruptStatus(DisableAllInterrupts);
    // Motor start
    for(j = 0; j < 100; j++)
    {
        delay_us(1000); 
    }

    while(count > FINISH_COUNT) 
    {
        delay_us(count);    
        bldc_move();
        count -= ITERATOR;
    }
    
    interruptFunctionAvailable = TRUE;
    ata_SetInterruptStatus(EnableAllInterrupts);
    flagClosedLoop = TRUE;

}
#endif

unsigned char initState = 0;
unsigned long initThread(void)
{
    switch(initState)
    {
        case 0:
            GPIO_WriteLow(GPIOB, GPIO_PIN_6);
            GPIO_WriteHigh(GPIOB, GPIO_PIN_7);
            TIM2->ARRH = (unsigned char)(0X30);
            TIM2->ARRL = (unsigned char)0XD0; 
            GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
            TIM2->CCR2H = (unsigned char)(0X01); //Duty High 0x01 
            TIM2->CCR2L = (unsigned char) (0x0A); // Duty Low 0x50
            TIM2->CCER1=0x30;

            initState = 1;
            return msg_ProcessAfter1ms*300;
            break;

        case 1:
            TIM2->CCER1=0x00;
            initState = 2;
            return msg_ProcessAfter1ms*100;
            break;

        case 2:
            TIM2->ARRH = (unsigned char)(0X10); 
            TIM2->ARRL = (unsigned char)0XD0; 
            TIM2->CCR2H = (unsigned char)(0X01); //Duty High 0x01 
            TIM2->CCR2L = (unsigned char) (0x0A); // Duty Low 0x50
            TIM2->CCER1=0x30;
            initState = 3;
            return msg_ProcessAfter1ms*100;
            break;

        case 3:
            TIM2->CCER1=0x00;
            initState = 4;
            return msg_ProcessAfter1ms*100;
            break;

        case 4:
            TIM2->CCER1=0x30;
            initState = 5;
            return msg_ProcessAfter1ms*100;
            break;

        case 5:
            TIM2->CCER1=0x00;
            initState = 6;
            return msg_ProcessAfter1ms*100;
            break;

        case 6:
            openLoopPhase();
            
            trk_PushMessage(&calculateSpeedThread, msg_ProcessAfter1ms);
            trk_PushMessage(&closedLoopPhase, msg_ProcessAfter1ms);
            
            initState = 7;
            return msg_ProcessStopped;
            break;
            
        default:
            //openLoopPhase();
            break;
    }

    return msg_ProcessStopped;
}

unsigned char getMotorState(void)
{
    return motorState;
}

void startStopMotor(unsigned char startstop)
{
    motorState = startstop;
    if(startstop)
    {
        totalSpeed = 0;
        speedCounter = 0;
        calculatedSpeed = LEVEL2;
        lowSideLoad = 256;
        lowSideCount = 43;
        countUsedAsSpeed = 40;
        phaseIsLost = FALSE;
        setTargetSpeed(LEVEL2);

        #if 0
        openLoopPhase();
        
        trk_PushMessage(&calculateSpeedThread, msg_ProcessAfter1ms);
        trk_PushMessage(&closedLoopPhase, msg_ProcessAfter1ms);

        #else
        initState = 0;
        trk_PushMessage(&initThread,msg_ProcessAfter1ms);
        #endif
    }
    else
    {
        interruptFunctionAvailable = FALSE;
        GPIO_WriteLow(GPIOC, GPIO_PIN_1);
        GPIO_WriteLow(GPIOC, GPIO_PIN_2);
        GPIO_WriteLow(GPIOC, GPIO_PIN_3);
        TIM2->CCER1=0x00;
        TIM2->CCER2=0x00;
        flagClosedLoop = FALSE;

        trk_StopMessage(&closedLoopPhase);
        trk_StopMessage(&calculateSpeedThread);
    } 
}

void main(void)
{
    InitRegisters();
    trk_MessageInit();
    ata_Init();
    trk_appInit();
    TIM1_Settings();
    ata_Run();
}

