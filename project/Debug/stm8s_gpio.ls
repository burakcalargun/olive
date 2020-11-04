   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
 113                     ; 45 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 113                     ; 46 {
 115                     	switch	.text
 116  0000               _GPIO_DeInit:
 120                     ; 47     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 122  0000 7f            	clr	(x)
 123                     ; 48     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 125  0001 6f02          	clr	(2,x)
 126                     ; 49     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 128  0003 6f03          	clr	(3,x)
 129                     ; 50     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 131  0005 6f04          	clr	(4,x)
 132                     ; 51 }
 135  0007 81            	ret	
 375                     ; 62 void GPIO_Init(GPIO_TypeDef* GPIOx,
 375                     ; 63                GPIO_Pin_TypeDef GPIO_Pin,
 375                     ; 64                GPIO_Mode_TypeDef GPIO_Mode)
 375                     ; 65 {
 376                     	switch	.text
 377  0008               _GPIO_Init:
 379  0008 89            	pushw	x
 380       00000000      OFST:	set	0
 383                     ; 70     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 385                     ; 71     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 387                     ; 77     if ((((u8)(GPIO_Mode)) & (u8)0x80) != (u8)0x00) /* Output mode */
 389  0009 7b06          	ld	a,(OFST+6,sp)
 390  000b 2a16          	jrpl	L771
 391                     ; 79         if ((((u8)(GPIO_Mode)) & (u8)0x10) != (u8)0x00) /* High level */
 393  000d a510          	bcp	a,#16
 394  000f 2705          	jreq	L102
 395                     ; 81             GPIOx->ODR |= (u8)GPIO_Pin;
 397  0011 f6            	ld	a,(x)
 398  0012 1a05          	or	a,(OFST+5,sp)
 400  0014 2004          	jra	L302
 401  0016               L102:
 402                     ; 84             GPIOx->ODR &= (u8)(~(GPIO_Pin));
 404  0016 7b05          	ld	a,(OFST+5,sp)
 405  0018 43            	cpl	a
 406  0019 f4            	and	a,(x)
 407  001a               L302:
 408  001a f7            	ld	(x),a
 409                     ; 87         GPIOx->DDR |= (u8)GPIO_Pin;
 411  001b 1e01          	ldw	x,(OFST+1,sp)
 412  001d e602          	ld	a,(2,x)
 413  001f 1a05          	or	a,(OFST+5,sp)
 415  0021 2005          	jra	L502
 416  0023               L771:
 417                     ; 91         GPIOx->DDR &= (u8)(~(GPIO_Pin));
 419  0023 7b05          	ld	a,(OFST+5,sp)
 420  0025 43            	cpl	a
 421  0026 e402          	and	a,(2,x)
 422  0028               L502:
 423  0028 e702          	ld	(2,x),a
 424                     ; 98     if ((((u8)(GPIO_Mode)) & (u8)0x40) != (u8)0x00) /* Pull-Up or Push-Pull */
 426  002a 7b06          	ld	a,(OFST+6,sp)
 427  002c a540          	bcp	a,#64
 428  002e 2706          	jreq	L702
 429                     ; 100         GPIOx->CR1 |= (u8)GPIO_Pin;
 431  0030 e603          	ld	a,(3,x)
 432  0032 1a05          	or	a,(OFST+5,sp)
 434  0034 2005          	jra	L112
 435  0036               L702:
 436                     ; 103         GPIOx->CR1 &= (u8)(~(GPIO_Pin));
 438  0036 7b05          	ld	a,(OFST+5,sp)
 439  0038 43            	cpl	a
 440  0039 e403          	and	a,(3,x)
 441  003b               L112:
 442  003b e703          	ld	(3,x),a
 443                     ; 110     if ((((u8)(GPIO_Mode)) & (u8)0x20) != (u8)0x00) /* Interrupt or Slow slope */
 445  003d 7b06          	ld	a,(OFST+6,sp)
 446  003f a520          	bcp	a,#32
 447  0041 2706          	jreq	L312
 448                     ; 112         GPIOx->CR2 |= (u8)GPIO_Pin;
 450  0043 e604          	ld	a,(4,x)
 451  0045 1a05          	or	a,(OFST+5,sp)
 453  0047 2005          	jra	L512
 454  0049               L312:
 455                     ; 115         GPIOx->CR2 &= (u8)(~(GPIO_Pin));
 457  0049 7b05          	ld	a,(OFST+5,sp)
 458  004b 43            	cpl	a
 459  004c e404          	and	a,(4,x)
 460  004e               L512:
 461  004e e704          	ld	(4,x),a
 462                     ; 118 }
 465  0050 85            	popw	x
 466  0051 81            	ret	
 512                     ; 129 void GPIO_Write(GPIO_TypeDef* GPIOx, u8 PortVal)
 512                     ; 130 {
 513                     	switch	.text
 514  0052               _GPIO_Write:
 516       fffffffe      OFST: set -2
 519                     ; 131     GPIOx->ODR = PortVal;
 521  0052 7b03          	ld	a,(OFST+5,sp)
 522  0054 f7            	ld	(x),a
 523                     ; 132 }
 526  0055 81            	ret	
 573                     ; 143 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 573                     ; 144 {
 574                     	switch	.text
 575  0056               _GPIO_WriteHigh:
 577       fffffffe      OFST: set -2
 580                     ; 163     GPIOx->ODR |= (u8)PortPins;
 582  0056 f6            	ld	a,(x)
 583  0057 1a03          	or	a,(OFST+5,sp)
 584  0059 f7            	ld	(x),a
 585                     ; 164 }
 588  005a 81            	ret	
 635                     ; 175 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 635                     ; 176 {
 636                     	switch	.text
 637  005b               _GPIO_WriteLow:
 639       fffffffe      OFST: set -2
 642                     ; 195     GPIOx->ODR &= (u8)(~PortPins);
 644  005b 7b03          	ld	a,(OFST+5,sp)
 645  005d 43            	cpl	a
 646  005e f4            	and	a,(x)
 647  005f f7            	ld	(x),a
 648                     ; 196 }
 651  0060 81            	ret	
 698                     ; 207 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 698                     ; 208 {
 699                     	switch	.text
 700  0061               _GPIO_WriteReverse:
 702       fffffffe      OFST: set -2
 705                     ; 209     GPIOx->ODR ^= (u8)PortPins;
 707  0061 f6            	ld	a,(x)
 708  0062 1803          	xor	a,(OFST+5,sp)
 709  0064 f7            	ld	(x),a
 710                     ; 210 }
 713  0065 81            	ret	
 751                     ; 219 u8 GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 751                     ; 220 {
 752                     	switch	.text
 753  0066               _GPIO_ReadOutputData:
 757                     ; 221     return ((u8)GPIOx->ODR);
 759  0066 f6            	ld	a,(x)
 762  0067 81            	ret	
 799                     ; 231 u8 GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 799                     ; 232 {
 800                     	switch	.text
 801  0068               _GPIO_ReadInputData:
 805                     ; 233     return ((u8)GPIOx->IDR);
 807  0068 e601          	ld	a,(1,x)
 810  006a 81            	ret	
 878                     ; 246 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 878                     ; 247 {
 879                     	switch	.text
 880  006b               _GPIO_ReadInputPin:
 882       fffffffe      OFST: set -2
 885                     ; 248         return ((BitStatus)(GPIOx->IDR & (vu8)GPIO_Pin));
 887  006b e601          	ld	a,(1,x)
 888  006d 1403          	and	a,(OFST+5,sp)
 891  006f 81            	ret	
 969                     ; 259 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 969                     ; 260 {
 970                     	switch	.text
 971  0070               _GPIO_ExternalPullUpConfig:
 973       fffffffe      OFST: set -2
 976                     ; 262     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 978                     ; 263     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 980                     ; 265     if (NewState != DISABLE) /* External Pull-Up Set*/
 982  0070 7b04          	ld	a,(OFST+6,sp)
 983  0072 2706          	jreq	L374
 984                     ; 267         GPIOx->CR1 |= (u8)GPIO_Pin;
 986  0074 e603          	ld	a,(3,x)
 987  0076 1a03          	or	a,(OFST+5,sp)
 989  0078 2005          	jra	L574
 990  007a               L374:
 991                     ; 270         GPIOx->CR1 &= (u8)(~(GPIO_Pin));
 993  007a 7b03          	ld	a,(OFST+5,sp)
 994  007c 43            	cpl	a
 995  007d e403          	and	a,(3,x)
 996  007f               L574:
 997  007f e703          	ld	(3,x),a
 998                     ; 272 }
1001  0081 81            	ret	
1048                     ; 279 void GPIO_ToggleBits(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
1048                     ; 280 {
1049                     	switch	.text
1050  0082               _GPIO_ToggleBits:
1052       fffffffe      OFST: set -2
1055                     ; 281   GPIOx->ODR ^= GPIO_Pin;
1057  0082 f6            	ld	a,(x)
1058  0083 1803          	xor	a,(OFST+5,sp)
1059  0085 f7            	ld	(x),a
1060                     ; 282 }
1063  0086 81            	ret	
1076                     	xdef	_GPIO_ExternalPullUpConfig
1077                     	xdef	_GPIO_ReadInputPin
1078                     	xdef	_GPIO_ReadOutputData
1079                     	xdef	_GPIO_ReadInputData
1080                     	xdef	_GPIO_ToggleBits
1081                     	xdef	_GPIO_WriteReverse
1082                     	xdef	_GPIO_WriteLow
1083                     	xdef	_GPIO_WriteHigh
1084                     	xdef	_GPIO_Write
1085                     	xdef	_GPIO_Init
1086                     	xdef	_GPIO_DeInit
1105                     	end
