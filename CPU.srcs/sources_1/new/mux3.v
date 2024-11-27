`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/03 10:16:13
// Design Name: 
// Module Name: mux3
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


module mux3(A,B,C,ALUSelB,OUT);
    parameter parameter_width = 32; // 默认位宽为 32 位
    input  [parameter_width-1:0] A,B,C;
    input  [1:0] ALUSelB;
    output [parameter_width-1:0] OUT;
    wire   [parameter_width-1:0] out_1;
    assign out_1 = ALUSelB[0]?B:A;
    assign OUT = ALUSelB[1]?C:out_1;
endmodule
