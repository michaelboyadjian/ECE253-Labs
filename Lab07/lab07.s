.text
.global start

start:
LDR R0, = TEST_NUM		// Assign address of list to R0
LDR R1, [R0]			// Assign value of initial element in list to R1
MOV R8, #0			// Set R8 to 0
MOV R7, #0			// Set R7 to 0

LOOP:
ADD R7, R7, R1		// R7 = R7 + R1
ADD R8, R8, #1			// R8 = R8 + 1  [counter]
ADD R0, R0, #4			// Increment address of list by 4 [go to next word]
	LDR R1, [R0]			// Load new element into R1
  	CMP R1, #0			// Compare R1 with 0, if >= 0, continue
    	BGE LOOP

END: 
	B END

TEST_NUM: 
	.word 1,2,3,5,0xA,-1		// Test list

.end

