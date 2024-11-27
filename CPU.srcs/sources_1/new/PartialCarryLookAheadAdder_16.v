`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:20:07
// Design Name: 
// Module Name: PartialCarryLookAheadAdder_16
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module PartialCarryLookAheadAdder_16 (A, B, C0, S, C16);//16位局部先行进位加法器
    input wire [15:0] A;
    input wire [15:0] B;
    input wire C0;
    output wire [15:0] S;
    output wire C16;
    wire C4, C8, C12;
    
    ParallelAdder4 U_0(A[3:0],B[3:0],C0,S[3:0],C4);
    ParallelAdder4 U_1(A[7:4],B[7:4],C4,S[7:4],C8);
    ParallelAdder4 U_2(A[11:8],B[11:8],C8,S[11:8],C12);
    ParallelAdder4 U_3(A[15:12],B[15:12],C12,S[15:12],C16);
endmodule
