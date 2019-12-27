module part1(SW, KEY, LEDR);
	// Assigning inputs and outputs
	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	
	// Assigning pretty lights
	assign LEDR[0] = SW[0];
	assign LEDR[1] = KEY[0];
	
	// Wires
	wire d, clk, Q0, Qb0, Q1, Qb1, Q2, Qb2;
	
	assign d = SW[0];
	assign clk = KEY[0];
	assign LEDR[9] = Q0;
	assign LEDR[8] = Qb0;
	assign LEDR[7] = Q1;
	assign LEDR[6] = Qb1;
	assign LEDR[5] = Q2;
	assign LEDR[4] = Qb2;
	
	// Storage elements
	gateddlatch S0 (d, clk, Q0, Qb0);
	posdff_flop S1 (d, clk, Q1, Qb1);
	negdff S2 (d, clk, Q2, Qb2);
endmodule[


module gateddlatch (D, clock, Q, Qb);
	input D, clock;
	output reg Q, Qb;
	always @(clock or D); 
	begin
		if (clock == 1'b1)
			begin
				Q = D;
				Qb = ~D;
			end
	end
endmodule


module posdff(D, clock, Q, Qb);
	input D, clock;
	output reg Q, Qb;
	always @ (posedge clock)
	begin
		Q <= D;
		Qb <= ~D;
	end
endmodule


module negdff(D, clock, Q, Qb);
	input D, clock;
	output reg Q, Qb;
	always @ (negedge clock)
	begin
		Q <= D;
		Qb <= ~D;
	end
endmodule