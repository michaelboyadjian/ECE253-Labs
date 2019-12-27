// Lab6 Part 2

module part2 (SW, KEY, LEDR);

	// Inputs and Outputs
	input [1:0] SW;
	input [0:0] KEY;
	output [9:0] LEDR;
	
	
	// Initializing wire variables
	wire W = SW[0];
	wire reset = SW[1];
	wire clock = KEY[0];
	wire z;

	// y_Q represents current state, Y_D represents next state
	reg [3:0] y_Q, Y_D; 

	parameter A = 4'b0000;
	parameter B = 4'b0001;
	parameter C = 4'b0010;
	parameter D = 4'b0011;
	parameter E = 4'b0100;
	parameter F = 4'b0101;
	parameter G = 4'b0110;
	parameter H = 4'b0111;
	parameter I = 4'b1000;

	// Determining next state
	always @(w, y_Q)
		begin: state_table
			case (y_Q)
			
				A: if (!w) Y_D = B;
					else Y_D = F;
				
				B: if (!w) Y_D = C;
					else Y_D = F;

				C: if (!w) Y_D = D;
					else Y_D = F;	
				
				D: if (!w) Y_D = E;
					else Y_D = F;

				E: if (!w) Y_D = E;
					else Y_D = F;

				F: if (!w) Y_D = G;
					else Y_D = B;
				
				G: if (!w) Y_D = B;
					else Y_D = H;
				
				H: if (!w) Y_D = B;
					else Y_D = I;
				
				I: if (!w) Y_D = B;
					else Y_D = I;
					
				default: Y_D = 4’bxxxx;
				
		endcase
	end
		
	always @(posedge Clock)
	begin: state_ffs
		if (!resetn)
			y <= A;
		else
			y <= Y;
	end
			
	assign z = (y_Q == E) | (y_Q == I);
	assign {LEDR[9], LEDR[3:0]} = {Z, Y[3:0]}; 
	
endmodule