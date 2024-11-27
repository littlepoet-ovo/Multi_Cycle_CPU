`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:16:12
// Design Name: 
// Module Name: ALU
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


module ALU(A,B,ALUctrl,shamt,Result,Result_high,OF,ZF,SF,done);
    input [31:0] A;//待计算的数据A
    input [31:0] B;//待计算的数据B
    input [5:0] ALUctrl;//不同运算的选择信号
    input [4:0]shamt;//移位运算的移位位数
    output reg [31:0] Result;//运算的结果
    output reg [31:0] Result_high;//运算的结果的高位，具体的用在乘法运算
    output reg OF;//溢出标志位
    output reg ZF;//零标志位
    output reg SF;//符号标志位
    output reg done;//乘法与除法的完成信号
    wire C;//进位标志位
    reg flag;
    reg [31:0]a_t;
    reg [31:0]b_t;
    wire [31:0]result_t;
    wire of_t;
    FixedComplementAdder32 u0(a_t,b_t,flag,result_t,of_t,C);
    always @(*)begin
       a_t <= A;
       b_t <= B;
       case (ALUctrl)
            6'b100000:begin//带符号加法
                Result <= result_t;
                flag <= 0;
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= of_t;
                Result_high <= 32'd0;
            end
            6'b100010:begin//带符号减法
                Result <= result_t;
                flag <= 1;
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= of_t;
                Result_high <= 32'd0;
            end
            6'b011000:begin//带符号乘法 
                {Result_high,Result} <= $signed(A)*$signed(B);
                ZF <= Result==0 && Result_high==0?1:0;
                SF <= Result_high[31];
                OF <= 0;
                done <= 1;
            end
            6'b011010:begin//带符号除法
                Result <= $signed(A)/$signed(B);
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= 0;
                done <= 1;
                Result_high <= 32'd0;
            end
            6'b100100:begin//按位与
                Result <= A&B;
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= 0;
                Result_high <= 32'd0;
            end
            6'b100101:begin//按位或
                Result <= A|B;
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= 0;
                Result_high <= 32'd0;
            end
            6'b100111:begin//按位或非
                Result <= ~(A|B);
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= 0;
                Result_high <= 32'd0;
            end
            6'b100110:begin//按位异或
                Result <= A^B;
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= 0;
                Result_high <= 32'd0;
            end
            6'b000000:begin//逻辑左移
                Result <= B << shamt;
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= 0;
                Result_high <= 32'd0;
            end
            6'b000011:begin//算术右移
                Result <= $signed(B) >>> shamt;
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= 0;
                Result_high <= 32'd0;
            end
            6'b100001:begin//无符号加法
                Result <= result_t;
                flag <= 0;
                ZF <= 0;
                SF <= Result[31];
                OF <= A[31]&B[31]&~Result[31];
                Result_high <= 32'd0;
            end
            6'b100011:begin//无符号减法
                Result <= result_t;
                flag <= 1;
                ZF <= 0;
                SF <= Result[31];
                OF <= ~A[31]&~B[31]&Result[31];
                Result_high <= 32'd0;
            end
            6'b000100:begin//逻辑左移sllv
                Result <= B << A[4:0];
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= 0;
                Result_high <= 32'd0;
            end
            6'b000110:begin//逻辑右移srlv
                Result <= B >> A[4:0];
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= 0;
                Result_high <= 32'd0;
            end
            6'b000111:begin//算术右移srav
                Result <= $signed(B) >>>  A[4:0];
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= 0;
                Result_high <= 32'd0;
            end
            6'b000010:begin//逻辑右移srl
                Result <= B >> shamt;
                ZF <= Result==0?1:0;
                SF <= Result[31];
                OF <= 0;
                Result_high <= 32'd0;
            end
            6'b101010:begin//slt IF A<B RETURN 1
                Result <= $signed(A)<$signed(B)?1:0;
            end
            6'b101011:begin//sltu IF A<B RETURN 1
                Result <= A<B?1:0;
            end
         endcase
    end
endmodule
