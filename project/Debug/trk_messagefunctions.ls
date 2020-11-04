   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  19                     .const:	section	.text
  20  0000               _trk_messageFunctionsArray:
  21  0000 04            	dc.b	4
  23  0001 0000          	dc.w	_trk_ProcessNull
  53                     ; 14 unsigned long trk_ProcessNull(void)
  53                     ; 15 {
  55                     	switch	.text
  56  0000               _trk_ProcessNull:
  60                     ; 16    return msg_ProcessStopped;
  62  0000 aeea6d        	ldw	x,#60013
  63  0003 bf02          	ldw	c_lreg+2,x
  64  0005 5f            	clrw	x
  65  0006 bf00          	ldw	c_lreg,x
  68  0008 81            	ret	
 167                     	xdef	_trk_messageFunctionsArray
 168                     	xdef	_trk_ProcessNull
 169                     	xref.b	c_lreg
 188                     	end
