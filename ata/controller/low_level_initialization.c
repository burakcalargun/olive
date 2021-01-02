#include "stm8s.h"
#include "stm8s_conf.h"
#include "stm8s_type.h"
#include "stm8s_gpio.h"
#include "stm8s_tim4.h"
#include "low_level_initialization.h"
#include "ata_project.h"

//####################################################################

void IWDG_Settings(void)
{
   IWDG->KR = 0xCC;            // enable and start the wdog counter at first!
   IWDG->KR = 0x55;            // unlock wdog configuration registers
   IWDG->PR = 0x06;            // divider /256
   IWDG->RLR = 0xFF;           // maximum length period
   IWDG->KR = 0xAA;            // lock wdog registers & reload the wdog counter
}

//####################################################################

void InitRegisters(void)
{
   CLK->CKDIVR = 0x01;                
   
   Init_GPIO();
   disableInterrupts();
   //IWDG_Settings();
   TIM4_Settings();

   #if 0
   TIM2_Settings();
   EXTI_DeInit();
   EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOA, EXTI_SENSITIVITY_RISE_FALL);

   #if(KEY_CHECK_METHOD == KEY_INTERRUPT)
   EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOD, EXTI_SENSITIVITY_RISE_FALL);
   #endif

   EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOB, EXTI_SENSITIVITY_RISE_FALL);
   #endif
}

//####################################################################

void Init_GPIO(void)
{
#if 0
#if(KEY_CHECK_METHOD == KEY_INTERRUPT)
   GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_FL_IT);
   GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_IT);
#else
   GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
   GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
#endif

   GPIO_Init(GPIOA, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
   GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);

   GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_OUT_PP_HIGH_FAST);
   GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_OUT_PP_HIGH_FAST);
   GPIO_Init(GPIOC, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST);
   GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);
   GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_HIGH_FAST);

   GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
   GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_IN_FL_IT);
   GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_IN_FL_IT);
 #else
    
   GPIO_Init(GPIOC, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
   GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);
   GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);

   GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
   GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
   GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);


   GPIO_Init(GPIOB, GPIO_PIN_7, GPIO_MODE_OUT_PP_LOW_FAST);
   GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_FAST);
   
   //GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_IN_FL_IT);

   
    EXTI_DeInit();
    GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_IN_PU_IT);           // 

    EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOC , EXTI_SENSITIVITY_FALL_ONLY);

    
   //EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOB, EXTI_SENSITIVITY_RISE_FALL);
#endif
}

//####################################################################

void TIM4_Settings(void)
{
   TIM4->CR1 |= 0x05;                       // URS = 1 update event only if overflow occurs, CEN = 1 counter enable
   TIM4->IER |= 0x01;                          // UIE = 1 update interrupt enable
   TIM4->PSCR = 0x06;                      // prescaler = 32
   TIM4->ARR = 500;                            // auto reload value is 250
}

//####################################################################


void TIM2_Set(unsigned short ms)
{
    unsigned char pscr = 5;
    unsigned short cntr = 25*ms;
    
    
    TIM2->CR1 |= 0x05;                       // URS = 1 update event only if overflow occurs, CEN = 1 counter enable
    TIM2->IER |= 0x00;                          // UIE = 1 update interrupt enable
    TIM2->PSCR = pscr;    // prescaler = 32              
    TIM2->ARRH = cntr >> 8;    // auto reload value is 2000              
    TIM2->ARRL = cntr;                    //default value is 8ms
}

void TIM2_Settings(void)
{
    TIM2->CR1 |= 0x05;                       // URS = 1 update event only if overflow occurs, CEN = 1 counter enable
    TIM2->IER &= 0x00;                          // UIE = 1 update interrupt enable
    TIM2->PSCR = 0x05;    // prescaler = 32              
    TIM2->ARRH = 0x07;    // auto reload value is 2000              
    TIM2->ARRL = 0xD0;                    //default value is 8ms
}

//####################################################################



