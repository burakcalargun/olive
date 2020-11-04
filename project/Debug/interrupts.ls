   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  19                     	switch	.data
  20  0000               _trigState:
  21  0000 00            	dc.b	0
  22  0001               _downKeyMightBePushed:
  23  0001 00            	dc.b	0
  24  0002               _upKeyMightBePushed:
  25  0002 00            	dc.b	0
  26  0003               _power_off_button_pressed:
  27  0003 00            	dc.b	0
  28  0004               _power_on_button_pressed:
  29  0004 00            	dc.b	0
  60                     ; 23 @interrupt void TIM4_UPD_OVF_IRQHandler(void)           //wil occur every 2 mili-seconds
  60                     ; 24 {
  62                     	switch	.text
  63  0000               _TIM4_UPD_OVF_IRQHandler:
  67                     ; 25    ata_TimerFlag++;
  69  0000 3c00          	inc	_ata_TimerFlag
  70                     ; 26    TIM4->SR1 &= 0xFE;          //clear UIF flag first.
  72  0002 72115344      	bres	21316,#0
  73                     ; 27 }
  76  0006 80            	iret	
 100                     ; 29 @interrupt void UART1_TX_IRQHandler(void)
 100                     ; 30 {
 101                     	switch	.text
 102  0007               _UART1_TX_IRQHandler:
 106                     ; 31    UART1->SR &=0xBF;
 108  0007 721d5230      	bres	21040,#6
 109                     ; 32 }
 112  000b 80            	iret	
 140                     ; 34 @interrupt void TIM2_UPD_OVF_IRQHandler(void)           //wil occur every 2 mili-seconds
 140                     ; 35  {
 141                     	switch	.text
 142  000c               _TIM2_UPD_OVF_IRQHandler:
 144  000c 8a            	push	cc
 145  000d 84            	pop	a
 146  000e a4bf          	and	a,#191
 147  0010 88            	push	a
 148  0011 86            	pop	cc
 149  0012 3b0002        	push	c_x+2
 150  0015 be00          	ldw	x,c_x
 151  0017 89            	pushw	x
 152  0018 3b0002        	push	c_y+2
 153  001b be00          	ldw	x,c_y
 154  001d 89            	pushw	x
 157                     ; 36     TIM2->SR1 &= 0xFE;
 159  001e 72115304      	bres	21252,#0
 160                     ; 38     if(trigState == 1)
 162  0022 c60000        	ld	a,_trigState
 163  0025 4a            	dec	a
 164  0026 261e          	jrne	L14
 165                     ; 40         GPIO_WriteHigh(GPIOB, GPIO_PIN_4);
 167  0028 4b10          	push	#16
 168  002a ae5005        	ldw	x,#20485
 169  002d cd0000        	call	_GPIO_WriteHigh
 171  0030 84            	pop	a
 172                     ; 41         GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
 174  0031 4b08          	push	#8
 175  0033 ae5000        	ldw	x,#20480
 176  0036 cd0000        	call	_GPIO_WriteHigh
 178  0039 ae000a        	ldw	x,#10
 179  003c 84            	pop	a
 180                     ; 42         TIM2_Set(10);
 182  003d cd0000        	call	_TIM2_Set
 184                     ; 43         trigState = 2;
 186  0040 35020000      	mov	_trigState,#2
 188  0044 201a          	jra	L34
 189  0046               L14:
 190                     ; 47         TIM2->CR1 = 0;
 192  0046 725f5300      	clr	21248
 193                     ; 48         GPIO_WriteLow(GPIOB, GPIO_PIN_4);
 195  004a 4b10          	push	#16
 196  004c ae5005        	ldw	x,#20485
 197  004f cd0000        	call	_GPIO_WriteLow
 199  0052 84            	pop	a
 200                     ; 49         GPIO_WriteLow(GPIOA, GPIO_PIN_3);
 202  0053 4b08          	push	#8
 203  0055 ae5000        	ldw	x,#20480
 204  0058 cd0000        	call	_GPIO_WriteLow
 206  005b 725f0000      	clr	_trigState
 207  005f 84            	pop	a
 208                     ; 50         trigState = 0;
 210  0060               L34:
 211                     ; 52 }
 214  0060 85            	popw	x
 215  0061 bf00          	ldw	c_y,x
 216  0063 320002        	pop	c_y+2
 217  0066 85            	popw	x
 218  0067 bf00          	ldw	c_x,x
 219  0069 320002        	pop	c_x+2
 220  006c 80            	iret	
 223                     	bsct
 224  0000               _brk:
 225  0000 00            	dc.b	0
 248                     ; 55 @interrupt void TIM1_UPD_OVF_IRQ_Handler(void)    
 248                     ; 56 {
 249                     	switch	.text
 250  006d               _TIM1_UPD_OVF_IRQ_Handler:
 252  006d 8a            	push	cc
 253  006e 84            	pop	a
 254  006f a4bf          	and	a,#191
 255  0071 88            	push	a
 256  0072 86            	pop	cc
 257  0073 3b0002        	push	c_x+2
 258  0076 be00          	ldw	x,c_x
 259  0078 89            	pushw	x
 260  0079 3b0002        	push	c_y+2
 261  007c be00          	ldw	x,c_y
 262  007e 89            	pushw	x
 265                     ; 69    stepping();
 267  007f cd0000        	call	_stepping
 269                     ; 71    TIM1->SR1 &= 0xFE;
 271  0082 72115255      	bres	21077,#0
 272                     ; 72 }
 275  0086 85            	popw	x
 276  0087 bf00          	ldw	c_y,x
 277  0089 320002        	pop	c_y+2
 278  008c 85            	popw	x
 279  008d bf00          	ldw	c_x,x
 280  008f 320002        	pop	c_x+2
 281  0092 80            	iret	
 304                     ; 74 unsigned long controlThread(void)
 304                     ; 75 {
 305                     	switch	.text
 306  0093               _controlThread:
 310                     ; 76    return msg_ProcessStopped;
 312  0093 aeea6d        	ldw	x,#60013
 313  0096 bf02          	ldw	c_lreg+2,x
 314  0098 5f            	clrw	x
 315  0099 bf00          	ldw	c_lreg,x
 318  009b 81            	ret	
 342                     ; 79 @interrupt void @svlreg ZeroCross_IntHandler(void)
 342                     ; 80 {  
 343                     	switch	.text
 344  009c               _ZeroCross_IntHandler:
 348                     ; 82 }
 351  009c 80            	iret	
 378                     ; 84 @interrupt  void @svlreg  RemoteControl_IntHandler(void)
 378                     ; 85 {
 379                     	switch	.text
 380  009d               _RemoteControl_IntHandler:
 382  009d 8a            	push	cc
 383  009e 84            	pop	a
 384  009f a4bf          	and	a,#191
 385  00a1 88            	push	a
 386  00a2 86            	pop	cc
 387  00a3 3b0002        	push	c_x+2
 388  00a6 be00          	ldw	x,c_x
 389  00a8 89            	pushw	x
 390  00a9 3b0002        	push	c_y+2
 391  00ac be00          	ldw	x,c_y
 392  00ae 89            	pushw	x
 393  00af be02          	ldw	x,c_lreg+2
 394  00b1 89            	pushw	x
 395  00b2 be00          	ldw	x,c_lreg
 396  00b4 89            	pushw	x
 399                     ; 86    if(GPIO_ReadInputPin(GPIOB, GPIO_PIN_0) == GPIO_PIN_0)
 401  00b5 4b01          	push	#1
 402  00b7 ae5005        	ldw	x,#20485
 403  00ba cd0000        	call	_GPIO_ReadInputPin
 405  00bd 5b01          	addw	sp,#1
 406  00bf 4a            	dec	a
 407  00c0 260a          	jrne	L501
 408                     ; 88       GPIO_WriteHigh(GPIOB, GPIO_PIN_6);
 410  00c2 4b40          	push	#64
 411  00c4 ae5005        	ldw	x,#20485
 412  00c7 cd0000        	call	_GPIO_WriteHigh
 415  00ca 2008          	jra	L701
 416  00cc               L501:
 417                     ; 92       GPIO_WriteLow(GPIOB, GPIO_PIN_6);
 419  00cc 4b40          	push	#64
 420  00ce ae5005        	ldw	x,#20485
 421  00d1 cd0000        	call	_GPIO_WriteLow
 423  00d4               L701:
 424  00d4 84            	pop	a
 425                     ; 94 }
 428  00d5 85            	popw	x
 429  00d6 bf00          	ldw	c_lreg,x
 430  00d8 85            	popw	x
 431  00d9 bf02          	ldw	c_lreg+2,x
 432  00db 85            	popw	x
 433  00dc bf00          	ldw	c_y,x
 434  00de 320002        	pop	c_y+2
 435  00e1 85            	popw	x
 436  00e2 bf00          	ldw	c_x,x
 437  00e4 320002        	pop	c_x+2
 438  00e7 80            	iret	
 461                     ; 97 @interrupt void @svlreg Key_IntHandler(void)
 461                     ; 98 {
 462                     	switch	.text
 463  00e8               _Key_IntHandler:
 467                     ; 100 }
 470  00e8 80            	iret	
 542                     	xdef	_Key_IntHandler
 543                     	xdef	_RemoteControl_IntHandler
 544                     	xdef	_ZeroCross_IntHandler
 545                     	xdef	_controlThread
 546                     	xdef	_TIM1_UPD_OVF_IRQ_Handler
 547                     	xdef	_brk
 548                     	xdef	_TIM2_UPD_OVF_IRQHandler
 549                     	xdef	_UART1_TX_IRQHandler
 550                     	xdef	_TIM4_UPD_OVF_IRQHandler
 551                     	xdef	_power_on_button_pressed
 552                     	xdef	_power_off_button_pressed
 553                     	xdef	_upKeyMightBePushed
 554                     	xdef	_downKeyMightBePushed
 555                     	xdef	_trigState
 556                     	xref	_stepping
 557                     	xref	_TIM2_Set
 558                     	xref.b	_ata_TimerFlag
 559                     	xref	_GPIO_ReadInputPin
 560                     	xref	_GPIO_WriteLow
 561                     	xref	_GPIO_WriteHigh
 562                     	xref.b	c_lreg
 563                     	xref.b	c_x
 564                     	xref.b	c_y
 583                     	end
