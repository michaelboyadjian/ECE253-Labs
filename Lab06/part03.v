// Lab6 Part 3

module part3 (SW, KEY, LEDR) 

	input [2:0] SW;
	input CLOCK_50;
	input [1:0] KEY;
	
	output [0:0] LEDR; 
	output [2:0] value;
	output [15:0] morsecode;
	output half-second;
	
	wire reset, load;
	
	assign reset = KEY[0];
	assign load = KEY[1];
	
	dec3to16 A0 (value, morsecode);
	counter A1 (1, CLOCK_50, reset, half-second);
	shiftregister A2 (morsecode, half-second, reset, load, LEDR[0]);
	
endmodule


module counter (enable, clock, reset, s);

	input enable, clock, reset;
	output reg s;
	reg [25:0] Q;
	
	always @ (posedge clock or posedge reset)
		if (reset) 
		begin
			Q <= 0;
			s <=0;
		end
		else if (Q == 8)
		begin
			Q <= 0;
			s <=0;
		end
		else if (Q == 4)
		begin
			s <=1;
			Q <= Q+1;
		end
		else if (enable)
		begin
			Q <= Q+1;
		end
	
endmodule


module dec3to16 (in, out);

	input [2:0] in;
	output [15:0] out;
	
	always @ (1)
		case (in)
			0 : out = 16'b0000000000011101;
			1 : out = 16'b0000000101010111;
			2 : out = 16'b0000010111010111;
			3 : out = 16'b0000000001010111;
			4 : out = 16'b0000000000000001;
			5 : out = 16'b0000000101110101;
			6 : out = 16'b0000000101110111;
			7 : out = 16'b0000000001010101;
		endcase
		
endmodule


module dff2 (D, clock, Q, reset);
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


module shiftregister (D, clock, reset, load, out);

	input [15:0] D;
	input clock, reset, load;
	output reg out;
	reg [15:0] Q;
	
	always @(posedge clk or posedge reset)
		if (reset) 	
			Q <= 0;
		else if (load) 
			Q <= D;
		else 
		begin
			out <= Q[0];
			Q[0] <= Q[1];
			Q[1] <= Q[2];
			Q[2] <= Q[3];
			Q[3] <= Q[4];
			Q[4] <= Q[5];
			Q[5] <= Q[6];
			Q[6] <= Q[7];
			Q[7] <= Q[8];
			Q[8] <= Q[9];
			Q[9] <= Q[10];
			Q[10] <= Q[11];
			Q[11] <= Q[12];
			Q[12] <= Q[13];
			Q[13] <= Q[14];
			Q[14] <= Q[15];
			Q[15] <= 0;
		end
endmodule


module shiftregister1 (D, clock, reset, load, out);
	
	input load, clock, reset;
	input [2:0] D;
	output out;
	
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	parameter G = 3'b110;
	parameter H = 3'b111;

	reg [3:0] Q, P;
	
	always @ (D)
	
		case (D)
		
			A : P = 4'b0010;
			B : P = 4'b0001;
			C : P = 4'b0101;
			D : P = 4'b0001;
			E : P = 4'b0000;
			F : P = 4'b0100;
			G : P = 4'b0011;
			H : P = 4'b0000;
			
			default P = 4'bxxxx;
		endcase
			
	assign out = Q[3];
	
endmodule



















