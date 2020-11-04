   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  48                     ; 11 void IWDG_Settings(void)
  48                     ; 12 {
  50                     	switch	.text
  51  0000               _IWDG_Settings:
  55                     ; 13    IWDG->KR = 0xCC;            // enable and start the wdog counter at first!
  57  0000 35cc50e0      	mov	20704,#204
  58                     ; 14    IWDG->KR = 0x55;            // unlock wdog configuration registers
  60  0004 355550e0      	mov	20704,#85
  61                     ; 15    IWDG->PR = 0x06;            // divider /256
  63  0008 350650e1      	mov	20705,#6
  64                     ; 16    IWDG->RLR = 0xFF;           // maximum length period
  66  000c 35ff50e2      	mov	20706,#255
  67                     ; 17    IWDG->KR = 0xAA;            // lock wdog registers & reload the wdog counter
  69  0010 35aa50e0      	mov	20704,#170
  70                     ; 18 }
  73  0014 81            	ret	
  99                     ; 22 void InitRegisters(void)
  99                     ; 23 {
 100                     	switch	.text
 101  0015               _InitRegisters:
 105                     ; 24    CLK->CKDIVR = 0x00;                
 107  0015 725f50c6      	clr	20678
 108                     ; 26    Init_GPIO();
 110  0019 ad03          	call	_Init_GPIO
 112                     ; 27    disableInterrupts();
 115  001b 9b            	sim	
 117                     ; 29    TIM4_Settings();
 121                     ; 42 }
 124  001c 205b          	jp	_TIM4_Settings
 149                     ; 46 void Init_GPIO(void)
 149                     ; 47 {
 150                     	switch	.text
 151  001e               _Init_GPIO:
 155                     ; 71    GPIO_Init(GPIOC, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
 157  001e 4be0          	push	#224
 158  0020 4b02          	push	#2
 159  0022 ae500a        	ldw	x,#20490
 160  0025 cd0000        	call	_GPIO_Init
 162  0028 85            	popw	x
 163                     ; 72    GPIO_Init(GPIOC, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST);
 165  0029 4be0          	push	#224
 166  002b 4b04          	push	#4
 167  002d ae500a        	ldw	x,#20490
 168  0030 cd0000        	call	_GPIO_Init
 170  0033 85            	popw	x
 171                     ; 73    GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 173  0034 4be0          	push	#224
 174  0036 4b08          	push	#8
 175  0038 ae500a        	ldw	x,#20490
 176  003b cd0000        	call	_GPIO_Init
 178  003e 85            	popw	x
 179                     ; 75    GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 181  003f 4be0          	push	#224
 182  0041 4b08          	push	#8
 183  0043 ae500f        	ldw	x,#20495
 184  0046 cd0000        	call	_GPIO_Init
 186  0049 85            	popw	x
 187                     ; 76    GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST);
 189  004a 4be0          	push	#224
 190  004c 4b10          	push	#16
 191  004e ae500f        	ldw	x,#20495
 192  0051 cd0000        	call	_GPIO_Init
 194  0054 85            	popw	x
 195                     ; 77    GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 197  0055 4be0          	push	#224
 198  0057 4b08          	push	#8
 199  0059 ae5000        	ldw	x,#20480
 200  005c cd0000        	call	_GPIO_Init
 202  005f 85            	popw	x
 203                     ; 80    GPIO_Init(GPIOB, GPIO_PIN_7, GPIO_MODE_OUT_PP_LOW_FAST);
 205  0060 4be0          	push	#224
 206  0062 4b80          	push	#128
 207  0064 ae5005        	ldw	x,#20485
 208  0067 cd0000        	call	_GPIO_Init
 210  006a 85            	popw	x
 211                     ; 81    GPIO_Init(GPIOB, GPIO_PIN_6, GPIO_MODE_OUT_PP_LOW_FAST);
 213  006b 4be0          	push	#224
 214  006d 4b40          	push	#64
 215  006f ae5005        	ldw	x,#20485
 216  0072 cd0000        	call	_GPIO_Init
 218  0075 85            	popw	x
 219                     ; 86    EXTI_DeInit();
 222                     ; 89 }
 225  0076 cc0000        	jp	_EXTI_DeInit
 248                     ; 93 void TIM4_Settings(void)
 248                     ; 94 {
 249                     	switch	.text
 250  0079               _TIM4_Settings:
 254                     ; 95    TIM4->CR1 |= 0x05;                       // URS = 1 update event only if overflow occurs, CEN = 1 counter enable
 256  0079 c65340        	ld	a,21312
 257  007c aa05          	or	a,#5
 258  007e c75340        	ld	21312,a
 259                     ; 96    TIM4->IER |= 0x01;                          // UIE = 1 update interrupt enable
 261  0081 72105343      	bset	21315,#0
 262                     ; 97    TIM4->PSCR = 0x06;                      // prescaler = 32
 264  0085 35065347      	mov	21319,#6
 265                     ; 98    TIM4->ARR = 500;                            // auto reload value is 250
 267  0089 35f45348      	mov	21320,#244
 268                     ; 99 }
 271  008d 81            	ret	
 323                     ; 104 void TIM2_Set(unsigned short ms)
 323                     ; 105 {
 324                     	switch	.text
 325  008e               _TIM2_Set:
 327  008e 5203          	subw	sp,#3
 328       00000003      OFST:	set	3
 331                     ; 106     unsigned char pscr = 5;
 333                     ; 107     unsigned short cntr = 25*ms;
 335  0090 a619          	ld	a,#25
 336  0092 cd0000        	call	c_bmulx
 338  0095 1f02          	ldw	(OFST-1,sp),x
 340                     ; 110     TIM2->CR1 |= 0x05;                       // URS = 1 update event only if overflow occurs, CEN = 1 counter enable
 342  0097 c65300        	ld	a,21248
 343  009a aa05          	or	a,#5
 344  009c c75300        	ld	21248,a
 345                     ; 111     TIM2->IER |= 0x00;                          // UIE = 1 update interrupt enable
 347  009f c65303        	ld	a,21251
 348                     ; 112     TIM2->PSCR = pscr;    // prescaler = 32              
 350  00a2 3505530e      	mov	21262,#5
 351                     ; 113     TIM2->ARRH = cntr >> 8;    // auto reload value is 2000              
 353  00a6 7b02          	ld	a,(OFST-1,sp)
 354  00a8 c7530f        	ld	21263,a
 355                     ; 114     TIM2->ARRL = cntr;                    //default value is 8ms
 357  00ab 7b03          	ld	a,(OFST+0,sp)
 358  00ad c75310        	ld	21264,a
 359                     ; 115 }
 362  00b0 5b03          	addw	sp,#3
 363  00b2 81            	ret	
 386                     ; 117 void TIM2_Settings(void)
 386                     ; 118 {
 387                     	switch	.text
 388  00b3               _TIM2_Settings:
 392                     ; 119     TIM2->CR1 |= 0x05;                       // URS = 1 update event only if overflow occurs, CEN = 1 counter enable
 394  00b3 c65300        	ld	a,21248
 395  00b6 aa05          	or	a,#5
 396  00b8 c75300        	ld	21248,a
 397                     ; 120     TIM2->IER &= 0x00;                          // UIE = 1 update interrupt enable
 399  00bb 725f5303      	clr	21251
 400                     ; 121     TIM2->PSCR = 0x05;    // prescaler = 32              
 402  00bf 3505530e      	mov	21262,#5
 403                     ; 122     TIM2->ARRH = 0x07;    // auto reload value is 2000              
 405  00c3 3507530f      	mov	21263,#7
 406                     ; 123     TIM2->ARRL = 0xD0;                    //default value is 8ms
 408  00c7 35d05310      	mov	21264,#208
 409                     ; 124 }
 412  00cb 81            	ret	
 446                     ; 131 void TIM1_Set(unsigned short ms)
 446                     ; 132 {
 447                     	switch	.text
 448  00cc               _TIM1_Set:
 452                     ; 133    TIM1->IER |= TIM1_IER_UIE;              //UIE = 0 update interrupt disable
 454  00cc 72105254      	bset	21076,#0
 455                     ; 134    TIM1->PSCRH = 0x00;
 457  00d0 725f5260      	clr	21088
 458                     ; 135    TIM1->PSCRL = 0x05;                     
 460  00d4 35055261      	mov	21089,#5
 461                     ; 136    TIM1->ARRH =  0x00;
 463  00d8 725f5262      	clr	21090
 464                     ; 137    TIM1->ARRL =  0xFF;                            
 466  00dc 35ff5263      	mov	21091,#255
 467                     ; 138    TIM1->CCR2H = 0x00;
 469  00e0 725f5267      	clr	21095
 470                     ; 139    TIM1->CCR2L = 0x00;                        
 472  00e4 725f5268      	clr	21096
 473                     ; 140    TIM1->CR1 = 0x05;  
 475  00e8 35055250      	mov	21072,#5
 476                     ; 141 }
 479  00ec 81            	ret	
 492                     	xdef	_IWDG_Settings
 493                     	xdef	_TIM1_Set
 494                     	xdef	_TIM2_Settings
 495                     	xdef	_TIM2_Set
 496                     	xdef	_TIM4_Settings
 497                     	xdef	_Init_GPIO
 498                     	xdef	_InitRegisters
 499                     	xref	_GPIO_Init
 500                     	xref	_EXTI_DeInit
 501                     	xref.b	c_x
 520                     	xref	c_bmulx
 521                     	end
