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

;---------------
;Instructions
;---------------

LD R1, ARRAY_LOCATION

AND R5, R5, x0
LD R6, SUB_GET_STRING
JSRR R6

LD R0, ARRAY_LOCATION
PUTS
AND R0, R0, x0
ADD R0, R0, #10
OUT

HALT

;---------------
;Data
;---------------

ARRAY_LOCATION	.FILL	x5000
SUB_GET_STRING	.FILL	x3200

.ORIG x5000

.BLKW	#100

;=============================================================
;SUB_GET_STRING
;Paramters: R1, the starting address of the character array.
;Postcondition: The subroutine has prompted the user to input a string, terminated by the [ENTER] key and has stored the received characters in an array of characters starting at (R1). The array is NULL-terminated; the sentinel character is NOT stored.
;Return value: R5, the number of non-sentinel character read from the user; R1 contains the starting address of the array unchanged.
;=============================================================

.ORIG x3200

;============================
;Subroutine Instructions
;============================

ST R1, BACKUP_R1_3200
ST R6, BACKUP_R6_3200
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
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200


RET

;============================
;Subroutine Data
;============================

BACKUP_R0_3200	.BLKW	#1
BACKUP_R1_3200	.BLKW	#1
BACKUP_R2_3200	.BLKW	#1
BACKUP_R3_3200	.BLKW	#1
BACKUP_R4_3200	.BLKW	#1
BACKUP_R5_3200	.BLKW	#1
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1
NEWLINE			.FILL	'\n'

;=============================================================
;End subroutine
;=============================================================

.END
