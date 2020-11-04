#include "ata_key.h"
#include "trk_app.h"
#include "ata_message.h"
#include "trk_message.h"
#include "trk_misc.h"
#include "ata_controller.h"
#include "ata_project.h"

unsigned char pressedKey = NULLKEY;
unsigned char letNewPress = 0;
trk_KeyCallbackFunct ata_keycallback;

void ata_KeyOpen(trk_KeyCallbackFunct keycallback)
{
    ata_keycallback = keycallback;
}

void ata_KeyHandleFromRemote(unsigned short function)
{
    if(function == 0x0C)
    {
        ata_keycallback(POWERBUTTONREMOTE,TRUE,KEYFROMREMOTE);
    }
    else if(function == 0x30)
    {
        ata_keycallback(REMOTELEVELDOWNKEY,TRUE,KEYFROMREMOTE);
    }
    else if(function == 0xC0)
    {
        ata_keycallback(REMOTELEVELUPKEY,TRUE,KEYFROMREMOTE);
    }
}

unsigned long ata_KeyCheckThread(void)
{
    unsigned char isAnyKeyPressed = TRUE;
    
    if(GPIO_ReadInputPin(GPIOD, GPIO_PIN_3) != 0)
    {
        pressedKey = LEVELDOWNKEY;
    }
    else if(GPIO_ReadInputPin(GPIOD, GPIO_PIN_2) != 0)
    {
        pressedKey = LEVELUPKEY;
    }
    else
    {
        isAnyKeyPressed = FALSE;
    }

    if(isAnyKeyPressed == TRUE)
    {
        if(letNewPress == TRUE)
        {
            ata_keycallback(pressedKey,TRUE,KEYFROMBUTTON);
            letNewPress = FALSE;

            return msg_ProcessAfter1ms*250;
        }
    }
    else
    {
        letNewPress = TRUE;
    }

    ata_keycallback(LEVELUPKEY,FALSE,KEYFROMBUTTON);
    ata_keycallback(LEVELDOWNKEY,FALSE,KEYFROMBUTTON);

    return msg_ProcessAfter1ms*50;
}

void ata_KeyInit(void)
{
    #if(KEY_CHECK_METHOD == KEY_POLLING)
    msg_pushcallback(&ata_KeyCheckThread,	msg_ProcessAfter1ms);
    #endif
}

