`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/03 10:20:31
// Design Name: 
// Module Name: ctrl
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


module ctrl(clk,rst,Op,PCWr,PCWrCond,MemWr,IRWr,RegWr, RegDst, MemtoReg,ExtOp,ALUSelA,ALUSelB,ALUop,R_type,BrWr,PCSource);
    
   input		clk, rst;       
   input  [5:0] Op;
   output  reg     PCWr;
   output  reg     PCWrCond;
   output  reg     MemWr;
   output  reg     IRWr;
   output  reg     RegWr;
   output  reg     RegDst;
   output  reg     MemtoReg;
   output  reg[1:0]     ExtOp;
   output  reg     ALUSelA;
   output  reg[1:0] ALUSelB;
   output  reg[3:0] ALUop;
   output  reg     R_type;
   output  reg     BrWr;
   output  reg[1:0] PCSource;
  
    
   parameter IFetch       = 4'b0000,   //取指令
              RFetch_ID    = 4'b0001,   //译码取数
              BrFinish     = 4'b0010,   //branch指令结束
              jumpFinish   = 4'b0011,   //jump指令结束
              oriExec      = 4'b0100,   //ori执行
              oriFinish    = 4'b0101,   //ori结束
              RExec        = 4'b0110,   //R-type指令执行
              RFinish      = 4'b0111,
              MemAdr       = 4'b1000,   //lw/sw计算内存地址
              swFinish     = 4'b1001,
              MemFetch     = 4'b1010,   //lw指令从内存取数
              lwFinish     = 4'b1011,
              addiuFetch   = 4'b1100,   //addi指令执行
              addiuFinish  = 4'b1101;   
    
    
    
	
   wire addsub;   // Type of RType Instruction
   wire ori;   // Type of Imm    Instruction  
   wire beq;  // Type of Branch Instruction
   wire jump;   // Type of Jump   Instruction
   wire lw;  // Type of Load   Instruction
   wire sw;  // Type of Store  Instruction
   wire lwsw; // Type of Memory Instruction(Load/Store)
   wire addiu; //Type of addi Instruction
	
   assign addsub   = (Op == 6'b000000);//判断是否为add/sub指令  
   assign ori      = (Op == 6'b001101 );//ori
   assign beq      = (Op == 6'b000100 );//beq
   assign jump     = (Op == 6'b000010  );//jump
   assign lw       = (Op == 6'b100011   );//lw
   assign sw       = (Op == 6'b101011   );//sw
   assign lwsw     = lw || sw;
   assign addiu     = (Op == 6'b001001);
	/*************************************************/
	/******               FSM                   ******/
   reg [3:0] nextstate;
   reg [3:0] state;
   
//状态切换逻辑
   always @(posedge clk) begin
	   if ( rst ) begin
		   state <= IFetch;
	   end
      else
         state <= nextstate;
	end // end always
   
//次态选择逻辑         
   always @(*) begin//state transition
      case (state)
         IFetch: nextstate = RFetch_ID;
         RFetch_ID: begin
            if ( beq ) 
			   nextstate = BrFinish;
            else if ( jump ) 
               nextstate = jumpFinish;
            else if ( ori )
               nextstate = oriExec;
            else if ( addsub )
               nextstate = RExec;
            else if ( lwsw )
                nextstate = MemAdr;
            else if( addiu )
                nextstate = addiuFetch;
            else nextstate=IFetch; //if Op wrong, then fetch next one.
         end//end RFetch_ID
         BrFinish:  nextstate = IFetch;
         MemAdr: begin 
            if ( lw )
				   nextstate = MemFetch;   //10
            else if ( sw )
					nextstate = swFinish;   //9
			end
         jumpFinish: nextstate = IFetch;
         oriExec: 	 nextstate = oriFinish;
         oriFinish:   nextstate = IFetch;
         RExec:      nextstate = RFinish;
         RFinish:    nextstate = IFetch;  
         swFinish:   nextstate = IFetch;
         MemFetch: 	 nextstate = lwFinish;
         lwFinish:   nextstate = IFetch;  
         addiuFetch: nextstate =  addiuFinish;
         addiuFinish: nextstate = IFetch;
	     default: ;
       endcase
   end // end always
	
	
	/*************************************************/
/******         Control Signal              ******/
always @( * ) begin//output
   case ( state ) 
        IFetch:  begin
            ALUSelA   <= 1'b0;
            ALUSelB   <= 2'b01; 
            ALUop     <= 4'b0100;
            PCSource  <= 2'b01;
            PCWr      <= 1'b1;  
            IRWr      <= 1'b1;
            MemWr     <= 1'b0;   
            RegWr     <= 1'b0;  
            BrWr      <= 1'b0; 
            R_type    <= 1'b0;   
		  end // end IFetch
         RFetch_ID:  begin
             ExtOp     <= 2'b01;
             ALUSelA   <= 1'b0;
             ALUSelB   <= 2'b11; 
             ALUop     <= 4'b0000;
             BrWr      <= 1'b1;
             PCWr      <= 1'b0;  
             PCWrCond  <= 1'b0;  
             IRWr      <= 1'b0;
             MemWr     <= 1'b0;   
             RegWr     <= 1'b0;  
             R_type    <= 1'b0;
             MemtoReg  <= 1'b0;   
			end	// end RFetch_ID
         RExec: 	begin
             ALUSelA   <= 1'b1;
             ALUSelB   <= 2'b00; 
             RegDst    <= 1'b1;
             R_type    <= 1'b1;
             BrWr      <= 1'b0;
             PCWr      <= 1'b0;  
             PCWrCond  <= 1'b0;  
             IRWr      <= 1'b0;
             MemWr     <= 1'b0;   
             RegWr     <= 1'b0;  
             MemtoReg  <= 1'b0; 
			end // end RExec
         RFinish: begin
             ALUSelA   <= 1'b1;
             ALUSelB   <= 2'b00; 
             RegDst    <= 1'b1;
             R_type    <= 1'b1;
             BrWr      <= 1'b0;
             PCWr      <= 1'b0;  
             PCWrCond  <= 1'b0;  
             IRWr      <= 1'b0;
             MemWr     <= 1'b0;   
             RegWr     <= 1'b1; 
             MemtoReg  <= 1'b0;
			end // end RFinish
         oriExec :begin
             ExtOp     <= 2'b00;
             ALUSelA   <= 1'b1;
             ALUSelB   <= 2'b10; 
             ALUop     <= 4'b0011;//ori运算
             RegDst    <= 1'b0;
             R_type    <= 1'b0;
             BrWr      <= 1'b0;
             PCWr      <= 1'b0;  
             PCWrCond  <= 1'b0;  
             IRWr      <= 1'b0;
             MemWr     <= 1'b0;   
             RegWr     <= 1'b0;
             MemtoReg  <= 1'b0;          
            end
         oriFinish :begin 
              ExtOp     <= 2'b00;
              ALUSelA   <= 1'b1;
              ALUSelB   <= 2'b10; 
              ALUop     <= 4'b0011;//ori运算
              RegDst    <= 1'b0;
              R_type    <= 1'b0;
              BrWr      <= 1'b0;
              PCWr      <= 1'b0;  
              PCWrCond  <= 1'b0;  
              IRWr      <= 1'b0;
              MemWr     <= 1'b0;   
              RegWr     <= 1'b1;
              MemtoReg  <= 1'b0;             
            end
         MemAdr:begin
             ExtOp     <= 2'b01;
             ALUSelA   <= 1'b1;
             ALUSelB   <= 2'b10; 
             ALUop     <= 4'b0000;//add运算
             RegDst    <= 1'b0;
             R_type    <= 1'b0;
             BrWr      <= 1'b0;
             PCWr      <= 1'b0;  
             PCWrCond  <= 1'b0;  
             IRWr      <= 1'b0;
             MemWr     <= 1'b0;   
             RegWr     <= 1'b0;
             //MemtoReg  =1'b0;    
            end  
         MemFetch:begin
             ExtOp     <= 2'b01;
             ALUSelA   <= 1'b1;
             ALUSelB   <= 2'b10; 
             ALUop     <= 4'b0000;//add运算
             RegDst    <= 1'b0;
             R_type    <= 1'b0;
             BrWr      <= 1'b0;
             PCWr      <= 1'b0;  
             PCWrCond  <= 1'b0;  
             IRWr      <= 1'b0;
             MemWr     <= 1'b0;   
             RegWr     <= 1'b0;
             MemtoReg  <= 1'b1;    
            end 
         lwFinish  :begin
             ExtOp     <= 2'b01;
             ALUSelA   <= 1'b1;
             ALUSelB   <= 2'b10; 
             ALUop     <= 4'b0000;//add运算
             RegDst    <= 1'b0;
             R_type    <= 1'b0;
             BrWr      <= 1'b0;
             PCWr      <= 1'b0;  
             PCWrCond  <= 1'b0;  
             IRWr      <= 1'b0;
             MemWr     <= 1'b0;   
             RegWr     <= 1'b1;
             MemtoReg  <= 1'b1;   
            end
         swFinish:begin
             ExtOp     <= 2'b01;
             ALUSelA   <= 1'b1;
             ALUSelB   <= 2'b10; 
             ALUop     <= 4'b0000;//add运算
             RegDst    <= 1'b0;
             R_type    <= 1'b0;
             BrWr      <= 1'b0;
             PCWr      <= 1'b0;  
             PCWrCond  <= 1'b0;  
             IRWr      <= 1'b0;
             MemWr     <= 1'b1;   
             RegWr     <= 1'b0;
             MemtoReg  <= 1'b1;        
           end

         jumpFinish  :begin
               BrWr      <= 1'b0;
               PCSource  <= 2'b00;
               PCWr      <= 1'b1;  
               IRWr      <= 1'b0;
               MemWr     <= 1'b0;   
               RegWr     <= 1'b0;
           end    
         BrFinish  :begin
              ALUSelA   <= 1'b1;
              ALUSelB   <= 2'b00; 
              ALUop     <= 4'b0001;//sub运算
              R_type    <= 1'b0;
              BrWr      <= 1'b0;
              PCSource  <= 2'b10;
              PCWr      <= 1'b0;  
              PCWrCond  <= 1'b1;  
              IRWr      <= 1'b0;
              MemWr     <= 1'b0;   
              RegWr     <= 1'b0;
             end  
          addiuFetch:begin
             ALUSelA   <= 1'b1;
             ALUSelB   <= 2'b10; 
             ExtOp     <= 2'b00;
             R_type    <= 1'b0;
             ALUop     <= 4'b0100;
             BrWr      <= 1'b0;
             PCWr      <= 1'b0;  
             PCWrCond  <= 1'b0;  
             IRWr      <= 1'b0;
             MemWr     <= 1'b0;   
             RegWr     <= 1'b0;  
             MemtoReg  <= 1'b0; 
          end
          addiuFinish:begin
             ALUSelA   <= 1'b1;
             ALUSelB   <= 2'b10; 
             RegDst    <= 1'b0;
             R_type    <= 1'b0;
             ALUop     <= 4'b0100;
             BrWr      <= 1'b0;
             PCWr      <= 1'b0;  
             PCWrCond  <= 1'b0;  
             IRWr      <= 1'b0;
             MemWr     <= 1'b0;   
             RegWr     <= 1'b1;  
             MemtoReg  <= 1'b0; 
          end  
		default: ;
	   endcase
   end // end always    
endmodule

