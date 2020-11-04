#ifndef __TRK_APP_H__
#define __TRK_APP_H__

typedef struct
{
   unsigned char needToSaveFlag;
   unsigned char levelThatWillBeSaved;
}dataSaveStruct;

extern dataSaveStruct levelRegister;

typedef void (*trk_KeyCallbackFunct)(unsigned char, unsigned char, unsigned char);
extern void trk_KeyCallback(unsigned char Key, unsigned char Pressed, unsigned char KeySource);
extern void trk_appInit(void);
extern unsigned char trk_GetSoftStartState(void);
extern unsigned char trk_SetSoftStartState(unsigned char state);
extern unsigned char trk_GetCurrentLevel(void);
extern void trk_SetCurrentLevel(unsigned char state);
extern unsigned char trk_LevelManager(unsigned char level);
extern void trk_ReadFlashCurrentLevel(void);
extern void trk_WriteFlashCurrentLevel(unsigned char level);
extern unsigned char getKeyOperationStatus(void);
extern unsigned long trk_Read(void);

#endif

