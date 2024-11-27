`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:35:44
// Design Name: 
// Module Name: top
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


module top(
    clk100MHZ, SW, BTNC, SEG, AN
    );
     input clk100MHZ;       //FPGA时钟
     input [15:0] SW;       // 16位拨动开关，其中SW[0]可用于作为复位信号rst
     input BTNC;            //按键
     output [7:0] SEG;      // 7段数码管驱动，低电平有效
     output [7:0] AN;       // 7段数码管片选信号，低电平有效
     wire [31:0] data;      //待显示内容
     wire clk1000Hz, clk100Hz, clk10Hz, clk1Hz;//1000/100/10/1Hz的时钟
     
     SevenSegDisp U_DISP(clk1000Hz, SW, data, SEG, AN);//七段数码管显示器
     FrequencyDivider U_FRQNCYDVD(clk100MHZ, clk1000Hz, clk100Hz, clk10Hz, clk1Hz);//分频器
     
     //补充部分代码，连接CPU
     wire [31:0] PC;
     assign data =  PC[31:0];
     mips U_CPU( clk10Hz, SW[0], PC) ;//clk,rst,PC,IR
     
       
endmodule
