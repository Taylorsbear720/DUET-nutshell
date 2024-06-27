`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/02 14:46:58
// Design Name: 
// Module Name: DataChange
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


module DataChange(
  input   [0:0]     s_axi_aclk,                        
  input   [0:0]     s_axi_aresetn,
  
  input   [0:0]     data_next, 
  
  input   [0:0]         valid,
  input   [0:0]         wen,
  input   [0:0]          en,
  input   [0:0]         isMMio, 
  input   [63:0]     syn_reg1,
  input   [63:0]     syn_reg2,
  input  [63:0]    instrcnt,
  input  io_ila_rfwen,
  input io_ila_isRVC,
  input [63:0] io_ila_WBUInstr,
    
    input [7:0] io_ila_priviledgeMode,
   input [63:0] io_ila_mstatus,

    input [63:0] io_ila_sstatus,
    input [63:0] io_ila_mepc,
    input [63:0] io_ila_sepc,
    input [63:0] io_ila_mtval,
    input  [63:0] io_ila_stval,
    input [63:0] io_ila_mtvec,
    input [63:0] io_ila_stvec,
   input  [63:0] io_ila_mcause,
   input  [63:0] io_ila_scause,
   input  [63:0] io_ila_satp,
   input  [63:0]  io_ila_mipReg,
   input  [63:0] io_ila_mie,
 input   [63:0]  io_ila_mscratch,
 input   [63:0]  io_ila_sscratch,
  input  [63:0]  io_ila_mideleg,
   input [63:0]  io_ila_medeleg,
    
    input [31:0]io_ila_intrNO,
 input  [31:0]  io_ila_cause,
  input  [63:0] io_ila_exceptionPC,
  input  [31:0] io_ila_exceptionInst,
    
    
   input io_ila_nutcoretrap,
   input  [7:0] io_ila_code,
   input[63:0] io_ila_pc,
   input [63:0]  io_ila_cycleCnt,
   
   output reg  axi_read_en,
   output reg [1663:0] data,
   output reg break_full
    );
    reg isFirst;
    reg compare;
//    reg [1663:0] Next_data;
    
    always@(posedge s_axi_aclk) begin
        if(!s_axi_aresetn || !en) begin
            break_full<=0;
            data<=0;
            compare=1;
            axi_read_en<=0;
//            Next_data<=0;
        end else begin
                
            if(valid && !break_full) begin  
                 // axi_read_en<=0;     
              //   if(compare==1000) begin   
                 data<={io_ila_mstatus,io_ila_sstatus,io_ila_mepc, io_ila_sepc,io_ila_mtval, io_ila_stval,io_ila_mtvec,io_ila_stvec,io_ila_mcause, io_ila_scause,io_ila_satp,io_ila_mipReg,
                 io_ila_mie,  io_ila_mscratch,io_ila_sscratch, io_ila_mideleg,io_ila_medeleg, io_ila_cycleCnt,  syn_reg2,syn_reg1,{7'd0},io_ila_isRVC,io_ila_priviledgeMode,{7'd0},io_ila_nutcoretrap,io_ila_code,io_ila_intrNO, 
                   io_ila_cause,io_ila_exceptionInst,io_ila_exceptionPC,io_ila_pc, io_ila_WBUInstr,instrcnt};  
//                   compare<=1;
//                 end else begin
//                 data<={ syn_reg2,syn_reg1,{7'd0},io_ila_isRVC,io_ila_priviledgeMode,{7'd0},io_ila_nutcoretrap,io_ila_code,io_ila_intrNO, 
//                   io_ila_cause,io_ila_exceptionInst,io_ila_exceptionPC,io_ila_pc, io_ila_WBUInstr,instrcnt}; 
//                   compare<=compare+1; 
//                 end
                 axi_read_en<=1;
                 break_full<=1'b1;
            end else if (data_next) begin
                 axi_read_en<=0;
                 data<=0;
                 break_full<=1'b0;
            end else begin
                axi_read_en<=0;
            end
        end
    
    end
    
endmodule
