`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 20:10:07
// Design Name: 
// Module Name: im_4k
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


module im_4k(rst,  addr, dout );
input wire rst;
    input [31:0] addr;
    output [31:0] dout;

    reg [31:0] imem[4096:3072];

    always @(posedge rst)
    if(rst)
    begin
        imem[3072]=32'h24010005;//addiu $1,$0,5
        imem[3073]=32'h2402000c;//addiu $2,$0,12
        imem[3074]=32'h00221821;//addu  $3,$1,$2
        imem[3075]=32'h00412023;//subu $4,$2,$1
        imem[3076]=32'h3425000a;//ori $5,$1,10
        imem[3077]=32'hac050004;//sw $5,4($0)
        imem[3078]=32'h08000c08;//j J_TEST
        imem[3079]=32'h24010064;//addiu $1,$0,100
        //J_TEST:
        imem[3080]=32'h8c060004;//lw $6,4($0)
        //BEQ_TEST:
        imem[3081]=32'h10a6ffff;//beq $5,$6,BEQ_TEST
    end

    assign dout = imem[addr[31:2]];

endmodule

