module part6(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	// Inputs and Outputs
	input CLOCK_50;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	// Initiatlizing wire variables
	reg reset_cnt_main, reset_cnt_smol;
	wire [1:0] M0, M1, M2, M3, M4, M5;
	wire [25:0] cnt_main;
	wire [2:0] cnt_smol;
	
	// Always blocks for signal resets
	always @(cnt_main)
		if (cnt_main == 26'b10111110101111000010000000)
			reset_cnt_main <= 1'b1;
		else
			reset_cnt_main <= 1'b0;
	always @(cnt_smol)
		if (cnt_smol == 3'b110)
			reset_cnt_smol <= 1'b1;
		else
			reset_cnt_smol <= 1'b0;
	
	// Call counters
	counter_50 C0 (CLOCK_50, reset_cnt_main, cnt_main);
	counter_9  C1 (CLOCK_50, reset_cnt_main, reset_cnt_smol, cnt_smol);
	
	// Rotate displays
	mux_2bit_6to1 U0 (cnt_smol, 2'b01, 3, 3, 3, 2'b00, 2'b10, M0);
	mux_2bit_6to1 U1 (cnt_smol, 2'b10, 2'b01, 3, 3, 3, 2'b00, M1);
	mux_2bit_6to1 U2 (cnt_smol, 2'b00, 2'b10, 2'b01, 3, 3, 3, M2);
	mux_2bit_6to1 U3 (cnt_smol, 3, 2'b00, 2'b10, 2'b01, 3, 3, M3);
	mux_2bit_6to1 U4 (cnt_smol, 3, 3, 2'b00, 2'b10, 2'b01, 3, M4);
	mux_2bit_6to1 U5 (cnt_smol, 3, 3, 3, 2'b00, 2'b10, 2'b01, M5);
	
	// 7-segment decoders
	char_7seg H0 (M0, HEX0);
	char_7seg H1 (M1, HEX1);
	char_7seg H2 (M2, HEX2);
	char_7seg H3 (M3, HEX3);
	char_7seg H4 (M4, HEX4);
	char_7seg H5 (M5, HEX5);
	
endmodule

module counter_50(clk, reset, Q);
	// Assigning inputs and outputs
	input clk, reset;
	output reg [25:0] Q;
	
	// Logic
	always @(posedge clk)
		if (reset)
			Q <= 26'b0;
		else
			Q <= Q + 1;
endmodule

module counter_9(clk, enable, reset, S);
	// Assigning inputs and outputs
	input clk, reset, enable;
	output reg [2:0] S;
	
	// Logic
	always @(posedge clk)
		if (reset)
			S <= 3'b0;
		else if (enable)
			S <= S + 1;
endmodule

module mux_2bit_6to1(S, A, B, C, D, E, F, M);

	// Assigning inputs and outputs
	input [1:0] A, B, C, D, E, F;
	input [2:0] S;
	output [1:0] M;
	
	// Multiplexer inplementation
	assign M = S[2] ? (S[0] ? F : E) : (S[1] ? (S[0] ? D : C) : (S[0] ? B : A));
	
endmodule

module char_7seg(C, display);

	// Inputs and Outputs
	input [1:0] C;
	output [0:6] display;
	
	// Mappping the outputs
	assign display[0] = C[0] | ~C[1];
	assign display[1] = C[1];
	assign display[2] = C[1];
	assign display[3] = C[0];
	assign display[4] = C[0];
	assign display[5] = C[0] | ~C[1];
	assign display[6] = C[0];
	
endmodule