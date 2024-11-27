`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 20:16:25
// Design Name: 
// Module Name: RF
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


`define DEBUG 1
module RF( clk, Ra, Rb, Rw, busW, RegWr, busA,busB);
   input wire clk;
   input  wire [4:0]  Ra, Rb, Rw;
   input  wire [31:0]  busW;
   input  wire RegWr;
   output wire [31:0] busA,busB;
    reg [31:0] rf[31:0];
/*初始化寄存器的值，当综合时将该部分代码删除*/
integer i;
   initial begin
       for (i=0; i<32; i=i+1)
          rf[i] = 0;
   end

   always @(negedge clk) 
   begin//写逻辑
      if (RegWr)
         rf[Rw] <= busW;
   end // end always
/*以下部分为读逻辑*/
   assign busA = (Ra == 0) ? 32'd0 : rf[Ra];
   assign busB = (Rb == 0) ? 32'd0 : rf[Rb];

endmodule 

