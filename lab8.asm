;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 25
; TA: Enoch Lin
; 
;=================================================

; test harness
					.orig x3000
				 
				 LD R6, SUB_PRINT_OPCODES
				 JSRR R6
				 
				 LD R6, SUB_FIND_OPCODE
				 JSRR R6
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
OPCODES	.FILL	x4000
INSTRUCTIONS	.FILL	x4100
SUB_PRINT_OPCODES	.FILL	x3200
SUB_FIND_OPCODE		.FILL	x3600

;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODES
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;		 		 and corresponding opcode in the following format:
;		 		 ADD = 0001
;		  		 AND = 0101
;		  		 BR = 0000
;		  		 …
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3200
				 
				 ST R0, BACKUP_R0_3200
				 ST R1, BACKUP_R1_3200
				 ST R2, BACKUP_R2_3200
				 ST R3, BACKUP_R3_3200
				 ST R4, BACKUP_R4_3200
				 ST R5, BACKUP_R5_3200
				 ST R6, BACKUP_R6_3200
				 ST R7, BACKUP_R7_3200
				 
				 ; There's 17 instructions.
				 LD R1, instructions_po_ptr ;R1 holds the address of the instructions array.
				 LDR R0, R1, #0 ;R0 holds the content at the address of R1.
				 LD R6, SUB_PRINT_OPCODE ;R6 holds the address of the print opcode subroutine.
				 LD R3, opcodes_po_ptr ;R3 points to an element in the opcodes array.
				 LD R4, CHECK_SPACE ;R4 checks for a space.
				 ;R5 holds the result of R0 + R4.
				 
				 OUTPUT_LOOP_3200
					ADD R5, R0, R4
					BRz IS_SPACE
					AND R0, R0, R0
					BRz END_OF_INSTRUCTION_3200
					BRn DONE_3200
					OUT
					IS_SPACE
					ADD R1, R1, #1
					LDR R0, R1, #0
					BR OUTPUT_LOOP_3200
					
				END_OF_INSTRUCTION_3200
					LD R0, SPACE
					OUT
					LD R0, EQUAL
					OUT
					LD R0, SPACE
					OUT
					JSRR R6
					ADD R3, R3, #1
					BR OUTPUT_LOOP_3200
				
				DONE_3200
				AND R0, R0, x0
				ADD R0, R0, xA
				OUT
				 
				 LD R0, BACKUP_R0_3200
				 LD R1, BACKUP_R1_3200
				 LD R2, BACKUP_R2_3200
				 LD R3, BACKUP_R3_3200
				 LD R4, BACKUP_R4_3200
				 LD R5, BACKUP_R5_3200
				 LD R6, BACKUP_R6_3200
				 LD R7, BACKUP_R7_3200
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODES local data
opcodes_po_ptr		.fill x4000
instructions_po_ptr	.fill x4100
BACKUP_R0_3200		.BLKW	#1
BACKUP_R1_3200		.BLKW	#1
BACKUP_R2_3200		.BLKW	#1
BACKUP_R3_3200		.BLKW	#1
BACKUP_R4_3200		.BLKW	#1
BACKUP_R5_3200		.BLKW	#1
BACKUP_R6_3200		.BLKW	#1
BACKUP_R7_3200		.BLKW	#1
SPACE				.FILL	x20
EQUAL				.FILL	x3D
SUB_PRINT_OPCODE		.FILL	x3400
CHECK_SPACE			.FILL	xFFE0


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3400
				 
				 ST R0, BACKUP_R0_3400
				 ST R1, BACKUP_R1_3400
				 ST R2, BACKUP_R2_3400
				 ST R3, BACKUP_R3_3400
				 ST R4, BACKUP_R4_3400
				 ST R5, BACKUP_R5_3400
				 ST R6, BACKUP_R6_3400
				 ST R7, BACKUP_R7_3400
				 
				 ;R1 is the loop counter.
				 ;R2 holds the content at the address of R3.
				 ;R3 points to an element in the opcodes array.
				 ;R4 holds the mask.
				 ;R5 holds the result of R2 and R4.
				 
				 LDR R2, R3, #0
				 AND R1, R1, x0
				 ADD R1, R1, #12
				 
				 ADD_LOOP
					ADD R2, R2, R2
					ADD R1, R1, -#1
					BRp ADD_LOOP
				 
				 ADD R1, R1, #4
				 LD R4, MASK_3400
				 
				 PRINT_LOOP
					AND R5, R2, R4
					BRz PRINT_ZERO
					BRn PRINT_ONE
					CONTINUE_3400
					ADD R2, R2, R2
					ADD R1, R1, #-1
					BRp PRINT_LOOP
					BR HEAD_OUT
					
					
				PRINT_ZERO
					AND R0, R0, x0
					LD R0, ZERO
					OUT
					BR CONTINUE_3400
				
				PRINT_ONE
					AND R0, R0, x0
					LD R0, ONE
					OUT
					BR CONTINUE_3400
				
				HEAD_OUT
				AND R0, R0, x0
				ADD R0, R0, xA
				OUT
				 
				 LD R0, BACKUP_R0_3400
				 LD R1, BACKUP_R1_3400
				 LD R2, BACKUP_R2_3400
				 LD R3, BACKUP_R3_3400
				 LD R4, BACKUP_R4_3400
				 LD R5, BACKUP_R5_3400
				 LD R6, BACKUP_R6_3400
				 LD R7, BACKUP_R7_3400
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
BACKUP_R0_3400	.BLKW	#1
BACKUP_R1_3400	.BLKW	#1
BACKUP_R2_3400	.BLKW	#1
BACKUP_R3_3400	.BLKW	#1
BACKUP_R4_3400	.BLKW	#1
BACKUP_R5_3400	.BLKW	#1
BACKUP_R6_3400	.BLKW	#1
BACKUP_R7_3400	.BLKW	#1
MASK_3400		.FILL	x8000
ZERO			.FILL	x30
ONE				.FILL	x31


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3600
				 
				 ST R0, BACKUP_R0_3600
				 ST R1, BACKUP_R1_3600
				 ST R2, BACKUP_R2_3600
				 ST R3, BACKUP_R3_3600
				 ST R4, BACKUP_R4_3600
				 ST R5, BACKUP_R5_3600
				 ST R6, BACKUP_R6_3600
				 ST R7, BACKUP_R7_3600
				 
				 LEA R2, USER_INPUT
				 LD R6, SUB_GET_STRING
				 JSRR R6
				 
				 
				 ;R0 holds the content of the address of R1.
				 ;R1 points to an element of the instructions array.
				 ;R2 points to an element of the user input array.
				 ;R3 holds the content of the address of R2.
				 ;R4 holds the flag for if a match is found.
				 
				 LD R1, instructions_fo_ptr
				 LEA R2, USER_INPUT
				 
				 AND R4, R4, x0
				 AND R5, R5, x0
				 AND R6, R6, x0
				 
				 FIND_LOOP
					LDR R0, R1, #0
					BRn INVALID
					BRz END_OF_INSTRUCTION
					LDR R3, R2, #0
					;OUT
					AND R3, R3, R3
					BRz RESET
					
					NOT R3, R3
					ADD R3, R3, #1
					ADD R5, R3, R0
					BRz MATCH
					BR NO_MATCH
					
					BRnp INCREMENT
					CONTINUE
					BR FIND_LOOP
					
					
				INCREMENT
					ADD R1, R1, #1
					ADD R2, R2, #1
					BR CONTINUE
				
				RESET
					LEA R2, USER_INPUT
					ADD R2, R2, #-1
					AND R4, R4, x0
					BR INCREMENT
				
				MATCH
					ADD R4, R4, #1
					BR INCREMENT
				
				NO_MATCH
					AND R4, R4, x0
					BR RESET
				
				END_OF_INSTRUCTION
					ADD R6, R6, #1
					AND R4, R4, R4
					BRz RESET
					LDR R3, R2, #0
					AND R3, R3, R3
					BRz YES
					BRp RESET
					
				YES
					NOT R4, R4
					ADD R4, R4, #1
					ADD R1, R1, R4
					ADD R6, R6, #-1
					LD R3, opcodes_fo_ptr
					ADD R3, R3, R6
					
					
					OUTPUT_INSTRUCTION_LOOP_3600
						LDR R0, R1, #0
						BRz END_OUTPUT_INSTRUCTION_LOOP_3600
						OUT
						ADD R1, R1, #1
						BR OUTPUT_INSTRUCTION_LOOP_3600
					END_OUTPUT_INSTRUCTION_LOOP_3600
					
					LD R0, SPACE_3600
					OUT
					LD R0, EQUAL_3600
					OUT
					LD R0, SPACE_3600
					OUT
					
					LD R6, SUB_PRINT_OPCODE_3600
					JSRR R6
					
					BR END_3600
				
				INVALID
					LEA R0, INVALID_INPUT_PROMPT
					PUTS
					
				END_3600
				 
				 LD R0, BACKUP_R0_3600
				 LD R1, BACKUP_R1_3600
				 LD R2, BACKUP_R2_3600
				 LD R3, BACKUP_R3_3600
				 LD R4, BACKUP_R4_3600
				 LD R5, BACKUP_R5_3600
				 LD R6, BACKUP_R6_3600
				 LD R7, BACKUP_R7_3600
				 
				 ret
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100
SUB_GET_STRING			.FILL	x3800
SUB_PRINT_OPCODE_3600		.FILL	x3400
BACKUP_R0_3600	.BLKW	#1
BACKUP_R1_3600	.BLKW	#1
BACKUP_R2_3600	.BLKW	#1
BACKUP_R3_3600	.BLKW	#1
BACKUP_R4_3600	.BLKW	#1
BACKUP_R5_3600	.BLKW	#1
BACKUP_R6_3600	.BLKW	#1
BACKUP_R7_3600	.BLKW	#1
INVALID_INPUT_PROMPT	.STRINGZ	"Invalid instruction."
SPACE_3600		.FILL	x20
EQUAL_3600		.FILL	x3D
USER_INPUT


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
					.orig x3800
				 
				 ST R0, BACKUP_R0_3800
				 ST R1, BACKUP_R1_3800
				 ST R2, BACKUP_R2_3800
				 ST R3, BACKUP_R3_3800
				 ST R4, BACKUP_R4_3800
				 ST R5, BACKUP_R5_3800
				 ST R6, BACKUP_R6_3800
				 ST R7, BACKUP_R7_3800
				 
				 LEA R0, PROMPT
				 PUTS
				 
				 ;R1 checks for newline.
				 ;R2 holds address of USER_INPUT.
				 ;R3 holds R0 + R1.
				 
				 LD R1, CHECK_NEWLINE
				 
				 GET_USER_INPUT
					GETC
					OUT
					ADD R3, R1, R0
					BRz END_GET_USER_INPUT
					STR R0, R2, #0
					ADD R2, R2, #1
					BR GET_USER_INPUT
					
				 END_GET_USER_INPUT
				 
				 LD R0, BACKUP_R0_3800
				 LD R1, BACKUP_R1_3800
				 ;LD R2, BACKUP_R2_3800
				 LD R3, BACKUP_R3_3800
				 LD R4, BACKUP_R4_3800
				 LD R5, BACKUP_R5_3800
				 LD R6, BACKUP_R6_3800
				 LD R7, BACKUP_R7_3800
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
CHECK_NEWLINE	.FILL	xFFF6
PROMPT			.STRINGZ	"Enter opcode to find: "
BACKUP_R0_3800	.BLKW	#1
BACKUP_R1_3800	.BLKW	#1
BACKUP_R2_3800	.BLKW	#1
BACKUP_R3_3800	.BLKW	#1
BACKUP_R4_3800	.BLKW	#1
BACKUP_R5_3800	.BLKW	#1
BACKUP_R6_3800	.BLKW	#1
BACKUP_R7_3800	.BLKW	#1


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
					.ORIG x4000			; list opcodes as numbers, e.g. .fill #12 or .fill xC
opcodes
.FILL	#1
.FILL	#5
.FILL	#0
.FILL	#12
.FILL	#4
.FILL	#4
.FILL	#2
.FILL	#10
.FILL	#6
.FILL	#14
.FILL	#9
.FILL	#12
.FILL	#8
.FILL	#3
.FILL	#11
.FILL	#7
.FILL	#15

					.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
instructions				 			; - be sure to follow same order in opcode & instruction arrays!
.STRINGZ	"ADD"
.STRINGZ	"AND"
.STRINGZ	"BR"
.STRINGZ	"JMP"
.STRINGZ	"JSR"
.STRINGZ	"JSRR"
.STRINGZ	"LD"
.STRINGZ	"LDI"
.STRINGZ	"LDR"
.STRINGZ	"LEA"
.STRINGZ	"NOT"
.STRINGZ	"RET"
.STRINGZ	"RTI"
.STRINGZ	"ST"
.STRINGZ	"STI"
.STRINGZ	"STR"
.STRINGZ	"TRAP"
.FILL		#-1


;===============================================================================================
