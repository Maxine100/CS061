;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 9, ex 1 & 2
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
LD R1, SUB_STACK_PUSH
JSRR R1

GETC
OUT
LD R1, SUB_STACK_PUSH
JSRR R1
GETC
OUT
LD R1, SUB_STACK_PUSH
JSRR R1
GETC
OUT
LD R1, SUB_STACK_PUSH
JSRR R1
GETC
OUT
LD R1, SUB_STACK_PUSH
JSRR R1
GETC
OUT
LD R1, SUB_STACK_PUSH
JSRR R1
LD R1, SUB_STACK_POP
JSRR R1

OUT 
LD R1, SUB_STACK_POP
JSRR R1

LD R1, SUB_STACK_POP
JSRR R1

					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
SUB_STACK_PUSH	.FILL	x3200
SUB_STACK_POP	.FILL	x3400
BASE			.FILL	xA000
MAX				.FILL	xA005
TOS				.FILL	xA000



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

