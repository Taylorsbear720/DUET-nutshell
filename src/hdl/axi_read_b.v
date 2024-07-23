`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/13 17:07:24
// Design Name: 
// Module Name: axi_read
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



module axi_read_b(
//Read address channel signals
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *)(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI, ID_WIDTH 16" *)    input   [11:0]    s_axi_araddr,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARBURST" *)  input   [1:0]     s_axi_arburst,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARCACHE" *)  input   [3:0]     s_axi_arcache,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARLEN" *)    input   [7:0]     s_axi_arlen,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARLOCK" *)   input   [0:0]     s_axi_arlock,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARPROT" *)   input   [2:0]     s_axi_arprot,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *)  output  [0:0]     s_axi_arready,                     //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARSIZE" *)   input   [2:0]     s_axi_arsize,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *)  input   [0:0]     s_axi_arvalid,                     //axi
 
   //Write address channel signals
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *)   input   [11:0]    s_axi_awaddr,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWBURST" *)  input   [1:0]     s_axi_awburst,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWCACHE" *)  input   [3:0]     s_axi_awcache,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWLEN" *)    input   [7:0]     s_axi_awlen,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWLOCK" *)   input   [0:0]     s_axi_awlock,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWPROT" *)   input   [2:0]     s_axi_awprot,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *)  output  [0:0]     s_axi_awready,                     //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWSIZE" *)   input   [2:0]     s_axi_awsize,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *)  input   [0:0]     s_axi_awvalid, 
                     //axi
                     
                     //Write response channel signals
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *)   input   [0:0]     s_axi_bready,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *)    output  [1:0]     s_axi_bresp,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *)   output  [0:0]     s_axi_bvalid,  
                     //axi
                    // Read data channel signals
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *)    output  [127:0]   s_axi_rdata,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RLAST" *)    output  [0:0]     s_axi_rlast,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *)   input   [0:0]     s_axi_rready,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *)    output  [1:0]     s_axi_rresp,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *)   output  [0:0]     s_axi_rvalid,  
                     //axi
                     //Write data channel signals
 (* X_INTERFACE_INFO = "xilinx.reg_s_axi_rdatacom:interface:aximm:1.0 S_AXI WDATA" *)    input   [127:0]   s_axi_wdata,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WLAST" *)    input   [0:0]     s_axi_wlast,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *)   output  [0:0]     s_axi_wready,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *)    input   [15:0]    s_axi_wstrb,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *)   input   [0:0]     s_axi_wvalid,  
                     //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BID" *)      output  [15:0]    s_axi_bid,
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWID" *)     input   [15:0]    s_axi_awid,
  input   [0:0]     s_axi_aclk,                        //axi
  input   [0:0]     s_axi_aresetn,                     //axi
 
 
 
 
 
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
    input [63:0]               break_counter,
    output reg [63:0]          all_cycle,
   output reg [63:0]          cpu_cycle,
  
  output  [0:0]      break_full,
  output  [127:0]    rdata,
  output   [4:0]   sstate,
  output  arvalid
  
 // output  reg[0:0]     turn2run

    );
    
    
    reg     [0:0]       reg_s_axi_arready;
    
    reg     [0:0]       reg_s_axi_rlast;
    reg     [0:0]       reg_s_axi_rvalid;
    reg     [127:0]     reg_s_axi_rdata;

    reg     [0:0]       reg_s_axi_awready;
    
    reg     [1:0]       reg_s_axi_bresp;
    reg     [0:0]       reg_s_axi_bvalid;
    reg     [0:0]       reg_s_axi_wready;
    reg     [127:0]     reg_fifo_wr_data;
    reg     [0:0]       reg_fifo_wr_en;
    reg     [0:0]       reg_fifo_rd_en;
    
    reg     [15:0]      reg_s_axi_bid;
    reg     [4:0]       state = 0;
    reg     [4:0]       state2=0;
    reg     [0:0]       reg_break_full=0;
    reg    [0:0]       reg_break_full_d1;
    
    
    reg     [1663:0]      data_mix;
    reg     [1663:0]      data;
    reg   isFirst;
    reg   isreg;
    
    reg    [3:0]  couter;
    reg    [0:0]   skip;
    
    reg  first_record;
    wire do_counting = break_counter > all_cycle;
    
  
    assign sstate=state;
    assign s_axi_arready = reg_s_axi_arready;
    
    assign s_axi_rlast = reg_s_axi_rlast;
    assign s_axi_rvalid = reg_s_axi_rvalid;
    assign s_axi_rdata = reg_s_axi_rdata;
    assign rdata=reg_s_axi_rdata;
    assign s_axi_awready = reg_s_axi_awready;
    assign s_axi_bresp = reg_s_axi_bresp;
    assign s_axi_bvalid = reg_s_axi_bvalid;
    assign s_axi_wready = reg_s_axi_wready;
    assign fifo_wr_data = reg_fifo_wr_data;
    assign fifo_wr_en = reg_fifo_wr_en;
    
    assign fifo_rd_en = reg_fifo_rd_en;
    
    assign s_axi_bid = reg_s_axi_bid;
    
    assign break_full=reg_break_full;
    
    
    
    //read
    always @(posedge s_axi_aclk)begin
        if(!s_axi_aresetn || !en) begin
            reg_s_axi_arready <= 0;
             reg_s_axi_rlast <= 1'b0;
                reg_s_axi_rvalid <= 1'b0;
            data_mix<=0;
            data<=0;
            couter<=0;
            isFirst<=1;
            reg_break_full<=1'b1;
           // turn2run <= 0;
            state <= 0;
        end
        else begin
            case(state)
             0:begin  
                reg_s_axi_rlast <= 1'b0;
                reg_s_axi_rvalid <= 1'b0;      
                if(en) begin 
                reg_break_full<=1'b0; 
                state<=1;
                end
                else  begin
                 state<=0;
                end
                   
            end
            1:begin
                 if(valid && !reg_break_full) begin    
                 data_mix<={instrcnt, {7'd0},io_ila_isRVC,io_ila_priviledgeMode,{7'd0},io_ila_nutcoretrap,io_ila_code,io_ila_intrNO,   syn_reg2,syn_reg1, io_ila_mstatus,io_ila_sstatus,io_ila_mepc, 
                 io_ila_sepc,io_ila_mtval, io_ila_stval,io_ila_mtvec,io_ila_stvec,io_ila_mcause, io_ila_scause,io_ila_satp,io_ila_mipReg,
                 io_ila_mie,  io_ila_mscratch,io_ila_sscratch, io_ila_mideleg,io_ila_medeleg, io_ila_cause,io_ila_exceptionInst,io_ila_exceptionPC,io_ila_pc, io_ila_cycleCnt,io_ila_WBUInstr};  
                 reg_break_full<=1'b1;               
                 state <= 5; 
                 end else begin
                  state<=1;
                 end         
               end 
          
            3:begin
                reg_s_axi_rlast <= 1'b0;
                reg_s_axi_rvalid <= 1'b0;
             if(s_axi_arvalid) begin           
                state <= 5;
                end else begin
                 state<=3;
                 end
            end 
            5:begin
             if(s_axi_arvalid) begin
                 reg_s_axi_arready <= 1;
                    state <= 6;
                end
            end
            6:begin
                reg_s_axi_arready <= 0;
                if(s_axi_rready)begin
                   state<=7;
                end 
                else begin
                    state <= 6;
                end
            end
            7:begin
                 reg_s_axi_rlast <= 1'b1;
                  reg_s_axi_rvalid <= 1'b1;
                  reg_s_axi_rdata <= data_mix[127:0];
                  data_mix<=data_mix >> 128; 
                if(couter==4'b1100) begin
                    couter<=0;
                    state<=0;
                end else begin 
                    couter<=couter+1'b1;
                     state <= 3;
                 end
            end
            endcase
        end
    end
//===================================================
//all_cycle
always@(posedge s_axi_aclk)begin
    if(!s_axi_aresetn || ~en) begin
        all_cycle <= 0;
    end
    else if(do_counting && en)begin
        all_cycle <= all_cycle + 1;
    end
end
always@(posedge s_axi_aclk)begin
    if(!s_axi_aresetn) begin
        cpu_cycle <= 0;
    end
    else if(reg_s_axi_arready && s_axi_arvalid && do_counting && en)begin
        cpu_cycle <= cpu_cycle + 1;
    end
end
//数据包数量
endmodule


