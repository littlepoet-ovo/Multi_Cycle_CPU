`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/22 00:03:33
// Design Name: 
// Module Name: mips_tb
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


module mips_tb();
    reg clk, rst;
    wire [31:0] PC;
   mips u0(clk,rst,PC);
   always #(5) clk = ~clk; 
   initial begin
     clk = 1 ;
     rst = 1 ;
     #20
     rst=0;
   end
endmodule
