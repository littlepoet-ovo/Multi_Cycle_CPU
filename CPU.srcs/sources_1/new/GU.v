`timescale 1ns / 1ps
module GU (Xi, Yi, Gi);//进位生成部件
	input wire Xi;
	input wire Yi;
	output wire Gi;
	assign Gi = Xi&Yi;//请补充完整
endmodule