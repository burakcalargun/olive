   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  47                     ; 50 void EXTI_DeInit(void)   
  47                     ; 51 {   
  49                     	switch	.text
  50  0000               _EXTI_DeInit:
  54                     ; 52   EXTI->CR1 = EXTI_CR1_RESET_VALUE;   
  56  0000 725f50a0      	clr	20640
  57                     ; 53   EXTI->CR2 = EXTI_CR2_RESET_VALUE;   
  59  0004 725f50a1      	clr	20641
  60                     ; 54 }   
  63  0008 81            	ret	
 188                     ; 67 void EXTI_SetExtIntSensitivity(EXTI_Port_TypeDef Port, EXTI_Sensitivity_TypeDef SensitivityValue)   
 188                     ; 68 {   
 189                     	switch	.text
 190  0009               _EXTI_SetExtIntSensitivity:
 192  0009 89            	pushw	x
 193       00000000      OFST:	set	0
 196                     ; 71   assert_param(IS_EXTI_PORT_OK(Port));   
 198                     ; 72   assert_param(IS_EXTI_SENSITIVITY_OK(SensitivityValue));   
 200                     ; 75   switch (Port)   
 202  000a 9e            	ld	a,xh
 204                     ; 97     default:   
 204                     ; 98       break;   
 205  000b 4d            	tnz	a
 206  000c 270e          	jreq	L12
 207  000e 4a            	dec	a
 208  000f 271a          	jreq	L32
 209  0011 4a            	dec	a
 210  0012 2725          	jreq	L52
 211  0014 4a            	dec	a
 212  0015 2731          	jreq	L72
 213  0017 4a            	dec	a
 214  0018 2745          	jreq	L13
 215  001a 2053          	jra	L311
 216  001c               L12:
 217                     ; 77     case EXTI_PORT_GPIOA:   
 217                     ; 78       EXTI->CR1 &= (u8)(~EXTI_CR1_PAIS);   
 219  001c c650a0        	ld	a,20640
 220  001f a4fc          	and	a,#252
 221  0021 c750a0        	ld	20640,a
 222                     ; 79       EXTI->CR1 |= (u8)(SensitivityValue);   
 224  0024 c650a0        	ld	a,20640
 225  0027 1a02          	or	a,(OFST+2,sp)
 226                     ; 80       break;   
 228  0029 202f          	jp	LC001
 229  002b               L32:
 230                     ; 81     case EXTI_PORT_GPIOB:   
 230                     ; 82       EXTI->CR1 &= (u8)(~EXTI_CR1_PBIS);   
 232  002b c650a0        	ld	a,20640
 233  002e a4f3          	and	a,#243
 234  0030 c750a0        	ld	20640,a
 235                     ; 83       EXTI->CR1 |= (u8)((u8)(SensitivityValue) << 2);   
 237  0033 7b02          	ld	a,(OFST+2,sp)
 238  0035 48            	sll	a
 239  0036 48            	sll	a
 240                     ; 84       break;   
 242  0037 201e          	jp	LC002
 243  0039               L52:
 244                     ; 85     case EXTI_PORT_GPIOC:   
 244                     ; 86       EXTI->CR1 &= (u8)(~EXTI_CR1_PCIS);   
 246  0039 c650a0        	ld	a,20640
 247  003c a4cf          	and	a,#207
 248  003e c750a0        	ld	20640,a
 249                     ; 87       EXTI->CR1 |= (u8)((u8)(SensitivityValue) << 4);   
 251  0041 7b02          	ld	a,(OFST+2,sp)
 252  0043 97            	ld	xl,a
 253  0044 a610          	ld	a,#16
 254                     ; 88       break;   
 256  0046 200d          	jp	LC003
 257  0048               L72:
 258                     ; 89     case EXTI_PORT_GPIOD:   
 258                     ; 90       EXTI->CR1 &= (u8)(~EXTI_CR1_PDIS);   
 260  0048 c650a0        	ld	a,20640
 261  004b a43f          	and	a,#63
 262  004d c750a0        	ld	20640,a
 263                     ; 91       EXTI->CR1 |= (u8)((u8)(SensitivityValue) << 6);   
 265  0050 7b02          	ld	a,(OFST+2,sp)
 266  0052 97            	ld	xl,a
 267  0053 a640          	ld	a,#64
 268  0055               LC003:
 269  0055 42            	mul	x,a
 270  0056 9f            	ld	a,xl
 271  0057               LC002:
 272  0057 ca50a0        	or	a,20640
 273  005a               LC001:
 274  005a c750a0        	ld	20640,a
 275                     ; 92       break;   
 277  005d 2010          	jra	L311
 278  005f               L13:
 279                     ; 93     case EXTI_PORT_GPIOE:   
 279                     ; 94       EXTI->CR2 &= (u8)(~EXTI_CR2_PEIS);   
 281  005f c650a1        	ld	a,20641
 282  0062 a4fc          	and	a,#252
 283  0064 c750a1        	ld	20641,a
 284                     ; 95       EXTI->CR2 |= (u8)(SensitivityValue);   
 286  0067 c650a1        	ld	a,20641
 287  006a 1a02          	or	a,(OFST+2,sp)
 288  006c c750a1        	ld	20641,a
 289                     ; 96       break;   
 291                     ; 97     default:   
 291                     ; 98       break;   
 293  006f               L311:
 294                     ; 100 }   
 297  006f 85            	popw	x
 298  0070 81            	ret	
 356                     ; 109 void EXTI_SetTLISensitivity(EXTI_TLISensitivity_TypeDef SensitivityValue)   
 356                     ; 110 {   
 357                     	switch	.text
 358  0071               _EXTI_SetTLISensitivity:
 362                     ; 113   assert_param(IS_EXTI_TLISENSITIVITY_OK(SensitivityValue));   
 364                     ; 116   EXTI->CR2 &= (u8)(~EXTI_CR2_TLIS);   
 366  0071 721550a1      	bres	20641,#2
 367                     ; 117   EXTI->CR2 |= (u8)(SensitivityValue);   
 369  0075 ca50a1        	or	a,20641
 370  0078 c750a1        	ld	20641,a
 371                     ; 119 }   
 374  007b 81            	ret	
 420                     ; 128 EXTI_Sensitivity_TypeDef EXTI_GetExtIntSensitivity(EXTI_Port_TypeDef Port)   
 420                     ; 129 {   
 421                     	switch	.text
 422  007c               _EXTI_GetExtIntSensitivity:
 424  007c 88            	push	a
 425       00000001      OFST:	set	1
 428                     ; 131   u8 value = 0;   
 430  007d 0f01          	clr	(OFST+0,sp)
 432                     ; 134   assert_param(IS_EXTI_PORT_OK(Port));   
 434                     ; 136   switch (Port)   
 437                     ; 153     default:   
 437                     ; 154       break;   
 438  007f 4d            	tnz	a
 439  0080 2710          	jreq	L341
 440  0082 4a            	dec	a
 441  0083 2712          	jreq	L541
 442  0085 4a            	dec	a
 443  0086 2716          	jreq	L741
 444  0088 4a            	dec	a
 445  0089 2719          	jreq	L151
 446  008b 4a            	dec	a
 447  008c 271c          	jreq	L351
 448  008e 7b01          	ld	a,(OFST+0,sp)
 449  0090 201d          	jra	L302
 450  0092               L341:
 451                     ; 138     case EXTI_PORT_GPIOA:   
 451                     ; 139       value = (u8)(EXTI->CR1 & EXTI_CR1_PAIS);   
 453  0092 c650a0        	ld	a,20640
 454                     ; 140       break;   
 456  0095 2016          	jp	LC004
 457  0097               L541:
 458                     ; 141     case EXTI_PORT_GPIOB:   
 458                     ; 142       value = (u8)((EXTI->CR1 & EXTI_CR1_PBIS) >> 2);   
 460  0097 c650a0        	ld	a,20640
 461  009a               LC005:
 462  009a 44            	srl	a
 463  009b 44            	srl	a
 464                     ; 143       break;   
 466  009c 200f          	jp	LC004
 467  009e               L741:
 468                     ; 144     case EXTI_PORT_GPIOC:   
 468                     ; 145       value = (u8)((EXTI->CR1 & EXTI_CR1_PCIS) >> 4);   
 470  009e c650a0        	ld	a,20640
 471  00a1 4e            	swap	a
 472                     ; 146       break;   
 474  00a2 2009          	jp	LC004
 475  00a4               L151:
 476                     ; 147     case EXTI_PORT_GPIOD:   
 476                     ; 148       value = (u8)((EXTI->CR1 & EXTI_CR1_PDIS) >> 6);   
 478  00a4 c650a0        	ld	a,20640
 479  00a7 4e            	swap	a
 480                     ; 149       break;   
 482  00a8 20f0          	jp	LC005
 483  00aa               L351:
 484                     ; 150     case EXTI_PORT_GPIOE:   
 484                     ; 151       value = (u8)(EXTI->CR2 & EXTI_CR2_PEIS);   
 486  00aa c650a1        	ld	a,20641
 487  00ad               LC004:
 488  00ad a403          	and	a,#3
 490                     ; 152       break;   
 492                     ; 153     default:   
 492                     ; 154       break;   
 494  00af               L302:
 495                     ; 157   return((EXTI_Sensitivity_TypeDef)value);   
 499  00af 5b01          	addw	sp,#1
 500  00b1 81            	ret	
 536                     ; 169 EXTI_TLISensitivity_TypeDef EXTI_GetTLISensitivity(void)   
 536                     ; 170 {   
 537                     	switch	.text
 538  00b2               _EXTI_GetTLISensitivity:
 540       00000001      OFST:	set	1
 543                     ; 175   value = (u8)(EXTI->CR2 & EXTI_CR2_TLIS);   
 545  00b2 c650a1        	ld	a,20641
 546  00b5 a404          	and	a,#4
 548                     ; 177   return((EXTI_TLISensitivity_TypeDef)value);   
 552  00b7 81            	ret	
 565                     	xdef	_EXTI_GetTLISensitivity
 566                     	xdef	_EXTI_GetExtIntSensitivity
 567                     	xdef	_EXTI_SetTLISensitivity
 568                     	xdef	_EXTI_SetExtIntSensitivity
 569                     	xdef	_EXTI_DeInit
 588                     	end
