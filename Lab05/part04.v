module part4 (SW, KEY, HEX3, HEX2, HEX1, HEX0);

	// Inputs and Outputs
	input [1:0] SW;
	input [0:0] KEY;
	output [0:6] HEX3, HEX2, HEX1, HEX0;
	
	// Initialize wire variables
	wire enable, clock, clear; 
	// Assign 16-bit register to Q
	reg [15:0] Q;
	
	// Assign wires to inputs (key and switches)
	assign clock = KEY[0];
	assign enable = SW[1];
	assign clear = SW[0];
	
	always @(posedge clk or negedge clear)
		if (~clear) 
			Q <= 16'b0;
		else if (enable)
			Q <= Q + 1;
	
	// Display bits on HEX display
	seg7display D1 (Q[3:0], HEX0);
	seg7display D2 (Q[7:4], HEX1);
	seg7display D3 (Q[11:8], HEX2);
	seg7display D4 (Q[15:12], HEX3);
	
endmodule


module seg7display (IN, OUT)

	// Inputs and Outputs
	input [3:0] IN;
	output [6:0] OUT;

	// Initialize wire variables 
	wire A, B, C, D;

	// Wire assignments to switch inputs
	assign A = IN[0];
	assign B = IN[1];
	assign C = IN[2];
	assign D = IN[3];

	// Output assignments for HEX
	assign OUT[0] = (~D&~C&~B&A) | (~B&~A&C);	
	assign OUT[1] = C & ( (~B&A) | (B&~A) );
	assign OUT[2] = (B&~A&~C);
	assign OUT[3] = (~B&A&~C) |  (C & ( (~B&~A) | (B&A) ) );
	assign OUT[4] = (~B&C) | A;
	assign OUT[5] = (B&D) | ( (~D&~C) & (B&A) );
	assign OUT[6] = (~D&~C&~B) | (B&C&A);
	
endmodule