.text
.global _start

_start:
	MOV R0, #0		// all registers are set 0
	MOV R1, #0
	MOV R2, #0
	MOV R3, #0
	MOV R4, #0
	MOV R5, #0
	MOV R6, #0
	MOV R7, #0
	MOV R8, #0
	MOV R9, #0
	MOV R10, #0
	MOV R11, #0
	MOV R12, #0

	LDR R4, = TEST_NUM		// list address
	LDR R5, [R4]			// list length -> R5
	MOV R6, R4			// Start address of list
	
MAIN:
	MOV R4, R6			// Put start of address of list in R4
	SUB R5, R5, #1			// R5--
	CMP R5, #0			// Compare new loop length to 0
	STR R5, [R6]			// Store new length in R6
	LDR R7, [R6]			// Load R6 into R7
	BNE FOR			// If R5 != 0, branch to for loop
B END
	
FOR:
	ADD R4, R4, #4			// Go to next list value
	CMP R7, #0			// Compare sub for loop length  to 0
	SUB R7, R7, #1			// R7--
	BLNE SWAP			// If R7 != 0, branch to swap
CMP R7, #0
 	BNE FOR
	B MAIN
	
SWAP: 
	MOV R0, #0			// Set R0 to zero before swapping takes place
	LDR R10, [R4]			// Load first word to R10
	LDR R11, [R4, #4]		// Load second word to R11
	CMP R10, R11			// Compare R10 to R11
	STRGT R10, [R4, #4]		// Store R10 into R4+4 address 
	STRGT R11, [R4]		// Store R11 into R4 address 
	MOVGT R0, #1			// Set R0 to 1 because swapped
	B EXIT	

EXIT:
	MOV PC, LR
	
END:
	B END

TEST_NUM:
	 .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33
	
.end




