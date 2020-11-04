   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  47                     ; 41 void TIM4_DeInit(void)
  47                     ; 42 {
  49                     	switch	.text
  50  0000               _TIM4_DeInit:
  54                     ; 43     TIM4->CR1 = TIM4_CR1_RESET_VALUE;
  56  0000 725f5340      	clr	21312
  57                     ; 44     TIM4->IER = TIM4_IER_RESET_VALUE;
  59  0004 725f5343      	clr	21315
  60                     ; 45     TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
  62  0008 725f5346      	clr	21318
  63                     ; 46     TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
  65  000c 725f5347      	clr	21319
  66                     ; 47     TIM4->ARR = TIM4_ARR_RESET_VALUE;
  68  0010 35ff5348      	mov	21320,#255
  69                     ; 48     TIM4->SR1 = TIM4_SR1_RESET_VALUE;
  71  0014 725f5344      	clr	21316
  72                     ; 49 }
  75  0018 81            	ret	
 181                     ; 57 void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, u8 TIM4_Period)
 181                     ; 58 {
 182                     	switch	.text
 183  0019               _TIM4_TimeBaseInit:
 187                     ; 60     assert_param(IS_TIM4_PRESCALER_OK(TIM4_Prescaler));
 189                     ; 62     TIM4->PSCR = (u8)(TIM4_Prescaler);
 191  0019 9e            	ld	a,xh
 192  001a c75347        	ld	21319,a
 193                     ; 64     TIM4->ARR = (u8)(TIM4_Period);
 195  001d 9f            	ld	a,xl
 196  001e c75348        	ld	21320,a
 197                     ; 65 }
 200  0021 81            	ret	
 255                     ; 75 void TIM4_Cmd(FunctionalState NewState)
 255                     ; 76 {
 256                     	switch	.text
 257  0022               _TIM4_Cmd:
 261                     ; 78     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 263                     ; 81     if (NewState != DISABLE)
 265  0022 4d            	tnz	a
 266  0023 2705          	jreq	L511
 267                     ; 83         TIM4->CR1 |= TIM4_CR1_CEN;
 269  0025 72105340      	bset	21312,#0
 272  0029 81            	ret	
 273  002a               L511:
 274                     ; 87         TIM4->CR1 &= (u8)(~TIM4_CR1_CEN);
 276  002a 72115340      	bres	21312,#0
 277                     ; 89 }
 280  002e 81            	ret	
 338                     ; 101 void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
 338                     ; 102 {
 339                     	switch	.text
 340  002f               _TIM4_ITConfig:
 342  002f 89            	pushw	x
 343       00000000      OFST:	set	0
 346                     ; 104     assert_param(IS_TIM4_IT_OK(TIM4_IT));
 348                     ; 105     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 350                     ; 107     if (NewState != DISABLE)
 352  0030 9f            	ld	a,xl
 353  0031 4d            	tnz	a
 354  0032 2706          	jreq	L151
 355                     ; 110         TIM4->IER |= (u8)TIM4_IT;
 357  0034 9e            	ld	a,xh
 358  0035 ca5343        	or	a,21315
 360  0038 2006          	jra	L351
 361  003a               L151:
 362                     ; 115         TIM4->IER &= (u8)(~TIM4_IT);
 364  003a 7b01          	ld	a,(OFST+1,sp)
 365  003c 43            	cpl	a
 366  003d c45343        	and	a,21315
 367  0040               L351:
 368  0040 c75343        	ld	21315,a
 369                     ; 117 }
 372  0043 85            	popw	x
 373  0044 81            	ret	
 409                     ; 125 void TIM4_UpdateDisableConfig(FunctionalState NewState)
 409                     ; 126 {
 410                     	switch	.text
 411  0045               _TIM4_UpdateDisableConfig:
 415                     ; 128     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 417                     ; 131     if (NewState != DISABLE)
 419  0045 4d            	tnz	a
 420  0046 2705          	jreq	L371
 421                     ; 133         TIM4->CR1 |= TIM4_CR1_UDIS;
 423  0048 72125340      	bset	21312,#1
 426  004c 81            	ret	
 427  004d               L371:
 428                     ; 137         TIM4->CR1 &= (u8)(~TIM4_CR1_UDIS);
 430  004d 72135340      	bres	21312,#1
 431                     ; 139 }
 434  0051 81            	ret	
 492                     ; 149 void TIM4_UpdateRequestConfig(TIM4_UpdateSource_TypeDef TIM4_UpdateSource)
 492                     ; 150 {
 493                     	switch	.text
 494  0052               _TIM4_UpdateRequestConfig:
 498                     ; 152     assert_param(IS_TIM4_UPDATE_SOURCE_OK(TIM4_UpdateSource));
 500                     ; 155     if (TIM4_UpdateSource != TIM4_UPDATESOURCE_GLOBAL)
 502  0052 4d            	tnz	a
 503  0053 2705          	jreq	L522
 504                     ; 157         TIM4->CR1 |= TIM4_CR1_URS;
 506  0055 72145340      	bset	21312,#2
 509  0059 81            	ret	
 510  005a               L522:
 511                     ; 161         TIM4->CR1 &= (u8)(~TIM4_CR1_URS);
 513  005a 72155340      	bres	21312,#2
 514                     ; 163 }
 517  005e 81            	ret	
 574                     ; 173 void TIM4_SelectOnePulseMode(TIM4_OPMode_TypeDef TIM4_OPMode)
 574                     ; 174 {
 575                     	switch	.text
 576  005f               _TIM4_SelectOnePulseMode:
 580                     ; 176     assert_param(IS_TIM4_OPM_MODE_OK(TIM4_OPMode));
 582                     ; 179     if (TIM4_OPMode != TIM4_OPMODE_REPETITIVE)
 584  005f 4d            	tnz	a
 585  0060 2705          	jreq	L752
 586                     ; 181         TIM4->CR1 |= TIM4_CR1_OPM;
 588  0062 72165340      	bset	21312,#3
 591  0066 81            	ret	
 592  0067               L752:
 593                     ; 185         TIM4->CR1 &= (u8)(~TIM4_CR1_OPM);
 595  0067 72175340      	bres	21312,#3
 596                     ; 188 }
 599  006b 81            	ret	
 667                     ; 210 void TIM4_PrescalerConfig(TIM4_Prescaler_TypeDef Prescaler, TIM4_PSCReloadMode_TypeDef TIM4_PSCReloadMode)
 667                     ; 211 {
 668                     	switch	.text
 669  006c               _TIM4_PrescalerConfig:
 673                     ; 213     assert_param(IS_TIM4_PRESCALER_RELOAD_OK(TIM4_PSCReloadMode));
 675                     ; 214     assert_param(IS_TIM4_PRESCALER_OK(Prescaler));
 677                     ; 217     TIM4->PSCR = (u8)Prescaler;
 679  006c 9e            	ld	a,xh
 680  006d c75347        	ld	21319,a
 681                     ; 220     TIM4->EGR = (u8)TIM4_PSCReloadMode;
 683  0070 9f            	ld	a,xl
 684  0071 c75345        	ld	21317,a
 685                     ; 221 }
 688  0074 81            	ret	
 724                     ; 229 void TIM4_ARRPreloadConfig(FunctionalState NewState)
 724                     ; 230 {
 725                     	switch	.text
 726  0075               _TIM4_ARRPreloadConfig:
 730                     ; 232     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 732                     ; 235     if (NewState != DISABLE)
 734  0075 4d            	tnz	a
 735  0076 2705          	jreq	L333
 736                     ; 237         TIM4->CR1 |= TIM4_CR1_ARPE;
 738  0078 721e5340      	bset	21312,#7
 741  007c 81            	ret	
 742  007d               L333:
 743                     ; 241         TIM4->CR1 &= (u8)(~TIM4_CR1_ARPE);
 745  007d 721f5340      	bres	21312,#7
 746                     ; 243 }
 749  0081 81            	ret	
 798                     ; 252 void TIM4_GenerateEvent(TIM4_EventSource_TypeDef TIM4_EventSource)
 798                     ; 253 {
 799                     	switch	.text
 800  0082               _TIM4_GenerateEvent:
 804                     ; 255     assert_param(IS_TIM4_EVENT_SOURCE_OK(TIM4_EventSource));
 806                     ; 258     TIM4->EGR = (u8)(TIM4_EventSource);
 808  0082 c75345        	ld	21317,a
 809                     ; 259 }
 812  0085 81            	ret	
 846                     ; 268 void TIM4_SetCounter(u8 Counter)
 846                     ; 269 {
 847                     	switch	.text
 848  0086               _TIM4_SetCounter:
 852                     ; 271     TIM4->CNTR = (u8)(Counter);
 854  0086 c75346        	ld	21318,a
 855                     ; 272 }
 858  0089 81            	ret	
 892                     ; 281 void TIM4_SetAutoreload(u8 Autoreload)
 892                     ; 282 {
 893                     	switch	.text
 894  008a               _TIM4_SetAutoreload:
 898                     ; 284     TIM4->ARR = (u8)(Autoreload);
 900  008a c75348        	ld	21320,a
 901                     ; 285 }
 904  008d 81            	ret	
 927                     ; 293 u8 TIM4_GetCounter(void)
 927                     ; 294 {
 928                     	switch	.text
 929  008e               _TIM4_GetCounter:
 933                     ; 296     return (u8)(TIM4->CNTR);
 935  008e c65346        	ld	a,21318
 938  0091 81            	ret	
 962                     ; 305 TIM4_Prescaler_TypeDef TIM4_GetPrescaler(void)
 962                     ; 306 {
 963                     	switch	.text
 964  0092               _TIM4_GetPrescaler:
 968                     ; 308     return (TIM4_Prescaler_TypeDef)(TIM4->PSCR);
 970  0092 c65347        	ld	a,21319
 973  0095 81            	ret	
1042                     ; 318 FlagStatus TIM4_GetFlagStatus(TIM4_FLAG_TypeDef TIM4_FLAG)
1042                     ; 319 {
1043                     	switch	.text
1044  0096               _TIM4_GetFlagStatus:
1048                     ; 321     assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1050                     ; 323     if ((TIM4->SR1 & TIM4_FLAG) != RESET )
1052  0096 c45344        	and	a,21316
1053  0099 2702          	jreq	L374
1054                     ; 325         return (FlagStatus)(SET);
1056  009b a601          	ld	a,#1
1059  009d               L374:
1060                     ; 329         return (FlagStatus)(RESET);
1064  009d 81            	ret	
1099                     ; 340 void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG)
1099                     ; 341 {
1100                     	switch	.text
1101  009e               _TIM4_ClearFlag:
1105                     ; 343     assert_param(IS_TIM4_GET_FLAG_OK(TIM4_FLAG));
1107                     ; 346     TIM4->SR1 = (u8)(~TIM4_FLAG);
1109  009e 43            	cpl	a
1110  009f c75344        	ld	21316,a
1111                     ; 348 }
1114  00a2 81            	ret	
1150                     ; 357 ITStatus TIM4_GetITStatus(TIM4_IT_TypeDef TIM4_IT)
1150                     ; 358 {
1151                     	switch	.text
1152  00a3               _TIM4_GetITStatus:
1154  00a3 88            	push	a
1155       00000000      OFST:	set	0
1158                     ; 360     assert_param(IS_TIM4_IT_OK(TIM4_IT));
1160                     ; 362     if (((TIM4->SR1 & TIM4_IT) != RESET ) && ((TIM4->IER & TIM4_IT) != RESET ))
1162  00a4 c45344        	and	a,21316
1163  00a7 270c          	jreq	L335
1165  00a9 c65343        	ld	a,21315
1166  00ac 1501          	bcp	a,(OFST+1,sp)
1167  00ae 2705          	jreq	L335
1168                     ; 364         return (ITStatus)(SET);
1170  00b0 a601          	ld	a,#1
1173  00b2 5b01          	addw	sp,#1
1174  00b4 81            	ret	
1175  00b5               L335:
1176                     ; 368         return (ITStatus)(RESET);
1178  00b5 4f            	clr	a
1181  00b6 5b01          	addw	sp,#1
1182  00b8 81            	ret	
1218                     ; 379 void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
1218                     ; 380 {
1219                     	switch	.text
1220  00b9               _TIM4_ClearITPendingBit:
1224                     ; 382     assert_param(IS_TIM4_IT_OK(TIM4_IT));
1226                     ; 385     TIM4->SR1 = (u8)(~TIM4_IT);
1228  00b9 43            	cpl	a
1229  00ba c75344        	ld	21316,a
1230                     ; 386 }
1233  00bd 81            	ret	
1246                     	xdef	_TIM4_ClearITPendingBit
1247                     	xdef	_TIM4_GetITStatus
1248                     	xdef	_TIM4_ClearFlag
1249                     	xdef	_TIM4_GetFlagStatus
1250                     	xdef	_TIM4_GetPrescaler
1251                     	xdef	_TIM4_GetCounter
1252                     	xdef	_TIM4_SetAutoreload
1253                     	xdef	_TIM4_SetCounter
1254                     	xdef	_TIM4_GenerateEvent
1255                     	xdef	_TIM4_ARRPreloadConfig
1256                     	xdef	_TIM4_PrescalerConfig
1257                     	xdef	_TIM4_SelectOnePulseMode
1258                     	xdef	_TIM4_UpdateRequestConfig
1259                     	xdef	_TIM4_UpdateDisableConfig
1260                     	xdef	_TIM4_ITConfig
1261                     	xdef	_TIM4_Cmd
1262                     	xdef	_TIM4_TimeBaseInit
1263                     	xdef	_TIM4_DeInit
1282                     	end
