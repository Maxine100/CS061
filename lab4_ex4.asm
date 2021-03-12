;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 4, ex 4
; Lab section: 25
; TA: Enoch
; 
;=================================================
.ORIG x3000

;------------
;Instructions
;------------

AND R0, R0, x0
AND R1, R1, x0

ADD R0, R0, #1
ADD R1, R1, #10
LD R2, ARRAY_PTR

INPUT_LOOP
	STR R0, R2, #0
	ADD R0, R0, R0
	ADD R2, R2, #1
	ADD R1, R1, #-1
	BRp INPUT_LOOP
END_INPUT_LOOP

ADD R1, R1, #10
AND R0, R0, x0
LD R2, ARRAY_PTR

OUTPUT_LOOP
	LDR R0, R2, #0
	OUT
	ADD R2, R2, #1
	ADD R1, R1, #-1
	BRp OUTPUT_LOOP
END_OUTPUT_LOOP

HALT

;------------
;Data
;------------

ARRAY_PTR	.FILL	x4000

.ORIG x4000

.BLKW	#10

.END
