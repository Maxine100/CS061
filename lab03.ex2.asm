;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 3, ex 2
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

LOOP
	IN
	STR R0, R2, #0
	ADD R2, R2, #1
	ADD R1, R1, #-1
	BRp LOOP
END_LOOP

HALT
;------------
;Data
;------------
ARRAY	.BLKW	#10
SIZE	.FILL	#10

.END
