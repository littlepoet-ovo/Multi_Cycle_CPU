`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:36:20
// Design Name: 
// Module Name: SevenSegDisp
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


module SevenSegDisp(clk, SW, data, SEG, AN);
    input clk;       //时钟
    input [15:0] SW;       // 16位拨动开关
    input [31:0] data;     //待显示数据
    output [7:0] SEG;      // 7段数码管驱动，低电平有效
    output [7:0] AN;       // 7段数码管片选信号，低电平有效
   
    //wire [31:0] data;
    wire [2:0] sel;
    wire [3:0] bcd;
    wire clk;
    assign rst = SW[0];
    //assign data = {16'h8765, SW[15:0]};

    Select U_SLCT(sel, data, bcd);
    SevenSegDecoder U_SSD(bcd, SEG);
    Counter8 U_CNT(clk, rst, sel);   
    Decoder3_8 U_D38(sel, AN);
endmodule

