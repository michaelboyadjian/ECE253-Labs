.text
.global _start

_start:
LDR R0, = TEST_LIST 	
    	MOV R8, #0
    	MOV R9, #0
    	MOV R10, #0

MAIN:
      	MOV R2, #0 		// Shift Counter
MOV R3, #0 		// LEADING counter
MOV R4, #0		// TRAILING counter
MOV R5, #0 		// Leading 1s counter
MOV R6, #0 		// Leading 0s
MOV R7, #0 		// Trailing 0s
LDR R11, [R0]
MOV R1, R11 		// Load value to R1
CMP R11, #-1 
BEQ END 			// End program if word is -1

        	BL ONES			// Branch to ONES subroutine
        	MOV R1, R11
        	BL LEADING 		// Branch to LEADING subroutine
       	MOV R1, R11
        	BL TRAILING 		// Branch to TRAILING subroutine
        	ADD R0, R0, #4 		// Go to next word in list

       	CMP R5, R8
        	MOVGT R8, R5 		// Compare new value to max, if R5 > R8, replace

        	CMP R6, R9 		
        	MOVGT R9, R6 		// Compare new value to max, if R6 > R9, replace

        	CMP R7, R10
        	MOVGT R10, R7 		// Compare new value to max, if R7 > R10, replace

        	B MAIN
	
ONES: 
        	CMP R2, #32 
        	BEQ EXIT 			// Stop if equal to 32
        	ADD R2, #1
        	AND R12,R1,#1
        	CMP R12, #1
        	ADDEQ R5,#1
        	LSR R1, #1
        	B ONES 				// Loop through ONES subroutine

LEADING:
        	CMP R3, #32
        	BEQ EXIT 				// Stop if equal to 32
        	ADD R3, #1
        	AND R12, R1, #2147483648 
        	CMP R12, #2147483648 
        	BEQ EXIT 				// If left most bit is 1, exit
        	ADD R6, #1
        	LSL R1, #1
        	B LEADING 			// Loop through leading subroutine

TRAILING:
        	CMP R4, #32
        	BEQ EXIT 
        	ADD R4, #1
        	AND R12, R1, #1 			// Extract right most bit
        	CMP R12, #1
        	BEQ EXIT 				// If right most bit is 1, exit
        	ADD R7, #1
        	LSR R1, #1
        	B TRAILING 				// Loop through TRAILING subroutine

EXIT:
       	MOV PC, LR

END: 
        	B END

TEST_LIST: 
.word 0x1111,0xffff,-1

.end

