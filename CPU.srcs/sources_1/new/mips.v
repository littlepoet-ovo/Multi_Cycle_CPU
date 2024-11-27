`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:40:19
// Design Name: 
// Module Name: mips
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


module mips(clk, rst, PC);
    input clk;
    input rst;
    output [31:0] PC;
    wire PCen;
    wire [31:0] PC,NPC,MPC_T;
    wire [31:0] im_dout,dm_dout;
    wire [31:0] instr;
    wire [4:0] rs,rt,rd,Rw;//U_rf
    wire [31:0] Da,Db,Dw;//U_rf
    wire  RFen;//U_rf
    wire [15:0] imm16;
    wire [25:0] imm26;
    wire [4:0] Imm5; 
    wire [27:0] shift_28_out;//U_shift_26，26位扩展成28位
    wire [31:0] imm32,shift_32_out;//U_EXT,U_shift_32
    wire [31:0] ALU_B,ALU_A,result,result_high;//U_alu
    wire  [5:0] Op;
    wire  [5:0] func;
    wire  Zero,OF,SF,done;
    wire PCWr, PCWrCond,MemWr,IRWr,RegWr,RegDst, MemtoReg,ALUSelA,R_type,BrWr; 
    wire[1:0] ExtOp;
    wire[1:0] ALUSelB,PCSource;
    wire[3:0] ALUop;
    wire[5:0] ALUctr;
    wire[5:0] ALUctr_Local;
    wire[31:0]  PC_jump,REG_branch_out;  
    PC U_PC(clk,rst,PCen,NPC,PC);
    assign NPC = rst?32'h0000_3000:MPC_T;
    assign PCen= (PCWrCond & Zero) || PCWr;
    im_4k U_IM (rst,PC,im_dout);
    IR  U_IR( clk, rst, IRWr, im_dout, instr);
    assign rs=instr[25:21];
    assign rt=instr[20:16];
    assign rd=instr[15:11];
    assign func=instr[5:0];
    assign imm16=instr[15:0];
    assign imm26=instr[25:0];
    assign Imm5=instr[10:6];
    assign Op=instr[31:26];
    mux2 #(5) U_RegDst (rt, rd, RegDst , Rw);
    EXT U_EXT (imm16,ExtOp,imm32);
    RF U_RF(clk,rs,rt,Rw,Dw,RFen,Da,Db);
    assign RFen= RegWr & ~OF;
    shift2_32_32  U_shift_32 (.in(imm32),.out(shift_32_out));
    mux4 #(32) U_ALUSelB (Db, 32'h0000_0004, imm32, shift_32_out,ALUSelB, ALU_B);
    mux2 #(32) U_ALUSelA (PC, Da, ALUSelA , ALU_A);
    shift2_26_28  U_shift_26(.in(imm26),.out(shift_28_out));
    ALU alu(ALU_A,ALU_B,ALUctr,Imm5,result,result_high,OF,Zero,SF,done);
    ALUControl U_Local_ctrl(ALUop,ALUctr_Local);
    mux2 #(6) U_R_type (ALUctr_Local, func, R_type ,ALUctr);
    dm_4k U_DM (result[11:2], Db, MemWr, clk, dm_dout);
    REG_branch U_REG_branch(clk, rst,BrWr,result,REG_branch_out);
    
    assign PC_jump={PC[31:28],shift_28_out};                        
    mux3 #(32) U_PCSource(PC_jump, result, REG_branch_out,PCSource, MPC_T) ;                        
    mux2 #(32) U_MemtoReg (result, dm_dout, MemtoReg , Dw);
    ctrl U_ctrl(clk,rst,Op,PCWr,PCWrCond,MemWr,IRWr,RegWr,RegDst,MemtoReg,ExtOp,ALUSelA,ALUSelB,ALUop,R_type,BrWr,PCSource);   
endmodule
