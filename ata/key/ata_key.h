#ifndef __ATA_KEY_H__
#define __ATA_KEY_H__

#include "trk_app.h"

#define NULLKEY            0
#define LEVELUPKEY         1
#define LEVELDOWNKEY       2

#define REMOTELEVELDOWNKEY 3
#define REMOTELEVELUPKEY   4

#define POWERBUTTONON      5
#define POWERBUTTONOFF     6
#define POWERBUTTONREMOTE  7

typedef enum
{
  KEYFROMBUTTON = 0,
  KEYFROMREMOTE = 1
}
RemoteControlKeyState;

extern trk_KeyCallbackFunct ata_keycallback;

extern void ata_KeyOpen(trk_KeyCallbackFunct keycallback);
extern void ata_KeyInit(void);
void ata_KeyHandleFromRemote(unsigned short function);


#endif
