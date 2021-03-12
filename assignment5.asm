;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 25
; TA: Enoch Lin
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
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

AND R3, R3, x0

LOOP
	LD R6, MENU
	JSRR R6

	;CHECK_IF_DONE
	;	AND R1, R1, R1
	;	BRz GOODBYE
	;	BRp CONTINUE

	CONTINUE
		ADD R2, R2, #-1
		
		ADD R1, R1, R2
		BRz ONE
		ADD R1, R1, R2
		BRz TWO
		ADD R1, R1, R2
		BRz THREE
		ADD R1, R1, R2
		BRz FOUR
		ADD R1, R1, R2
		BRz FIVE
		ADD R1, R1, R2
		BRz SIX
		ADD R1, R1, R2
		BRz SEVEN
		
		ONE
			LD R6, ALL_MACHINES_BUSY
			JSRR R6
			AND R2, R2, R2
			BRz NO_ALL_MACHINES_BUSY
			BRnp YES_ALL_MACHINES_BUSY
			NO_ALL_MACHINES_BUSY
				LEA R0, allnotbusy
				PUTS
				BR END_ALL_MACHINES_BUSY
			YES_ALL_MACHINES_BUSY
				LEA R0, allbusy
				PUTS
				BR END_ALL_MACHINES_BUSY
			END_ALL_MACHINES_BUSY
			BR LOOP
			
		TWO
			LD R6, ALL_MACHINES_FREE
			JSRR R6
			AND R2, R2, R2
			BRz NO_ALL_MACHINES_FREE
			BRnp YES_ALL_MACHINES_FREE
			NO_ALL_MACHINES_FREE
				LEA R0, allnotfree
				PUTS
				BR END_ALL_MACHINES_FREE
			YES_ALL_MACHINES_FREE
				LEA R0, allfree
				PUTS
				BR END_ALL_MACHINES_FREE
			END_ALL_MACHINES_FREE
			BR LOOP
			
		THREE
			LEA R0, busymachine1
			PUTS
			LD R6, NUM_BUSY_MACHINES
			JSRR R6
			LD R6, PRINT_NUM
			JSRR R6
			LEA R0, busymachine2
			PUTS
			BR LOOP
			
		FOUR
			LEA R0, freemachine1
			PUTS
			LD R6, NUM_FREE_MACHINES
			JSRR R6
			LD R6, PRINT_NUM
			JSRR R6
			LEA R0, freemachine2
			PUTS
			BR LOOP
			
		FIVE
			LD R6, GET_MACHINE_NUM
			JSRR R6
			LEA R0, status1
			PUTS
			LD R6, PRINT_NUM
			JSRR R6
			LD R6, MACHINE_STATUS
			JSRR R6
			AND R2, R2, R2
			BRp YES_MACHINE_FREE
			BRz NO_MACHINE_FREE
			NO_MACHINE_FREE
				LEA R0, status2
				PUTS
				BR END_MACHINE_STATUS
			YES_MACHINE_FREE
				LEA R0, status3
				PUTS
				BR END_MACHINE_STATUS
			END_MACHINE_STATUS
			BR LOOP
			
		SIX
			LD R6, FIRST_FREE
			JSRR R6
			AND R2, R2, R2
			BRn NO_FREE
			BRzp YES_FREE
			YES_FREE
				AND R1, R1, x0
				ADD R1, R1, R2
				LEA R0, firstfree1
				PUTS
				LD R6, PRINT_NUM
				JSRR R6
				LD R0, newline
				OUT
				BR END_FIRST_FREE
			NO_FREE
				LEA R0, firstfree2
				PUTS
				BR END_FIRST_FREE
			END_FIRST_FREE
			BR LOOP

		SEVEN
			LEA R0, goodbye
			PUTS
	
DONE_MAIN
	
HALT
;---------------	
;Data
;---------------
;Subroutine pointers
MENU	.FILL	x3200
ALL_MACHINES_BUSY	.FILL	x3400
ALL_MACHINES_FREE	.FILL	x3600
NUM_BUSY_MACHINES	.FILL	x3800
NUM_FREE_MACHINES	.FILL	x4000
MACHINE_STATUS		.FILL	x4200
FIRST_FREE			.FILL	x4400
GET_MACHINE_NUM		.FILL	x4600
PRINT_NUM			.FILL	x4800

;Other data 
newline 		.fill '\n'

; Strings for reports from menu subroutines:
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------

.ORIG x3200

;HINT back up 
ST R6, BACKUP_R6_3200
ST R7, BACKUP_R7_3200

START_3200
LD R0, Menu_string_addr
PUTS

GETC
OUT

LESS_THAN_ONE_3200
	LD R1, ASCII_ONE
	ADD R2, R0, R1
	BRn INVALID_3200
GREATER_THAN_SEVEN_3200
	LD R1, ASCII_SEVEN
	ADD R2, R0, R1
	BRp INVALID_3200
	BRnz VALID_3200
	;BRz SEVEN_3200

INVALID_3200
	LD R0, NEWLINE_3200
	OUT
	LEA R0, Error_msg_1
	PUTS
	BR START_3200

VALID_3200
	AND R1, R1, x0
	ADD R1, R0, #0
	LD R2, ASCII
	ADD R1, R1, R2
	LD R0, NEWLINE_3200
	OUT
	BR DONE_3200

;SEVEN_3200
;	AND R1, R1, x0
;	LD R0, NEWLINE_3200
;	OUT
	
DONE_3200
AND R2, R2, x0

;HINT Restore
LD R6, BACKUP_R6_3200
LD R7, BACKUP_R7_3200

RET

;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x6A00
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1
NEWLINE_3200	.FILL	xA
ASCII_ONE		.FILL	xFFCF
ASCII_SEVEN		.FILL	xFFC9
ASCII			.FILL	xFFD0

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------

.ORIG x3400

;HINT back up 
ST R6, BACKUP_R6_3400
ST R7, BACKUP_R7_3400


AND R2, R2, x0
LDI R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY
BRz BUSY_3400
BR END_3400
BUSY_3400
	ADD R2, R2, #1
END_3400


;HINT Restore
LD R6, BACKUP_R6_3400
LD R7, BACKUP_R7_3400

RET

;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xBA00
BACKUP_R6_3400	.BLKW	#1
BACKUP_R7_3400	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------

.ORIG x3600

;HINT back up 
ST R6, BACKUP_R6_3600
ST R7, BACKUP_R7_3600


LDI R0, BUSYNESS_ADDR_ALL_MACHINES_FREE
ADD R1, R1, #15
LD R3, MASK_3600

CHECK_LOOP_3600
	AND R4, R0, R3
	BRz NO_ALL_FREE_3600
	ADD R0, R0, R0
	ADD R1, R1, #-1
	BRzp CHECK_LOOP_3600
	
YES_ALL_FREE_3600
	AND R2, R2, x0
	ADD R2, R2, #1
	BR DONE_ALL_MACHINES_FREE_3600
NO_ALL_FREE_3600
	AND R2, R2, x0
	
DONE_ALL_MACHINES_FREE_3600


;HINT Restore
LD R6, BACKUP_R6_3600
LD R7, BACKUP_R7_3600

RET

;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xBA00
BACKUP_R6_3600	.BLKW	#1
BACKUP_R7_3600	.BLKW	#1
MASK_3600		.FILL	x8000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------

.ORIG x3800

;HINT back up 
ST R6, BACKUP_R6_3800
ST R7, BACKUP_R7_3800


AND R1, R1, x0
AND R0, R0, x0
ADD R0, R0, #15
LDI R2, BUSYNESS_ADDR_NUM_BUSY_MACHINES
LD R3, MASK_3800

CHECK_LOOP_3800
	AND R4, R2, R3
	BRz IS_BUSY_3800
	CONTINUE_3800
	ADD R2, R2, R2
	ADD R0, R0, #-1
	BRzp CHECK_LOOP_3800
	BRn DONE_3800

IS_BUSY_3800
	ADD R1, R1, #1
	BR CONTINUE_3800
	
DONE_3800


;HINT Restore
LD R6, BACKUP_R6_3800
LD R7, BACKUP_R7_3800

RET

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xBA00
BACKUP_R6_3800	.BLKW	#1
BACKUP_R7_3800	.BLKW	#1
MASK_3800		.FILL	x8000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------

.ORIG x4000

;HINT back up 
ST R6, BACKUP_R6_4000
ST R7, BACKUP_R7_4000


AND R1, R1, x0
AND R0, R0, x0
ADD R0, R0, #15
LDI R2, BUSYNESS_ADDR_NUM_FREE_MACHINES
LD R3, MASK_4000

CHECK_LOOP_4000
	AND R4, R2, R3
	BRn IS_FREE_4000
	CONTINUE_4000
	ADD R2, R2, R2
	ADD R0, R0, #-1
	BRzp CHECK_LOOP_4000
	BRn DONE_4000
	
IS_FREE_4000
	ADD R1, R1, #1
	BR CONTINUE_4000

DONE_4000



;HINT Restore
LD R6, BACKUP_R6_4000
LD R7, BACKUP_R7_4000

RET

;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xBA00
BACKUP_R6_4000	.BLKW	#1
BACKUP_R7_4000	.BLKW	#1
MASK_4000		.FILL	x8000


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------

.ORIG x4200

;HINT back up 
ST R6, BACKUP_R6_4200
ST R7, BACKUP_R7_4200


LDI R2, BUSYNESS_ADDR_MACHINE_STATUS ;R2 holds the bit vector.
LD R3, MASK_4200 ;R3 holds the mask.
NOT R0, R1
ADD R0, R0, #1
ADD R0, R0, #15 ;R0 is how many times to double the bit vector.
BRz ZERO_BIT_4200 ;If R0 is 0, then R1 is 15; no need to double.

LOOP_4200
	ADD R2, R2, R2
	ADD R0, R0, #-1
	BRn ZERO_BIT_4200
	BRp LOOP_4200

ZERO_BIT_4200
AND R2, R2, R3

BRn IS_FREE_4200
BRz EXIT_4200

IS_FREE_4200
	AND R2, R2, x0
	ADD R2, R2, #1
	BR EXIT_4200
	
EXIT_4200

;HINT Restore
LD R6, BACKUP_R6_4200
LD R7, BACKUP_R7_4200

RET

;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS	.Fill xBA00
BACKUP_R6_4200	.BLKW	#1
BACKUP_R7_4200	.BLKW	#1
MASK_4200		.FILL	x8000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------

.ORIG x4400

;HINT back up 
ST R6, BACKUP_R6_4400
ST R7, BACKUP_R7_4400


AND R0, R0, x0
ADD R0, R0, #15 ;R0 is the loop counter.
LDI R1, BUSYNESS_ADDR_FIRST_FREE ;R1 holds the bit vector.
AND R2, R2, x0
ADD R2, R2, #-1 ;R2 holds the number of the first free machine.
LD R3, MASK_4400 ;R3 holds the mask.


DOUBLE_4400
	AND R4, R1, R3
	BRn SET_TO_R2_4400
	CONTINUE_DOUBLE_4400
	ADD R1, R1, R1
	ADD R0, R0, #-1
	BRzp DOUBLE_4400
	BRn DONE_DOUBLE_4400

SET_TO_R2_4400
	ADD R2, R0, #0
	BR CONTINUE_DOUBLE_4400

DONE_DOUBLE_4400


;HINT Restore
LD R6, BACKUP_R6_4400
LD R7, BACKUP_R7_4400

RET

;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xBA00
BACKUP_R6_4400	.BLKW	#1
BACKUP_R7_4400	.BLKW	#1
MASK_4400		.FILL	x8000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------

.ORIG x4600

ST R6, BACKUP_R6_4600
ST R7, BACKUP_R7_4600


;R1 is sign flag.
AND R1, R1, x0
;R2 holds checker and checks if input is valid.
;R3 checks if digits have been entered.
AND R3, R3, x0
;R4 holds input.
AND R4, R4, x0
;R5 is loop counter.

LEA R0, prompt
PUTS

FIRST_INPUT_LOOP_4600
	GETC
	OUT
	CHECK_IF_PLUS_4600 ;Check if it's a plus sign.
		LD R2, PLUS_4600
		ADD R2, R0, R2
		BRz IS_PLUS_4600
	;CHECK_IF_MINUS_4600
		;LD R2, MINUS_4600
		;ADD R2, R0, R2
		;BRz IS_MINUS_4600
	CHECK_IF_NEWLINE_4600 ;Check if it's a newline.
		LD R2, NEWLINE_4600
		ADD R2, R0, R2
		BRz IS_NEWLINE_4600
	LESS_THAN_ZERO_4600 ;Check if it's less than 0.
		LD R2, ZERO_4600
		ADD R2, R0, R2
		BRn ERROR_4600
	GREATER_THAN_NINE_4600 ;Check if it's greater than 9.
		LD R2, NINE_4600
		ADD R2, R0, R2
		BRp ERROR_4600
		LD R5, ZERO_4600
		ADD R0, R0, R5
		ADD R3, R3, #1
		ADD R4, R4, R0
		BRp SECOND_DIGIT_4600
		BRz FIRST_INPUT_LOOP_4600
	ERROR_4600
	AND R1, R1, x0
	AND R2, R2, x0
	AND R3, R3, x0
	AND R4, R4, x0
	AND R0, R0, x0
	ADD R0, R0, #10
	OUT
	LEA R0, Error_msg_2
	PUTS
	LEA R0, prompt
	PUTS
	BR FIRST_INPUT_LOOP_4600


IS_PLUS_4600
	AND R1, R1, R1 ;Check if a plus sign was previously input.
	BRp ERROR_4600 ;If so, error.
	AND R3, R3, R3 ;Check if a digit was previously input.
	BRp ERROR_4600 ;If so, error.
	ADD R1, R1, #1 ;If not, set sign flag.
	BR FIRST_INPUT_LOOP_4600 ;Go back to first input loop.
IS_NEWLINE_4600
	AND R3, R3, R3 ;Check if a digit was previously input.
	BRz ERROR_4600 ;If not, error.
	BR EXIT_4600 ;If so, exit.

SECOND_DIGIT_4600
	GETC
	OUT
	CHECK_IF_NEWLINE_2_4600
		LD R2, NEWLINE_4600
		ADD R2, R0, R2
		BRz IS_NEWLINE_4600
	LESS_THAN_ZERO_2_4600
		LD R2, ZERO_4600
		ADD R2, R0, R2
		BRn ERROR_4600
	GREATER_THAN_FIVE_2_4600
		LD R2, FIVE_4600
		ADD R2, R0, R2
		BRp ERROR_4600
	LD R5, ZERO_4600
	ADD R0, R0, R5
	AND R5, R5, x0
	ADD R5, R5, #9
	AND R6, R6, x0
	ADD R6, R6, R4
	ADD_LOOP
		ADD R4, R6, R4
		ADD R5, R5, #-1
		BRp ADD_LOOP
	ADD R4, R4, R0
	BR SECOND_DIGIT_4600
EXIT_4600

ADD R1, R4, #-15
BRp ERROR_4600

AND R1, R1, x0
ADD R1, R1, R4



LD R6, BACKUP_R6_4600
LD R7, BACKUP_R7_4600

RET

;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
BACKUP_R6_4600	.BLKW	#1
BACKUP_R7_4600	.BLKW	#1
ZERO_4600		.FILL	xFFD0
ONE_4600		.FILL	xFFCF
FIVE_4600		.FILL	xFFCB
NINE_4600		.FILL	xFFC7
PLUS_4600		.FILL	xFFD5
MINUS_4600		.FILL	xFFD3
NEWLINE_4600	.FILL	xFFF6
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,15}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
; WITHOUT leading 0's, a leading sign, or a trailing newline.
;      Note: that number is guaranteed to be in the range {#0, #15}, 
;            i.e. either a single digit, or '1' followed by a single digit.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------

.ORIG x4800

ST R6, BACKUP_R6_4800
ST R7, BACKUP_R7_4800


AND R2, R2, x0
ADD R2, R2, #9
NOT R2, R2
ADD R2, R2, #1
LD R3, ASCII_4800
LD R4, MASK_4800

ADD R5, R1, R2
BRnz NINE_OR_LESS
BRp TEN_OR_GREATER 

NINE_OR_LESS
	ADD R0, R1, R3
	OUT
	BR DONE_4800
TEN_OR_GREATER
	AND R0, R0, x0
	ADD R0, R0, #1
	ADD R0, R0, R3
	OUT
	ADD R0, R1, R2
	ADD R0, R0, #-1
	ADD R0, R0, R3
	OUT
	
DONE_4800


LD R6, BACKUP_R6_4800
LD R7, BACKUP_R7_4800

RET

;--------------------------------
;Data for subroutine print number
;--------------------------------

BACKUP_R6_4800	.BLKW	#1
BACKUP_R7_4800	.BLKW	#1
ASCII_4800		.FILL	x30
MASK_4800		.FILL	xA






.ORIG x6A00
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xBA00			; Remote data
BUSYNESS .FILL x0000		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
