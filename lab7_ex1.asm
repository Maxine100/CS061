;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 6, ex 1
; Lab section: 25
; TA: Enoch Lin
; 
;=================================================

.ORIG x3000

;-----------------
;Instructions
;-----------------

LD R6, SUBROUTINE1
JSRR R6

ADD R1, R1, #1

AND R3, R3, R3
BRp NEGATIVE
BRnz NON_NEGATIVE

NEGATIVE
	LD R0, MINUS1
	OUT
	NOT R1, R1
	ADD R1, R1, #1
NON_NEGATIVE

AND R0, R0, x0
LD R6, SUBROUTINE2
JSRR R6

HALT

;-----------------
;Data
;-----------------

SUBROUTINE1		.FILL	x3200
SUBROUTINE2		.FILL	x3400
MINUS1		.FILL	x2D

;===============================================================================
;SUB_1
;Parameters: none
;Postcondition: R1 will be loaded with user-input.
;Return value: R1
;===============================================================================

.ORIG x3200

;=======================
;Subroutine Instructions
;=======================

ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

FIRST_INPUT_LOOP
LD R0, introPromptPtr
PUTS
AND R1, R1, x0 ;Compares with input.
AND R2, R2, x0 ;Stores number.
AND R3, R3, x0 ;Negative flag.
AND R4, R4, x0 ;Digit counter.
ADD R4, R4, #5 ;Counts input.
AND R5, R5, x0 ;Determines if a digit has been entered.

GETC
OUT

;Checking for '\n'.
LD R1, NEWLINE
ADD R1, R1, R0
BRz TERMINATE

;Checking if '+'.
LD R1, PLUS
ADD R1, R1, R0
BRz IS_POSITIVE

;Checking if '-'.
LD R1, MINUS
ADD R1, R1, R0
BRz IS_NEGATIVE

;Checking if < '0'.
LD R1, ZERO
ADD R1, R1, R0
BRp GREATER_THAN_ZERO
BRz CONTINUE
BRn ERROR

GREATER_THAN_ZERO
;Checking if > '9'.
LD R1, NINE
ADD R1, R1, R0
BRnz CONTINUE
BRp ERROR

IS_POSITIVE
	BR REST_OF_DIGITS
IS_NEGATIVE
	ADD R3, R3, #1
	BR REST_OF_DIGITS
CONTINUE
	ADD R5, R5, #1
	AND R6, R6, x0
	ADD R6, R6, #9
	LD R1, ZERO
	ADD R0, R0, R1
	ADD R1, R2, #0
	ADD_LOOP
		ADD R2, R2, R1
		ADD R6, R6, #-1
		BRp ADD_LOOP
	ADD R2, R2, R0
	ADD R4, R4, #-1
	BRz END

REST_OF_DIGITS
	GETC
	OUT
	
	LD R1, NEWLINE
	ADD R1, R1, R0
	BRz NEWLINE_INPUT
	
	INVALID_MINUS
		LD R1, MINUS
		ADD R1, R1, R0
		BRz ERROR
	INVALID_PLUS
		LD R1, PLUS
		ADD R1, R1, R0
		BRz ERROR
	
	LD R1, ZERO
	ADD R1, R1, R0
	BRp GREATER_THAN_ZERO
	BRz CONTINUE
	LD R0, OUTPUT_NEWLINE
	OUT
	LD R0, errorMessagePtr
	PUTS
	BR FIRST_INPUT_LOOP
	
	ERROR
		LD R0, OUTPUT_NEWLINE
		OUT
		LD R0, errorMessagePtr
		PUTS
		BR FIRST_INPUT_LOOP
	
	NEWLINE_INPUT
		AND R5, R5, R5
		BRp CHECK_FOR_NEGATIVE
		BRz ERROR

END
	LD R0, OUTPUT_NEWLINE
	OUT
	CHECK_FOR_NEGATIVE
		AND R3, R3, R3
		BRp CONVERT_TO_NEGATIVE
		BR TERMINATE

CONVERT_TO_NEGATIVE
	NOT R2, R2
	ADD R2, R2, #1

TERMINATE

AND R1, R1, x0
ADD R1, R1, R2
AND R2, R2, x0
AND R4, R4, x0
AND R5, R5, x0

LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET

;==========================
;Subroutine Data
;==========================

BACKUP_R6_3200	.BLKW 	#1
BACKUP_R7_3200	.BLKW	#1
NEWLINE		.FILL	xFFF6
PLUS		.FILL	xFFD5
MINUS		.FILL	xFFD3
ZERO		.FILL	xFFD0
NINE		.FILL	xFFC7
OUTPUT_NEWLINE	.FILL	xA
introPromptPtr	.FILL	xA100
errorMessagePtr	.FILL	xA200

.ORIG xA100
.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"

.ORIG xA200
.STRINGZ	"Error: invalid input\n"

;=================================================================================
;End subroutine
;=================================================================================


;==========================================
;SUB_2
;Parameters: R1
;Postcondition: prints the decimal value of R1.
;Return value: none.
;==========================================

.ORIG x3400

;==============================
;Subroutine Instructions
;==============================

ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400

; R1 holds the value.
ADD R2, R2, #5 ;Loop counter
LD R3, ARRAY_PTR ;Points to ARRAY_PTR.
; R4 holds value to subtract.
; R5 determines if a nonzero digit has been output.
LD R6, ASCII ;R6 holds ASCII

DIV_LOOP
	LDR R4, R3, #0
	ADD R1, R1, R4
	BRp IS_POS
	BRn IS_NEG
	BRz IS_ZERO

	INCREMENT
	ADD R3, R3, #1
	ADD R2, R2, #-1
	BRp DIV_LOOP
	BR EXIT

IS_POS
	ADD R5, R5, #1
	ADD R0, R0, #1
	BR DIV_LOOP
	
IS_NEG
	;Making positive again.
	;---------------------
	NOT R4, R4
	ADD R4, R4, #1
	ADD R1, R1, R4
	;---------------------
	BR OUTPUT

IS_ZERO
	ADD R0, R0, #1
	BR OUTPUT

OUTPUT
	ADD R5, R5, #0
	BRp NONZERO
	AND R0, R0, x0
	BR INCREMENT

NONZERO
	ADD R0, R0, R6
	OUT
	AND R0, R0, x0
	BR INCREMENT
	
EXIT

LD R6, BACKUP_R6_3400
LD R7, BACKUP_R7_3400

RET

;============================
;Subroutine Data
;============================

BACKUP_R6_3400	.BLKW	#1
BACKUP_R7_3400	.BLKW	#1
ASCII			.FILL	x30
ARRAY_PTR		.FILL	x3600

.ORIG x3600
.FILL	xD8F0
.FILL	xFC18
.FILL	xFF9C
.FILL	xFFF6
.FILL	xFFFF

;==================================================================================
;End subroutine
;==================================================================================

.END
