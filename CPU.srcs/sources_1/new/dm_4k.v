`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 20:22:27
// Design Name: 
// Module Name: dm_4k
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


module dm_4k( addr, din, MemWr, clk, dout );

   input wire [11:2] addr;
   input wire [31:0] din;
   input  wire  MemWr;
   input  wire   clk;
   output wire [31:0] dout;

   reg [31:0] dmem[1023:0];
   integer i;
   initial begin
       for (i=0; i<1024; i=i+1)
          dmem[i] = 0;
   end
   always @(negedge clk) 
   begin
      if (MemWr)
         dmem[addr] <= din;
   end // end always

   assign dout = dmem[addr];

endmodule   

