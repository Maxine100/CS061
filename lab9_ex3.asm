;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 9, ex 3
; Lab section: 25
; TA: Enoch Lin
; 
;=================================================

; test harness
					.orig x3000

LD R4, BASE
LD R5, MAX
LD R6, TOS

GETC
OUT
LD R1, SUB_STACK_PUSH_3000
JSRR R1

GETC
OUT
LD R1, SUB_STACK_PUSH_3000
JSRR R1

GETC
OUT
AND R0, R0, x0
ADD R0, R0, xA
OUT

LD R1, SUB_RPN_MULTIPLY_3000
JSRR R1

LD R1, SUB_STACK_POP_3000
JSRR R1

LD R1, SUB_PRINT_DECIMAL_3000
JSRR R1

AND R0, R0, x0
ADD R0, R0, xA
OUT

 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
SUB_STACK_PUSH_3000	.FILL	x3200
SUB_STACK_POP_3000	.FILL	x3400
SUB_RPN_MULTIPLY_3000	.FILL	x3600
SUB_PRINT_DECIMAL_3000	.FILL	x3800
BASE	.FILL	xA000
MAX		.FILL	xA005
TOS		.FILL	xA000



;===============================================================================================


; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3200

ST R7, BACKUP_3200_R7
	 
NOT R1, R6
ADD R1, R1, #1
ADD R1, R1, R5
BRz ERROR_3200


ADD R6, R6, #1
STR R0, R6, #0
BR END_3200


ERROR_3200
	LEA R0, ERROR_PROMPT_3200
	PUTS


END_3200

LD R7, BACKUP_3200_R7
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data

ERROR_PROMPT_3200	.STRINGZ	"Overflow.\n"
BACKUP_3200_R7	.BLKW	#1

;===============================================================================================


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3400

ST R7, BACKUP_3400_R7

NOT R1, R6
ADD R1, R1, #1
ADD R1, R1, R4
BRz ERROR_3400

LDR R0, R6, #0
ADD R6, R6, #-1
BR END_3400


ERROR_3400
	LEA R0, ERROR_PROMPT_3400
	PUTS
	
	
END_3400

LD R7, BACKUP_3400_R7

					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
ERROR_PROMPT_3400	.STRINGZ	"Underflow.\n"
BACKUP_3400_R7	.BLKW	#1



;===============================================================================================

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    multiplied them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
					.orig x3600

ST R7, BACKUP_3600_R7

AND R2, R2, x0
AND R3, R3, x0

LD R1, SUB_STACK_POP_3600
JSRR R1
LD R1, ASCII
ADD R2, R0, R1
BRz IS_ZERO_3600

LD R1, SUB_STACK_POP_3600
JSRR R1
LD R1, ASCII
ADD R3, R0, R1
BRz IS_ZERO_3600

AND R0, R0, x0
MULTIPLY_LOOP_3600
	ADD R0, R0, R2
	ADD R3, R3, #-1
	BRp MULTIPLY_LOOP_3600
BR DONE

IS_ZERO_3600
	AND R0, R0, x0

DONE

LD R1, SUB_STACK_PUSH_3600
JSRR R1

LD R7, BACKUP_3600_R7

					ret
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data

BACKUP_3600_R7	.BLKW	#1
ASCII	.FILL	xFFD0
SUB_STACK_POP_3600	.FILL	x3400
SUB_STACK_PUSH_3600	.FILL	x3200

;===============================================================================================


; Subroutine: SUB_MULTIPLY


;===============================================================================================

; Subroutine: SUB_GET_NUM

;===============================================================================================

; Subroutine: SUB_PRINT_DECIMAL		Only needs to be able to print 1 or 2 digit numbers. You can use your lab 7 s/r.


.ORIG x3800

ST R7, BACKUP_3800_R7

AND R3, R3, x0
ADD R3, R3, R0
LD R1, NEG_TEN
AND R2, R2, x0

ADD R0, R0, #-10
BRn LESS_THAN_TEN

LOOP
	ADD R2, R2, #1
	ADD R3, R3, R1
	BRp LOOP

AND R3, R3, R3
BRz MULTIPLE_OF_TEN
BRn NEGATIVE

NEGATIVE
	ADD R2, R2, #-1
	LD R1, TEN
	ADD R3, R3, R1
	LD R1, ASCII_3800
	ADD R0, R2, R1
	OUT
	
ADD R0, R3, R1
OUT

BR END_3800

LESS_THAN_TEN
	ADD R0, R0, #10
	LD R1, ASCII_3800
	ADD R0, R0, R1
	OUT
BR END_3800

MULTIPLE_OF_TEN
	LD R1, ASCII_3800
	ADD R0, R2, R1
	OUT
	AND R0, R0, x0
	ADD R0, R0, R1
	OUT
	
END_3800


LD R7, BACKUP_3800_R7

RET

;-------------------------------------------------------------
; SUB_PRINT_DECIMAL local data

NEG_TEN		.FILL	xFFF6
TEN		.FILL	xA
ASCII_3800	.FILL	x30
BACKUP_3800_R7	.BLKW	#1
