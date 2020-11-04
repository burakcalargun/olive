#ifndef __ATA_CONTROLLER_H__
#define __ATA_CONTROLLER_H__

#include "stm8s.h"
#include "ata_project.h"
#include "trk_misc.h"

enum
{
   DisableAllInterrupts = 0,
   EnableAllInterrupts = 1
};

#define ata_StartTimer4() (TIM4->CR1) |= 0x05
#define ata_StartTimer2() (TIM2->CR1) |= 0x05
#define ata_StopTimer2() (TIM2->CR1) &= 0xFE

#define getTimeValue() ((unsigned short)((TIM1->CNTRH << 8) | (TIM1->CNTRL)))

#define CounterPSC (0x07)
#define startTimeCalculation()      (TIM1->CR1 |= TIM1_CR1_CEN);  \
                                    (TIM1->CR1 |= TIM1_CR1_URS); \
                                    (TIM1->PSCRL = CounterPSC); \
                                    (TIM1->ARRH = 0xFF); \
                                    (TIM1->ARRL = 0xFF)
                                 
#define clearTimeValue()            (TIM1->CNTRH = 0); \
                                    (TIM1->CNTRL = 0)

#define stopTimeValue()             (TIM1->CR1 |= 0x00); 

/*
#define ata_StopTimer(x) TT0 |= (0x01 << x)
#define ata_GetTimerValue(x) TCR0##x
#define ata_EnableTimer(x) TOE0 |= (0x01 << x)
#define ata_isTimer0Overflowed() (TSR00 == 1)
#define ata_isUartTxFinished() (SSR00L_bit.no6 == 0)
#define ata_SendUartByte(x) SDR00 = x
*/
extern void ata_SetInterruptStatus(unsigned char status);

#endif
