#ifndef __TRK_MAIN_H__
#define __TRK_MAIN_H__


#define MAINTIMER 30000
#define DEBOUNCE_ITERATOR 4


#define LEVEL1 (185) // yavas seviye
#define LEVEL2 (150) // hizli seviye


#define ORIGINAL_MOTOR (1)
#define MY_TEST_MOTOR (2)
#define MOTOR_TYPE (ORIGINAL_MOTOR)


extern unsigned char phaseIsLost;
extern unsigned char interruptFunctionAvailable;
extern unsigned short phaseLossCounter;

extern void main(void);

unsigned short TIM1_Get(void);
void TIM1_Set(unsigned short ms);

void interruptFunction(void);
void bldc_move(void);

void drive_BC(void);
void drive_BA(void);
void drive_CA(void);
void drive_CB(void);
void drive_AB(void);
void drive_AC(void);

void BEMF_A_RISING(void); //(U) _ B2 pin
void BEMF_A_FALLING(void); //(U) _ B2 pin
void BEMF_B_RISING(void); //(V) _ B1 pin
void BEMF_B_FALLING(void); //(V) _ B1 pin
void BEMF_C_RISING(void); //(W) _ B0 pin
void BEMF_C_FALLING(void); //(W) _ B0 pin

void setTargetSpeed(unsigned short set);
void startStopMotor(unsigned char startstop);
unsigned char getMotorState(void);
unsigned short getTargetSpeed(void);
void setCountLimit(unsigned short set);



#endif

