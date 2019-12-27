module part2(SW, LEDR, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input [9:0] SW;
	input [0:0] KEY;
	output [0:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire [7:0] A, B, S;
	
	assign B = SW[7:0];
	reg8 U1 (B, KEY, A);
	assign S = A + B;
	
	dec_8to7 U2 (B, HEX0, HEX1);
	dec_8to7 U3 (A, HEX2, HEX3);
	dec_8to7 U4 (S, HEX4, HEX5);
	
endmodule


module dec_8to7(in,out0,out1);
	input [7:0]in;
	output reg [6:0]out0,out1;
	
	always@(in)
		case((in % 10))
			0 : out0 = 7'b1000000;
			1 : out0 = 7'b1111001;
			2 : out0 = 7'b0100100;
			3 : out0 = 7'b0110000;
			4 : out0 = 7'b0011001;
			5 : out0 = 7'b0010010;
			6 : out0 = 7'b0000010;
			7 : out0 = 7'b1111000;
			8 : out0 = 7'b0000000;
			9 : out0 = 7'b0010000;
		endcase
		
	always@(in)
		case((in / 10))
			0 : out1 = 7'b1000000;
			1 : out1 = 7'b1111001;
			2 : out1 = 7'b0100100;
			3 : out1 = 7'b0110000;
			4 : out1 = 7'b0011001;
			5 : out1 = 7'b0010010;
			6 : out1 = 7'b0000010;
			7 : out1 = 7'b1111000;
			8 : out1 = 7'b0000000;
			9 : out1 = 7'b0010000;
		endcase
endmodule


module reg8 (D, clock, Q);
	input [7:0] D;
	input clock;
	ouptut reg [7:0] Q;
	always @ (posedge clock)
		Q <= D;
endmodule
