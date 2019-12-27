.text
.global _start

_start:
	LDR		R1, =0xFF200000 	// LEDR
	LDR		R2, =0xFF200050 	// KEYS
	LDR		R8, =0xFFFEC600	// Timer 
	LDR		R0, =200000000	// Delay (0.25s)
	MOV		R3, #0		// Direction Tracker (0 = IN, 1 = OUT)
	STR		R0, [R8]			
            	MOV		R0, #0b011		// A = 1, E = 1, I = 0
            	STR		R0, [R8, #8]		
	MOV		R6, #0x00000001 	// Initial Pattern - LED0 
            	MOV 		R9, #0x00000200	// Initial Pattern - LED0
	ORR		R6, R6, R9		// ORR R6 and R9 so both are lit up
	MOV		R5, #0x00000001		
		
DISPLAY:
	STR	R6, [R1]				// Display LEDs

ROTATE:
CMP		R3, #0			        // Check direction
	BLEQ		ROT_IN			// if equal, branch to ROT_IN
	CMP		R3, #0			    // Check direction again
      BLNE		ROT_OUT			// if not equal, branch to ROT_OUT
	B ROTATE

ROT_IN:
	AND 		R12, R6, #0b10000	
	CMP		R12, #0x00000010	// Check to see if left side is on inside boundary
	MOVEQ	R3, #1			// If yes, change the direction
	AND 		R10, R6, #0b11111	// Shift the right half once to the left 
	LSL		R10, R10, #1
AND		R11, R6, #0b1111100000	// Shift the left half once to the right
	ROR		R11, R11, #1
ORR		R6, R10, R11		// Or together to get both LEDs to display
            	B		WAIT1

ROT_OUT:
	AND 		R12, R6, #1		
	CMP		R12, #0x00000001	// Check to see if left side is on outside boundary
	MOVEQ	R3, #0			// If yes, change the direction
            	AND 		R10, R6, #0b11111	// Shift the left half once to the right
	BEQ 		WAIT1
	ROR		R10, R10, #1
	AND		R11, R6, #0b1111100000	// Shift the right half once to the left
	LSL		R11, R11, #1
	ORR		R6, R10, R11		// Or together to get both LEDs to display
            	B		WAIT1

WAIT1:
	LDR		R7, [R2]			// Read KEYS
	CMP 		R7, #0x00000008		// Check if KEY3 is pressed
            	BEQ		KEY_PRESS_1		// Branch to KEY_PRESS_1

WAIT2:
	LDR		R0, [R8, #0xC]		// R0 = interrupt status register
	CMP		R0, #0			// Check F == 0
            	BEQ		WAIT1		// Keep delaying if F is not 0
            	STR		R0, [R8, #0xC]		// Writing to interrupt status register to reset it
            	B		DISPLAY

// KEY PRESS to pause LEDs

KEY_PRESS_1:
	LDR		R7, [R2]			// Read KEYS
	CMP		R7, #0x00000000		// Check if KEYS have been released
            	BEQ		KEY_RELEASE_1	// If yes, branch to KEY_RELEASE_1
              B		KEY_PRESS_1		// Keep looping if KEYS have not been released

KEY_RELEASE_1:
	LDR		R7, [R2]			// Read KEYS
	CMP		R7, #0x00000008		// Check if KEY3 has been pressed
               BEQ		KEY_PRESS_2		// If yes, branch to KEY_PRESS_2
               B		KEY_RELEASE_1	// Keep looping if KEY3 has not been released

// KEY PRESS to play LEDs

KEY_PRESS_2:
	LDR		R7, [R2]			// Read KEYS
	CMP		R7, #0x00000000 	// Check if KEYS have been released
                BEQ		WAIT2		// If yes, jump back to original delay block
                B		KEY_PRESS_2		// Keep looping if KEYS have not been released


