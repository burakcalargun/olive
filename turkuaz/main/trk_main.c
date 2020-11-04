#include "trk_main.h"
#include "ata_project.h"
#include "ata_main.h"
#include "low_level_initialization.h"
#include "stm8s.h"
#include "trk_message.h"
#include "trk_message.h"
#include "trk_misc.h"
#include "trk_app.h"



#define		TIM1_DIV1			(unsigned short)(1-1)
#define		TIM1_DIV2			(unsigned short)(2-1)
#define		TIM1_DIV4			(unsigned short)(4-1)
#define		TIM1_DIV8			(unsigned short)(8-1)
#define		TIM1_DIV16			(unsigned short)(16-1)
#define		TIM1_DIV32			(unsigned short)(32-1)
 
// timer1 PWM output pin to enable

 
 // PWM frequency setting
#define	V_PWMFRE  1000
 
#define ToCMPxH(CMP,Value) (CMP = (unsigned char)((Value >> 8 ) & 0xFF))
#define ToCMPxL(CMP,Value) (CMP = (unsigned char)(Value & 0xFF))
 
 
//*************************************
 // function name: Init_Timer1_PWM
 // Function: initializing a timer for generating a PWM output
 // entry parameters: PWM Level 0.625U (1000 * 0.625 = 62.5U = 8K) each stage
 // export parameters: None
 // this initialization settings in the three-phase PWM BLDC output
//***************************************
void Init_Timer1_PWM(unsigned short Tcon,unsigned short Pscr)
{	
   
   #if 0
   // 16M via System Clock Prescaler f = fck / (PSCR + 1)  

   TIM1->PSCRH = (Pscr >> 8) & 0xff ;  
   TIM1->PSCRL = Pscr & 0xff ; 

   // the value setting register reload, 255 is a maximum value			
   TIM1->ARRH = (Tcon >> 8) & 0xff ;
   TIM1->ARRL = Tcon & 0xff ;

   // set the brakes register 		
   TIM1->BKR |= 0X80 ;   

   // PWM1 mode, TIM1_CNT <TIM1_CCR1 valid		
   TIM1->CCMR1 = 0x78 ; 
   // PWM1 mode, TIM1_CNT <TIM1_CCR1 valid		
   TIM1->CCMR2 = 0x78 ; 
   // PWM1 mode, TIM1_CNT <TIM1_CCR1 valid		
   TIM1->CCMR3 = 0x78 ; 
   // freeze mode, TIM1_CNT <TIM1_CCR1 valid		
   TIM1->CCMR4 = 0x08 ; 

   TIM1->CCER1 = 0x00;  // Disable the Channels 1-2
   TIM1->CCER1 = 0x17;  // Enable the Channel 1-2 & Low Polarity

   TIM1->CCER2 = 0x00;  // Disable the Channels 3
   TIM1->CCER2 = 0x03;  // Enable the Channel 3 & Low Polarity

   // PWM duty cycle is cleared
   TIM1->CCR1H = (unsigned char)(333 >> 8); 
   TIM1->CCR1L = (unsigned char)333;    

   TIM1->CCR2H = (unsigned char)(333 >> 8); 
   TIM1->CCR2L = (unsigned char)333;

   TIM1->CCR3H = (unsigned char)(333 >> 8); 
   TIM1->CCR3L = (unsigned char)333;

   TIM1->EGR = 0X01; // UG = 1; Loading initializes the counter preload shadow registers
   TIM1->CNTRH = 0; // Counter Cleared
   TIM1->CNTRL = 0 ;

   TIM1->CR1 |= 0x80;
   TIM1->CR1 |= 0X01; // counter enable, start counting 	
   #else
			
			
   #endif
				
}




void drive_BC(void)
{
   GPIO_WriteLow(GPIOC, GPIO_PIN_1);
   GPIO_WriteHigh(GPIOC, GPIO_PIN_2);
   GPIO_WriteLow(GPIOC, GPIO_PIN_3);

   #if 0
   #if 0
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
   #else
   TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
   TIM2->CCER2 = 0x00;  // Disable the Channels 3
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   TIM2->CCER2 = 0x01;  // Enable the Channel 3 & Low Polarity
   #endif
   #endif
}

void drive_BA(void)
{
   GPIO_WriteLow(GPIOC, GPIO_PIN_1);
   GPIO_WriteHigh(GPIOC, GPIO_PIN_2);
   GPIO_WriteLow(GPIOC, GPIO_PIN_3);

   #if 0
   GPIO_WriteHigh(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   #else
   TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
   TIM2->CCER2 = 0x00;  // Disable the Channels 3
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   TIM2->CCER1 = 0x01;  // Enable the Channel 1 & Low Polarity
   #endif
}

void drive_CA(void)
{
   GPIO_WriteLow(GPIOC, GPIO_PIN_1);
   GPIO_WriteLow(GPIOC, GPIO_PIN_2);
   GPIO_WriteHigh(GPIOC, GPIO_PIN_3);

   #if 0
   #if 0
   GPIO_WriteHigh(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   #else
   TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
   TIM2->CCER2 = 0x00;  // Disable the Channels 3
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   TIM2->CCER1 = 0x01;  // Enable the Channel 1 & Low Polarity
   #endif
   #endif
}

void drive_CB(void)
{
   GPIO_WriteLow(GPIOC, GPIO_PIN_1);
   GPIO_WriteLow(GPIOC, GPIO_PIN_2);
   GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
   
   #if 0
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteHigh(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   #else
   TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
   TIM2->CCER2 = 0x00;  // Disable the Channels 3
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   TIM2->CCER1 = 0x10;  // Enable the Channel 2 & Low Polarity
   #endif
}

void drive_AB(void)
{
   GPIO_WriteHigh(GPIOC, GPIO_PIN_1);
   GPIO_WriteLow(GPIOC, GPIO_PIN_2);
   GPIO_WriteLow(GPIOC, GPIO_PIN_3);

   #if 0
   #if 0
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteHigh(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   #else
   TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
   TIM2->CCER2 = 0x00;  // Disable the Channels 3
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   TIM2->CCER1 = 0x10;  // Enable the Channel 2 & Low Polarity
   #endif
   #endif
}

void drive_AC(void)
{
   GPIO_WriteHigh(GPIOC, GPIO_PIN_1);
   GPIO_WriteLow(GPIOC, GPIO_PIN_2);
   GPIO_WriteLow(GPIOC, GPIO_PIN_3);
   
   #if 0
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
   #else
   TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
   TIM2->CCER2 = 0x00;  // Disable the Channels 3
   GPIO_WriteLow(GPIOD, GPIO_PIN_4);
   GPIO_WriteLow(GPIOD, GPIO_PIN_3);
   GPIO_WriteLow(GPIOA, GPIO_PIN_3);
   TIM2->CCER2 = 0x01;  // Enable the Channel 3 & Low Polarity
   #endif
}

void drive_Allign(void)
{
   drive_BA();
}

void drive_AllignStep2(void)
{
   drive_CA();
}

unsigned char commutationSteps = step_CB;
unsigned char allignmentCounter = 0;
unsigned char allignmentPhase = 1;

unsigned char testState = 0;

void stepping(void)
{
   if(testState == 2)
   {
      switch(commutationSteps)
      {
         case step_BC:
            drive_BC();
            commutationSteps = step_BA;
            break;

         case step_BA:
            drive_BA();
            commutationSteps = step_CA;
            break;

         case step_CA:
            drive_CA();
            commutationSteps = step_CB;
            break;

         case step_CB:
            drive_CB();
            commutationSteps = step_AB;
            break;
            
         case step_AB:
            drive_AB();
            commutationSteps = step_AC;
            break;

         case step_AC:
            drive_AC();
            commutationSteps = step_BC;
            break;
      }
   }
}


unsigned long testThread(void)
{
   if(testState == 0)
   {
      drive_AllignStep2();
      testState = 1;
      GPIO_WriteHigh(GPIOB, GPIO_PIN_7);
   }
   else
   {
      GPIO_WriteLow(GPIOB, GPIO_PIN_7);
      testState = 2;
      return msg_ProcessStopped;
   }
   return msg_ProcessAfter1s;
}

#define MAINTIMER 20000

unsigned short mainTimerLoad = MAINTIMER;
unsigned short lowSideLoad = MAINTIMER / 20;
unsigned short lowSideDuty = 15;

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

void setLowSideDuty(unsigned short duty)
{
   lowSideDuty = duty;
}

unsigned short getLowSideDuty(void)
{
   return lowSideDuty;
}

unsigned short getResult(void)
{   
   return lowSideLoad - ((lowSideLoad*lowSideDuty) / 100);
}

/*timer 2 is the pwm timer for low side switching*/
void Init_Timer2(unsigned short load, unsigned short duty) 
{
   unsigned short loadduty = load - ((load * duty) / 100);
   
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
 
   TIM2->CCR1H = (unsigned char)(loadduty >> 8); 
   TIM2->CCR1L = (unsigned char)loadduty;    
 
   TIM2->CCR2H = (unsigned char)(loadduty >> 8); 
   TIM2->CCR2L = (unsigned char)loadduty;
 
   TIM2->CCR3H = (unsigned char)(loadduty >> 8); 
   TIM2->CCR3L = (unsigned char)loadduty;
 
   TIM2->CR1  |= 0x80;  // AutoReload aktif durumda.
   TIM2->CR1  |= 0x01;  // Timer çalýþmaya baþlýyor.

}

void main(void)
{
   InitRegisters();
   trk_MessageInit();
   ata_Init();
   trk_appInit();
   //Init_Timer1_PWM (V_PWMFRE, TIM1_DIV4);
   TIM1_Settings();
   Init_Timer2(getLowSideLoad(), getLowSideDuty());
   drive_Allign();
   trk_PushMessage(&testThread,msg_ProcessAfter1s);
   ata_Run();
}

