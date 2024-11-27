`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:17:41
// Design Name: 
// Module Name: mux2
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


module mux2(A,B,SEL,OUT);
    parameter parameter_width = 32; // 默认位宽为 32 位
    input  [parameter_width-1:0] A,B;
    input  SEL;
    output [parameter_width-1:0] OUT;
    assign OUT = SEL?B:A;//请补充完整
endmodule
