;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 25
; TA: Enoch Lin
; 
;=================================================

.ORIG x3000

;--------------
;Instructions
;--------------

LD R1, ARRAY_LOCATION

AND R5, R5, x0
LD R6, SUB_GET_STRING
JSRR R6

LD R0, ARRAY_LOCATION
PUTS
AND R0, R0, x0
ADD R0, R0, xA
OUT

AND R0, R0, x0
AND R2, R2, x0
LD R6, SUB_IS_A_PALINDROME
JSRR R6

LEA R0, THE_STRING
PUTS
LD R0, ARRAY_LOCATION
PUTS

AND R4, R4, R4
BRp YES
BRz NO

YES
	LEA R0, TRUE
	BR PRINT
NO
	LEA R0, FALSE
	
PRINT
PUTS

AND R0, R0, x0
ADD R0, R0, #10

OUT

HALT

;--------------
;Data
;--------------

ARRAY_LOCATION	.FILL	x5000
SUB_GET_STRING	.FILL	x3200
SUB_IS_A_PALINDROME	.FILL	x3400
THE_STRING		.STRINGZ	"The string \""
TRUE			.STRINGZ	"\" IS a palindrome."
FALSE			.STRINGZ	"\" IS NOT a palindrome."

.ORIG x5000

.BLKW	#100

;=============================================================
;SUB_GET_STRING
;Paramters: R1, the starting address of the character array.
;Postcondition: the subroutine has prompted the user to input a string, terminated by the [ENTER] key and has stored the received characters in an array of characters starting at (R1); the array is NULL-terminated; the sentinel character is NOT stored.
;Return value: R5, the number of non-sentinel character read from the user; R1 contains the starting address of the array unchanged.
;=============================================================

.ORIG x3200

;============================
;Subroutine Instructions
;============================

ST R1, BACKUP_R1_3200
ST R7, BACKUP_R7_3200

ADD R2, R2, #-10
GET_INPUT
	GETC
	OUT
	ADD R3, R2, R0
	BRnp PUT_IN_ARRAY
	BRz END_GET_INPUT

PUT_IN_ARRAY
	STR R0, R1, #0
	ADD R1, R1, #1
	ADD R5, R5, #1
	BR GET_INPUT

END_GET_INPUT
AND R0, R0, x0
STR R0, R1, #0

LD R1, BACKUP_R1_3200
LD R7, BACKUP_R7_3200

RET

;============================
;Subroutine Data
;============================

BACKUP_R1_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1

;=============================================================
;End subroutine
;=============================================================

;=============================================================
;SUB_IS_A_PALINDROME
;Parameter: R1, the starting address of a null-terminated string; R5, the number of characters in the array.
;Postcondition: the subroutine has determined whether the string at R1 is a palindrome or not and returned a flag to that effect.
;Return value: R4, 1 if the string is a palindrome, 0 otherwise.
;=============================================================

.ORIG x3400

;=========================
;Subroutine Instructions
;=========================

;R5 is the size of the array.
;R1 is the starting address of the array.

ST R7, BACKUP_R7_3400

ADD R2, R1, R5
ADD R2, R2, #-1
;R2 now holds the ending address of the array.

COMPARE_LOOP
	AND R0, R0, x0
	ADD R0, R0, R2
	NOT R0, R0
	ADD R0, R0, #1
	ADD R0, R0, R1
	BRp IS_PALINDROME
	LDR R3, R1, #0
	LDR R4, R2, #0
	NOT R4, R4
	ADD R4, R4, #1
	ADD R4, R3, R4
	BRnp NOT_PALINDROME
	ADD R1, R1, #1
	ADD R2, R2, #-1
	BR COMPARE_LOOP
	
IS_PALINDROME
	AND R4, R4, x0
	ADD R4, R4, #1
	BR END

NOT_PALINDROME
	AND R4, R4, x0
	
END

LD R7, BACKUP_R7_3400

RET

;=========================
;Subroutine Data
;=========================

BACKUP_R7_3400	.BLKW	#1

;=============================================================
;End subroutine
;=============================================================

.END
