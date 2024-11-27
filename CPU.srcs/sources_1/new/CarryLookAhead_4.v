`timescale 1ns / 1ps



module CarryLookAhead_4 (P, G, C0, C);//CLA部件, 4-bit Carry Look Ahead
	input wire [3:0] P;
	input wire [3:0] G;
	input wire C0;
	output wire [4:1] C;
	
	assign C[1] = G[0] | (P[0] & C0);//请补充完整
	assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C0);//请补充完整
	assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C0);//请补充完整
	assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C0);//请补充完整
endmodule
