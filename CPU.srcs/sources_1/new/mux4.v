`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/03 09:07:05
// Design Name: 
// Module Name: mux4
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


module mux4(A,B,C,D,ALUSelB,OUT);
    parameter parameter_width = 32; // 默认位宽为 32 位
    input  [parameter_width-1:0] A,B,C,D;
    input  [1:0] ALUSelB;
    output [parameter_width-1:0] OUT;
    wire   [parameter_width-1:0] out_1,out_2;
    assign out_1 = ALUSelB[0]?B:A;
    assign out_2 = ALUSelB[0]?D:C;
    assign OUT = ALUSelB[1]?out_2:out_1;
endmodule
