;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 5, ex 3
; Lab section: 25
; TA: Enoch Lin
; 
;=================================================

.ORIG x3000

;---------------
;Instructions
;---------------

LD R1, b
NOT R1, R1
ADD R1, R1, #1

GETC
OUT
ADD R0, R0, R1
BRnp NOT_b
BRz IS_b

NOT_b
	LD R0, NEWLINE
	OUT
	LEA R0, ERROR_MESSAGE
	PUTS
	LD R0, NEWLINE
	OUT
	GETC
	OUT
	ADD R0, R0, R1
	BRnp NOT_b
	
IS_b

LD R0, NEWLINE
OUT

LD R6, SUM_READ_BINARY_3200

AND R1, R1, x0
ADD R1, R1, #15

READ_LOOP
	JSRR R6
	ADD R1, R1, #-1
	BRzp READ_LOOP

LD R6, SUM_PRINT_IN_BINARY_3400

JSRR R6

LD R0, NEWLINE
OUT

HALT

;---------------
;DATA
;---------------

ERROR_MESSAGE	.STRINGZ	"Invalid input; put in 'b'."
b				.FILL	#98
NEWLINE			.FILL	'\n'
SUM_READ_BINARY_3200	.FILL	x3200
SUM_PRINT_IN_BINARY_3400	.FILL	x3400

;=====================================================
;SUB_READ_BINARY
;Parameters: R0, R1, R6, R7
;Postcondition: reads input, checks for validity
;Return value: R2
;=====================================================

.ORIG x3200

;============================
;Subroutine instruction
;============================

ST R1, BACKUP_R1_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

INPUT
GETC
OUT

CHECK_IF_ZERO
	LD R1, ZERO
	ADD R1, R1, R0
	BRz IS_ZERO_ONE
CHECK_IF_ONE
	LD R1, ONE
	ADD R1, R1, R0
	BRz IS_ZERO_ONE
CHECK_IF_SPACE
	LD R1, SPACE
	ADD R1, R1, R0
	BRz IS_SPACE
	BRnp NONE
	
NONE
	LD R0, NEWLINE_1
	OUT
	LEA R0, ERROR
	PUTS
	LD R0, NEWLINE_1
	OUT
	BR INPUT

IS_SPACE
	OUT
	BR INPUT
	
IS_ZERO_ONE
	LD R1, ZERO
	ADD R0, R0, R1
	ADD R2, R2, R2
	ADD R2, R2, R0
	LD R0, NEWLINE_1
	OUT

LD R1, BACKUP_R1_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET

;=========================
;Subroutine Data
;=========================
ZERO	.FILL	xFFD0
ONE		.FILL	xFFCF
SPACE	.FILL	xFFE0
ERROR	.STRINGZ	"Put in '0' or '1'."
NEWLINE_1	.FILL	'\n'
BACKUP_R1_3200	.BLKW	#1
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1

;========================================================
;End subroutine
;========================================================




;========================================================
;SUB_PRINT_IN_BINARY
;Parameters: R0, R1, R2, R3, R4, R5, R6, R7
;Postcondition: outputs R2 in binary
;Return value: none
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
		LD R0, ONE_1
		OUT
		BR DONE
	IS_ZERO
		LD R0, ZERO_1
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
		LD R0, SPACE_1
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
SPACE_1			.FILL	' '
FOUR			.FILL	#4
MASK			.FILL	x8000
ZERO_1			.FILL	x30
ONE_1			.FILL	x31


;========================================================
;End subroutine
;========================================================

.END
