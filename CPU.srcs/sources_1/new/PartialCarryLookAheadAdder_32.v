`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:19:44
// Design Name: 
// Module Name: PartialCarryLookAheadAdder_32
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


module PartialCarryLookAheadAdder_32(A, B, C0, S, C32);//32位局部先行进位加法器
    input wire [31:0] A;
    input wire [31:0] B;
    input wire C0;
    output wire [31:0] S;
    output wire C32;
    wire C16;
    
    PartialCarryLookAheadAdder_16 U_0(A[15:0],B[15:0],C0,S[15:0],C16);//请补充完整
    PartialCarryLookAheadAdder_16 U_1(A[31:16],B[31:16],C16,S[31:16],C32);//请补充完整
endmodule
