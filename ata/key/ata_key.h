#ifndef __ATA_KEY_H__
#define __ATA_KEY_H__

#include "trk_app.h"

#define NULLKEY            0
#define POWERBUTTON        1
#define LEVELBUTTON        2


extern trk_KeyCallbackFunct ata_keycallback;

extern void ata_KeyOpen(trk_KeyCallbackFunct keycallback);
extern void ata_KeyInit(void);


#endif
