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
     input clk100MHZ;       //FPGAʱ��
     input [15:0] SW;       // 16λ�������أ�����SW[0]��������Ϊ��λ�ź�rst
     input BTNC;            //����
     output [7:0] SEG;      // 7��������������͵�ƽ��Ч
     output [7:0] AN;       // 7�������Ƭѡ�źţ��͵�ƽ��Ч
     wire [31:0] data;      //����ʾ����
     wire clk1000Hz, clk100Hz, clk10Hz, clk1Hz;//1000/100/10/1Hz��ʱ��
     
     SevenSegDisp U_DISP(clk1000Hz, SW, data, SEG, AN);//�߶��������ʾ��
     FrequencyDivider U_FRQNCYDVD(clk100MHZ, clk1000Hz, clk100Hz, clk10Hz, clk1Hz);//��Ƶ��
     
     //���䲿�ִ��룬����CPU
     wire [31:0] PC;
     assign data =  PC[31:0];
     mips U_CPU( clk10Hz, SW[0], PC) ;//clk,rst,PC,IR
     
       
endmodule