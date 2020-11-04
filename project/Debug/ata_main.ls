   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  19                     	bsct
  20  0000               _ata_Let_ZeroCrossHandle:
  21  0000 00            	dc.b	0
  50                     ; 16 void WatchdogKick(void)
  50                     ; 17 {
  52                     	switch	.text
  53  0000               _WatchdogKick:
  57                     ; 18    IWDG->KR = (unsigned char)0xCC; /* Write Access */   
  59  0000 35cc50e0      	mov	20704,#204
  60                     ; 19    IWDG->KR = (unsigned char)0x55; /* Write Access */   
  62  0004 355550e0      	mov	20704,#85
  63                     ; 20    IWDG->PR = (unsigned char)0x06;
  65  0008 350650e1      	mov	20705,#6
  66                     ; 21    IWDG->RLR = (unsigned char)0xFF;
  68  000c 35ff50e2      	mov	20706,#255
  69                     ; 22    IWDG->KR = 0xAA;
  71  0010 35aa50e0      	mov	20704,#170
  72                     ; 23 }
  75  0014 81            	ret	
 100                     ; 25 unsigned long ata_KickWatchdogThread(void)
 100                     ; 26 {
 101                     	switch	.text
 102  0015               _ata_KickWatchdogThread:
 106                     ; 27    WatchdogKick();
 108  0015 ade9          	call	_WatchdogKick
 110                     ; 28    return msg_ProcessAfter1ms * 10;
 112  0017 ae000a        	ldw	x,#10
 113  001a bf02          	ldw	c_lreg+2,x
 114  001c 5f            	clrw	x
 115  001d bf00          	ldw	c_lreg,x
 118  001f 81            	ret	
 144                     ; 31 void ata_WatchdogInit(void)
 144                     ; 32 {
 145                     	switch	.text
 146  0020               _ata_WatchdogInit:
 150                     ; 33    trk_PushMessage(&ata_KickWatchdogThread, msg_ProcessAfter1ms*5);
 152  0020 ae0005        	ldw	x,#5
 153  0023 89            	pushw	x
 154  0024 ae0015        	ldw	x,#_ata_KickWatchdogThread
 155  0027 cd0000        	call	_trk_PushMessage
 157  002a 85            	popw	x
 158                     ; 34 }
 161  002b 81            	ret	
 186                     ; 36 unsigned long ata_ZC_Control_Thread(void)
 186                     ; 37 {
 187                     	switch	.text
 188  002c               _ata_ZC_Control_Thread:
 192                     ; 38    ata_Let_ZeroCrossHandle = TRUE;
 194  002c 35010000      	mov	_ata_Let_ZeroCrossHandle,#1
 195                     ; 39    return msg_ProcessStopped;
 197  0030 aeea6d        	ldw	x,#60013
 198  0033 bf02          	ldw	c_lreg+2,x
 199  0035 5f            	clrw	x
 200  0036 bf00          	ldw	c_lreg,x
 203  0038 81            	ret	
 227                     ; 42 unsigned char ata_Get_ZC_Handle(void)
 227                     ; 43 {
 228                     	switch	.text
 229  0039               _ata_Get_ZC_Handle:
 233                     ; 44    return ata_Let_ZeroCrossHandle;
 235  0039 b600          	ld	a,_ata_Let_ZeroCrossHandle
 238  003b 81            	ret	
 267                     ; 47 void ata_Init(void)
 267                     ; 48 {
 268                     	switch	.text
 269  003c               _ata_Init:
 273                     ; 50    ata_StartTimer4();
 275  003c c65340        	ld	a,21312
 276  003f aa05          	or	a,#5
 277  0041 c75340        	ld	21312,a
 278                     ; 51    ata_SetInterruptStatus(EnableAllInterrupts);
 280  0044 a601          	ld	a,#1
 281  0046 cd0000        	call	_ata_SetInterruptStatus
 283                     ; 52    ata_WatchdogInit();
 285  0049 add5          	call	_ata_WatchdogInit
 287                     ; 53    ata_KeyInit();
 289  004b cd0000        	call	_ata_KeyInit
 291                     ; 54    trk_PushMessage(&ata_ZC_Control_Thread, msg_ProcessAfter1s);
 293  004e ae03e8        	ldw	x,#1000
 294  0051 89            	pushw	x
 295  0052 ae002c        	ldw	x,#_ata_ZC_Control_Thread
 296  0055 cd0000        	call	_trk_PushMessage
 298  0058 85            	popw	x
 299                     ; 55 }
 302  0059 81            	ret	
 325                     ; 57 void ata_1mstimer(void)
 325                     ; 58 {
 326                     	switch	.text
 327  005a               _ata_1mstimer:
 331                     ; 59 }
 334  005a 81            	ret	
 359                     ; 61 void ata_Run(void)
 359                     ; 62 {
 360                     	switch	.text
 361  005b               _ata_Run:
 365  005b               L111:
 366                     ; 65       msg_callback(msg_ProcessMessages, msg_ProcessInstant); //msg_ProcessForever is used only for msg_ProcessMessages
 368  005b aeea71        	ldw	x,#60017
 369  005e 89            	pushw	x
 370  005f a601          	ld	a,#1
 371  0061 92cd00        	call	[_msg_callback.w]
 373  0064 3d00          	tnz	_ata_TimerFlag
 374  0066 85            	popw	x
 375                     ; 66       if(ata_TimerFlag >= 1)
 377  0067 27f2          	jreq	L111
 378                     ; 68          msg_callback(msg_1msTimer, msg_ProcessInstant);
 380  0069 aeea71        	ldw	x,#60017
 381  006c 89            	pushw	x
 382  006d a602          	ld	a,#2
 383  006f 92cd00        	call	[_msg_callback.w]
 385  0072 3a00          	dec	_ata_TimerFlag
 386  0074 85            	popw	x
 387                     ; 69          ata_TimerFlag--;
 389  0075 20e4          	jra	L111
 423                     	xdef	_ata_1mstimer
 424                     	xdef	_ata_ZC_Control_Thread
 425                     	xdef	_ata_WatchdogInit
 426                     	xdef	_ata_KickWatchdogThread
 427                     	xdef	_ata_Let_ZeroCrossHandle
 428                     	xref	_ata_KeyInit
 429                     	xref	_ata_SetInterruptStatus
 430                     	xref.b	_msg_callback
 431                     	xref	_trk_PushMessage
 432                     	xdef	_ata_Get_ZC_Handle
 433                     	xdef	_WatchdogKick
 434                     	xdef	_ata_Run
 435                     	xdef	_ata_Init
 436                     	switch	.ubsct
 437  0000               _ata_TimerFlag:
 438  0000 00            	ds.b	1
 439                     	xdef	_ata_TimerFlag
 440                     	xref.b	c_lreg
 460                     	end
