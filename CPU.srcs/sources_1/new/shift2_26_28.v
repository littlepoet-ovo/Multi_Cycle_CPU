`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/03 08:57:47
// Design Name: 
// Module Name: shift2_26_28
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


module shift2_26_28 #(parameter WIDTH = 26)(
   input [WIDTH-1:0] in,
   output [WIDTH+1:0] out
    );
    assign out={in,2'b00};
endmodule


