module part5(CLOCK_50, HEX0);

	// Inputs and Outputs 
	input CLOCK_50;
	output [6:0] HEX0;
	
	// Wires
	reg reset_cnt_main, reset_cnt_smol;
	wire [25:0] cnt_main;
	wire [3:0] cnt_smol;
	
	// Determining when to send reset signals
	always @(CLOCK_50)
		if (cnt_main == 26'b10111110101111000010000000)
			reset_cnt_main <= 1'b1;
		else
			reset_cnt_main <= 1'b0;
	always @(CLOCK_50)
		if (cnt_smol == 4'b1010)
			reset_cnt_smol <= 1'b1;
		else
			reset_cnt_smol <= 1'b0;
	
	// Running counters
	counter_50 C0 (CLOCK_50, reset_cnt_main, cnt_main);
	counter_9  C1 (reset_cnt_main, reset_cnt_smol, cnt_smol);
	
	// Display outputs
	hexDisp H0 (cnt_smol, HEX0);
endmodule

module counter_50(clk, reset, Q);
	// Assigning inputs and outputs
	input clk, reset;
	output reg [25:0] Q;
	
	// Logic
	always @(posedge clk or posedge reset)
		if (reset)
			Q <= 26'b0;
		else
			Q <= Q + 1;
endmodule

module counter_9(clk, reset, S);
	// Assigning inputs and outputs
	input clk, reset;
	output reg [3:0] S;
	
	// Logic
	always @(posedge clk or posedge reset)
		if (reset)
			S <= 4'b0;
		else
			S <= S + 1;
endmodule