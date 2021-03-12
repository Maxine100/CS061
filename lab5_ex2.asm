;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 5, ex 2
; Lab section: 25
; TA: Enoch Lin
; 
;=================================================

.ORIG x3000

;---------------
;Instructions
;---------------

AND R2, R2, x0
AND R1, R1, x0
ADD R1, R1, #15
GETC

LD R6, SUB_READ_BINARY_3200

READ_LOOP
	JSRR R6
	ADD R1, R1, #-1
	BRzp READ_LOOP
	

LD R6, SUB_PRINT_IN_BINARY_3400

JSRR R6

LD R0, NEWLINE
OUT

HALT

;---------------
;Data
;---------------

SUB_READ_BINARY_3200	.FILL	x3200
SUB_PRINT_IN_BINARY_3400	.FILL	x3400
NEWLINE			.FILL	'\n'

;=====================================================
;SUB_READ_BINARY
;Parameters: R0, R1, R6, R7
;Postcondition: reads input
;Return value: R2
;=====================================================

.ORIG x3200

;============================
;Subroutine instruction
;============================

ST R1, BACKUP_R1_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

GETC
LD R1, ASCII
NOT R1, R1
ADD R1, R1, #1
ADD R0, R0, R1
ADD R2, R2, R2
ADD R2, R2, R0


LD R1, BACKUP_R1_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET

;=========================
;Subroutine Data
;=========================
BACKUP_R1_3200	.BLKW	#1
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1
ASCII			.FILL	x30


;========================================================
;End subroutine
;========================================================

;========================================================
;SUB_PRINT_IN_BINARY
;Parameter:
;Postcondition:
;Return value:
;========================================================

.ORIG x3400

;=========================
;Subroutine instruction
;=========================

ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400

LD R1, MASK
AND R3, R3, x0
ADD R3, R3, #15
AND R4, R4, x0
AND R5, R5, #0
ADD R5, R5, #3

OUTPUT_LOOP
	AND R0, R1, R2
	BRz IS_ZERO
	BRn IS_ONE
	
	IS_ONE
		LD R0, ONE
		OUT
		BR DONE
	IS_ZERO
		LD R0, ZERO
		OUT
	DONE
	ADD R2, R2, R2
	ADD R4, R4, #1
	
	IF_IS_FOUR
		AND R0, R0, x0
		ADD R0, R0, #4
		NOT R0, R0
		ADD R0, R0, #1
		ADD R0, R0, R4
		BRz MAYBE_OUTPUT_SPACE
		BRnp END_OUTPUT_SPACE
	
	MAYBE_OUTPUT_SPACE
		AND R5, R5, R5
		BRp FOR_SURE_OUTPUT_SPACE
		BRz END_OUTPUT_SPACE
	FOR_SURE_OUTPUT_SPACE
		LD R0, SPACE
		OUT
		ADD R5, R5, #-1
		AND R4, R4, x0
	END_OUTPUT_SPACE
	
	ADD R3, R3, #-1
	BRzp OUTPUT_LOOP

LD R6, BACKUP_R6_3400
LD R7, BACKUP_R7_3400

RET

;=========================
;Subroutine Data
;=========================
BACKUP_R6_3400	.BLKW	#1
BACKUP_R7_3400	.BLKW	#1
SPACE			.FILL	' '
FOUR			.FILL	#4
MASK			.FILL	x8000
ZERO			.FILL	x30
ONE				.FILL	x31

;========================================================
;End subroutine
;========================================================

.END
