   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  19                     	bsct
  20  0000               _trk_SystemClock:
  21  0000 00000000      	dc.l	0
  22  0004               L5_trk_MaxMessageCounter:
  23  0004 00            	dc.b	0
  54                     ; 29 unsigned char trk_GetMaxMessegeCounter(void)
  54                     ; 30 {
  56                     	switch	.text
  57  0000               _trk_GetMaxMessegeCounter:
  61                     ; 31    return trk_MaxMessageCounter;
  63  0000 b604          	ld	a,L5_trk_MaxMessageCounter
  66  0002 81            	ret	
 268                     ; 35 void trk_FindAndPushMessage(trk_messages message, trk_msgProcessTime ProcessTime)
 268                     ; 36 {
 269                     	switch	.text
 270  0003               _trk_FindAndPushMessage:
 272  0003 88            	push	a
 273  0004 89            	pushw	x
 274       00000002      OFST:	set	2
 277                     ; 37    const trk_MessageFunctions_t *ptr = trk_messageFunctionsArray;
 279  0005 ae0000        	ldw	x,#_trk_messageFunctionsArray
 280  0008 1f01          	ldw	(OFST-1,sp),x
 282  000a f6            	ld	a,(x)
 283  000b               L531:
 284                     ; 40       if (ptr->message == message)
 286  000b 1103          	cp	a,(OFST+1,sp)
 287  000d 2617          	jrne	L341
 288                     ; 42          if (ProcessTime == msg_ProcessInstant)
 290  000f 1e06          	ldw	x,(OFST+4,sp)
 291  0011 a3ea71        	cpw	x,#60017
 292  0014 2607          	jrne	L541
 293                     ; 44             ptr->messageFunction();
 295  0016 1e01          	ldw	x,(OFST-1,sp)
 296  0018 ee01          	ldw	x,(1,x)
 297  001a fd            	call	(x)
 300  001b 2009          	jra	L341
 301  001d               L541:
 302                     ; 48             trk_PushMessage(ptr->messageFunction, ProcessTime);
 304  001d 89            	pushw	x
 305  001e 1e03          	ldw	x,(OFST+1,sp)
 306  0020 ee01          	ldw	x,(1,x)
 307  0022 cd0221        	call	_trk_PushMessage
 309  0025 85            	popw	x
 310  0026               L341:
 311                     ; 51       ptr++;
 313  0026 1e01          	ldw	x,(OFST-1,sp)
 314  0028 1c0003        	addw	x,#3
 315  002b 1f01          	ldw	(OFST-1,sp),x
 317                     ; 53    while (ptr->message != msg_LastMessage);
 319  002d f6            	ld	a,(x)
 320  002e a104          	cp	a,#4
 321  0030 26d9          	jrne	L531
 322                     ; 54 }
 325  0032 5b03          	addw	sp,#3
 326  0034 81            	ret	
 386                     ; 56 unsigned char trk_FindMessagePosition(trk_MessageFunction function)
 386                     ; 57 {
 387                     	switch	.text
 388  0035               _trk_FindMessagePosition:
 390  0035 89            	pushw	x
 391  0036 89            	pushw	x
 392       00000002      OFST:	set	2
 395                     ; 58    unsigned char messagepos = 0;
 397  0037 0f02          	clr	(OFST+0,sp)
 399                     ; 59    unsigned char firststoppedfunction = 0xFF;
 401  0039 a6ff          	ld	a,#255
 402  003b 6b01          	ld	(OFST-1,sp),a
 405  003d 2019          	jra	L302
 406  003f               L771:
 407                     ; 66       if ( (trk_Messages[messagepos].property.stopped == TRUE) && (firststoppedfunction == 0xFF) &&
 407                     ; 67            (trk_Messages[messagepos].property.isprotected == FALSE) )
 409  003f 7b02          	ld	a,(OFST+0,sp)
 410  0041 ad4e          	call	LC002
 411  0043 e604          	ld	a,(L3_trk_Messages+4,x)
 412  0045 a520          	bcp	a,#32
 413  0047 270d          	jreq	L702
 415  0049 7b01          	ld	a,(OFST-1,sp)
 416  004b 4c            	inc	a
 417  004c 2608          	jrne	L702
 419  004e e604          	ld	a,(L3_trk_Messages+4,x)
 420  0050 2b04          	jrmi	L702
 421                     ; 69          firststoppedfunction = messagepos;
 423  0052 7b02          	ld	a,(OFST+0,sp)
 424  0054 6b01          	ld	(OFST-1,sp),a
 426  0056               L702:
 427                     ; 71       messagepos++;
 429  0056 0c02          	inc	(OFST+0,sp)
 431  0058               L302:
 432                     ; 61    while ( (messagepos != MAX_MESSAGE_NUMBER) && 
 432                     ; 62            ( (trk_Messages[messagepos].messagefunction != 0x0000) || (trk_Messages[messagepos].property.isprotected == TRUE) ) && 
 432                     ; 63            ( (trk_Messages[messagepos].messagefunction != function) || (trk_Messages[messagepos].property.stopped == TRUE) ) 
 432                     ; 64          )
 434  0058 7b02          	ld	a,(OFST+0,sp)
 435  005a a114          	cp	a,#20
 436  005c 271c          	jreq	L112
 438  005e ad31          	call	LC002
 439  0060 e601          	ld	a,(L3_trk_Messages+1,x)
 440  0062 ea00          	or	a,(L3_trk_Messages,x)
 441  0064 2604          	jrne	L512
 443  0066 e604          	ld	a,(L3_trk_Messages+4,x)
 444  0068 2a10          	jrpl	L112
 445  006a               L512:
 447  006a ee00          	ldw	x,(L3_trk_Messages,x)
 448  006c 1303          	cpw	x,(OFST+1,sp)
 449  006e 26cf          	jrne	L771
 451  0070 7b02          	ld	a,(OFST+0,sp)
 452  0072 ad1d          	call	LC002
 453  0074 e604          	ld	a,(L3_trk_Messages+4,x)
 454  0076 a520          	bcp	a,#32
 455  0078 26c5          	jrne	L771
 456  007a               L112:
 457                     ; 73    if (trk_Messages[messagepos].messagefunction == function)
 459  007a 7b02          	ld	a,(OFST+0,sp)
 460  007c ad13          	call	LC002
 461  007e ee00          	ldw	x,(L3_trk_Messages,x)
 462  0080 1303          	cpw	x,(OFST+1,sp)
 463                     ; 75       return messagepos;
 465  0082 2709          	jreq	L122
 466                     ; 77    else if (firststoppedfunction != 0xFF)
 468  0084 7b01          	ld	a,(OFST-1,sp)
 469  0086 a1ff          	cp	a,#255
 470  0088 2703          	jreq	L122
 471                     ; 79       return firststoppedfunction;
 474  008a               L61:
 476  008a 5b04          	addw	sp,#4
 477  008c 81            	ret	
 478  008d               L122:
 479                     ; 81    return messagepos;
 482  008d 7b02          	ld	a,(OFST+0,sp)
 484  008f 20f9          	jra	L61
 485  0091               LC002:
 486  0091 97            	ld	xl,a
 487  0092 a605          	ld	a,#5
 488  0094 42            	mul	x,a
 489  0095 81            	ret	
 538                     ; 84 unsigned char trk_IsMessagePushed(trk_MessageFunction function)
 538                     ; 85 {
 539                     	switch	.text
 540  0096               _trk_IsMessagePushed:
 542  0096 89            	pushw	x
 543  0097 88            	push	a
 544       00000001      OFST:	set	1
 547                     ; 86    unsigned char position = trk_FindMessagePosition(function);
 549  0098 ad9b          	call	_trk_FindMessagePosition
 551  009a 6b01          	ld	(OFST+0,sp),a
 553                     ; 87    if (trk_Messages[position].messagefunction == function)
 555  009c 97            	ld	xl,a
 556  009d a605          	ld	a,#5
 557  009f 42            	mul	x,a
 558  00a0 ee00          	ldw	x,(L3_trk_Messages,x)
 559  00a2 1302          	cpw	x,(OFST+1,sp)
 560  00a4 2610          	jrne	L42
 561                     ; 89       return (trk_Messages[position].property.stopped == FALSE);
 563  00a6 7b01          	ld	a,(OFST+0,sp)
 564  00a8 97            	ld	xl,a
 565  00a9 a605          	ld	a,#5
 566  00ab 42            	mul	x,a
 567  00ac e604          	ld	a,(L3_trk_Messages+4,x)
 568  00ae a520          	bcp	a,#32
 569  00b0 2604          	jrne	L42
 570  00b2 a601          	ld	a,#1
 571  00b4 2001          	jra	L03
 572  00b6               L42:
 574                     ; 93       return FALSE;
 576  00b6 4f            	clr	a
 578  00b7               L03:
 580  00b7 5b03          	addw	sp,#3
 581  00b9 81            	ret	
 630                     ; 97 unsigned long trk_GetMessageRemainingTime(trk_MessageFunction function)
 630                     ; 98 {
 631                     	switch	.text
 632  00ba               _trk_GetMessageRemainingTime:
 634  00ba 89            	pushw	x
 635  00bb 5205          	subw	sp,#5
 636       00000005      OFST:	set	5
 639                     ; 99    unsigned char position = trk_FindMessagePosition(function);
 641  00bd cd0035        	call	_trk_FindMessagePosition
 643  00c0 6b05          	ld	(OFST+0,sp),a
 645                     ; 100    if ( (trk_Messages[position].messagefunction == function) && (trk_Messages[position].property.stopped == FALSE) )
 647  00c2 97            	ld	xl,a
 648  00c3 a605          	ld	a,#5
 649  00c5 42            	mul	x,a
 650  00c6 ee00          	ldw	x,(L3_trk_Messages,x)
 651  00c8 1306          	cpw	x,(OFST+1,sp)
 652  00ca 2630          	jrne	L572
 654  00cc 7b05          	ld	a,(OFST+0,sp)
 655  00ce 97            	ld	xl,a
 656  00cf a605          	ld	a,#5
 657  00d1 42            	mul	x,a
 658  00d2 e604          	ld	a,(L3_trk_Messages+4,x)
 659  00d4 a520          	bcp	a,#32
 660  00d6 2624          	jrne	L572
 661                     ; 102       return (trk_Messages[position].TimeToProcess + ((unsigned long)trk_Messages[position].property.MinuteCounter)*((unsigned long)msg_ProcessAfter1m));
 663  00d8 ee02          	ldw	x,(L3_trk_Messages+2,x)
 664  00da cd0000        	call	c_uitolx
 666  00dd 96            	ldw	x,sp
 667  00de 5c            	incw	x
 668  00df cd0000        	call	c_rtol
 671  00e2 7b05          	ld	a,(OFST+0,sp)
 672  00e4 97            	ld	xl,a
 673  00e5 a605          	ld	a,#5
 674  00e7 42            	mul	x,a
 675  00e8 e604          	ld	a,(L3_trk_Messages+4,x)
 676  00ea a41f          	and	a,#31
 677  00ec 5f            	clrw	x
 678  00ed 02            	rlwa	x,a
 679  00ee 90aeea60      	ldw	y,#60000
 680  00f2 cd0000        	call	c_umul
 682  00f5 96            	ldw	x,sp
 683  00f6 5c            	incw	x
 684  00f7 cd0000        	call	c_ladd
 687  00fa 2005          	jra	L63
 688  00fc               L572:
 689                     ; 106       return 0;
 691  00fc 5f            	clrw	x
 692  00fd bf02          	ldw	c_lreg+2,x
 693  00ff bf00          	ldw	c_lreg,x
 695  0101               L63:
 697  0101 5b07          	addw	sp,#7
 698  0103 81            	ret	
 755                     .const:	section	.text
 756  0000               L44:
 757  0000 0000ea6d      	dc.l	60013
 758  0004               L64:
 759  0004 0000ea85      	dc.l	60037
 760  0008               L05:
 761  0008 0000eaad      	dc.l	60077
 762  000c               L25:
 763  000c 0000ea60      	dc.l	60000
 764                     ; 110 unsigned char trk_CheckMessage(unsigned char counter)
 764                     ; 111 {
 765                     	switch	.text
 766  0104               _trk_CheckMessage:
 768  0104 88            	push	a
 769  0105 5208          	subw	sp,#8
 770       00000008      OFST:	set	8
 773                     ; 114    if ( (trk_Messages[counter].property.paused == FALSE) && (trk_Messages[counter].property.stopped == FALSE) )
 775  0107 cd01c5        	call	LC006
 776  010a e604          	ld	a,(L3_trk_Messages+4,x)
 777  010c a540          	bcp	a,#64
 778  010e 2703cc01c0    	jrne	L723
 780  0113 7b09          	ld	a,(OFST+1,sp)
 781  0115 cd01c5        	call	LC006
 782  0118 e604          	ld	a,(L3_trk_Messages+4,x)
 783  011a a520          	bcp	a,#32
 784  011c 26f2          	jrne	L723
 785                     ; 116       if ((trk_Messages[counter].TimeToProcess == 0) && (trk_Messages[counter].property.MinuteCounter == 0))
 787  011e e603          	ld	a,(L3_trk_Messages+3,x)
 788  0120 ea02          	or	a,(L3_trk_Messages+2,x)
 789  0122 26ec          	jrne	L723
 791  0124 e604          	ld	a,(L3_trk_Messages+4,x)
 792  0126 a51f          	bcp	a,#31
 793  0128 26e6          	jrne	L723
 794                     ; 118          messagefunction = trk_Messages[counter].messagefunction;
 796  012a ee00          	ldw	x,(L3_trk_Messages,x)
 797  012c 1f03          	ldw	(OFST-5,sp),x
 799                     ; 119          messageRefreshTime = messagefunction();
 801  012e fd            	call	(x)
 803  012f 96            	ldw	x,sp
 804  0130 1c0005        	addw	x,#OFST-3
 805  0133 cd0000        	call	c_rtol
 808                     ; 121          if (messagefunction != trk_Messages[counter].messagefunction)
 810  0136 7b09          	ld	a,(OFST+1,sp)
 811  0138 cd01c5        	call	LC006
 812  013b ee00          	ldw	x,(L3_trk_Messages,x)
 813  013d 1303          	cpw	x,(OFST-5,sp)
 814  013f 267f          	jrne	L723
 816                     ; 125          else if ((trk_Messages[counter].TimeToProcess > 0) || (trk_Messages[counter].property.MinuteCounter > 0))
 818  0141 7b09          	ld	a,(OFST+1,sp)
 819  0143 cd01c5        	call	LC006
 820  0146 e603          	ld	a,(L3_trk_Messages+3,x)
 821  0148 ea02          	or	a,(L3_trk_Messages+2,x)
 822  014a 2674          	jrne	L723
 824  014c e604          	ld	a,(L3_trk_Messages+4,x)
 825  014e a51f          	bcp	a,#31
 826  0150 266e          	jrne	L723
 827                     ; 129          else if (messageRefreshTime == msg_ProcessStopped)
 829  0152 96            	ldw	x,sp
 830  0153 1c0005        	addw	x,#OFST-3
 831  0156 cd0000        	call	c_ltor
 833  0159 ae0000        	ldw	x,#L44
 834  015c cd0000        	call	c_lcmp
 836                     ; 131             trk_Messages[counter].property.stopped = TRUE;
 838  015f 270f          	jreq	LC005
 839                     ; 133          else if (messageRefreshTime == msg_ProcessPause)
 841  0161 96            	ldw	x,sp
 842  0162 1c0005        	addw	x,#OFST-3
 843  0165 cd0000        	call	c_ltor
 845  0168 ae0004        	ldw	x,#L64
 846  016b cd0000        	call	c_lcmp
 848  016e 260a          	jrne	L153
 849                     ; 135             trk_Messages[counter].property.stopped = TRUE; // after execution of message, pause means nothing, stop it.
 851  0170               LC005:
 853  0170 7b09          	ld	a,(OFST+1,sp)
 854  0172 ad51          	call	LC006
 855  0174 e604          	ld	a,(L3_trk_Messages+4,x)
 856  0176 aa20          	or	a,#32
 858  0178 2044          	jp	LC004
 859  017a               L153:
 860                     ; 139             if (messageRefreshTime == msg_ProcessNextCheck)
 862  017a 96            	ldw	x,sp
 863  017b 1c0005        	addw	x,#OFST-3
 864  017e cd0000        	call	c_ltor
 866  0181 ae0008        	ldw	x,#L05
 867  0184 cd0000        	call	c_lcmp
 869  0187 2605          	jrne	L553
 870                     ; 141                messageRefreshTime = 0x00;
 872  0189 5f            	clrw	x
 873  018a 1f07          	ldw	(OFST-1,sp),x
 874  018c 1f05          	ldw	(OFST-3,sp),x
 876  018e               L553:
 877                     ; 144             trk_Messages[counter].TimeToProcess = (unsigned int)(messageRefreshTime % msg_ProcessAfter1m);
 879  018e 96            	ldw	x,sp
 880  018f 1c0005        	addw	x,#OFST-3
 881  0192 cd0000        	call	c_ltor
 883  0195 ae000c        	ldw	x,#L25
 884  0198 cd0000        	call	c_lumd
 886  019b be02          	ldw	x,c_lreg+2
 887  019d 1f01          	ldw	(OFST-7,sp),x
 889  019f 7b09          	ld	a,(OFST+1,sp)
 890  01a1 ad22          	call	LC006
 891  01a3 1601          	ldw	y,(OFST-7,sp)
 892  01a5 ef02          	ldw	(L3_trk_Messages+2,x),y
 893                     ; 145             trk_Messages[counter].property.MinuteCounter = (unsigned char)(messageRefreshTime / msg_ProcessAfter1m);
 895  01a7 89            	pushw	x
 896  01a8 96            	ldw	x,sp
 897  01a9 1c0007        	addw	x,#OFST-1
 898  01ac cd0000        	call	c_ltor
 900  01af ae000c        	ldw	x,#L25
 901  01b2 cd0000        	call	c_ludv
 903  01b5 85            	popw	x
 904  01b6 b603          	ld	a,c_lreg+3
 905  01b8 e804          	xor	a,(L3_trk_Messages+4,x)
 906  01ba a41f          	and	a,#31
 907  01bc e804          	xor	a,(L3_trk_Messages+4,x)
 908  01be               LC004:
 909  01be e704          	ld	(L3_trk_Messages+4,x),a
 910  01c0               L723:
 911                     ; 149    return counter;
 913  01c0 7b09          	ld	a,(OFST+1,sp)
 916  01c2 5b09          	addw	sp,#9
 917  01c4 81            	ret	
 918  01c5               LC006:
 919  01c5 97            	ld	xl,a
 920  01c6 a605          	ld	a,#5
 921  01c8 42            	mul	x,a
 922  01c9 81            	ret	
 959                     ; 152 void trk_PushMessage1ms(trk_MessageFunction messagefunction)
 959                     ; 153 {
 960                     	switch	.text
 961  01ca               _trk_PushMessage1ms:
 963  01ca 89            	pushw	x
 964       00000000      OFST:	set	0
 967                     ; 154    trk_PushMessage(messagefunction, msg_ProcessAfter1ms);
 969  01cb ae0001        	ldw	x,#1
 970  01ce 89            	pushw	x
 971  01cf 1e03          	ldw	x,(OFST+3,sp)
 972  01d1 ad4e          	call	_trk_PushMessage
 974                     ; 155 }
 977  01d3 5b04          	addw	sp,#4
 978  01d5 81            	ret	
1036                     ; 157 void trk_PushMessageLong(trk_MessageFunction messagefunction, unsigned long ProcessTime)
1036                     ; 158 {
1037                     	switch	.text
1038  01d6               _trk_PushMessageLong:
1040  01d6 89            	pushw	x
1041  01d7 88            	push	a
1042       00000001      OFST:	set	1
1045                     ; 159    unsigned char messageCount = trk_PushMessage(messagefunction, ProcessTime % msg_ProcessAfter1m);
1047  01d8 96            	ldw	x,sp
1048  01d9 1c0006        	addw	x,#OFST+5
1049  01dc cd0000        	call	c_ltor
1051  01df ae000c        	ldw	x,#L25
1052  01e2 cd0000        	call	c_lumd
1054  01e5 be02          	ldw	x,c_lreg+2
1055  01e7 89            	pushw	x
1056  01e8 1e04          	ldw	x,(OFST+3,sp)
1057  01ea ad35          	call	_trk_PushMessage
1059  01ec 85            	popw	x
1060  01ed 6b01          	ld	(OFST+0,sp),a
1062                     ; 160    if ((trk_Messages[messageCount].messagefunction == messagefunction) && 
1062                     ; 161        (trk_Messages[messageCount].property.stopped == FALSE))
1064  01ef 97            	ld	xl,a
1065  01f0 a605          	ld	a,#5
1066  01f2 42            	mul	x,a
1067  01f3 ee00          	ldw	x,(L3_trk_Messages,x)
1068  01f5 1302          	cpw	x,(OFST+1,sp)
1069  01f7 2625          	jrne	L324
1071  01f9 7b01          	ld	a,(OFST+0,sp)
1072  01fb 97            	ld	xl,a
1073  01fc a605          	ld	a,#5
1074  01fe 42            	mul	x,a
1075  01ff e604          	ld	a,(L3_trk_Messages+4,x)
1076  0201 a520          	bcp	a,#32
1077  0203 2619          	jrne	L324
1078                     ; 163       trk_Messages[messageCount].property.MinuteCounter = (unsigned char)(ProcessTime / msg_ProcessAfter1m);
1080  0205 89            	pushw	x
1081  0206 96            	ldw	x,sp
1082  0207 1c0008        	addw	x,#OFST+7
1083  020a cd0000        	call	c_ltor
1085  020d ae000c        	ldw	x,#L25
1086  0210 cd0000        	call	c_ludv
1088  0213 85            	popw	x
1089  0214 b603          	ld	a,c_lreg+3
1090  0216 e804          	xor	a,(L3_trk_Messages+4,x)
1091  0218 a41f          	and	a,#31
1092  021a e804          	xor	a,(L3_trk_Messages+4,x)
1093  021c e704          	ld	(L3_trk_Messages+4,x),a
1094  021e               L324:
1095                     ; 165 }
1098  021e 5b03          	addw	sp,#3
1099  0220 81            	ret	
1102                     	bsct
1103  0005               L524_trk_pushmessagecounter:
1104  0005 00            	dc.b	0
1185                     ; 166 unsigned char trk_PushMessage(trk_MessageFunction messagefunction, trk_msgProcessTime ProcessTime)
1185                     ; 167 {
1186                     	switch	.text
1187  0221               _trk_PushMessage:
1189  0221 89            	pushw	x
1190  0222 5204          	subw	sp,#4
1191       00000004      OFST:	set	4
1194                     ; 169    unsigned char trk_messagepos = 0xFF;
1196  0224 a6ff          	ld	a,#255
1197  0226 6b04          	ld	(OFST+0,sp),a
1199  0228               L564:
1200                     ; 177       if (trk_messagepos != 0xFF)
1202  0228 7b04          	ld	a,(OFST+0,sp)
1203  022a a1ff          	cp	a,#255
1204  022c 2707          	jreq	L374
1205                     ; 179          trk_Messages[trk_messagepos].property.isprotected = FALSE; // to clear previous wrong protected message
1207  022e cd02d5        	call	LC008
1208  0231 a47f          	and	a,#127
1209  0233 e704          	ld	(L3_trk_Messages+4,x),a
1210  0235               L374:
1211                     ; 181       trk_pushmessagecountertemporary = trk_pushmessagecounter;
1213  0235 b605          	ld	a,L524_trk_pushmessagecounter
1214  0237 6b03          	ld	(OFST-1,sp),a
1216                     ; 182       trk_messagepos = trk_FindMessagePosition(messagefunction);
1218  0239 1e05          	ldw	x,(OFST+1,sp)
1219  023b cd0035        	call	_trk_FindMessagePosition
1221  023e 6b04          	ld	(OFST+0,sp),a
1223                     ; 183       trk_Messages[trk_messagepos].property.isprotected = TRUE;
1225  0240 cd02d5        	call	LC008
1226  0243 aa80          	or	a,#128
1227  0245 e704          	ld	(L3_trk_Messages+4,x),a
1228                     ; 185    while (trk_pushmessagecountertemporary != trk_pushmessagecounter); 
1230  0247 7b03          	ld	a,(OFST-1,sp)
1231  0249 b105          	cp	a,L524_trk_pushmessagecounter
1232  024b 26db          	jrne	L564
1233                     ; 187    trk_pushmessagecounter++;
1235  024d 3c05          	inc	L524_trk_pushmessagecounter
1236                     ; 189    if (trk_messagepos == MAX_MESSAGE_NUMBER)
1238  024f 7b04          	ld	a,(OFST+0,sp)
1239  0251 a114          	cp	a,#20
1240  0253 2605          	jrne	L574
1241                     ; 191       ata_MessageStackOverflow();
1243  0255 cd0000        	call	_ata_MessageStackOverflow
1246  0258 206e          	jra	L774
1247  025a               L574:
1248                     ; 195       if (ProcessTime == msg_ProcessStopped)
1250  025a 1e09          	ldw	x,(OFST+5,sp)
1251  025c a3ea6d        	cpw	x,#60013
1252  025f 2610          	jrne	L105
1253                     ; 197          if (trk_Messages[trk_messagepos].messagefunction != 0x0000)
1255  0261 97            	ld	xl,a
1256  0262 a605          	ld	a,#5
1257  0264 42            	mul	x,a
1258  0265 e601          	ld	a,(L3_trk_Messages+1,x)
1259  0267 ea00          	or	a,(L3_trk_Messages,x)
1260  0269 2755          	jreq	L505
1261                     ; 199             trk_Messages[trk_messagepos].property.stopped = TRUE;
1263  026b e604          	ld	a,(L3_trk_Messages+4,x)
1264  026d aa20          	or	a,#32
1265  026f 204d          	jp	LC007
1266  0271               L105:
1267                     ; 202       else if (ProcessTime == msg_ProcessPause)
1269  0271 a3ea85        	cpw	x,#60037
1270  0274 2606          	jrne	L705
1271                     ; 204          trk_Messages[trk_messagepos].property.paused = TRUE;
1273  0276 ad5d          	call	LC008
1274  0278 aa40          	or	a,#64
1276  027a 2042          	jp	LC007
1277  027c               L705:
1278                     ; 206       else if (ProcessTime == msg_ProcessResume)
1280  027c a3ea89        	cpw	x,#60041
1281  027f 97            	ld	xl,a
1282  0280 260f          	jrne	L315
1283                     ; 208          if (trk_Messages[trk_messagepos].messagefunction != 0x0000)
1285  0282 a605          	ld	a,#5
1286  0284 42            	mul	x,a
1287  0285 e601          	ld	a,(L3_trk_Messages+1,x)
1288  0287 ea00          	or	a,(L3_trk_Messages,x)
1289  0289 2735          	jreq	L505
1290                     ; 210             trk_Messages[trk_messagepos].property.paused = FALSE;
1292  028b e604          	ld	a,(L3_trk_Messages+4,x)
1293  028d a4bf          	and	a,#191
1294  028f 202d          	jp	LC007
1295  0291               L315:
1296                     ; 215          trk_Messages[trk_messagepos].messagefunction = messagefunction;
1298  0291 a605          	ld	a,#5
1299  0293 42            	mul	x,a
1300  0294 1605          	ldw	y,(OFST+1,sp)
1301  0296 ef00          	ldw	(L3_trk_Messages,x),y
1302                     ; 216          trk_Messages[trk_messagepos].property.paused = FALSE;
1304  0298 e604          	ld	a,(L3_trk_Messages+4,x)
1305                     ; 217          trk_Messages[trk_messagepos].property.stopped = FALSE;
1307  029a a49f          	and	a,#159
1308  029c e704          	ld	(L3_trk_Messages+4,x),a
1309                     ; 219          if (ProcessTime == msg_ProcessNextCheck)
1311  029e 1e09          	ldw	x,(OFST+5,sp)
1312  02a0 a3eaad        	cpw	x,#60077
1313  02a3 2603          	jrne	L125
1314                     ; 221             ProcessTime = 0;
1316  02a5 5f            	clrw	x
1317  02a6 1f09          	ldw	(OFST+5,sp),x
1318  02a8               L125:
1319                     ; 224          trk_Messages[trk_messagepos].TimeToProcess = (unsigned int)(ProcessTime % msg_ProcessAfter1m);
1321  02a8 90aeea60      	ldw	y,#60000
1322  02ac 65            	divw	x,y
1323  02ad 93            	ldw	x,y
1324  02ae 1f01          	ldw	(OFST-3,sp),x
1326  02b0 7b04          	ld	a,(OFST+0,sp)
1327  02b2 97            	ld	xl,a
1328  02b3 a605          	ld	a,#5
1329  02b5 42            	mul	x,a
1330  02b6 1601          	ldw	y,(OFST-3,sp)
1331  02b8 ef02          	ldw	(L3_trk_Messages+2,x),y
1332                     ; 225          trk_Messages[trk_messagepos].property.MinuteCounter = 0;
1334  02ba e604          	ld	a,(L3_trk_Messages+4,x)
1335  02bc a4e0          	and	a,#224
1336  02be               LC007:
1337  02be e704          	ld	(L3_trk_Messages+4,x),a
1338  02c0               L505:
1339                     ; 228       if (trk_messagepos > trk_MaxMessageCounter)
1341  02c0 7b04          	ld	a,(OFST+0,sp)
1342  02c2 b104          	cp	a,L5_trk_MaxMessageCounter
1343  02c4 2302          	jrule	L774
1344                     ; 230          trk_MaxMessageCounter = trk_messagepos;
1346  02c6 b704          	ld	L5_trk_MaxMessageCounter,a
1347  02c8               L774:
1348                     ; 233    trk_Messages[trk_messagepos].property.isprotected = FALSE;
1350  02c8 7b04          	ld	a,(OFST+0,sp)
1351  02ca ad09          	call	LC008
1352  02cc a47f          	and	a,#127
1353  02ce e704          	ld	(L3_trk_Messages+4,x),a
1354                     ; 234    return trk_messagepos;
1356  02d0 7b04          	ld	a,(OFST+0,sp)
1359  02d2 5b06          	addw	sp,#6
1360  02d4 81            	ret	
1361  02d5               LC008:
1362  02d5 97            	ld	xl,a
1363  02d6 a605          	ld	a,#5
1364  02d8 42            	mul	x,a
1365  02d9 e604          	ld	a,(L3_trk_Messages+4,x)
1366  02db 81            	ret	
1403                     ; 237 void trk_Fire1msTimer(void)
1403                     ; 238 {
1404                     	switch	.text
1405  02dc               _trk_Fire1msTimer:
1407  02dc 88            	push	a
1408       00000001      OFST:	set	1
1411                     ; 245       trk_SystemClock += msg_ProcessAfter1ms;
1413  02dd ae0000        	ldw	x,#_trk_SystemClock
1414  02e0 a601          	ld	a,#1
1415  02e2 cd0000        	call	c_lgadc
1417                     ; 251       for (counter = 0; counter <= trk_MaxMessageCounter; counter++)
1419  02e5 0f01          	clr	(OFST+0,sp)
1422  02e7 203d          	jra	L745
1423  02e9               L345:
1424                     ; 253          if ((trk_Messages[counter].property.stopped == FALSE) && (trk_Messages[counter].property.paused == FALSE))
1426  02e9 97            	ld	xl,a
1427  02ea a605          	ld	a,#5
1428  02ec 42            	mul	x,a
1429  02ed e604          	ld	a,(L3_trk_Messages+4,x)
1430  02ef a520          	bcp	a,#32
1431  02f1 2631          	jrne	L355
1433  02f3 a540          	bcp	a,#64
1434  02f5 262d          	jrne	L355
1435                     ; 255             if ((trk_Messages[counter].TimeToProcess >= msg_ProcessAfter1ms) || (trk_Messages[counter].property.MinuteCounter > 0))
1437  02f7 e603          	ld	a,(L3_trk_Messages+3,x)
1438  02f9 ea02          	or	a,(L3_trk_Messages+2,x)
1439  02fb 2606          	jrne	L755
1441  02fd e604          	ld	a,(L3_trk_Messages+4,x)
1442  02ff a51f          	bcp	a,#31
1443  0301 2721          	jreq	L355
1444  0303               L755:
1445                     ; 257                if (trk_Messages[counter].TimeToProcess >= msg_ProcessAfter1ms)
1447  0303 e603          	ld	a,(L3_trk_Messages+3,x)
1448  0305 ea02          	or	a,(L3_trk_Messages+2,x)
1449  0307 270a          	jreq	L165
1450                     ; 259                   trk_Messages[counter].TimeToProcess -= msg_ProcessAfter1ms;
1452  0309 9093          	ldw	y,x
1453  030b ee02          	ldw	x,(L3_trk_Messages+2,x)
1454  030d 5a            	decw	x
1455  030e 90ef02        	ldw	(L3_trk_Messages+2,y),x
1457  0311 2011          	jra	L355
1458  0313               L165:
1459                     ; 263                   trk_Messages[counter].TimeToProcess = msg_ProcessAfter1m;
1461  0313 90aeea60      	ldw	y,#60000
1462  0317 ef02          	ldw	(L3_trk_Messages+2,x),y
1463                     ; 264                   trk_Messages[counter].property.MinuteCounter--;
1465  0319 e604          	ld	a,(L3_trk_Messages+4,x)
1466  031b 4a            	dec	a
1467  031c e804          	xor	a,(L3_trk_Messages+4,x)
1468  031e a41f          	and	a,#31
1469  0320 e804          	xor	a,(L3_trk_Messages+4,x)
1470  0322 e704          	ld	(L3_trk_Messages+4,x),a
1471                     
1472  0324               L355:
1473                     ; 251       for (counter = 0; counter <= trk_MaxMessageCounter; counter++)
1475  0324 0c01          	inc	(OFST+0,sp)
1477  0326               L745:
1480  0326 7b01          	ld	a,(OFST+0,sp)
1481  0328 b104          	cp	a,L5_trk_MaxMessageCounter
1482  032a 23bd          	jrule	L345
1483                     ; 270 }
1486  032c 84            	pop	a
1487  032d 81            	ret	
1490                     	bsct
1491  0006               L565_counter:
1492  0006 00            	dc.b	0
1538                     	switch	.const
1539  0010               L001:
1540  0010 0000ea7d      	dc.l	60029
1541                     ; 272 void trk_ProcessMessages(unsigned long ProcessTime)
1541                     ; 273 {
1542                     	switch	.text
1543  032e               _trk_ProcessMessages:
1545       00000000      OFST:	set	0
1548  032e               L116:
1549                     ; 278       if (counter >= MAX_MESSAGE_NUMBER)
1551  032e b606          	ld	a,L565_counter
1552  0330 a114          	cp	a,#20
1553  0332 2503          	jrult	L716
1554                     ; 280          counter = 0;
1556  0334 4f            	clr	a
1557  0335 b706          	ld	L565_counter,a
1558  0337               L716:
1559                     ; 286       if (trk_Messages[counter].messagefunction != 0x0000)
1561  0337 97            	ld	xl,a
1562  0338 a605          	ld	a,#5
1563  033a 42            	mul	x,a
1564  033b e601          	ld	a,(L3_trk_Messages+1,x)
1565  033d ea00          	or	a,(L3_trk_Messages,x)
1566  033f 2712          	jreq	L126
1567                     ; 288          counter = trk_CheckMessage(counter);
1569  0341 b606          	ld	a,L565_counter
1570  0343 cd0104        	call	_trk_CheckMessage
1572  0346 4c            	inc	a
1573  0347 b706          	ld	L565_counter,a
1574                     ; 289          counter++;
1576                     ; 290          if (trk_Messages[counter].messagefunction == 0x0000)
1578  0349 97            	ld	xl,a
1579  034a a605          	ld	a,#5
1580  034c 42            	mul	x,a
1581  034d e601          	ld	a,(L3_trk_Messages+1,x)
1582  034f ea00          	or	a,(L3_trk_Messages,x)
1583  0351 2602          	jrne	L316
1584                     ; 292             counter = 0;
1585  0353               L126:
1586                     ; 300          counter = 0;
1589  0353 b706          	ld	L565_counter,a
1590  0355               L316:
1591                     ; 309    while (ProcessTime == msg_ProcessForever);
1593  0355 96            	ldw	x,sp
1594  0356 1c0003        	addw	x,#OFST+3
1595  0359 cd0000        	call	c_ltor
1597  035c ae0010        	ldw	x,#L001
1598  035f cd0000        	call	c_lcmp
1600  0362 27ca          	jreq	L116
1601                     ; 312 }
1604  0364 81            	ret	
1652                     ; 314 void trk_Message(trk_messages message, trk_msgProcessTime ProcessTime)
1652                     ; 315 {
1653                     	switch	.text
1654  0365               _trk_Message:
1656  0365 88            	push	a
1657       00000000      OFST:	set	0
1660                     ; 316    if (message == msg_1msTimer)
1662  0366 a102          	cp	a,#2
1663  0368 2605          	jrne	L156
1664                     ; 321       trk_Fire1msTimer();
1666  036a cd02dc        	call	_trk_Fire1msTimer
1669  036d 201d          	jra	L356
1670  036f               L156:
1671                     ; 324    else if (message == msg_ProcessMessages)
1673  036f 4a            	dec	a
1674  0370 2611          	jrne	L556
1675                     ; 326       trk_ProcessMessages(ProcessTime);
1677  0372 1e04          	ldw	x,(OFST+4,sp)
1678  0374 cd0000        	call	c_uitolx
1680  0377 be02          	ldw	x,c_lreg+2
1681  0379 89            	pushw	x
1682  037a be00          	ldw	x,c_lreg
1683  037c 89            	pushw	x
1684  037d adaf          	call	_trk_ProcessMessages
1686  037f 5b04          	addw	sp,#4
1688  0381 2009          	jra	L356
1689  0383               L556:
1690                     ; 330       trk_FindAndPushMessage(message,ProcessTime);
1692  0383 1e04          	ldw	x,(OFST+4,sp)
1693  0385 89            	pushw	x
1694  0386 7b03          	ld	a,(OFST+3,sp)
1695  0388 cd0003        	call	_trk_FindAndPushMessage
1697  038b 85            	popw	x
1698  038c               L356:
1699                     ; 332 }
1702  038c 84            	pop	a
1703  038d 81            	ret	
1741                     ; 335 void trk_KillAllMessages(void)
1741                     ; 336 {
1742                     	switch	.text
1743  038e               _trk_KillAllMessages:
1745  038e 88            	push	a
1746       00000001      OFST:	set	1
1749                     ; 338    for (counter = 0; counter < MAX_MESSAGE_NUMBER; counter++)
1751  038f 4f            	clr	a
1752  0390 6b01          	ld	(OFST+0,sp),a
1754  0392               L776:
1755                     ; 340       trk_Messages[counter].messagefunction = 0x0000;
1757  0392 97            	ld	xl,a
1758  0393 a605          	ld	a,#5
1759  0395 42            	mul	x,a
1760  0396 905f          	clrw	y
1761  0398 ef00          	ldw	(L3_trk_Messages,x),y
1762                     ; 338    for (counter = 0; counter < MAX_MESSAGE_NUMBER; counter++)
1764  039a 0c01          	inc	(OFST+0,sp)
1768  039c 7b01          	ld	a,(OFST+0,sp)
1769  039e a114          	cp	a,#20
1770  03a0 25f0          	jrult	L776
1771                     ; 342 }
1774  03a2 84            	pop	a
1775  03a3 81            	ret	
1804                     ; 344 void trk_MessageInit(void)
1804                     ; 345 {
1805                     	switch	.text
1806  03a4               _trk_MessageInit:
1810                     ; 346    ata_MessageOpen(&trk_Message, &trk_PushMessage);
1812  03a4 ae0221        	ldw	x,#_trk_PushMessage
1813  03a7 89            	pushw	x
1814  03a8 ae0365        	ldw	x,#_trk_Message
1815  03ab cd0000        	call	_ata_MessageOpen
1817  03ae 85            	popw	x
1818                     ; 347    trk_KillAllMessages();
1821                     ; 348 }
1824  03af 20dd          	jp	_trk_KillAllMessages
1861                     ; 350 void trk_StopMessage(trk_MessageFunction messagefunction)
1861                     ; 351 {
1862                     	switch	.text
1863  03b1               _trk_StopMessage:
1865  03b1 89            	pushw	x
1866       00000000      OFST:	set	0
1869                     ; 352    trk_PushMessage(messagefunction, msg_ProcessStopped);
1871  03b2 aeea6d        	ldw	x,#60013
1872  03b5 89            	pushw	x
1873  03b6 1e03          	ldw	x,(OFST+3,sp)
1874  03b8 cd0221        	call	_trk_PushMessage
1876                     ; 353 }
1879  03bb 5b04          	addw	sp,#4
1880  03bd 81            	ret	
2009                     	xdef	_trk_ProcessMessages
2010                     	xdef	_trk_Fire1msTimer
2011                     	xdef	_trk_CheckMessage
2012                     	xdef	_trk_FindMessagePosition
2013                     	xdef	_trk_FindAndPushMessage
2014                     	switch	.ubsct
2015  0000               L3_trk_Messages:
2016  0000 000000000000  	ds.b	100
2017                     	xref	_ata_MessageStackOverflow
2018                     	xref	_ata_MessageOpen
2019                     	xref	_trk_messageFunctionsArray
2020                     	xdef	_trk_SystemClock
2021                     	xdef	_trk_GetMaxMessegeCounter
2022                     	xdef	_trk_GetMessageRemainingTime
2023                     	xdef	_trk_IsMessagePushed
2024                     	xdef	_trk_StopMessage
2025                     	xdef	_trk_KillAllMessages
2026                     	xdef	_trk_MessageInit
2027                     	xdef	_trk_Message
2028                     	xdef	_trk_PushMessage
2029                     	xdef	_trk_PushMessageLong
2030                     	xdef	_trk_PushMessage1ms
2031                     	xref.b	c_lreg
2032                     	xref.b	c_x
2033                     	xref.b	c_y
2053                     	xref	c_lgadc
2054                     	xref	c_ludv
2055                     	xref	c_lumd
2056                     	xref	c_lcmp
2057                     	xref	c_ltor
2058                     	xref	c_ladd
2059                     	xref	c_rtol
2060                     	xref	c_uitolx
2061                     	xref	c_umul
2062                     	end
