   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  19                     	bsct
  20  0000               _pressedKey:
  21  0000 00            	dc.b	0
  22  0001               _letNewPress:
  23  0001 00            	dc.b	0
  66                     ; 13 void ata_KeyOpen(trk_KeyCallbackFunct keycallback)
  66                     ; 14 {
  68                     	switch	.text
  69  0000               _ata_KeyOpen:
  73                     ; 15     ata_keycallback = keycallback;
  75  0000 bf00          	ldw	_ata_keycallback,x
  76                     ; 16 }
  79  0002 81            	ret	
 115                     ; 18 void ata_KeyHandleFromRemote(unsigned short function)
 115                     ; 19 {
 116                     	switch	.text
 117  0003               _ata_KeyHandleFromRemote:
 119  0003 89            	pushw	x
 120       00000000      OFST:	set	0
 123                     ; 20     if(function == 0x0C)
 125  0004 a3000c        	cpw	x,#12
 126  0007 2607          	jrne	L54
 127                     ; 22         ata_keycallback(POWERBUTTONREMOTE,TRUE,KEYFROMREMOTE);
 129  0009 4b01          	push	#1
 130  000b ae0701        	ldw	x,#1793
 133  000e 2016          	jp	LC001
 134  0010               L54:
 135                     ; 24     else if(function == 0x30)
 137  0010 a30030        	cpw	x,#48
 138  0013 2607          	jrne	L15
 139                     ; 26         ata_keycallback(REMOTELEVELDOWNKEY,TRUE,KEYFROMREMOTE);
 141  0015 4b01          	push	#1
 142  0017 ae0301        	ldw	x,#769
 145  001a 200a          	jp	LC001
 146  001c               L15:
 147                     ; 28     else if(function == 0xC0)
 149  001c a300c0        	cpw	x,#192
 150  001f 2609          	jrne	L74
 151                     ; 30         ata_keycallback(REMOTELEVELUPKEY,TRUE,KEYFROMREMOTE);
 153  0021 4b01          	push	#1
 154  0023 ae0401        	ldw	x,#1025
 156  0026               LC001:
 157  0026 92cd00        	call	[_ata_keycallback.w]
 158  0029 84            	pop	a
 159  002a               L74:
 160                     ; 32 }
 163  002a 85            	popw	x
 164  002b 81            	ret	
 202                     ; 34 unsigned long ata_KeyCheckThread(void)
 202                     ; 35 {
 203                     	switch	.text
 204  002c               _ata_KeyCheckThread:
 206  002c 88            	push	a
 207       00000001      OFST:	set	1
 210                     ; 36     unsigned char isAnyKeyPressed = TRUE;
 212  002d a601          	ld	a,#1
 213  002f 6b01          	ld	(OFST+0,sp),a
 215                     ; 38     if(GPIO_ReadInputPin(GPIOD, GPIO_PIN_3) != 0)
 217  0031 4b08          	push	#8
 218  0033 ae500f        	ldw	x,#20495
 219  0036 cd0000        	call	_GPIO_ReadInputPin
 221  0039 5b01          	addw	sp,#1
 222  003b 4d            	tnz	a
 223  003c 2706          	jreq	L57
 224                     ; 40         pressedKey = LEVELDOWNKEY;
 226  003e 35020000      	mov	_pressedKey,#2
 228  0042 2015          	jra	L77
 229  0044               L57:
 230                     ; 42     else if(GPIO_ReadInputPin(GPIOD, GPIO_PIN_2) != 0)
 232  0044 4b04          	push	#4
 233  0046 ae500f        	ldw	x,#20495
 234  0049 cd0000        	call	_GPIO_ReadInputPin
 236  004c 5b01          	addw	sp,#1
 237  004e 4d            	tnz	a
 238  004f 2706          	jreq	L101
 239                     ; 44         pressedKey = LEVELUPKEY;
 241  0051 35010000      	mov	_pressedKey,#1
 243  0055 2002          	jra	L77
 244  0057               L101:
 245                     ; 48         isAnyKeyPressed = FALSE;
 247  0057 6b01          	ld	(OFST+0,sp),a
 249  0059               L77:
 250                     ; 51     if(isAnyKeyPressed == TRUE)
 252  0059 7b01          	ld	a,(OFST+0,sp)
 253  005b 4a            	dec	a
 254  005c 261d          	jrne	L501
 255                     ; 53         if(letNewPress == TRUE)
 257  005e b601          	ld	a,_letNewPress
 258  0060 4a            	dec	a
 259  0061 261c          	jrne	L111
 260                     ; 55             ata_keycallback(pressedKey,TRUE,KEYFROMBUTTON);
 262  0063 4b00          	push	#0
 263  0065 b600          	ld	a,_pressedKey
 264  0067 ae0001        	ldw	x,#1
 265  006a 95            	ld	xh,a
 266  006b 92cd00        	call	[_ata_keycallback.w]
 268  006e 3f01          	clr	_letNewPress
 269  0070 ae00fa        	ldw	x,#250
 270  0073 bf02          	ldw	c_lreg+2,x
 271  0075 5f            	clrw	x
 272  0076 bf00          	ldw	c_lreg,x
 273                     ; 56             letNewPress = FALSE;
 275                     ; 58             return msg_ProcessAfter1ms*250;
 279  0078 5b02          	addw	sp,#2
 280  007a 81            	ret	
 281  007b               L501:
 282                     ; 63         letNewPress = TRUE;
 284  007b 35010001      	mov	_letNewPress,#1
 285  007f               L111:
 286                     ; 66     ata_keycallback(LEVELUPKEY,FALSE,KEYFROMBUTTON);
 288  007f 4b00          	push	#0
 289  0081 ae0100        	ldw	x,#256
 290  0084 92cd00        	call	[_ata_keycallback.w]
 292  0087 84            	pop	a
 293                     ; 67     ata_keycallback(LEVELDOWNKEY,FALSE,KEYFROMBUTTON);
 295  0088 4b00          	push	#0
 296  008a ae0200        	ldw	x,#512
 297  008d 92cd00        	call	[_ata_keycallback.w]
 299  0090 ae0032        	ldw	x,#50
 300  0093 bf02          	ldw	c_lreg+2,x
 301  0095 5f            	clrw	x
 302  0096 bf00          	ldw	c_lreg,x
 303                     ; 69     return msg_ProcessAfter1ms*50;
 307  0098 5b02          	addw	sp,#2
 308  009a 81            	ret	
 334                     ; 72 void ata_KeyInit(void)
 334                     ; 73 {
 335                     	switch	.text
 336  009b               _ata_KeyInit:
 340                     ; 75     msg_pushcallback(&ata_KeyCheckThread,	msg_ProcessAfter1ms);
 342  009b ae0001        	ldw	x,#1
 343  009e 89            	pushw	x
 344  009f ae002c        	ldw	x,#_ata_KeyCheckThread
 345  00a2 92cd00        	call	[_msg_pushcallback.w]
 347  00a5 85            	popw	x
 348                     ; 77 }
 351  00a6 81            	ret	
 395                     	xdef	_ata_KeyCheckThread
 396                     	xdef	_letNewPress
 397                     	xdef	_pressedKey
 398                     	xref	_GPIO_ReadInputPin
 399                     	xref.b	_msg_pushcallback
 400                     	xdef	_ata_KeyHandleFromRemote
 401                     	xdef	_ata_KeyInit
 402                     	xdef	_ata_KeyOpen
 403                     	switch	.ubsct
 404  0000               _ata_keycallback:
 405  0000 0000          	ds.b	2
 406                     	xdef	_ata_keycallback
 407                     	xref.b	c_lreg
 427                     	end
