   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.14 - 18 Nov 2019
   3                     ; Generator (Limited) V4.4.11 - 19 Nov 2019
   4                     ; Optimizer V4.4.11 - 19 Nov 2019
  61                     ; 4 void ata_SetInterruptStatus(unsigned char status)
  61                     ; 5 {
  63                     	switch	.text
  64  0000               _ata_SetInterruptStatus:
  66       00000000      OFST:	set	0
  69                     ; 6    if (status == DisableAllInterrupts)
  71  0000 4d            	tnz	a
  72  0001 2602          	jrne	L72
  73                     ; 8       disableInterrupts();
  76  0003 9b            	sim	
  81  0004 81            	ret	
  82  0005               L72:
  83                     ; 10    else if (status == EnableAllInterrupts)
  85  0005 4a            	dec	a
  86  0006 2601          	jrne	L13
  87                     ; 12       enableInterrupts();
  90  0008 9a            	rim	
  93  0009               L13:
  94                     ; 14 }
  97  0009 81            	ret	
 110                     	xdef	_ata_SetInterruptStatus
 129                     	end
