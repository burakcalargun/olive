/*===========================================================================*/
/* Module : low_level_initialization.h                                       */
/* Version: V1.00                                                            */
/*===========================================================================*/
/*                                  COPYRIGHT                                */
/*===========================================================================*/
/* Copyright (c) 2011 by Renesas Electronics Europe GmbH,                    */
/*               a company of the Renesas Electronics Corporation            */
/*===========================================================================*/
/* Purpose: basic microcontroller initialization macros                      */
/*                                                                           */
/*===========================================================================*/
/* In case of any question please do not hesitate to contact:                */
/*                                                                           */
/*        Technical Product Support                                          */
/*                                                                           */
/*        Renesas Electronics Europe GmbH                                    */
/*        Arcadiastrasse 10                                                  */
/*        D-40472 Duesseldorf, Germany                                       */
/*                                                                           */
/*        e-mail: device_support.rl78-eu@lm.renesas.com                      */
/*        FAX:   +49 - (0)211 / 65 03 - 12 79                                */
/*                                                                           */
/*===========================================================================*/
/* Warranty Disclaimer                                                       */
/*                                                                           */
/* Because the Product(s) is licensed free of charge, there is no warranty   */
/* of any kind whatsoever and expressly disclaimed and excluded by Renesas,  */
/* either expressed or implied, including but not limited to those for       */
/* non-infringement of intellectual property, merchantability and/or         */
/* fitness for the particular purpose.                                       */
/* NEC shall not have any obligation to maintain, service or provide bug     */
/* fixes for the supplied Product(s) and/or the Application.                 */
/*                                                                           */
/* Each User is solely responsible for determining the appropriateness of    */
/* using the Product(s) and assumes all risks associated with its exercise   */
/* of rights under this Agreement, including, but not limited to the risks   */
/* and costs of program errors, compliance with applicable laws, damage to   */
/* or loss of data, programs or equipment, and unavailability or             */
/* interruption of operations.                                               */
/*                                                                           */
/* Limitation of Liability                                                   */
/*                                                                           */
/* In no event shall Renesas be liable to the User for any incidental,       */
/* consequential, indirect, or punitive damage (including but not limited    */
/* to lost profits) regardless of whether such liability is based on breach  */
/* of contract, tort, strict liability, breach of warranties, failure of     */
/* essential purpose or otherwise and even if advised of the possibility of  */
/* such damages. Renesas shall not be liable for any services or products    */
/* provided by third party vendors, developers or consultants identified or  */
/* referred to the User by Renesas in connection with the Product(s) and/or  */
/* the Application.                                                          */
/*                                                                           */
/*===========================================================================*/
/* Environment:                                                              */
/*              Device:          R5F100LE                                    */
/*              Target Hardware: QB-R5F100LE-TB                              */
/*              IDE:             IAR Systems                                 */
/*                               Embedded Workbench for RL78 V1.xx           */
/*                                                                           */
/*===========================================================================*/
/* History:                                                                  */
/*              V1.00: Initial version                                       */
/*                                                                           */
/*===========================================================================*/

#ifndef __low_level_initialization_H
#define __low_level_initialization_H

extern void InitRegisters(void);

extern void Init_GPIO (void);

extern void ADC_Settings(void);

extern void TIM4_Settings(void);

extern void TIM2_Set(unsigned short ms);

extern void TIM2_Settings(void);

extern void TIM1_Set(unsigned short ms);

extern void TIM1_Settings(void);

/* --------------------------------------------------------------------------*/
/* Option-bytes and security ID                                              */
/* --------------------------------------------------------------------------
#define OPT_BYTES_SIZE     4u
#define SECU_ID_SIZE       10u
*/


/* --------------------------------------------------------------------------*/
/* Variable Initialization                                                   */
/* --------------------------------------------------------------------------
#define ENABLE_VAR_INIT    TRUE
#define DISABLE_VAR_INIT   FALSE
*/

/* --------------------------------------------------------------------------*/
/* Clock Configuration                                                       */
/* --------------------------------------------------------------------------*/


/* --------------------------------------------------------------------------*/
/* I/O Port Configuration                                                    */
/* --------------------------------------------------------------------------


#define FALSE               0
#define TRUE                1
#define LOW                 FALSE
#define HIGH                TRUE
#define OUTPUT              FALSE
#define INPUT               TRUE
#define OPEN                FALSE
#define CLOSE               TRUE

#define IRQ_ENABLE          FALSE
#define IRQ_DISABLE         (!IRQ_ENABLE)

*/


#endif /* __low_level_initialization_H */

