;=================================================
; Name: Maxine Wu
; Email: mwu031@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 25
; TA: Enoch Lin
; 
;=================================================

.ORIG x3000
;------------
;Instructions
;------------

LDI R3, DATA_PTR
LDI R4, DATA_PTR+#1

ADD R3, R3, 1
ADD R4, R4, 1

STI R3, DATA_PTR
STI R4, DATA_PTR+#1

LD R5, DATA_PTR
LD R6, DATA_PTR+#1

ADD R3, R3, 1
ADD R4, R4, 1

STR R3, R5, #0
STR R4, R6, #0

HALT
;-------------
;Data
;-------------
DATA_PTR	.FILL	x4000
.FILL	x4001

.ORIG x4000
.FILL	#65
.FILL	x41

.END
