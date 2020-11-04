   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  67                     ; 9 void trk_KeyCallback(unsigned char Key, unsigned char Pressed, RemoteControlKeyState RemotePressed)
  67                     ; 10 {     
  69                     	switch	.text
  70  0000               _trk_KeyCallback:
  74                     ; 11    if(Pressed == TRUE)
  76  0000 9f            	ld	a,xl
  77  0001 4a            	dec	a
  78  0002 2602          	jrne	L33
  79                     ; 13       if(Key == 0x00)
  81  0004 9e            	ld	a,xh
  82  0005 4d            	tnz	a
  83  0006               L33:
  84                     ; 18 }
  87  0006 81            	ret	
 113                     ; 20 void trk_appInit(void)
 113                     ; 21 {  
 114                     	switch	.text
 115  0007               _trk_appInit:
 119                     ; 22    ata_KeyOpen(&trk_KeyCallback);
 121  0007 ae0000        	ldw	x,#_trk_KeyCallback
 123                     ; 23 }
 126  000a cc0000        	jp	_ata_KeyOpen
 139                     	xref	_ata_KeyOpen
 140                     	xdef	_trk_appInit
 141                     	xdef	_trk_KeyCallback
 160                     	end
