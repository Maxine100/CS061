;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 25
; TA: Enoch Lin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R2
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------

FIRST_INPUT_LOOP
; output intro prompt
LD R0, introPromptPtr
PUTS
						
; Set up flags, counters, accumulators as needed

AND R1, R1, x0 ;Compares with input.
AND R2, R2, x0 ;Stores number.
AND R3, R3, x0 ;Negative flag.
AND R4, R4, x0 ;Digit counter.
ADD R4, R4, #5 ;Counts input.
AND R5, R5, x0 ;Determines if a digit has been entered.
; Get first character, test for '\n', '+', '-', digit/non-digit 	
GETC
OUT
	
					; is very first character = '\n'? if so, just quit (no message)!
					LD R1, newline
					ADD R1, R1, R0
					BRz TERMINATE

					; is it = '+'? if so, ignore it, go get digits
					LD R1, plus
					ADD R1, R1, R0
					BRz IS_POSITIVE

					; is it = '-'? if so, set neg flag, go get digits
					LD R1, minus
					ADD R1, R1, R0
					BRz IS_NEGATIVE
					
					; is it < '0'? if so, it is not a digit	- o/p error message, start over
					LD R1, zero
					ADD R1, R1, R0
					BRp GREATER_THAN_ZERO
					BRz CONTINUE
					BRn ERROR


					GREATER_THAN_ZERO
					; is it > '9'? if so, it is not a digit	- o/p error message, start over
					LD R1, nine
					ADD R1, R1, R0
					BRnz CONTINUE
					BRp ERROR
				
					; if none of the above, first character is first numeric digit - convert it to number & store in target register!
					
; Now get remaining digits (max 5) from user, testing each to see if it is a digit, and build up number in accumulator

					; remember to end with a newline!
		
		IS_POSITIVE
			BR REST_OF_DIGITS
		IS_NEGATIVE
			ADD R3, R3, #1
			BR REST_OF_DIGITS
		CONTINUE
			ADD R5, R5, #1
			AND R6, R6, x0
			ADD R6, R6, #9
			LD R1, zero
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
	
	LD R1, newline
	ADD R1, R1, R0
	BRz NEWLINE_INPUT
	
	INVALID_MINUS
		LD R1, minus
		ADD R1, R1, R0
		BRz ERROR
	INVALID_PLUS
		LD R1, plus
		ADD R1, R1, R0
		BRz ERROR
		
	LD R1, zero
	ADD R1, R1, R0
	BRp GREATER_THAN_ZERO
	BRz CONTINUE
	LD R0, output_newline
	OUT
	LD R0, errorMessagePtr
	PUTS
	BR FIRST_INPUT_LOOP
	
	ERROR
		LD R0, output_newline
		OUT
		LD R0, errorMessagePtr
		PUTS
		BR FIRST_INPUT_LOOP
	
	NEWLINE_INPUT
		AND R5, R5, R5
		BRp CHECK_FOR_NEGATIVE
		BRz ERROR

END
	LD R0, output_newline
	OUT
	CHECK_FOR_NEGATIVE
		AND R3, R3, R3
		BRp CONVERT_TO_NEGATIVE
		BR TERMINATE

CONVERT_TO_NEGATIVE
	NOT R2, R2
	ADD R2, R2, #1

TERMINATE

					HALT

;---------------	
; Program Data
;---------------

introPromptPtr		.FILL xA100
errorMessagePtr		.FILL xA200
newline				.FILL	xFFF6
plus				.FILL	xFFD5
minus				.FILL	xFFD3
zero				.FILL	xFFD0
nine				.FILL	xFFC7
output_newline		.FILL	xA

;------------
; Remote data
;------------
					.ORIG xA100			; intro prompt
					.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
					.ORIG xA200			; error message
					.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
					.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
