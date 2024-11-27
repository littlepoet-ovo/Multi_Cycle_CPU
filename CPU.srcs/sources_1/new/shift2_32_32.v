`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/03 08:57:47
// Design Name: 
// Module Name: shift2_32_32
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


module shift2_32_32 #(parameter WIDTH = 32)(
   input [WIDTH-1:0] in,
   output [WIDTH-1:0] out
    );
    assign out={in[WIDTH-3:0],2'b00};
endmodule

