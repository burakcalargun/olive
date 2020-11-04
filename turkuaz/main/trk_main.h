#ifndef __TRK_MAIN_H__
#define __TRK_MAIN_H__


enum{
   step_First,
   step_BC,
   step_BA,
   step_CA,
   step_CB,
   step_AB,
   step_AC,
   step_Last
};

extern void main(void);
extern unsigned long trk_PeriodicPrint(void);

extern void stepping(void);

#endif

