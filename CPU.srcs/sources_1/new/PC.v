`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/16 11:34:37
// Design Name: 
// Module Name: PC
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


module PC( clk, rst,PCen,NPC, PC );          
   input clk;
   input rst;
   input PCen;
   input[31:0] NPC;
   output[31:0] PC;
   
   reg [31:0] PC;            
   always @(posedge clk ) begin
      if ( rst ) 
         PC <= 32'h0000_3000;   
      else 
         if (PCen)
            PC <= NPC;
   end // end always         
endmodule



