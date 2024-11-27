`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:38:15
// Design Name: 
// Module Name: FrequencyDivider
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

module FrequencyDivider (clk, clk1000Hz, clk100Hz, clk10Hz, clk1Hz);//分频器
    input  clk;              // 系统时钟
    output reg  clk1000Hz;  // 分频后的时钟1000Hz
    output reg  clk100Hz;   //分频后的时钟100Hz
    output reg  clk10Hz;    //分频后的时钟10Hz
    output reg  clk1Hz;     // 分频后的时钟1Hz
    parameter      N1000 = 50_000;          // 1000Hz的时钟,N=fclk/fclk_N
    parameter      N100 = 50_000_0;          // 1000Hz的时钟,N=fclk/fclk_N
    parameter      N10 = 50_000_00;          // 1000Hz的时钟,N=fclk/fclk_N
    parameter      N1 = 50_000_000;         // 1Hz的时钟,N=fclk/fclk_N
    reg [31:0]      counter1000, counter100, counter10, counter1;  /* 计数器变量，通过计数实现分频。
                                                当计数器从0计数到(N/2-1)时，
                                                输出时钟翻转，计数器清零 */
    always @(posedge clk)  begin              // 时钟上升沿
        if(counter1000==N1000) begin
            clk1000Hz <= ~clk1000Hz;
            counter1000 <= 32'h0;
        end            
        else 
            counter1000 <= counter1000 + 1;
    end
    
    always @(posedge clk)  begin              // 时钟上升沿
        if(counter100==N100) begin
            clk100Hz <= ~clk100Hz;
            counter100 <= 32'h0;
        end            
        else 
            counter100 <= counter100 + 1;
    end
    
    always @(posedge clk)  begin              // 时钟上升沿
        if(counter10==N10) begin
            clk10Hz <= ~clk10Hz;
            counter10 <= 32'h0;
        end            
        else 
            counter10 <= counter10 + 1;
    end
    
    always @(posedge clk)  begin              // 时钟上升沿
        if(counter1==N1) begin
            clk1Hz <= ~clk1Hz;
            counter1 <= 32'h0;
        end            
        else 
            counter1 <= counter1 + 1;
    end
endmodule
