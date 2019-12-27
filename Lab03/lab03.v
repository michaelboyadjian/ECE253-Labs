module part5 (SW,LEDR,HEX0,HEX1,HEX2);

	input [9:0] SW; // slide switches 
	output [9:0] LEDR; // red lights 
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;	// 7-seg display
	wire [1:0] M0, M1, M2;

	assign LEDR[0] = SW[0]; 
	assign LEDR[1] = SW[1];
	assign LEDR[2] = SW[2];
	assign LEDR[3] = SW[3];
	assign LEDR[4] = SW[4];
	assign LEDR[5] = SW[5];
	assign LEDR[6] = SW[6];
	assign LEDR[7] = SW[7];
	assign LEDR[8] = SW[8];
	assign LEDR[9] = SW[9];
	
	mux_2bit_3to1 U0 (SW[9:8], SW[1:0], SW[5:4], SW[3:2], M0);
	char_7seg H0 (M0, HEX0);

	mux_2bit_3to1 U1 (SW[9:8], SW[3:2], SW[1:0], SW[5:4], M1);
	char_7seg H1 (M1, HEX1);

	mux_2bit_3to1 U2 (SW[9:8], SW[5:4], SW[3:2], SW[1:0], M2);
	char_7seg H2 (M2, HEX2);

endmodule

module char_7seg (C, Display);

	input [1:0] C;
	output [6:0] Display;
	
	wire C1, C0;
	
	assign C1 = C[1];
	assign C0 = C[0];
	
	assign Display[0] = C0 & C1;
	assign Display[1] = C0;
	assign Display[2] = (~C0 & ~C1) | (C0 & C1);
	assign Display[3] = C0 & C1;
	assign Display[4] = C0 | C1;
	assign Display[5] = (~C0 & ~C1) | (C1 & ~C0) | (C0 & C1);
	assign Display[6] = C0 & C1;
	
endmodule


module mux_2bit_3to1(S,U,V,W,M);

	input[1:0] S,U,V,W;
	output[1:0] M;

	wire S0,S1;
	wire [1:0] Q;
	
	assign S1 = S[1];
	assign S0 = S[0];

	assign Q[0] = (~S0 & U[0]) | (S0 & V[0]);
	assign Q[1] = (~S0 & U[1]) | (S0 & V[1]);
	
	assign M[0] = (~S1 & Q[0]) | (S1 & W[0]);
	assign M[1] = (~S1 & Q[1]) | (S1 & W[1]);
	
endmodule


