   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  74                     ; 8 void ata_MessageOpen(trk_MessageCallback MessageCallback, trk_PushMessageCallback PushMessageCallback)
  74                     ; 9 {
  76                     	switch	.text
  77  0000               _ata_MessageOpen:
  79       fffffffe      OFST: set -2
  82                     ; 10    msg_callback = MessageCallback;
  84  0000 bf02          	ldw	_msg_callback,x
  85                     ; 11    msg_pushcallback = PushMessageCallback;
  87  0002 1e03          	ldw	x,(OFST+5,sp)
  88  0004 bf00          	ldw	_msg_pushcallback,x
  89                     ; 12 }
  92  0006 81            	ret	
 116                     ; 14 void ata_MessageStackOverflow()
 116                     ; 15 {
 117                     	switch	.text
 118  0007               _ata_MessageStackOverflow:
 122                     ; 17 }
 125  0007 81            	ret	
 162                     	xdef	_ata_MessageStackOverflow
 163                     	xdef	_ata_MessageOpen
 164                     	switch	.ubsct
 165  0000               _msg_pushcallback:
 166  0000 0000          	ds.b	2
 167                     	xdef	_msg_pushcallback
 168  0002               _msg_callback:
 169  0002 0000          	ds.b	2
 170                     	xdef	_msg_callback
 190                     	end
