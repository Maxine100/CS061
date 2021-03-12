;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 25
; TA: Enoch Lin
; 
;=================================================
.ORIG x3000
;------------
;Instructions
;------------

LD R1, ARRAY
LD R2, NEWLINE
NOT R2, R2
ADD R2, R2, #1

LOOP1
	GETC
	OUT
	IF
		ADD R0, R0, R2
		BRnp CONTINUE
		BRz DONE
	CONTINUE
		ADD R0, R0, #10
		STR R0, R1, #0
		ADD R1, R1, #1
		AND R0, R0, #0
		BRnzp LOOP1
	DONE
		END_LOOP1
	END_IF

LD R1, ARRAY
LDR R0, R1, #0

IF2
	ADD R3, R0, R0
	BRnp CONTINUE2
	;BRz DONE2
CONTINUE2
	OUT
	LD R0, NEWLINE
	OUT
	ADD R1, R1, #1
	LDR R0, R1, #0
	BRnp IF2
END_IF2

HALT
;------------
;Data
;------------
ARRAY	.FILL	x4000
;NULL	.FILL	x0000
NEWLINE	.FILL	'\n'

.END
