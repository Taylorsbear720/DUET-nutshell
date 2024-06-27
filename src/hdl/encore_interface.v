`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2023 12:48:56 PM
// Design Name: 
// Module Name: encore_interface
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

module encore_interface(
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *)(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI, ID_WIDTH 16" *)    input   [11:0]    s_axi_araddr,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARBURST" *)  input   [1:0]     s_axi_arburst,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARCACHE" *)  input   [3:0]     s_axi_arcache,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARLEN" *)    input   [7:0]     s_axi_arlen,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARLOCK" *)   input   [0:0]     s_axi_arlock,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARPROT" *)   input   [2:0]     s_axi_arprot,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *)  output  [0:0]     s_axi_arready,                     //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARSIZE" *)   input   [2:0]     s_axi_arsize,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *)  input   [0:0]     s_axi_arvalid,                     //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *)   input   [11:0]    s_axi_awaddr,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWBURST" *)  input   [1:0]     s_axi_awburst,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWCACHE" *)  input   [3:0]     s_axi_awcache,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWLEN" *)    input   [7:0]     s_axi_awlen,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWLOCK" *)   input   [0:0]     s_axi_awlock,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWPROT" *)   input   [2:0]     s_axi_awprot,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *)  output  [0:0]     s_axi_awready,                     //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWSIZE" *)   input   [2:0]     s_axi_awsize,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *)  input   [0:0]     s_axi_awvalid,                     //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *)   input   [0:0]     s_axi_bready,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *)    output  [1:0]     s_axi_bresp,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *)   output  [0:0]     s_axi_bvalid,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *)    output  [127:0]   s_axi_rdata,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RLAST" *)    output  [0:0]     s_axi_rlast,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *)   input   [0:0]     s_axi_rready,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *)    output  [1:0]     s_axi_rresp,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *)   output  [0:0]     s_axi_rvalid,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WDATA" *)    input   [127:0]   s_axi_wdata,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WLAST" *)    input   [0:0]     s_axi_wlast,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *)   output  [0:0]     s_axi_wready,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *)    input   [15:0]    s_axi_wstrb,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *)   input   [0:0]     s_axi_wvalid,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BID" *)      output  [15:0]    s_axi_bid,
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWID" *)     input   [15:0]    s_axi_awid,
  input   [0:0]     s_axi_aclk,                        //axi
  input   [0:0]     s_axi_aresetn,                     //axi
  (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE ALMOST_FULL" *) input   [0:0]     fifo_almost_full,
  (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE FULL" *)        input   [0:0]     fifo_full,
  (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_DATA" *)     output  [127:0]   fifo_wr_data,
  (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_write:1.0 FIFO_WRITE WR_EN" *)       output  [0:0]     fifo_wr_en,
  input   [127:0]     syn_reg1,
  input   [127:0]     syn_reg2,
  output  reg[0:0]     turn2run,
  output  [4:0]    debug_state

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
    reg     [15:0]      reg_s_axi_bid;
    reg     [4:0]       state = 0;
    
    assign debug_state = state;
    assign s_axi_arready = reg_s_axi_arready;
    assign s_axi_rlast = reg_s_axi_rlast;
    assign s_axi_rvalid = reg_s_axi_rvalid;
    assign s_axi_rdata = reg_s_axi_rdata;
    assign s_axi_awready = reg_s_axi_awready;
    assign s_axi_bresp = reg_s_axi_bresp;
    assign s_axi_bvalid = reg_s_axi_bvalid;
    assign s_axi_wready = reg_s_axi_wready;
    assign fifo_wr_data = reg_fifo_wr_data;
    assign fifo_wr_en = reg_fifo_wr_en;
    assign s_axi_bid = reg_s_axi_bid;

    parameter EMU_AXI_READY         = 5'd0;
    parameter EMU_DIFDATA_AXI_AW    = 5'd1;
    parameter EMU_DIFDATA_AXI_W1    = 5'd2;
    parameter EMU_DIFDATA_AXI_W2    = 5'd3;
    parameter EMU_DIFDATA_AXI_B     = 5'd4;
    parameter EMU_READ_AXI_AR       = 5'd5;
    parameter EMU_SYNREG1_AXI_R1    = 5'd6;
    parameter EMU_SYNREG1_AXI_R2    = 5'd7;
    parameter EMU_SYNREG2_AXI_R1    = 5'd8;
    parameter EMU_SYNREG2_AXI_R2    = 5'd9;
    parameter EMU_TURN2RUN_AXI_AW   = 5'd10;
    parameter EMU_TURN2RUN_AXI_W1   = 5'd11;
    parameter EMU_TURN2RUN_AXI_W2   = 5'd12;
    parameter EMU_TURN2RUN_AXI_B    = 5'd13;


    
    always @(posedge s_axi_aclk)begin
        if(!s_axi_aresetn) begin
            reg_s_axi_arready <= 0;
            reg_s_axi_awready <= 0;
            reg_s_axi_bresp <= 0;
            reg_s_axi_bvalid <= 0;
            reg_s_axi_wready <= 0;
            reg_fifo_wr_en <= 0;
            turn2run <= 0;
            state <= EMU_AXI_READY;
        end
        else begin
            case(state)
            EMU_AXI_READY:begin                                 //ready
                reg_s_axi_bvalid <= 0;
                reg_s_axi_bresp <= 0;
                reg_s_axi_rlast <= 1'b0;
                reg_s_axi_rvalid <= 1'b0;
                if(s_axi_awvalid) begin
                    if(s_axi_awaddr == 12'h080)begin
                        state <= EMU_TURN2RUN_AXI_AW;
                    end
                    else begin
                        state <= EMU_DIFDATA_AXI_AW;
                    end
                end
                else if(s_axi_arvalid)begin
                    state <= EMU_READ_AXI_AR;
                end
                else begin
                    state <= EMU_AXI_READY;
                end
            end
            EMU_DIFDATA_AXI_AW:begin                                 //axi_aw
                if(!fifo_full && !fifo_almost_full) begin
                    reg_s_axi_awready <= 1;
                    reg_s_axi_bid <= s_axi_awid;
                    state <= EMU_DIFDATA_AXI_W1;
                end
                else begin
                    state <= EMU_DIFDATA_AXI_AW;
                end
            end
            EMU_DIFDATA_AXI_W1:begin                                 //aw_step1
                reg_s_axi_awready <= 0;
                reg_s_axi_wready <= 1;
                state <= EMU_DIFDATA_AXI_W2;
            end
            EMU_DIFDATA_AXI_W2:begin                                 //aw_step2
                reg_s_axi_wready <= 0;
                if(s_axi_wvalid && reg_s_axi_wready)begin
                    reg_fifo_wr_data <= s_axi_wdata;
                    reg_fifo_wr_en <= 1;
                    state <= EMU_DIFDATA_AXI_B;
                end
                else begin
                    state <= EMU_DIFDATA_AXI_W1;
                end
            end
            EMU_DIFDATA_AXI_B:begin                                 //axi_b
                reg_fifo_wr_en <= 0;
                reg_s_axi_bvalid <= 1;
                reg_s_axi_bresp <= 0;
                state <= EMU_AXI_READY;
            end
            EMU_READ_AXI_AR:begin
                reg_s_axi_arready <= 1;
                if(s_axi_araddr == 12'h0)begin
                    state <= EMU_SYNREG1_AXI_R1;
                end
                else begin
                    state <= EMU_SYNREG2_AXI_R1;
                end
            end
            EMU_SYNREG1_AXI_R1:begin
                reg_s_axi_arready <= 0;
                if(s_axi_rready)begin
                    state <= EMU_SYNREG1_AXI_R2;
                end
                else begin
                    state <= EMU_SYNREG1_AXI_R1;
                end
            end
            EMU_SYNREG1_AXI_R2:begin
                reg_s_axi_rlast <= 1'b1;
                reg_s_axi_rvalid <= 1'b1;
                reg_s_axi_rdata <= syn_reg1;
                state <= EMU_AXI_READY;
            end
            EMU_SYNREG2_AXI_R1:begin
                reg_s_axi_arready <= 0;
                if(s_axi_rready)begin
                    state <= EMU_SYNREG2_AXI_R2;
                end
                else begin
                    state <= EMU_SYNREG2_AXI_R1;
                end
            end
            EMU_SYNREG2_AXI_R2:begin
                reg_s_axi_rlast <= 1'b1;
                reg_s_axi_rvalid <= 1'b1;
                reg_s_axi_rdata <= syn_reg2;
                state <= EMU_AXI_READY;
            end
            EMU_TURN2RUN_AXI_AW:begin
                reg_s_axi_awready <= 1;
                reg_s_axi_bid <= s_axi_awid;
                state <= EMU_TURN2RUN_AXI_W1;
            end
            EMU_TURN2RUN_AXI_W1:begin
                reg_s_axi_awready <= 0;
                reg_s_axi_wready <= 1;
                state <= EMU_TURN2RUN_AXI_W2;
            end
            EMU_TURN2RUN_AXI_W2:begin
                reg_s_axi_wready <= 0;
                if(s_axi_wvalid && reg_s_axi_wready)begin
                    turn2run <= 1;
                    state <= EMU_TURN2RUN_AXI_B;
                end
                else begin
                    state <= EMU_TURN2RUN_AXI_W1;
                end
            end
            EMU_TURN2RUN_AXI_B:begin
                turn2run <= 0;
                reg_s_axi_bvalid <= 1;
                reg_s_axi_bresp <= 0;
                state <= EMU_AXI_READY;
            end
            endcase
        end
    end
endmodule


