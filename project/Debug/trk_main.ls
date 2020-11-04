   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  58                     ; 37 void Init_Timer1_PWM(unsigned short Tcon,unsigned short Pscr)
  58                     ; 38 {	
  60                     	switch	.text
  61  0000               _Init_Timer1_PWM:
  65                     ; 89 }
  68  0000 81            	ret	
  93                     ; 94 void drive_BC(void)
  93                     ; 95 {
  94                     	switch	.text
  95  0001               _drive_BC:
  99                     ; 96    GPIO_WriteLow(GPIOC, GPIO_PIN_1);
 101  0001 4b02          	push	#2
 102  0003 ae500a        	ldw	x,#20490
 103  0006 cd0000        	call	_GPIO_WriteLow
 105  0009 84            	pop	a
 106                     ; 97    GPIO_WriteHigh(GPIOC, GPIO_PIN_2);
 108  000a 4b04          	push	#4
 109  000c ae500a        	ldw	x,#20490
 110  000f cd0000        	call	_GPIO_WriteHigh
 112  0012 84            	pop	a
 113                     ; 98    GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 115  0013 4b08          	push	#8
 116  0015 ae500a        	ldw	x,#20490
 117  0018 cd0000        	call	_GPIO_WriteLow
 119  001b 84            	pop	a
 120                     ; 114 }
 123  001c 81            	ret	
 148                     ; 116 void drive_BA(void)
 148                     ; 117 {
 149                     	switch	.text
 150  001d               _drive_BA:
 154                     ; 118    GPIO_WriteLow(GPIOC, GPIO_PIN_1);
 156  001d 4b02          	push	#2
 157  001f ae500a        	ldw	x,#20490
 158  0022 cd0000        	call	_GPIO_WriteLow
 160  0025 84            	pop	a
 161                     ; 119    GPIO_WriteHigh(GPIOC, GPIO_PIN_2);
 163  0026 4b04          	push	#4
 164  0028 ae500a        	ldw	x,#20490
 165  002b cd0000        	call	_GPIO_WriteHigh
 167  002e 84            	pop	a
 168                     ; 120    GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 170  002f 4b08          	push	#8
 171  0031 ae500a        	ldw	x,#20490
 172  0034 cd0000        	call	_GPIO_WriteLow
 174  0037 725f530a      	clr	21258
 175  003b 725f530b      	clr	21259
 176  003f 84            	pop	a
 177                     ; 127    TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
 179                     ; 128    TIM2->CCER2 = 0x00;  // Disable the Channels 3
 181                     ; 129    GPIO_WriteLow(GPIOD, GPIO_PIN_4);
 183  0040 4b10          	push	#16
 184  0042 ae500f        	ldw	x,#20495
 185  0045 cd0000        	call	_GPIO_WriteLow
 187  0048 84            	pop	a
 188                     ; 130    GPIO_WriteLow(GPIOD, GPIO_PIN_3);
 190  0049 4b08          	push	#8
 191  004b ae500f        	ldw	x,#20495
 192  004e cd0000        	call	_GPIO_WriteLow
 194  0051 84            	pop	a
 195                     ; 131    GPIO_WriteLow(GPIOA, GPIO_PIN_3);
 197  0052 4b08          	push	#8
 198  0054 ae5000        	ldw	x,#20480
 199  0057 cd0000        	call	_GPIO_WriteLow
 201  005a 3501530a      	mov	21258,#1
 202  005e 84            	pop	a
 203                     ; 132    TIM2->CCER1 = 0x01;  // Enable the Channel 1 & Low Polarity
 205                     ; 134 }
 208  005f 81            	ret	
 233                     ; 136 void drive_CA(void)
 233                     ; 137 {
 234                     	switch	.text
 235  0060               _drive_CA:
 239                     ; 138    GPIO_WriteLow(GPIOC, GPIO_PIN_1);
 241  0060 4b02          	push	#2
 242  0062 ae500a        	ldw	x,#20490
 243  0065 cd0000        	call	_GPIO_WriteLow
 245  0068 84            	pop	a
 246                     ; 139    GPIO_WriteLow(GPIOC, GPIO_PIN_2);
 248  0069 4b04          	push	#4
 249  006b ae500a        	ldw	x,#20490
 250  006e cd0000        	call	_GPIO_WriteLow
 252  0071 84            	pop	a
 253                     ; 140    GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
 255  0072 4b08          	push	#8
 256  0074 ae500a        	ldw	x,#20490
 257  0077 cd0000        	call	_GPIO_WriteHigh
 259  007a 84            	pop	a
 260                     ; 156 }
 263  007b 81            	ret	
 288                     ; 158 void drive_CB(void)
 288                     ; 159 {
 289                     	switch	.text
 290  007c               _drive_CB:
 294                     ; 160    GPIO_WriteLow(GPIOC, GPIO_PIN_1);
 296  007c 4b02          	push	#2
 297  007e ae500a        	ldw	x,#20490
 298  0081 cd0000        	call	_GPIO_WriteLow
 300  0084 84            	pop	a
 301                     ; 161    GPIO_WriteLow(GPIOC, GPIO_PIN_2);
 303  0085 4b04          	push	#4
 304  0087 ae500a        	ldw	x,#20490
 305  008a cd0000        	call	_GPIO_WriteLow
 307  008d 84            	pop	a
 308                     ; 162    GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
 310  008e 4b08          	push	#8
 311  0090 ae500a        	ldw	x,#20490
 312  0093 cd0000        	call	_GPIO_WriteHigh
 314  0096 725f530a      	clr	21258
 315  009a 725f530b      	clr	21259
 316  009e 84            	pop	a
 317                     ; 169    TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
 319                     ; 170    TIM2->CCER2 = 0x00;  // Disable the Channels 3
 321                     ; 171    GPIO_WriteLow(GPIOD, GPIO_PIN_4);
 323  009f 4b10          	push	#16
 324  00a1 ae500f        	ldw	x,#20495
 325  00a4 cd0000        	call	_GPIO_WriteLow
 327  00a7 84            	pop	a
 328                     ; 172    GPIO_WriteLow(GPIOD, GPIO_PIN_3);
 330  00a8 4b08          	push	#8
 331  00aa ae500f        	ldw	x,#20495
 332  00ad cd0000        	call	_GPIO_WriteLow
 334  00b0 84            	pop	a
 335                     ; 173    GPIO_WriteLow(GPIOA, GPIO_PIN_3);
 337  00b1 4b08          	push	#8
 338  00b3 ae5000        	ldw	x,#20480
 339  00b6 cd0000        	call	_GPIO_WriteLow
 341  00b9 3510530a      	mov	21258,#16
 342  00bd 84            	pop	a
 343                     ; 174    TIM2->CCER1 = 0x10;  // Enable the Channel 2 & Low Polarity
 345                     ; 176 }
 348  00be 81            	ret	
 373                     ; 178 void drive_AB(void)
 373                     ; 179 {
 374                     	switch	.text
 375  00bf               _drive_AB:
 379                     ; 180    GPIO_WriteHigh(GPIOC, GPIO_PIN_1);
 381  00bf 4b02          	push	#2
 382  00c1 ae500a        	ldw	x,#20490
 383  00c4 cd0000        	call	_GPIO_WriteHigh
 385  00c7 84            	pop	a
 386                     ; 181    GPIO_WriteLow(GPIOC, GPIO_PIN_2);
 388  00c8 4b04          	push	#4
 389  00ca ae500a        	ldw	x,#20490
 390  00cd cd0000        	call	_GPIO_WriteLow
 392  00d0 84            	pop	a
 393                     ; 182    GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 395  00d1 4b08          	push	#8
 396  00d3 ae500a        	ldw	x,#20490
 397  00d6 cd0000        	call	_GPIO_WriteLow
 399  00d9 84            	pop	a
 400                     ; 198 }
 403  00da 81            	ret	
 428                     ; 200 void drive_AC(void)
 428                     ; 201 {
 429                     	switch	.text
 430  00db               _drive_AC:
 434                     ; 202    GPIO_WriteHigh(GPIOC, GPIO_PIN_1);
 436  00db 4b02          	push	#2
 437  00dd ae500a        	ldw	x,#20490
 438  00e0 cd0000        	call	_GPIO_WriteHigh
 440  00e3 84            	pop	a
 441                     ; 203    GPIO_WriteLow(GPIOC, GPIO_PIN_2);
 443  00e4 4b04          	push	#4
 444  00e6 ae500a        	ldw	x,#20490
 445  00e9 cd0000        	call	_GPIO_WriteLow
 447  00ec 84            	pop	a
 448                     ; 204    GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 450  00ed 4b08          	push	#8
 451  00ef ae500a        	ldw	x,#20490
 452  00f2 cd0000        	call	_GPIO_WriteLow
 454  00f5 725f530a      	clr	21258
 455  00f9 725f530b      	clr	21259
 456  00fd 84            	pop	a
 457                     ; 211    TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
 459                     ; 212    TIM2->CCER2 = 0x00;  // Disable the Channels 3
 461                     ; 213    GPIO_WriteLow(GPIOD, GPIO_PIN_4);
 463  00fe 4b10          	push	#16
 464  0100 ae500f        	ldw	x,#20495
 465  0103 cd0000        	call	_GPIO_WriteLow
 467  0106 84            	pop	a
 468                     ; 214    GPIO_WriteLow(GPIOD, GPIO_PIN_3);
 470  0107 4b08          	push	#8
 471  0109 ae500f        	ldw	x,#20495
 472  010c cd0000        	call	_GPIO_WriteLow
 474  010f 84            	pop	a
 475                     ; 215    GPIO_WriteLow(GPIOA, GPIO_PIN_3);
 477  0110 4b08          	push	#8
 478  0112 ae5000        	ldw	x,#20480
 479  0115 cd0000        	call	_GPIO_WriteLow
 481  0118 3501530b      	mov	21259,#1
 482  011c 84            	pop	a
 483                     ; 216    TIM2->CCER2 = 0x01;  // Enable the Channel 3 & Low Polarity
 485                     ; 218 }
 488  011d 81            	ret	
 512                     ; 220 void drive_Allign(void)
 512                     ; 221 {
 513                     	switch	.text
 514  011e               _drive_Allign:
 518                     ; 222    drive_BA();
 521                     ; 223 }
 524  011e cc001d        	jp	_drive_BA
 548                     ; 225 void drive_AllignStep2(void)
 548                     ; 226 {
 549                     	switch	.text
 550  0121               _drive_AllignStep2:
 554                     ; 227    drive_CA();
 557                     ; 228 }
 560  0121 cc0060        	jp	_drive_CA
 563                     	bsct
 564  0000               _commutationSteps:
 565  0000 04            	dc.b	4
 566  0001               _allignmentCounter:
 567  0001 00            	dc.b	0
 568  0002               _allignmentPhase:
 569  0002 01            	dc.b	1
 570  0003               _testState:
 571  0003 00            	dc.b	0
 600                     ; 236 void stepping(void)
 600                     ; 237 {
 601                     	switch	.text
 602  0124               _stepping:
 606                     ; 238    if(testState == 2)
 608  0124 b603          	ld	a,_testState
 609  0126 a102          	cp	a,#2
 610  0128 2644          	jrne	L351
 611                     ; 240       switch(commutationSteps)
 613  012a b600          	ld	a,_commutationSteps
 615                     ; 270             break;
 616  012c 4a            	dec	a
 617  012d 2710          	jreq	L721
 618  012f 4a            	dec	a
 619  0130 2715          	jreq	L131
 620  0132 4a            	dec	a
 621  0133 271a          	jreq	L331
 622  0135 4a            	dec	a
 623  0136 271f          	jreq	L531
 624  0138 4a            	dec	a
 625  0139 2724          	jreq	L731
 626  013b 4a            	dec	a
 627  013c 2729          	jreq	L141
 629  013e 81            	ret	
 630  013f               L721:
 631                     ; 242          case step_BC:
 631                     ; 243             drive_BC();
 633  013f cd0001        	call	_drive_BC
 635                     ; 244             commutationSteps = step_BA;
 637  0142 35020000      	mov	_commutationSteps,#2
 638                     ; 245             break;
 641  0146 81            	ret	
 642  0147               L131:
 643                     ; 247          case step_BA:
 643                     ; 248             drive_BA();
 645  0147 cd001d        	call	_drive_BA
 647                     ; 249             commutationSteps = step_CA;
 649  014a 35030000      	mov	_commutationSteps,#3
 650                     ; 250             break;
 653  014e 81            	ret	
 654  014f               L331:
 655                     ; 252          case step_CA:
 655                     ; 253             drive_CA();
 657  014f cd0060        	call	_drive_CA
 659                     ; 254             commutationSteps = step_CB;
 661  0152 35040000      	mov	_commutationSteps,#4
 662                     ; 255             break;
 665  0156 81            	ret	
 666  0157               L531:
 667                     ; 257          case step_CB:
 667                     ; 258             drive_CB();
 669  0157 cd007c        	call	_drive_CB
 671                     ; 259             commutationSteps = step_AB;
 673  015a 35050000      	mov	_commutationSteps,#5
 674                     ; 260             break;
 677  015e 81            	ret	
 678  015f               L731:
 679                     ; 262          case step_AB:
 679                     ; 263             drive_AB();
 681  015f cd00bf        	call	_drive_AB
 683                     ; 264             commutationSteps = step_AC;
 685  0162 35060000      	mov	_commutationSteps,#6
 686                     ; 265             break;
 689  0166 81            	ret	
 690  0167               L141:
 691                     ; 267          case step_AC:
 691                     ; 268             drive_AC();
 693  0167 cd00db        	call	_drive_AC
 695                     ; 269             commutationSteps = step_BC;
 697  016a 35010000      	mov	_commutationSteps,#1
 698                     ; 270             break;
 700  016e               L351:
 701                     ; 273 }
 704  016e 81            	ret	
 731                     ; 276 unsigned long testThread(void)
 731                     ; 277 {
 732                     	switch	.text
 733  016f               _testThread:
 737                     ; 278    if(testState == 0)
 739  016f b603          	ld	a,_testState
 740  0171 2618          	jrne	L171
 741                     ; 280       drive_AllignStep2();
 743  0173 adac          	call	_drive_AllignStep2
 745                     ; 281       testState = 1;
 747  0175 35010003      	mov	_testState,#1
 748                     ; 282       GPIO_WriteHigh(GPIOB, GPIO_PIN_7);
 750  0179 4b80          	push	#128
 751  017b ae5005        	ldw	x,#20485
 752  017e cd0000        	call	_GPIO_WriteHigh
 754  0181 ae03e8        	ldw	x,#1000
 755  0184 bf02          	ldw	c_lreg+2,x
 756  0186 5f            	clrw	x
 757  0187 bf00          	ldw	c_lreg,x
 758  0189 84            	pop	a
 760                     ; 290    return msg_ProcessAfter1s;
 764  018a 81            	ret	
 765  018b               L171:
 766                     ; 286       GPIO_WriteLow(GPIOB, GPIO_PIN_7);
 768  018b 4b80          	push	#128
 769  018d ae5005        	ldw	x,#20485
 770  0190 cd0000        	call	_GPIO_WriteLow
 772  0193 35020003      	mov	_testState,#2
 773  0197 aeea6d        	ldw	x,#60013
 774  019a bf02          	ldw	c_lreg+2,x
 775  019c 5f            	clrw	x
 776  019d bf00          	ldw	c_lreg,x
 777  019f 84            	pop	a
 778                     ; 287       testState = 2;
 780                     ; 288       return msg_ProcessStopped;
 784  01a0 81            	ret	
 787                     	bsct
 788  0004               _mainTimerLoad:
 789  0004 4e20          	dc.w	20000
 790  0006               _lowSideLoad:
 791  0006 03e8          	dc.w	1000
 792  0008               _lowSideDuty:
 793  0008 000f          	dc.w	15
 815                     ; 300 void TIM1_Settings(void)
 815                     ; 301 {
 816                     	switch	.text
 817  01a1               _TIM1_Settings:
 821                     ; 302    TIM1->IER   = 0x01;                       
 823  01a1 35015254      	mov	21076,#1
 824                     ; 303    TIM1->PSCRH = 0x00;
 826  01a5 725f5260      	clr	21088
 827                     ; 304    TIM1->PSCRL = 0x02;                      
 829  01a9 35025261      	mov	21089,#2
 830                     ; 305    TIM1->ARRH  = (unsigned char)(mainTimerLoad >> 8) & 0xFF;
 832  01ad 5500045262    	mov	21090,_mainTimerLoad
 833                     ; 306    TIM1->ARRL  = (unsigned char)mainTimerLoad;                  
 835  01b2 5500055263    	mov	21091,_mainTimerLoad+1
 836                     ; 307    TIM1->CCR2H = 0x00;
 838  01b7 725f5267      	clr	21095
 839                     ; 308    TIM1->CCR2L = 0x00;                        
 841  01bb 725f5268      	clr	21096
 842                     ; 309    TIM1->CR1 = 0x05;                    
 844  01bf 35055250      	mov	21072,#5
 845                     ; 310 }
 848  01c3 81            	ret	
 883                     ; 313 void setLowSideLoad(unsigned short load)
 883                     ; 314 {
 884                     	switch	.text
 885  01c4               _setLowSideLoad:
 889                     ; 315    lowSideLoad = load;
 891  01c4 bf06          	ldw	_lowSideLoad,x
 892                     ; 316 }
 895  01c6 81            	ret	
 919                     ; 318 unsigned short getLowSideLoad(void)
 919                     ; 319 {
 920                     	switch	.text
 921  01c7               _getLowSideLoad:
 925                     ; 320    return lowSideLoad;
 927  01c7 be06          	ldw	x,_lowSideLoad
 930  01c9 81            	ret	
 965                     ; 323 void setLowSideDuty(unsigned short duty)
 965                     ; 324 {
 966                     	switch	.text
 967  01ca               _setLowSideDuty:
 971                     ; 325    lowSideDuty = duty;
 973  01ca bf08          	ldw	_lowSideDuty,x
 974                     ; 326 }
 977  01cc 81            	ret	
1001                     ; 328 unsigned short getLowSideDuty(void)
1001                     ; 329 {
1002                     	switch	.text
1003  01cd               _getLowSideDuty:
1007                     ; 330    return lowSideDuty;
1009  01cd be08          	ldw	x,_lowSideDuty
1012  01cf 81            	ret	
1037                     ; 333 unsigned short getResult(void)
1037                     ; 334 {   
1038                     	switch	.text
1039  01d0               _getResult:
1041  01d0 89            	pushw	x
1042       00000002      OFST:	set	2
1045                     ; 335    return lowSideLoad - ((lowSideLoad*lowSideDuty) / 100);
1047  01d1 be06          	ldw	x,_lowSideLoad
1048  01d3 90be08        	ldw	y,_lowSideDuty
1049  01d6 cd0000        	call	c_imul
1051  01d9 a664          	ld	a,#100
1052  01db 62            	div	x,a
1053  01dc 1f01          	ldw	(OFST-1,sp),x
1055  01de be06          	ldw	x,_lowSideLoad
1056  01e0 72f001        	subw	x,(OFST-1,sp)
1059  01e3 5b02          	addw	sp,#2
1060  01e5 81            	ret	
1112                     ; 339 void Init_Timer2(unsigned short load, unsigned short duty) 
1112                     ; 340 {
1113                     	switch	.text
1114  01e6               _Init_Timer2:
1116  01e6 89            	pushw	x
1117  01e7 5204          	subw	sp,#4
1118       00000004      OFST:	set	4
1121                     ; 341    unsigned short loadduty = load - ((load * duty) / 100);
1123  01e9 1609          	ldw	y,(OFST+5,sp)
1124  01eb cd0000        	call	c_imul
1126  01ee a664          	ld	a,#100
1127  01f0 62            	div	x,a
1128  01f1 1f01          	ldw	(OFST-3,sp),x
1130  01f3 1e05          	ldw	x,(OFST+1,sp)
1131  01f5 72f001        	subw	x,(OFST-3,sp)
1132  01f8 1f03          	ldw	(OFST-1,sp),x
1134                     ; 343 	TIM2->PSCR = 0x00;//0x03;    
1136  01fa 725f530e      	clr	21262
1137                     ; 344    TIM2->ARRH = (unsigned char)(load >> 8); 
1139  01fe 7b05          	ld	a,(OFST+1,sp)
1140  0200 c7530f        	ld	21263,a
1141                     ; 345    TIM2->ARRL = (unsigned char)load;   
1143  0203 7b06          	ld	a,(OFST+2,sp)
1144  0205 c75310        	ld	21264,a
1145                     ; 347    TIM2->CCER1 = 0x00;  // Disable the Channels 1-2
1147  0208 725f530a      	clr	21258
1148                     ; 350    TIM2->CCER2 = 0x00;  // Disable the Channels 3
1150  020c 725f530b      	clr	21259
1151                     ; 353    TIM2->CCMR1 = 0x78;  // PWM Mode2(CH1) - Preload  Enabled
1153  0210 35785307      	mov	21255,#120
1154                     ; 354    TIM2->CCMR2 = 0x78;  // PWM Mode2(CH2) - Preload  Enabled
1156  0214 35785308      	mov	21256,#120
1157                     ; 355    TIM2->CCMR3 = 0x78;  // PWM Mode2(CH3) - Preload  Enabled
1159  0218 35785309      	mov	21257,#120
1160                     ; 357    TIM2->CCR1H = (unsigned char)(loadduty >> 8); 
1162  021c 7b03          	ld	a,(OFST-1,sp)
1163  021e c75311        	ld	21265,a
1164                     ; 358    TIM2->CCR1L = (unsigned char)loadduty;    
1166  0221 7b04          	ld	a,(OFST+0,sp)
1167  0223 c75312        	ld	21266,a
1168                     ; 360    TIM2->CCR2H = (unsigned char)(loadduty >> 8); 
1170  0226 7b03          	ld	a,(OFST-1,sp)
1171  0228 c75313        	ld	21267,a
1172                     ; 361    TIM2->CCR2L = (unsigned char)loadduty;
1174  022b 7b04          	ld	a,(OFST+0,sp)
1175  022d c75314        	ld	21268,a
1176                     ; 363    TIM2->CCR3H = (unsigned char)(loadduty >> 8); 
1178  0230 7b03          	ld	a,(OFST-1,sp)
1179  0232 c75315        	ld	21269,a
1180                     ; 364    TIM2->CCR3L = (unsigned char)loadduty;
1182  0235 7b04          	ld	a,(OFST+0,sp)
1183  0237 c75316        	ld	21270,a
1184                     ; 366    TIM2->CR1  |= 0x80;  // AutoReload aktif durumda.
1186  023a 721e5300      	bset	21248,#7
1187                     ; 367    TIM2->CR1  |= 0x01;  // Timer çalýþmaya baþlýyor.
1189  023e 72105300      	bset	21248,#0
1190                     ; 369 }
1193  0242 5b06          	addw	sp,#6
1194  0244 81            	ret	
1230                     ; 371 void main(void)
1230                     ; 372 {
1231                     	switch	.text
1232  0245               _main:
1236                     ; 373    InitRegisters();
1238  0245 cd0000        	call	_InitRegisters
1240                     ; 374    trk_MessageInit();
1242  0248 cd0000        	call	_trk_MessageInit
1244                     ; 375    ata_Init();
1246  024b cd0000        	call	_ata_Init
1248                     ; 376    trk_appInit();
1250  024e cd0000        	call	_trk_appInit
1252                     ; 378    TIM1_Settings();
1254  0251 cd01a1        	call	_TIM1_Settings
1256                     ; 379    Init_Timer2(getLowSideLoad(), getLowSideDuty());
1258  0254 cd01cd        	call	_getLowSideDuty
1260  0257 89            	pushw	x
1261  0258 cd01c7        	call	_getLowSideLoad
1263  025b ad89          	call	_Init_Timer2
1265  025d 85            	popw	x
1266                     ; 380    drive_Allign();
1268  025e cd011e        	call	_drive_Allign
1270                     ; 381    trk_PushMessage(&testThread,msg_ProcessAfter1s);
1272  0261 ae03e8        	ldw	x,#1000
1273  0264 89            	pushw	x
1274  0265 ae016f        	ldw	x,#_testThread
1275  0268 cd0000        	call	_trk_PushMessage
1277  026b 85            	popw	x
1278                     ; 382    ata_Run();
1281                     ; 383 }
1284  026c cc0000        	jp	_ata_Run
1362                     	xdef	_Init_Timer2
1363                     	xdef	_getResult
1364                     	xdef	_getLowSideDuty
1365                     	xdef	_setLowSideDuty
1366                     	xdef	_getLowSideLoad
1367                     	xdef	_setLowSideLoad
1368                     	xdef	_lowSideDuty
1369                     	xdef	_lowSideLoad
1370                     	xdef	_mainTimerLoad
1371                     	xdef	_testThread
1372                     	xdef	_testState
1373                     	xdef	_allignmentPhase
1374                     	xdef	_allignmentCounter
1375                     	xdef	_commutationSteps
1376                     	xdef	_drive_AllignStep2
1377                     	xdef	_drive_Allign
1378                     	xdef	_drive_AC
1379                     	xdef	_drive_AB
1380                     	xdef	_drive_CB
1381                     	xdef	_drive_CA
1382                     	xdef	_drive_BA
1383                     	xdef	_drive_BC
1384                     	xdef	_Init_Timer1_PWM
1385                     	xref	_trk_appInit
1386                     	xref	_trk_MessageInit
1387                     	xref	_trk_PushMessage
1388                     	xref	_GPIO_WriteLow
1389                     	xref	_GPIO_WriteHigh
1390                     	xdef	_TIM1_Settings
1391                     	xref	_InitRegisters
1392                     	xref	_ata_Run
1393                     	xref	_ata_Init
1394                     	xdef	_stepping
1395                     	xdef	_main
1396                     	xref.b	c_lreg
1397                     	xref.b	c_x
1416                     	xref	c_imul
1417                     	end
