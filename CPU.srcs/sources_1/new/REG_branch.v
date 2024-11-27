`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/03 09:00:29
// Design Name: 
// Module Name: REG_branch
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

module REG_branch#(parameter WIDTH = 32)
              (clk, rst,BrWr, d, q);
   input              clk;
   input              rst;
   input              BrWr;
   input  [WIDTH-1:0] d;
   output [WIDTH-1:0] q;
   reg [WIDTH-1:0] q_r;
   always @(posedge clk ) begin
      if ( rst ) 
         q_r <= 0;
      else 
        if (BrWr)
           q_r <= d;
   end // end always
   assign q = q_r;
endmodule

