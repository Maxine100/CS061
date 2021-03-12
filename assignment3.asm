;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 25
; TA: Enoch  Lin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R2, POINTER ;Points to masks.
LDR R3, R2, #0 ;Contains masks.
AND R4, R4, x0 ;Counter
ADD R4, R4, #15 ;Counter
AND R5, R5, #0 ;Space counter.

LOOP
	IF
		AND R0, R1, R3
		BRn IS_ONE
		BRz IS_ZERO
	IS_ONE
		LD R0, ONE
		OUT
		BR END_IF
	IS_ZERO
		LD R0, ZERO
		OUT
	END_IF
	ADD R5, R5, #1
	
	IF_IS_FOUR
		AND R0, R0, x0
		ADD R0, R0, #4
		NOT R0, R0
		ADD R0, R0, #1
		ADD R0, R5, R0
		BRz OUTPUT_SPACE
		BRnp END_OUTPUT_SPACE
	END_IS_FOUR
	
	OUTPUT_SPACE
		LD R0, SPACE
		OUT
		AND R5, R5, x0
	END_OUTPUT_SPACE
	
	ADD R2, R2, #1
	LDR R3, R2, #0
	ADD R4, R4, #-1
	BRp LOOP
END_LOOP	

IF2
	AND R0, R1, R3
	BRn IS_ONE_2
	BRz IS_ZERO_2
IS_ONE_2
	LD R0, ONE
	OUT
	BR END_IF_2
IS_ZERO_2
	LD R0, ZERO
	OUT
END_IF_2

LD R0, NEWLINE
OUT


HALT
;---------------	
;Data
;---------------
Value_addr	.FILL xB800	; The address where value to be displayed is stored
ZERO	.FILL	x30
ONE		.FILL	x31
POINTER	.FILL	xB801
NEWLINE	.FILL	'\n'
SPACE	.FILL	' '
FOUR	.FILL	#4

.ORIG xB800					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
.FILL	x8000
.FILL	x4000
.FILL	x2000
.FILL	x1000
.FILL	x0800
.FILL	x0400
.FILL	x0200
.FILL	x0100
.FILL	x0080
.FILL	x0040
.FILL	x0020
.FILL	x0010
.FILL	x0008
.FILL	x0004
.FILL	x0002
.FILL	x0001

;---------------	
;END of PROGRAM
;---------------	
.END
