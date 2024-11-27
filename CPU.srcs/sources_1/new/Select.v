`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/21 19:37:31
// Design Name: 
// Module Name: Select
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


module Select(
    sel, data, bcd
    );
    input [2:0] sel;
    input [31:0] data;
    output reg [3:0] bcd;
    
    always @(*)
    case (sel)
        3'h0:bcd = data[3:0];
        3'h1:bcd = data[7:4];
        3'h2:bcd = data[11:8];
        3'h3:bcd = data[15:12];
        3'h4:bcd = data[19:16];
        3'h5:bcd = data[23:20];
        3'h6:bcd = data[27:24];
        3'h7:bcd = data[31:28];
    endcase
endmodule
