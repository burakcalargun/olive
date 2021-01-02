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
unsigned char keyPressCounter = 0;
void ata_KeyOpen(trk_KeyCallbackFunct keycallback)
{
    ata_keycallback = keycallback;
}

unsigned char pressState = FALSE;
unsigned char previousPressState = FALSE;
unsigned char longPressWasActive = FALSE;
unsigned long ata_KeyCheckThread(void)
{
    unsigned char isAnyKeyPressed = FALSE;

    pressState = GPIO_ReadInputPin(GPIOC, GPIO_PIN_7) ? (FALSE) : (TRUE);

    if((previousPressState == TRUE) && (pressState == FALSE))
    {
        if(longPressWasActive == FALSE)
        {
            pressedKey = POWERBUTTON;
            isAnyKeyPressed = TRUE;
        }
        else
        {
            longPressWasActive = FALSE;
        }
    }
    else if((pressState == TRUE) && (++keyPressCounter > 50))
    {
        pressedKey = LEVELBUTTON;
        isAnyKeyPressed = TRUE;
        longPressWasActive = TRUE;
    }

    if(isAnyKeyPressed == TRUE)
    {
        keyPressCounter = 0;
        ata_keycallback(pressedKey,TRUE);
    }

    previousPressState = pressState;

    return msg_ProcessAfter1ms*50;
}

void ata_KeyInit(void)
{
    #if(KEY_CHECK_METHOD == KEY_POLLING)
    msg_pushcallback(&ata_KeyCheckThread, msg_ProcessAfter1s);
    #endif
}

