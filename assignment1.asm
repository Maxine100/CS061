;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Assignment name: Assignment 1
; Lab section: 25
; TA: Enoch Lin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

;------------------------------------------
;           BUILD TABLE HERE
;------------------------------------------
;
;-----------------------------------------------------
;REG VALUES 		R0	R1	R2	R3	R4	R5	R6	R7
;-----------------------------------------------------
;Pre-loop   		0	6	12	0	0	0	0	1168
;Iteration 1		0	5	12	12	0	0	0	1168
;Iteration 2		0	4	12	24	0	0	0	1168
;Iteration 3		0	3	12	36	0	0	0	1168
;Iteration 4		0	2	12	48	0	0	0	1168
;Iteration 5		0	1	12	60	0	0	0	1168
;Iteration 6		0	0	12	72	0	0	0	1168
;End of program		0	0	12	72	0	0	0	DEC_0
;-----------------------------------------------------


.ORIG x3000					;Program begins here.
;-------------
;Instructions: CODE GOES HERE
;-------------
LD R1, DEC_6				;R1 <-- 6
LD R2, DEC_12				;R2 <-- 12
;LD R3, DEC_0				;R3 <-- 0
AND R3, R3, x0				;R3 <-- (R3) AND x0000, tip from lab 1.

DO_WHILE	
	ADD R3, R3, R2			;R3 <-- R3 + R2
	ADD R1, R1, #-1			;R1 <-- R1 - 1
	BRp DO_WHILE			;if (LMR > 0) goto DO_WHILE
			
HALT						;Terminate the program.
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------
DEC_0	.FILL	#0		;Put the value 0 into memory here.
DEC_6	.FILL	#6		;Put the value 6 into memory here.
DEC_12	.FILL	#12		;Put the value 12 into memory here.

;---------------	
;END of PROGRAM
;---------------	
.END


