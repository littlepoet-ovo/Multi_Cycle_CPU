`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 20:18:07
// Design Name: 
// Module Name: EXT
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


module EXT( Imm16, EXTOp, Imm32 );

   input wire [15:0] Imm16;
   input wire [1:0]  EXTOp;
   output reg [31:0] Imm32;

   always @(*) begin
      case (EXTOp)
         2'b00:  Imm32 = {16'd0, Imm16};
         2'b01:  Imm32 = {{16{Imm16[15]}}, Imm16};
         2'b10:  Imm32 = {Imm16, 16'd0};
         default: ;
      endcase
   end // end always

endmodule   

