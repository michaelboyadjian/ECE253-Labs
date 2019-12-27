module part3(SW, KEY, HEX0, HEX1);

	// Inputs and Outputs
	input [9:0] SW;
	input [0:0] KEY;
	output [0:6] HEX0, HEX1;
	
	wire clk, enable, reset;
	wire [15:0] Q;
	
	// Assignments
	assign clock = KEY[0];
	assign enable = SW[1];
	assign reset = SW[0];
	
	// Logic
	flip_flop T0  (enable, clock, reset, Q[0]);
	flip_flop T1  ((enable & Q[0]), clock, reset, Q[1]);
	flip_flop T2  ((enable & Q[0] & Q[1]), clock, reset, Q[2]);
	flip_flop T3  ((enable & Q[0] & Q[1] & Q[2]), clock, reset, Q[3]);
	flip_flop T4  ((enable & Q[0] & Q[1] & Q[2] & Q[3]), clock, reset, Q[4]);
	flip_flop T5  ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4]), clock, reset, Q[5]);
	flip_flop T6  ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5]), clock, reset, Q[6]);
	flip_flop T7  ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6]), clock, reset, Q[7]);
	flip_flop T8  ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7]), clock, reset, Q[8]);
	flip_flop T9  ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7] & Q[8]), clock, reset, Q[9]);
	flip_flop T10 ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7] & Q[8] & Q[9]), clock, reset, Q[10]);
	flip_flop T11 ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7] & Q[8] & Q[9] & Q[10]), clock, reset, Q[11]);
	flip_flop T12 ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7] & Q[8] & Q[9] & Q[10] & Q[11]), clock, reset, Q[12]);
	flip_flop T13 ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7] & Q[8] & Q[9] & Q[10] & Q[11] & Q[12]), clock, reset, Q[13]);
	flip_flop T14 ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7] & Q[8] & Q[9] & Q[10] & Q[11] & Q[12] & Q[13]), clock, reset, Q[14]);
	flip_flop T15 ((enable & Q[0] & Q[1] & Q[2] & Q[3] & Q[4] & Q[5] & Q[6] & Q[7] & Q[8] & Q[9] & Q[10] & Q[11] & Q[12] & Q[13] & Q[14]), clock, reset, Q[15]);

	
	dispHex H0 (Q[3:0],  HEX0);
	dispHex H1 (Q[7:4],  HEX1);	
	dispHex H2 (Q[11:8], HEX2);
	dispHex H3 (Q[15:9], HEX3);

endmodule


module tflipflop(T, clock, reset, Q);
	input T, clock, reset;
	output reg Q;
	
	always @ (posedge clock or negedge reset)
		if (~reset)
			Q <= 1'b0;
		else if (T)
			Q <= !Q;
endmodule
