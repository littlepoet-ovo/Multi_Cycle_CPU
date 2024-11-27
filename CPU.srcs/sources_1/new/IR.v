`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/03 08:57:06
// Design Name: 
// Module Name: IR
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


module IR (clk, rst, IRWr, im_instr, instr);
   input         clk;
   input         rst;
   input         IRWr; 
   input  [31:0] im_instr;
   output [31:0] instr;
   reg [31:0] instr;
   always @(posedge clk ) begin
      if ( rst ) 
         instr <= 0;
      else if (IRWr)
         instr <= im_instr;
   end // end always
endmodule

