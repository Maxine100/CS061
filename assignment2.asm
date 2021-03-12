;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
;Getting and outputing user input.
GETC
OUT
ADD R1, R0, 0
LD R0, newline
OUT
GETC
OUT
ADD R2, R0, 0
LD R0, newline
OUT

;Outputing equation.
ADD R0, R1, 0
OUT
LD R0, space
OUT
LD R0, subtract
OUT
LD R0, space
OUT
ADD R0, R2, 0
OUT
LD R0, space
OUT
LD R0, equal
OUT
LD R0, space
OUT

;Converting ASCII values to numerical values.
LD R3, reduce
NOT R3, R3
ADD R3, R3, #1
ADD R1, R1, R3
ADD R2, R2, R3

;Taking 2's complement of second number.
NOT R2, R2
ADD R2, R2, #1

LD R3, reduce

;Adding the two numbers.
ADD R4, R1, R2

IF
	BRn NEGATIVE
	BRzp END_IF
NEGATIVE
	LD R0, subtract
	OUT
	NOT R4, R4
	ADD R4, R4, #1
END_IF

;Converting numerical value to ASCII value.
ADD R0, R4, R3
;ADD R0, R4, #0
OUT

LD R0, newline
OUT

HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT

subtract	.FILL	'-'
equal		.FILL	'='
space		.FILL	' '
;bitsize		.FILL	#5
reduce		.FILL	x0030

;---------------	
;END of PROGRAM
;---------------	
.END

