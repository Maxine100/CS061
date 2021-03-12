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
AND R2, R2, x0 ;Counter
ADD R2, R2, #15 ;Counter
AND R3, R3, #0 ;Space counter.
AND R4, R4, #0
ADD R4, R4, #3

LOOP
	IF
		AND R0, R1, R1
		BRn IS_ONE
		BRzp IS_ZERO
	IS_ONE
		LD R0, ONE
		OUT
		BR END_IF
	IS_ZERO
		LD R0, ZERO
		OUT
	END_IF
	ADD R3, R3, #1
	
	IF_IS_FOUR
		AND R0, R0, x0
		ADD R0, R0, #4
		NOT R0, R0
		ADD R0, R0, #1
		ADD R0, R3, R0
		BRz MAYBE_OUTPUT_SPACE
		BRnp END_OUTPUT_SPACE
	END_IS_FOUR
	
	MAYBE_OUTPUT_SPACE
		AND R4, R4, R4
		BRp FOR_SURE_OUTPUT_SPACE
		BRz END_OUTPUT_SPACE
	FOR_SURE_OUTPUT_SPACE
		LD R0, SPACE
		OUT
		ADD R4, R4, #-1
		AND R3, R3, x0
	END_OUTPUT_SPACE
	ADD R1, R1, R1

	ADD R2, R2, #-1
	BRzp LOOP
END_LOOP

LD R0, NEWLINE
OUT


HALT
;---------------	
;Data
;---------------
Value_addr	.FILL xB800	; The address where value to be displayed is stored
ZERO	.FILL	x30
ONE		.FILL	x31
NEWLINE	.FILL	'\n'
SPACE	.FILL	' '
FOUR	.FILL	#4

.ORIG xB800					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.

;---------------	
;END of PROGRAM
;---------------	
.END
