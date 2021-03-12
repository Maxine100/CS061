;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 3, ex 3
; Lab section: 25
; TA: Enoch Lin
; 
;=================================================
.ORIG x3000
;------------
;Instructions
;------------

LD R1, SIZE
LEA R2, ARRAY

LOOP1
	IN
	STR R0, R2, #0
	ADD R2, R2, #1
	ADD R1, R1, #-1
	BRp LOOP1
END_LOOP1

AND R0, R0, #0
LD R1, SIZE
LEA R2, ARRAY

LOOP2
	LDR R0, R2, #0
	OUT
	LD R0, NEWLINE
	OUT
	ADD R2, R2, #1
	ADD R1, R1, #-1
	BRp LOOP2
END_LOOP2

HALT
;------------
;Data
;------------
ARRAY	.BLKW	#10
SIZE	.FILL	#10
NEWLINE	.FILL	'\n'

.END
