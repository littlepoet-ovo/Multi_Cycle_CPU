`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:38:57
// Design Name: 
// Module Name: Counter8
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


module Counter8(
    clk, rst, out

    );
    input clk; // 计数时钟
    input rst;//复位
    output reg [2:0]  out; // 计数值
         
    always @(posedge clk or posedge rst)  
    if (rst)
        out <= 3'b000;
    else  // 在时钟上升沿计数器加1
          out <= out + 1;                               
endmodule

