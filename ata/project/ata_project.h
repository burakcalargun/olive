#ifndef __ATA_PROJECT_H__
#define __ATA_PROJECT_H__

#include "trk_misc.h"

#define KEY_POLLING (0)
#define KEY_INTERRUPT (1)

#define KEY_CHECK_METHOD (KEY_POLLING)

#ifndef PROJECT_VERSION
   #define PROJECT_VERSION (7)
#endif

#ifndef MINOR_PROJECT_VERSION
   #define MINOR_PROJECT_VERSION (0)
#endif

#endif
