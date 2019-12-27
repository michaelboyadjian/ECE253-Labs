// Lab6 Part 1

module part1a (SW, KEY, LEDR)

	// Inputs and Outputs
	input [1:0] SW;
	input [0:0] KEY;
	output [9:0]LEDR;
	
	// Initializing wire variables
	wire clock, w, reset, Z;
	wire [8:0] Y, N;
	
	// Assigning switches and key
	assign clock = KEY[0];
	assign w = SW[1];
	assign resetn = SW[0];
	
	// Initial FSM state assignments
	assign Y[0] = (!w) & (y[0]);
	assign Y[1] = (!w) & (y[0]|y[5]|y[6]|y[7]|y[8]);
	assign Y[2] = (!w) & (y[1]);
	assign Y[3] = (!w) & (y[2]);
	assign Y[4] = (!w) & (y[3]|y[4]);
	assign Y[5] = (w) & (y[0]|y[1]|y[2]|y[3]|y[4]);
	assign Y[6] = (w) & (y[5]);
	assign Y[7] = (w) & (y[6]);
	assign Y[8] = (w) & (y[7]|y[8]);
	
	// Flip-flops to determine the next states
	dff A0(Y[0], clock, N[0], reset);
	dff A1(Y[1], clock, N[1], reset);
	dff A2(Y[2], clock, N[2], reset);
	dff A3(Y[3], clock, N[3], reset);
	dff A4(Y[4], clock, N[4], reset);
	dff A5(Y[5], clock, N[5], reset);
	dff A6(Y[6], clock, N[6], reset);
	dff A7(Y[7], clock, N[7], reset);
	dff A8(Y[8], clock, N[8], reset);
	
	assign Z = Y[8] | Y[4]
	
	assign LEDR[9:0] = {Z, Y[8:0]}

endmodule

module part1b (SW, KEY, LEDR)

	// Inputs and Outputs
	input [1:0] SW;
	input [0:0] KEY;
	output [9:0]LEDR;
	
	// Initializing wire variables
	wire clock, w, reset, Z;
	wire [8:0] Y, N;
	
	// Assigning switches and key
	assign clock = KEY[0];
	assign w = SW[1];
	assign resetn = SW[0];
	
	// Initial FSM state assignments
	assign Y[0] = 1'b1;
	assign Y[1] = (!w) & (!y[0]|y[5]|y[6]|y[7]|y[8]); 
	assign Y[2] = (!w) & (y[1]);
	assign Y[3] = (!w) & (y[2]);
	assign Y[4] = (!w) & (y[3]|y[4]);
	assign Y[5] = (w) & (!y[0]|y[1]|y[2]|y[3]|y[4]);
	assign Y[6] = (w) & (y[5]);
	assign Y[7] = (w) & (y[6]);
	assign Y[8] = (w) & (y[7]|y[8]);
	
	// Flip-flops to determine the next states
	dff A0(Y[0], clock, N[0], reset);
	dff A1(Y[1], clock, N[1], reset);
	dff A2(Y[2], clock, N[2], reset);
	dff A3(Y[3], clock, N[3], reset);
	dff A4(Y[4], clock, N[4], reset);
	dff A5(Y[5], clock, N[5], reset);
	dff A6(Y[6], clock, N[6], reset);
	dff A7(Y[7], clock, N[7], reset);
	dff A8(Y[8], clock, N[8], reset);
	
	assign Z = Y[8] | Y[4]
	
	assign LEDR[9:0] = {Z, Y[8:0]}

endmodule


// D-FlipFlop Module
module dff(D, clock, Q, reset);
	input D, clock, reset;
	output reg Q;
	always @(posedge clock)
	begin
		if (reset == 1'b0)
		begin
			Q <= 1'b0;
		end
		else
		begin
			Q <= D;
		end
	end
endmodule

