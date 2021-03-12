;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 4, ex 1
; Lab section: 25
; TA: Enoch Lin
; 
;=================================================
.ORIG x3000

;------------
;Instructions
;------------

AND R0, R0, x0
AND R1, R1, x0
ADD R1, R1, #10
LD R2, ARRAY_PTR

POPULATE_ARRAY
	STR R0, R2, #0
	ADD R0, R0, #1
	ADD R2, R2, #1
	ADD R1, R1, #-1
	BRp POPULATE_ARRAY
END_POPULATE_ARRAY

LD R2, ARRAY_PTR
LDR R2, R2, #6

HALT

;------------
;Data
;------------

ARRAY_PTR	.FILL	x4000

.ORIG x4000

.BLKW	#10

.END
