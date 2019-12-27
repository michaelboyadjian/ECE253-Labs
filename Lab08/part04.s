.text
.global _start

_start:
    	MOV R5, #0 			// R5 will hold final result
	MOV R0, #0			// R0 will hold result per word
	LDR R3, = TEST_NUM 		// Load list to R3
	
LOOP:
LDR R1,  [R3]			// load the first word into R1
CMP R1, #0			// If word = -1		
	BLT END				// Branch to end
	MOV R0, #0			// R0 will hold result per word
	BL ONES				// Branch to ONES subroutine
	ADD R3, R3, #4 			// Go to the next word
	CMP R5, R0			// Comparing R5 and R0
	MOVLT R5, R0			// Update value if R0 > R5 
	B LOOP

END:
	B END				// End program
	
ONES:
	CMP R1, #0 			// loop until the data contains no more 1’s
    	BEQ EXIT
    	LSR R2, R1, #1			// perform SHIFT, followed by AND
    	AND R1, R1, R2
    	ADD R0, #1 			// count the string lengths so far
B ONES			

EXIT:
	MOV PC, LR			// Exit subroutine

TEST_NUM: 
	.word 0x618dc64c, 0x103fe00f, 0xdf233dfc, 0x3c886635, 0x00000002, 0x00000030,  -1

.end