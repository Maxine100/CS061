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

;----------------
;Instructions
;----------------

GETC
AND R1, R1, x0
ADD R1, R1, R0

LD R6, SUB_NUM_ONES
JSRR R6

LEA R0, STATEMENT1
PUTS
AND R0, R0, x0
ADD R0, R0, R1
OUT
LEA R0, STATEMENT2
PUTS
AND R0, R0, x0
ADD R0, R0, R2
LD R3, ASCII
ADD R0, R0, R3
OUT
AND R0, R0, x0
ADD R0, R0, xA
OUT

HALT

;----------------
;Data
;----------------

SUB_NUM_ONES	.FILL	x3200
STATEMENT1	.STRINGZ	"The number of 1's in '"
STATEMENT2	.STRINGZ	"' is: "
ASCII	.FILL	x30


;=====================================================
;SUB_NUM_ONES
;Parameters: R0
;Postcondition: R2 holds the number of 1s.
;Return value: R2
;=====================================================

.ORIG x3200

;==========================
;Subroutine Instructions
;==========================

ST R1, BACKUP_R1_3200
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

LD R1, MASK ;R1 contains mask.
AND R2, R2, x0 ;R2 contains number of 1s.
AND R3, R3, x0 ;R3 counts for the loops.
ADD R3, R3, #15
;R4 is either 0 or 1.

COUNT_LOOP
	AND R4, R0, R1
	BRz ZERO
	ADD R2, R2, #1
	ZERO
	ADD R0, R0, R0
	ADD R3, R3, #-1
	BRzp COUNT_LOOP

LD R1, BACKUP_R1_3200
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET

;==========================
;Subroutine Data
;==========================

BACKUP_R1_3200	.BLKW	#1
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1
MASK	.FILL	x8000


;==========================
;End subroutine
;==========================

.END
