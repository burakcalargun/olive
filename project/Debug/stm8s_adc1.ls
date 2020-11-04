   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  47                     ; 46 void ADC1_DeInit(void)
  47                     ; 47 {
  49                     	switch	.text
  50  0000               _ADC1_DeInit:
  54                     ; 48     ADC1->CSR  = ADC1_CSR_RESET_VALUE;
  56  0000 725f5400      	clr	21504
  57                     ; 49     ADC1->CR1  = ADC1_CR1_RESET_VALUE;
  59  0004 725f5401      	clr	21505
  60                     ; 50     ADC1->CR2  = ADC1_CR2_RESET_VALUE;
  62  0008 725f5402      	clr	21506
  63                     ; 51     ADC1->CR3  = ADC1_CR3_RESET_VALUE;
  65  000c 725f5403      	clr	21507
  66                     ; 52     ADC1->TDRH = ADC1_TDRH_RESET_VALUE;
  68  0010 725f5406      	clr	21510
  69                     ; 53     ADC1->TDRL = ADC1_TDRL_RESET_VALUE;
  71  0014 725f5407      	clr	21511
  72                     ; 54     ADC1->HTRH = ADC1_HTRH_RESET_VALUE;
  74  0018 35ff5408      	mov	21512,#255
  75                     ; 55     ADC1->HTRL = ADC1_HTRL_RESET_VALUE;
  77  001c 35035409      	mov	21513,#3
  78                     ; 56     ADC1->LTRH = ADC1_LTRH_RESET_VALUE;
  80  0020 725f540a      	clr	21514
  81                     ; 57     ADC1->LTRL = ADC1_LTRL_RESET_VALUE;
  83  0024 725f540b      	clr	21515
  84                     ; 58     ADC1->AWCRH = ADC1_AWCRH_RESET_VALUE;
  86  0028 725f540e      	clr	21518
  87                     ; 59     ADC1->AWCRL = ADC1_AWCRL_RESET_VALUE;
  89  002c 725f540f      	clr	21519
  90                     ; 60 }
  93  0030 81            	ret	
 529                     ; 83 void ADC1_Init(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_PresSel_TypeDef ADC1_PrescalerSelection, ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState ADC1_ExtTriggerState, ADC1_Align_TypeDef ADC1_Align, ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState ADC1_SchmittTriggerState)
 529                     ; 84 {
 530                     	switch	.text
 531  0031               _ADC1_Init:
 533  0031 89            	pushw	x
 534       00000000      OFST:	set	0
 537                     ; 87     assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
 539                     ; 88     assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
 541                     ; 89     assert_param(IS_ADC1_PRESSEL_OK(ADC1_PrescalerSelection));
 543                     ; 90     assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
 545                     ; 91     assert_param(IS_FUNCTIONALSTATE_OK(((ADC1_ExtTriggerState))));
 547                     ; 92     assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
 549                     ; 93     assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
 551                     ; 94     assert_param(IS_FUNCTIONALSTATE_OK(ADC1_SchmittTriggerState));
 553                     ; 99     ADC1_ConversionConfig(ADC1_ConversionMode, ADC1_Channel, ADC1_Align);
 555  0032 7b08          	ld	a,(OFST+8,sp)
 556  0034 88            	push	a
 557  0035 7b02          	ld	a,(OFST+2,sp)
 558  0037 95            	ld	xh,a
 559  0038 cd011b        	call	_ADC1_ConversionConfig
 561  003b 84            	pop	a
 562                     ; 101     ADC1_PrescalerConfig(ADC1_PrescalerSelection);
 564  003c 7b05          	ld	a,(OFST+5,sp)
 565  003e ad54          	call	_ADC1_PrescalerConfig
 567                     ; 106     ADC1_ExternalTriggerConfig(ADC1_ExtTrigger, ADC1_ExtTriggerState);
 569  0040 7b07          	ld	a,(OFST+7,sp)
 570  0042 97            	ld	xl,a
 571  0043 7b06          	ld	a,(OFST+6,sp)
 572  0045 95            	ld	xh,a
 573  0046 cd0148        	call	_ADC1_ExternalTriggerConfig
 575                     ; 111     ADC1_SchmittTriggerConfig(ADC1_SchmittTriggerChannel, ADC1_SchmittTriggerState);
 577  0049 7b0a          	ld	a,(OFST+10,sp)
 578  004b 97            	ld	xl,a
 579  004c 7b09          	ld	a,(OFST+9,sp)
 580  004e 95            	ld	xh,a
 581  004f ad56          	call	_ADC1_SchmittTriggerConfig
 583                     ; 114     ADC1->CR1 |= ADC1_CR1_ADON;
 585  0051 72105401      	bset	21505,#0
 586                     ; 116 }
 589  0055 85            	popw	x
 590  0056 81            	ret	
 625                     ; 124 void ADC1_Cmd(FunctionalState NewState)
 625                     ; 125 {
 626                     	switch	.text
 627  0057               _ADC1_Cmd:
 631                     ; 128     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 633                     ; 130     if (NewState != DISABLE)
 635  0057 4d            	tnz	a
 636  0058 2705          	jreq	L752
 637                     ; 132         ADC1->CR1 |= ADC1_CR1_ADON;
 639  005a 72105401      	bset	21505,#0
 642  005e 81            	ret	
 643  005f               L752:
 644                     ; 136         ADC1->CR1 &= (u8)(~ADC1_CR1_ADON);
 646  005f 72115401      	bres	21505,#0
 647                     ; 139 }
 650  0063 81            	ret	
 685                     ; 146 void ADC1_ScanModeCmd(FunctionalState NewState)
 685                     ; 147 {
 686                     	switch	.text
 687  0064               _ADC1_ScanModeCmd:
 691                     ; 150     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 693                     ; 152     if (NewState != DISABLE)
 695  0064 4d            	tnz	a
 696  0065 2705          	jreq	L103
 697                     ; 154         ADC1->CR2 |= ADC1_CR2_SCAN;
 699  0067 72125402      	bset	21506,#1
 702  006b 81            	ret	
 703  006c               L103:
 704                     ; 158         ADC1->CR2 &= (u8)(~ADC1_CR2_SCAN);
 706  006c 72135402      	bres	21506,#1
 707                     ; 161 }
 710  0070 81            	ret	
 745                     ; 168 void ADC1_DataBufferCmd(FunctionalState NewState)
 745                     ; 169 {
 746                     	switch	.text
 747  0071               _ADC1_DataBufferCmd:
 751                     ; 172     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 753                     ; 174     if (NewState != DISABLE)
 755  0071 4d            	tnz	a
 756  0072 2705          	jreq	L323
 757                     ; 176         ADC1->CR3 |= ADC1_CR3_DBUF;
 759  0074 721e5403      	bset	21507,#7
 762  0078 81            	ret	
 763  0079               L323:
 764                     ; 180         ADC1->CR3 &= (u8)(~ADC1_CR3_DBUF);
 766  0079 721f5403      	bres	21507,#7
 767                     ; 183 }
 770  007d 81            	ret	
 919                     ; 194 void ADC1_ITConfig(ADC1_IT_TypeDef ADC1_IT, FunctionalState NewState)
 919                     ; 195 {
 920                     	switch	.text
 921  007e               _ADC1_ITConfig:
 923  007e 89            	pushw	x
 924       00000000      OFST:	set	0
 927                     ; 198     assert_param(IS_ADC1_IT_OK(ADC1_IT));
 929                     ; 199     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 931                     ; 201     if (NewState != DISABLE)
 933  007f 7b05          	ld	a,(OFST+5,sp)
 934  0081 2706          	jreq	L114
 935                     ; 204         ADC1->CSR |= (u8)ADC1_IT;
 937  0083 9f            	ld	a,xl
 938  0084 ca5400        	or	a,21504
 940  0087 2006          	jra	L314
 941  0089               L114:
 942                     ; 209         ADC1->CSR &= (u8)(~ADC1_IT);
 944  0089 7b02          	ld	a,(OFST+2,sp)
 945  008b 43            	cpl	a
 946  008c c45400        	and	a,21504
 947  008f               L314:
 948  008f c75400        	ld	21504,a
 949                     ; 212 }
 952  0092 85            	popw	x
 953  0093 81            	ret	
 989                     ; 220 void ADC1_PrescalerConfig(ADC1_PresSel_TypeDef ADC1_Prescaler)
 989                     ; 221 {
 990                     	switch	.text
 991  0094               _ADC1_PrescalerConfig:
 993  0094 88            	push	a
 994       00000000      OFST:	set	0
 997                     ; 224     assert_param(IS_ADC1_PRESSEL_OK(ADC1_Prescaler));
 999                     ; 227     ADC1->CR1 &= (u8)(~ADC1_CR1_SPSEL);
1001  0095 c65401        	ld	a,21505
1002  0098 a48f          	and	a,#143
1003  009a c75401        	ld	21505,a
1004                     ; 229     ADC1->CR1 |= (u8)(ADC1_Prescaler);
1006  009d c65401        	ld	a,21505
1007  00a0 1a01          	or	a,(OFST+1,sp)
1008  00a2 c75401        	ld	21505,a
1009                     ; 231 }
1012  00a5 84            	pop	a
1013  00a6 81            	ret	
1060                     ; 242 void ADC1_SchmittTriggerConfig(ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState NewState)
1060                     ; 243 {
1061                     	switch	.text
1062  00a7               _ADC1_SchmittTriggerConfig:
1064  00a7 89            	pushw	x
1065       00000000      OFST:	set	0
1068                     ; 246     assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
1070                     ; 247     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1072                     ; 249     if (ADC1_SchmittTriggerChannel == ADC1_SCHMITTTRIG_ALL)
1074  00a8 9e            	ld	a,xh
1075  00a9 4c            	inc	a
1076  00aa 261d          	jrne	L554
1077                     ; 251         if (NewState != DISABLE)
1079  00ac 9f            	ld	a,xl
1080  00ad 4d            	tnz	a
1081  00ae 270a          	jreq	L754
1082                     ; 253             ADC1->TDRL &= (u8)0x0;
1084  00b0 725f5407      	clr	21511
1085                     ; 254             ADC1->TDRH &= (u8)0x0;
1087  00b4 725f5406      	clr	21510
1089  00b8 2059          	jra	L364
1090  00ba               L754:
1091                     ; 258             ADC1->TDRL |= (u8)0xFF;
1093  00ba c65407        	ld	a,21511
1094  00bd aaff          	or	a,#255
1095  00bf c75407        	ld	21511,a
1096                     ; 259             ADC1->TDRH |= (u8)0xFF;
1098  00c2 c65406        	ld	a,21510
1099  00c5 aaff          	or	a,#255
1100  00c7 2047          	jp	LC001
1101  00c9               L554:
1102                     ; 262     else if (ADC1_SchmittTriggerChannel < ADC1_SCHMITTTRIG_CHANNEL8)
1104  00c9 7b01          	ld	a,(OFST+1,sp)
1105  00cb a108          	cp	a,#8
1106  00cd 0d02          	tnz	(OFST+2,sp)
1107  00cf 2420          	jruge	L564
1108                     ; 264         if (NewState != DISABLE)
1110  00d1 2711          	jreq	L764
1111                     ; 266             ADC1->TDRL &= (u8)(~(u8)((u8)0x01 << (u8)ADC1_SchmittTriggerChannel));
1113  00d3 ad40          	call	LC003
1114  00d5 2704          	jreq	L43
1115  00d7               L63:
1116  00d7 48            	sll	a
1117  00d8 5a            	decw	x
1118  00d9 26fc          	jrne	L63
1119  00db               L43:
1120  00db 43            	cpl	a
1121  00dc c45407        	and	a,21511
1122  00df               LC002:
1123  00df c75407        	ld	21511,a
1125  00e2 202f          	jra	L364
1126  00e4               L764:
1127                     ; 270             ADC1->TDRL |= (u8)((u8)0x01 << (u8)ADC1_SchmittTriggerChannel);
1129  00e4 ad2f          	call	LC003
1130  00e6 2704          	jreq	L04
1131  00e8               L24:
1132  00e8 48            	sll	a
1133  00e9 5a            	decw	x
1134  00ea 26fc          	jrne	L24
1135  00ec               L04:
1136  00ec ca5407        	or	a,21511
1137  00ef 20ee          	jp	LC002
1138  00f1               L564:
1139                     ; 275         if (NewState != DISABLE)
1141  00f1 2710          	jreq	L574
1142                     ; 277             ADC1->TDRH &= (u8)(~(u8)((u8)0x01 << ((u8)ADC1_SchmittTriggerChannel - (u8)8)));
1144  00f3 a008          	sub	a,#8
1145  00f5 ad1e          	call	LC003
1146  00f7 2704          	jreq	L44
1147  00f9               L64:
1148  00f9 48            	sll	a
1149  00fa 5a            	decw	x
1150  00fb 26fc          	jrne	L64
1151  00fd               L44:
1152  00fd 43            	cpl	a
1153  00fe c45406        	and	a,21510
1155  0101 200d          	jp	LC001
1156  0103               L574:
1157                     ; 281             ADC1->TDRH |= (u8)((u8)0x01 << ((u8)ADC1_SchmittTriggerChannel - (u8)8));
1159  0103 a008          	sub	a,#8
1160  0105 ad0e          	call	LC003
1161  0107 2704          	jreq	L05
1162  0109               L25:
1163  0109 48            	sll	a
1164  010a 5a            	decw	x
1165  010b 26fc          	jrne	L25
1166  010d               L05:
1167  010d ca5406        	or	a,21510
1168  0110               LC001:
1169  0110 c75406        	ld	21510,a
1170  0113               L364:
1171                     ; 285 }
1174  0113 85            	popw	x
1175  0114 81            	ret	
1176  0115               LC003:
1177  0115 5f            	clrw	x
1178  0116 97            	ld	xl,a
1179  0117 a601          	ld	a,#1
1180  0119 5d            	tnzw	x
1181  011a 81            	ret	
1238                     ; 298 void ADC1_ConversionConfig(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_Align_TypeDef ADC1_Align)
1238                     ; 299 {
1239                     	switch	.text
1240  011b               _ADC1_ConversionConfig:
1242  011b 89            	pushw	x
1243       00000000      OFST:	set	0
1246                     ; 302     assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
1248                     ; 303     assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
1250                     ; 304     assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
1252                     ; 307     ADC1->CR2 &= (u8)(~ADC1_CR2_ALIGN);
1254  011c 72175402      	bres	21506,#3
1255                     ; 309     ADC1->CR2 |= (u8)(ADC1_Align);
1257  0120 c65402        	ld	a,21506
1258  0123 1a05          	or	a,(OFST+5,sp)
1259  0125 c75402        	ld	21506,a
1260                     ; 311     if (ADC1_ConversionMode == ADC1_CONVERSIONMODE_CONTINUOUS)
1262  0128 9e            	ld	a,xh
1263  0129 4a            	dec	a
1264  012a 2606          	jrne	L725
1265                     ; 314         ADC1->CR1 |= ADC1_CR1_CONT;
1267  012c 72125401      	bset	21505,#1
1269  0130 2004          	jra	L135
1270  0132               L725:
1271                     ; 319         ADC1->CR1 &= (u8)(~ADC1_CR1_CONT);
1273  0132 72135401      	bres	21505,#1
1274  0136               L135:
1275                     ; 323     ADC1->CSR &= (u8)(~ADC1_CSR_CH);
1277  0136 c65400        	ld	a,21504
1278  0139 a4f0          	and	a,#240
1279  013b c75400        	ld	21504,a
1280                     ; 325     ADC1->CSR |= (u8)(ADC1_Channel);
1282  013e c65400        	ld	a,21504
1283  0141 1a02          	or	a,(OFST+2,sp)
1284  0143 c75400        	ld	21504,a
1285                     ; 327 }
1288  0146 85            	popw	x
1289  0147 81            	ret	
1335                     ; 340 void ADC1_ExternalTriggerConfig(ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState NewState)
1335                     ; 341 {
1336                     	switch	.text
1337  0148               _ADC1_ExternalTriggerConfig:
1339  0148 89            	pushw	x
1340       00000000      OFST:	set	0
1343                     ; 344     assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
1345                     ; 345     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1347                     ; 348     ADC1->CR2 &= (u8)(~ADC1_CR2_EXTSEL);
1349  0149 c65402        	ld	a,21506
1350  014c a4cf          	and	a,#207
1351  014e c75402        	ld	21506,a
1352                     ; 350     if (NewState != DISABLE)
1354  0151 9f            	ld	a,xl
1355  0152 4d            	tnz	a
1356  0153 2706          	jreq	L555
1357                     ; 353         ADC1->CR2 |= (u8)(ADC1_CR2_EXTTRIG);
1359  0155 721c5402      	bset	21506,#6
1361  0159 2004          	jra	L755
1362  015b               L555:
1363                     ; 358         ADC1->CR2 &= (u8)(~ADC1_CR2_EXTTRIG);
1365  015b 721d5402      	bres	21506,#6
1366  015f               L755:
1367                     ; 362     ADC1->CR2 |= (u8)(ADC1_ExtTrigger);
1369  015f c65402        	ld	a,21506
1370  0162 1a01          	or	a,(OFST+1,sp)
1371  0164 c75402        	ld	21506,a
1372                     ; 364 }
1375  0167 85            	popw	x
1376  0168 81            	ret	
1400                     ; 377 void ADC1_StartConversion(void)
1400                     ; 378 {
1401                     	switch	.text
1402  0169               _ADC1_StartConversion:
1406                     ; 379     ADC1->CR1 |= ADC1_CR1_ADON;
1408  0169 72105401      	bset	21505,#0
1409                     ; 380 }
1412  016d 81            	ret	
1456                     ; 390 u16 ADC1_GetConversionValue(void)
1456                     ; 391 {
1457                     	switch	.text
1458  016e               _ADC1_GetConversionValue:
1460  016e 5205          	subw	sp,#5
1461       00000005      OFST:	set	5
1464                     ; 393     u16 temph = 0;
1466                     ; 394     u8 templ = 0;
1468                     ; 396     if (ADC1->CR2 & ADC1_CR2_ALIGN) /* Right alignment */
1470  0170 720754020e    	btjf	21506,#3,L316
1471                     ; 399         templ = ADC1->DRL;
1473  0175 c65405        	ld	a,21509
1474  0178 6b03          	ld	(OFST-2,sp),a
1476                     ; 401         temph = ADC1->DRH;
1478  017a c65404        	ld	a,21508
1479  017d 97            	ld	xl,a
1481                     ; 403         temph = (u16)(templ | (u16)(temph << (u8)8));
1483  017e 7b03          	ld	a,(OFST-2,sp)
1484  0180 02            	rlwa	x,a
1487  0181 201a          	jra	L516
1488  0183               L316:
1489                     ; 408         temph = ADC1->DRH;
1491  0183 c65404        	ld	a,21508
1492  0186 97            	ld	xl,a
1494                     ; 410         templ = ADC1->DRL;
1496  0187 c65405        	ld	a,21509
1497  018a 6b03          	ld	(OFST-2,sp),a
1499                     ; 412         temph = (u16)((u16)(templ << (u8)6) | (u16)(temph << (u8)8));
1501  018c 4f            	clr	a
1502  018d 02            	rlwa	x,a
1503  018e 1f01          	ldw	(OFST-4,sp),x
1505  0190 7b03          	ld	a,(OFST-2,sp)
1506  0192 97            	ld	xl,a
1507  0193 a640          	ld	a,#64
1508  0195 42            	mul	x,a
1509  0196 01            	rrwa	x,a
1510  0197 1a02          	or	a,(OFST-3,sp)
1511  0199 01            	rrwa	x,a
1512  019a 1a01          	or	a,(OFST-4,sp)
1513  019c 01            	rrwa	x,a
1515  019d               L516:
1516                     ; 415     return ((u16)temph);
1520  019d 5b05          	addw	sp,#5
1521  019f 81            	ret	
1567                     ; 427 void ADC1_AWDChannelConfig(ADC1_Channel_TypeDef Channel, FunctionalState NewState)
1567                     ; 428 {
1568                     	switch	.text
1569  01a0               _ADC1_AWDChannelConfig:
1571  01a0 89            	pushw	x
1572       00000000      OFST:	set	0
1575                     ; 430     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1577                     ; 431     assert_param(IS_ADC1_CHANNEL_OK(Channel));
1579                     ; 433     if (Channel < (u8)8)
1581  01a1 9e            	ld	a,xh
1582  01a2 a108          	cp	a,#8
1583  01a4 2425          	jruge	L146
1584                     ; 435         if (NewState != DISABLE)
1586  01a6 9f            	ld	a,xl
1587  01a7 4d            	tnz	a
1588  01a8 270e          	jreq	L346
1589                     ; 437             ADC1->AWCRL |= (u8)((u8)1 << Channel);
1591  01aa 9e            	ld	a,xh
1592  01ab ad48          	call	LC006
1593  01ad 2704          	jreq	L66
1594  01af               L07:
1595  01af 48            	sll	a
1596  01b0 5a            	decw	x
1597  01b1 26fc          	jrne	L07
1598  01b3               L66:
1599  01b3 ca540f        	or	a,21519
1601  01b6 200e          	jp	LC005
1602  01b8               L346:
1603                     ; 441             ADC1->AWCRL &= (u8)(~((u8)1 << Channel));
1605  01b8 7b01          	ld	a,(OFST+1,sp)
1606  01ba ad39          	call	LC006
1607  01bc 2704          	jreq	L27
1608  01be               L47:
1609  01be 48            	sll	a
1610  01bf 5a            	decw	x
1611  01c0 26fc          	jrne	L47
1612  01c2               L27:
1613  01c2 43            	cpl	a
1614  01c3 c4540f        	and	a,21519
1615  01c6               LC005:
1616  01c6 c7540f        	ld	21519,a
1617  01c9 2028          	jra	L746
1618  01cb               L146:
1619                     ; 446         if (NewState != DISABLE)
1621  01cb 7b02          	ld	a,(OFST+2,sp)
1622  01cd 2711          	jreq	L156
1623                     ; 448             ADC1->AWCRH |= (u8)((u8)1 << (Channel - (u8)8));
1625  01cf 7b01          	ld	a,(OFST+1,sp)
1626  01d1 a008          	sub	a,#8
1627  01d3 ad20          	call	LC006
1628  01d5 2704          	jreq	L67
1629  01d7               L001:
1630  01d7 48            	sll	a
1631  01d8 5a            	decw	x
1632  01d9 26fc          	jrne	L001
1633  01db               L67:
1634  01db ca540e        	or	a,21518
1636  01de 2010          	jp	LC004
1637  01e0               L156:
1638                     ; 452             ADC1->AWCRH &= (u8)(~((u8)1 << (Channel - (u8)8)));
1640  01e0 7b01          	ld	a,(OFST+1,sp)
1641  01e2 a008          	sub	a,#8
1642  01e4 ad0f          	call	LC006
1643  01e6 2704          	jreq	L201
1644  01e8               L401:
1645  01e8 48            	sll	a
1646  01e9 5a            	decw	x
1647  01ea 26fc          	jrne	L401
1648  01ec               L201:
1649  01ec 43            	cpl	a
1650  01ed c4540e        	and	a,21518
1651  01f0               LC004:
1652  01f0 c7540e        	ld	21518,a
1653  01f3               L746:
1654                     ; 455 }
1657  01f3 85            	popw	x
1658  01f4 81            	ret	
1659  01f5               LC006:
1660  01f5 5f            	clrw	x
1661  01f6 97            	ld	xl,a
1662  01f7 a601          	ld	a,#1
1663  01f9 5d            	tnzw	x
1664  01fa 81            	ret	
1699                     ; 463 void ADC1_SetHighThreshold(u16 Threshold)
1699                     ; 464 {
1700                     	switch	.text
1701  01fb               _ADC1_SetHighThreshold:
1705                     ; 465     ADC1->HTRH = (u8)(Threshold >> (u8)8);
1707  01fb 9e            	ld	a,xh
1708  01fc c75408        	ld	21512,a
1709                     ; 466     ADC1->HTRL = (u8)Threshold;
1711  01ff 9f            	ld	a,xl
1712  0200 c75409        	ld	21513,a
1713                     ; 467 }
1716  0203 81            	ret	
1751                     ; 475 void ADC1_SetLowThreshold(u16 Threshold)
1751                     ; 476 {
1752                     	switch	.text
1753  0204               _ADC1_SetLowThreshold:
1757                     ; 477     ADC1->LTRL = (u8)Threshold;
1759  0204 9f            	ld	a,xl
1760  0205 c7540b        	ld	21515,a
1761                     ; 478     ADC1->LTRH = (u8)(Threshold >> (u8)8);
1763  0208 9e            	ld	a,xh
1764  0209 c7540a        	ld	21514,a
1765                     ; 479 }
1768  020c 81            	ret	
1821                     ; 488 u16 ADC1_GetBufferValue(u8 Buffer)
1821                     ; 489 {
1822                     	switch	.text
1823  020d               _ADC1_GetBufferValue:
1825  020d 88            	push	a
1826  020e 5205          	subw	sp,#5
1827       00000005      OFST:	set	5
1830                     ; 491     u16 temph = 0;
1832                     ; 492     u8 templ = 0;
1834                     ; 495     assert_param(IS_ADC1_BUFFER_OK(Buffer));
1836                     ; 497     if (ADC1->CR2 & ADC1_CR2_ALIGN) /* Right alignment */
1838  0210 5f            	clrw	x
1839  0211 97            	ld	xl,a
1840  0212 58            	sllw	x
1841  0213 720754020e    	btjf	21506,#3,L737
1842                     ; 500         templ = *(u8*)(ADC1_BaseAddress + (Buffer << 1) + 1);
1844  0218 d653e1        	ld	a,(21473,x)
1845  021b 6b03          	ld	(OFST-2,sp),a
1847                     ; 502         temph = *(u8*)(ADC1_BaseAddress + (Buffer << 1));
1849  021d d653e0        	ld	a,(21472,x)
1850  0220 97            	ld	xl,a
1852                     ; 504         temph = (u16)(templ | (u16)(temph << (u8)8));
1854  0221 7b03          	ld	a,(OFST-2,sp)
1855  0223 02            	rlwa	x,a
1858  0224 2024          	jra	L147
1859  0226               L737:
1860                     ; 509         temph = *(u8*)(ADC1_BaseAddress + (Buffer << 1));
1862  0226 d653e0        	ld	a,(21472,x)
1863  0229 5f            	clrw	x
1864  022a 97            	ld	xl,a
1865  022b 1f04          	ldw	(OFST-1,sp),x
1867                     ; 511         templ = *(u8*)(ADC1_BaseAddress + (Buffer << 1) + 1);
1869  022d 5f            	clrw	x
1870  022e 7b06          	ld	a,(OFST+1,sp)
1871  0230 97            	ld	xl,a
1872  0231 58            	sllw	x
1873  0232 d653e1        	ld	a,(21473,x)
1874  0235 6b03          	ld	(OFST-2,sp),a
1876                     ; 513         temph = (u16)((u16)(templ << (u8)6) | (u16)(temph << (u8)8));
1878  0237 4f            	clr	a
1879  0238 1e04          	ldw	x,(OFST-1,sp)
1880  023a 02            	rlwa	x,a
1881  023b 1f01          	ldw	(OFST-4,sp),x
1883  023d 7b03          	ld	a,(OFST-2,sp)
1884  023f 97            	ld	xl,a
1885  0240 a640          	ld	a,#64
1886  0242 42            	mul	x,a
1887  0243 01            	rrwa	x,a
1888  0244 1a02          	or	a,(OFST-3,sp)
1889  0246 01            	rrwa	x,a
1890  0247 1a01          	or	a,(OFST-4,sp)
1891  0249 01            	rrwa	x,a
1893  024a               L147:
1894                     ; 516     return ((u16)temph);
1898  024a 5b06          	addw	sp,#6
1899  024c 81            	ret	
1965                     ; 526 FlagStatus ADC1_GetAWDChannelStatus(ADC1_Channel_TypeDef Channel)
1965                     ; 527 {
1966                     	switch	.text
1967  024d               _ADC1_GetAWDChannelStatus:
1969       00000001      OFST:	set	1
1972                     ; 528     u8 status = 0;
1974                     ; 531     assert_param(IS_ADC1_CHANNEL_OK(Channel));
1976                     ; 533     if (Channel < (u8)8)
1978  024d a108          	cp	a,#8
1979  024f 240f          	jruge	L577
1980                     ; 535         status = (u8)(ADC1->AWSRL & ((u8)1 << Channel));
1982  0251 5f            	clrw	x
1983  0252 97            	ld	xl,a
1984  0253 a601          	ld	a,#1
1985  0255 5d            	tnzw	x
1986  0256 2704          	jreq	L611
1987  0258               L021:
1988  0258 48            	sll	a
1989  0259 5a            	decw	x
1990  025a 26fc          	jrne	L021
1991  025c               L611:
1992  025c c4540d        	and	a,21517
1996  025f 81            	ret	
1997  0260               L577:
1998                     ; 539         status = (u8)(ADC1->AWSRH & ((u8)1 << (Channel - (u8)8)));
2000  0260 a008          	sub	a,#8
2001  0262 5f            	clrw	x
2002  0263 97            	ld	xl,a
2003  0264 a601          	ld	a,#1
2004  0266 5d            	tnzw	x
2005  0267 2704          	jreq	L221
2006  0269               L421:
2007  0269 48            	sll	a
2008  026a 5a            	decw	x
2009  026b 26fc          	jrne	L421
2010  026d               L221:
2011  026d c4540c        	and	a,21516
2013                     ; 542     return ((FlagStatus)status);
2017  0270 81            	ret	
2168                     ; 551 FlagStatus ADC1_GetFlagStatus(ADC1_Flag_TypeDef Flag)
2168                     ; 552 {
2169                     	switch	.text
2170  0271               _ADC1_GetFlagStatus:
2172  0271 88            	push	a
2173  0272 88            	push	a
2174       00000001      OFST:	set	1
2177                     ; 553     u8 flagstatus = 0;
2179                     ; 554     u8 temp = 0;
2181                     ; 557     assert_param(IS_ADC1_FLAG_OK(Flag));
2183                     ; 559     if ((Flag & 0x0F) == 0x01)
2185  0273 a40f          	and	a,#15
2186  0275 4a            	dec	a
2187  0276 2607          	jrne	L5601
2188                     ; 562         flagstatus = (u8)(ADC1->CR3 & ADC1_CR3_OVR);
2190  0278 c65403        	ld	a,21507
2191  027b a440          	and	a,#64
2194  027d 2039          	jra	L7601
2195  027f               L5601:
2196                     ; 564     else if ((Flag & 0xF0) == 0x10)
2198  027f 7b02          	ld	a,(OFST+1,sp)
2199  0281 a4f0          	and	a,#240
2200  0283 a110          	cp	a,#16
2201  0285 262c          	jrne	L1701
2202                     ; 567         temp = (u8)(Flag & 0x0F);
2204  0287 7b02          	ld	a,(OFST+1,sp)
2205  0289 a40f          	and	a,#15
2206  028b 6b01          	ld	(OFST+0,sp),a
2208                     ; 568         if (temp < 8)
2210  028d a108          	cp	a,#8
2211  028f 2410          	jruge	L3701
2212                     ; 570             flagstatus = (u8)(ADC1->AWSRL & (1 << temp));
2214  0291 5f            	clrw	x
2215  0292 97            	ld	xl,a
2216  0293 a601          	ld	a,#1
2217  0295 5d            	tnzw	x
2218  0296 2704          	jreq	L031
2219  0298               L231:
2220  0298 48            	sll	a
2221  0299 5a            	decw	x
2222  029a 26fc          	jrne	L231
2223  029c               L031:
2224  029c c4540d        	and	a,21517
2227  029f 2017          	jra	L7601
2228  02a1               L3701:
2229                     ; 574             flagstatus = (u8)(ADC1->AWSRH & (1 << (temp - 8)));
2231  02a1 a008          	sub	a,#8
2232  02a3 5f            	clrw	x
2233  02a4 97            	ld	xl,a
2234  02a5 a601          	ld	a,#1
2235  02a7 5d            	tnzw	x
2236  02a8 2704          	jreq	L431
2237  02aa               L631:
2238  02aa 48            	sll	a
2239  02ab 5a            	decw	x
2240  02ac 26fc          	jrne	L631
2241  02ae               L431:
2242  02ae c4540c        	and	a,21516
2244  02b1 2005          	jra	L7601
2245  02b3               L1701:
2246                     ; 579         flagstatus = (u8)(ADC1->CSR & Flag);
2248  02b3 c65400        	ld	a,21504
2249  02b6 1402          	and	a,(OFST+1,sp)
2251  02b8               L7601:
2252                     ; 581     return ((FlagStatus)flagstatus);
2256  02b8 85            	popw	x
2257  02b9 81            	ret	
2301                     ; 591 void ADC1_ClearFlag(ADC1_Flag_TypeDef Flag)
2301                     ; 592 {
2302                     	switch	.text
2303  02ba               _ADC1_ClearFlag:
2305  02ba 88            	push	a
2306  02bb 88            	push	a
2307       00000001      OFST:	set	1
2310                     ; 593     u8 temp = 0;
2312                     ; 596     assert_param(IS_ADC1_FLAG_OK(Flag));
2314                     ; 598     if ((Flag & 0x0F) == 0x01)
2316  02bc a40f          	and	a,#15
2317  02be 4a            	dec	a
2318  02bf 2606          	jrne	L3211
2319                     ; 601         ADC1->CR3 &= (u8)(~ADC1_CR3_OVR);
2321  02c1 721d5403      	bres	21507,#6
2323  02c5 2045          	jra	L5211
2324  02c7               L3211:
2325                     ; 603     else if ((Flag & 0xF0) == 0x10)
2327  02c7 7b02          	ld	a,(OFST+1,sp)
2328  02c9 a4f0          	and	a,#240
2329  02cb a110          	cp	a,#16
2330  02cd 2634          	jrne	L7211
2331                     ; 606         temp = (u8)(Flag & 0x0F);
2333  02cf 7b02          	ld	a,(OFST+1,sp)
2334  02d1 a40f          	and	a,#15
2335  02d3 6b01          	ld	(OFST+0,sp),a
2337                     ; 607         if (temp < 8)
2339  02d5 a108          	cp	a,#8
2340  02d7 2414          	jruge	L1311
2341                     ; 609             ADC1->AWSRL &= (u8)(~((u8)1 << temp));
2343  02d9 5f            	clrw	x
2344  02da 97            	ld	xl,a
2345  02db a601          	ld	a,#1
2346  02dd 5d            	tnzw	x
2347  02de 2704          	jreq	L241
2348  02e0               L441:
2349  02e0 48            	sll	a
2350  02e1 5a            	decw	x
2351  02e2 26fc          	jrne	L441
2352  02e4               L241:
2353  02e4 43            	cpl	a
2354  02e5 c4540d        	and	a,21517
2355  02e8 c7540d        	ld	21517,a
2357  02eb 201f          	jra	L5211
2358  02ed               L1311:
2359                     ; 613             ADC1->AWSRH &= (u8)(~((u8)1 << (temp - 8)));
2361  02ed a008          	sub	a,#8
2362  02ef 5f            	clrw	x
2363  02f0 97            	ld	xl,a
2364  02f1 a601          	ld	a,#1
2365  02f3 5d            	tnzw	x
2366  02f4 2704          	jreq	L641
2367  02f6               L051:
2368  02f6 48            	sll	a
2369  02f7 5a            	decw	x
2370  02f8 26fc          	jrne	L051
2371  02fa               L641:
2372  02fa 43            	cpl	a
2373  02fb c4540c        	and	a,21516
2374  02fe c7540c        	ld	21516,a
2375  0301 2009          	jra	L5211
2376  0303               L7211:
2377                     ; 618         ADC1->CSR &= (u8) (~Flag);
2379  0303 7b02          	ld	a,(OFST+1,sp)
2380  0305 43            	cpl	a
2381  0306 c45400        	and	a,21504
2382  0309 c75400        	ld	21504,a
2383  030c               L5211:
2384                     ; 620 }
2387  030c 85            	popw	x
2388  030d 81            	ret	
2443                     ; 640 ITStatus ADC1_GetITStatus(ADC1_IT_TypeDef ITPendingBit)
2443                     ; 641 {
2444                     	switch	.text
2445  030e               _ADC1_GetITStatus:
2447  030e 89            	pushw	x
2448  030f 88            	push	a
2449       00000001      OFST:	set	1
2452                     ; 642     ITStatus itstatus = RESET;
2454                     ; 643     u8 temp = 0;
2456                     ; 646     assert_param(IS_ADC1_ITPENDINGBIT_OK(ITPendingBit));
2458                     ; 648     if ((ITPendingBit & 0xF0) == 0x10)
2460  0310 01            	rrwa	x,a
2461  0311 a4f0          	and	a,#240
2462  0313 5f            	clrw	x
2463  0314 02            	rlwa	x,a
2464  0315 a30010        	cpw	x,#16
2465  0318 262c          	jrne	L5611
2466                     ; 651         temp = (u8)(ITPendingBit & 0x0F);
2468  031a 7b03          	ld	a,(OFST+2,sp)
2469  031c a40f          	and	a,#15
2470  031e 6b01          	ld	(OFST+0,sp),a
2472                     ; 652         if (temp < 8)
2474  0320 a108          	cp	a,#8
2475  0322 2410          	jruge	L7611
2476                     ; 654             itstatus = (u8)(ADC1->AWSRL & (u8)((u8)1 << temp));
2478  0324 5f            	clrw	x
2479  0325 97            	ld	xl,a
2480  0326 a601          	ld	a,#1
2481  0328 5d            	tnzw	x
2482  0329 2704          	jreq	L451
2483  032b               L651:
2484  032b 48            	sll	a
2485  032c 5a            	decw	x
2486  032d 26fc          	jrne	L651
2487  032f               L451:
2488  032f c4540d        	and	a,21517
2491  0332 2017          	jra	L3711
2492  0334               L7611:
2493                     ; 658             itstatus = (u8)(ADC1->AWSRH & (u8)((u8)1 << (temp - 8)));
2495  0334 a008          	sub	a,#8
2496  0336 5f            	clrw	x
2497  0337 97            	ld	xl,a
2498  0338 a601          	ld	a,#1
2499  033a 5d            	tnzw	x
2500  033b 2704          	jreq	L061
2501  033d               L261:
2502  033d 48            	sll	a
2503  033e 5a            	decw	x
2504  033f 26fc          	jrne	L261
2505  0341               L061:
2506  0341 c4540c        	and	a,21516
2508  0344 2005          	jra	L3711
2509  0346               L5611:
2510                     ; 663         itstatus = (u8)(ADC1->CSR & ITPendingBit);
2512  0346 c65400        	ld	a,21504
2513  0349 1403          	and	a,(OFST+2,sp)
2515  034b               L3711:
2516                     ; 665     return ((ITStatus)itstatus);
2520  034b 5b03          	addw	sp,#3
2521  034d 81            	ret	
2566                     ; 687 void ADC1_ClearITPendingBit(ADC1_IT_TypeDef ITPendingBit)
2566                     ; 688 {
2567                     	switch	.text
2568  034e               _ADC1_ClearITPendingBit:
2570  034e 89            	pushw	x
2571  034f 88            	push	a
2572       00000001      OFST:	set	1
2575                     ; 689     u8 temp = 0;
2577                     ; 692     assert_param(IS_ADC1_ITPENDINGBIT_OK(ITPendingBit));
2579                     ; 694     if ((ITPendingBit& 0xF0) == 0x10)
2581  0350 01            	rrwa	x,a
2582  0351 a4f0          	and	a,#240
2583  0353 5f            	clrw	x
2584  0354 02            	rlwa	x,a
2585  0355 a30010        	cpw	x,#16
2586  0358 2634          	jrne	L7121
2587                     ; 697         temp = (u8)(ITPendingBit & 0x0F);
2589  035a 7b03          	ld	a,(OFST+2,sp)
2590  035c a40f          	and	a,#15
2591  035e 6b01          	ld	(OFST+0,sp),a
2593                     ; 698         if (temp < 8)
2595  0360 a108          	cp	a,#8
2596  0362 2414          	jruge	L1221
2597                     ; 700             ADC1->AWSRL &= (u8)(~((u8)1 << temp));
2599  0364 5f            	clrw	x
2600  0365 97            	ld	xl,a
2601  0366 a601          	ld	a,#1
2602  0368 5d            	tnzw	x
2603  0369 2704          	jreq	L661
2604  036b               L071:
2605  036b 48            	sll	a
2606  036c 5a            	decw	x
2607  036d 26fc          	jrne	L071
2608  036f               L661:
2609  036f 43            	cpl	a
2610  0370 c4540d        	and	a,21517
2611  0373 c7540d        	ld	21517,a
2613  0376 201f          	jra	L5221
2614  0378               L1221:
2615                     ; 704             ADC1->AWSRH &= (u8)(~((u8)1 << (temp - 8)));
2617  0378 a008          	sub	a,#8
2618  037a 5f            	clrw	x
2619  037b 97            	ld	xl,a
2620  037c a601          	ld	a,#1
2621  037e 5d            	tnzw	x
2622  037f 2704          	jreq	L271
2623  0381               L471:
2624  0381 48            	sll	a
2625  0382 5a            	decw	x
2626  0383 26fc          	jrne	L471
2627  0385               L271:
2628  0385 43            	cpl	a
2629  0386 c4540c        	and	a,21516
2630  0389 c7540c        	ld	21516,a
2631  038c 2009          	jra	L5221
2632  038e               L7121:
2633                     ; 709         ADC1->CSR &= (u8) (~ITPendingBit);
2635  038e 7b03          	ld	a,(OFST+2,sp)
2636  0390 43            	cpl	a
2637  0391 c45400        	and	a,21504
2638  0394 c75400        	ld	21504,a
2639  0397               L5221:
2640                     ; 711 }
2643  0397 5b03          	addw	sp,#3
2644  0399 81            	ret	
2657                     	xdef	_ADC1_ClearITPendingBit
2658                     	xdef	_ADC1_GetITStatus
2659                     	xdef	_ADC1_ClearFlag
2660                     	xdef	_ADC1_GetFlagStatus
2661                     	xdef	_ADC1_GetAWDChannelStatus
2662                     	xdef	_ADC1_GetBufferValue
2663                     	xdef	_ADC1_SetLowThreshold
2664                     	xdef	_ADC1_SetHighThreshold
2665                     	xdef	_ADC1_GetConversionValue
2666                     	xdef	_ADC1_StartConversion
2667                     	xdef	_ADC1_AWDChannelConfig
2668                     	xdef	_ADC1_ExternalTriggerConfig
2669                     	xdef	_ADC1_ConversionConfig
2670                     	xdef	_ADC1_SchmittTriggerConfig
2671                     	xdef	_ADC1_PrescalerConfig
2672                     	xdef	_ADC1_ITConfig
2673                     	xdef	_ADC1_DataBufferCmd
2674                     	xdef	_ADC1_ScanModeCmd
2675                     	xdef	_ADC1_Cmd
2676                     	xdef	_ADC1_Init
2677                     	xdef	_ADC1_DeInit
2696                     	end
