;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 25
; TA: Enoch Lin
; 
;=================================================

.ORIG x3000

;-------------
;Instructions
;-------------

AND R0, R0, x0
AND R1, R1, x0

ADD R0, R0, #1
ADD R1, R1, #10
LD R2, ARRAY_PTR

POPULATE_ARRAY_LOOP
	STR R0, R2, #0
	ADD R0, R0, R0
	ADD R2, R2, #1
	ADD R1, R1, #-1
	BRp POPULATE_ARRAY_LOOP

ADD R1, R1, #10		;R1 counts how many times the loop has ran.
AND R0, R0, x0		;R0 outputs stuff.
LD R2, ARRAY_PTR	;R2 points to array.

LD R6, SUB_PRINT_IN_BINARY_3200

OUTPUT_ARRAY_LOOP
	JSRR R6
	ADD R2, R2, #1
	LD R0, NEWLINE
	OUT
	ADD R1, R1, #-1
	BRp OUTPUT_ARRAY_LOOP

HALT

;------------
;Data
;------------

ARRAY_PTR	.FILL	x4000
SUB_PRINT_IN_BINARY_3200	.FILL	x3200
NEWLINE			.FILL	'\n'

.ORIG x4000

.BLKW	#10

;========================================================================================
;SUB_PRINT_IN_BINARY_3200
;Parameters: R0, R1, R2, R3, R4, R5, R6, R7
;Postcondition: prints out the values in the array in binary
;Return value: none
;========================================================================================

.ORIG x3200

;==========================
;Subroutine Instructions
;==========================

ST R0, BACKUP_R0_3200
ST R1, BACKUP_R1_3200
ST R2, BACKUP_R2_3200
ST R3, BACKUP_R3_3200
ST R4, BACKUP_R4_3200
ST R5, BACKUP_R5_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200


LDR R1, R2, #0	;R1 holds the value to be outputed.
LD R2, MASK		;R2 holds the mask x8000.
AND R3, R3, x0
ADD R3, R3, #15	;R3 counts.
AND R4, R4, #0	;R4 is the space counter.
AND R5, R5, #0
ADD R5, R5, #3

LOOP
	AND R0, R1, R2
	BRn IS_ONE
	BRz IS_ZERO
	IS_ONE
		LD R0, ONE
		OUT
		BR DONE
	IS_ZERO
		LD R0, ZERO
		OUT
	DONE
	ADD R1, R1, R1
	ADD R4, R4, #1
	
	IF_IS_FOUR
		AND R0, R0, x0
		ADD R0, R0, #4
		NOT R0, R0
		ADD R0, R0, #1
		ADD R0, R4, R0
		BRz MAYBE_OUTPUT_SPACE
		BRnp END_OUTPUT_SPACE
	END_IS_FOUR
	
	MAYBE_OUTPUT_SPACE
		AND R5, R5, R5
		BRp FOR_SURE_OUTPUT_SPACE
		BRz	END_OUTPUT_SPACE
	FOR_SURE_OUTPUT_SPACE
		LD R0, SPACE
		OUT
		ADD R5, R5, #-1
		AND R4, R4, x0
	END_OUTPUT_SPACE
	
	ADD R3, R3, #-1
	BRzp LOOP



LD R0, BACKUP_R0_3200
LD R1, BACKUP_R1_3200
LD R2, BACKUP_R2_3200
LD R3, BACKUP_R3_3200
LD R4, BACKUP_R4_3200
LD R5, BACKUP_R5_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET

;=========================
;Subroutine Data
;=========================
BACKUP_R0_3200	.BLKW	#1
BACKUP_R1_3200	.BLKW	#1
BACKUP_R2_3200	.BLKW	#1
BACKUP_R3_3200	.BLKW	#1
BACKUP_R4_3200	.BLKW	#1
BACKUP_R5_3200	.BLKW	#1
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1
SPACE			.FILL	' '
FOUR			.FILL	#4
MASK			.FILL	x8000
ZERO			.FILL	x30
ONE				.FILL	x31


;========================================================================================
;End subroutine
;========================================================================================


.END
