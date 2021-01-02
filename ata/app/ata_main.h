#ifndef __ATA_MAIN_H__
#define __ATA_MAIN_H__


extern unsigned char ata_TimerFlag;

extern void ata_Init(void);
extern void ata_Run(void);
extern void ata_1msTimer(void);
extern void WatchdogKick(void);
#endif
