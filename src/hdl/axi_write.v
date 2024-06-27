`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/06 16:35:47
// Design Name: 
// Module Name: axi_write
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



module axi_write(
//Read address channel signals
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *)(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI, ID_WIDTH 6" *)    output   [48:0]    s_axi_araddr,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARBURST" *)  output   [1:0]     s_axi_arburst,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARCACHE" *)  output   [3:0]     s_axi_arcache,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARLEN" *)    output   [7:0]     s_axi_arlen,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARLOCK" *)   output   [0:0]     s_axi_arlock,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARPROT" *)   output   [2:0]     s_axi_arprot,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *)  input    [0:0]      s_axi_arready,                     //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARSIZE" *)   output   [2:0]     s_axi_arsize,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *)  output   [0:0]     s_axi_arvalid,                     //axi

   //Write address channel signals
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *)   output   [48:0]    s_axi_awaddr,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWBURST" *)  output   [1:0]     s_axi_awburst,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWCACHE" *)  output   [3:0]     s_axi_awcache,    //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWLEN" *)    output   [7:0]     s_axi_awlen,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWLOCK" *)   output   [0:0]     s_axi_awlock,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWPROT" *)   output   [2:0]     s_axi_awprot,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *)  input    [0:0]     s_axi_awready,                     //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWSIZE" *)   output   [2:0]     s_axi_awsize,     //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *)  output   [0:0]     s_axi_awvalid, 
                     //axi

                     //Write response channel signals
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *)   output   [0:0]     s_axi_bready,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *)    input  [1:0]     s_axi_bresp,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *)   input  [0:0]     s_axi_bvalid,  
                     //axi
                    // Read data channel signals
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *)    input  [127:0]   s_axi_rdata,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RLAST" *)    input  [0:0]     s_axi_rlast,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *)   output   [0:0]     s_axi_rready,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *)    input  [1:0]     s_axi_rresp,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *)   input  [0:0]     s_axi_rvalid,  
                     //axi
                     //Write data channel signals
 (* X_INTERFACE_INFO = "xilinx.reg_s_axi_rdatacom:interface:aximm:1.0 S_AXI WDATA" *)    output   [127:0]   s_axi_wdata,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WLAST" *)    output   [0:0]     s_axi_wlast,                       //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *)   input  [0:0]     s_axi_wready,                      //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *)    output   [15:0]    s_axi_wstrb,      //               //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *)   output   [0:0]     s_axi_wvalid,  
                     //axi
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BID" *)      input  [5:0]    s_axi_bid,
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RID" *)      input  [5:0]    s_axi_rid,
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWID" *)     output   [5:0]    s_axi_awid,
 (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARID" *)     output   [5:0]    s_axi_arid,
  input   [0:0]     s_axi_aclk,                        //axi
  input   [0:0]     s_axi_aresetn,                     //axi

  input  [1663:0]      data,
  input  [0:0]    axi_read_en,

  input   [0:0]         valid,
  input   [0:0]         wen,
  input   [0:0]          en,
    input [63:0]               break_counter,
    output reg [63:0]          all_cycle,
   output reg [63:0]          cpu_cycle,
   output reg [0:0]  data_next,
  output reg    [31:0] address_count,
  output reg  [127:0]    rdata,
  output   [4:0]   sstate,
  output   [4:0]   readsstate,
  output  [0:0] read_test_en,
  output  [0:0] xinhao,
  output  reg [31:0] readata
 // output  reg[0:0]     turn2run

    );
    
    reg    [63:0]     lastdata;
    reg    [48:0]     reg_s_axi_awaddr;
    reg    [1:0]      reg_s_axi_awburst;
    reg    [7:0]      reg_s_axi_awlen;
    reg    [2:0]      reg_s_axi_awsize;
    reg    [0:0]      reg_s_axi_awvalid;

    reg    [0:0]     reg_s_axi_bready;

    reg     [127:0]     reg_s_axi_wdata;
    reg     [0:0]     reg_s_axi_wlast;
    reg     [15:0]    reg_s_axi_wstrb;
    reg     [0:0]     reg_s_axi_wvalid;


    reg    [48:0]     reg_s_axi_araddr;
    reg    [1:0]      reg_s_axi_arburst;
    reg    [7:0]      reg_s_axi_arlen;
    reg    [2:0]      reg_s_axi_arsize;
    reg    [0:0]      reg_s_axi_arvalid;

    reg    [0:0]      reg_s_axi_rready;
    //reg    [3:0]  readcouter;
    reg     [4:0]       readstate = 0;
        reg    [0:0]  read_count;
    //reg     [127:0]     reg_s_axi_rdata;
   // reg     [0:0]     reg_s_axi_rlast;
    //reg     [15:0]    reg_s_axi_wstrb;
    //reg     [0:0]     reg_s_axi_rvalid;


    parameter integer MAX_INSTRCOUNT=19;

    reg     [4:0]       state = 0;
    reg     [1663:0]      data_mix;

    reg    [3:0]  couter;

    wire    [36:0] Wadress;
    reg    [0:0] isQue;
    reg isFirst;

    reg compare;
    
    assign Wadress=36'h0000000;
    assign xinhao=address_count< MAX_INSTRCOUNT;
    assign  read_test_en= MAX_INSTRCOUNT==address_count;

    wire do_counting = break_counter > all_cycle;
    wire write_next= read_count==1;
    wire [31:0] data_second;
    assign data_second=rdata;

    assign sstate=state;
    assign readsstate=readstate;
     assign s_axi_awaddr=reg_s_axi_awaddr;
    assign s_axi_awburst=reg_s_axi_awburst;
    assign s_axi_awlen=reg_s_axi_awlen;
    assign  s_axi_awsize=reg_s_axi_awsize;
     assign s_axi_awvalid=reg_s_axi_awvalid;

     assign s_axi_bready=reg_s_axi_bready;

    assign  s_axi_wdata=reg_s_axi_wdata;
   assign s_axi_wlast=reg_s_axi_wlast;
     assign s_axi_wstrb=reg_s_axi_wstrb;
     assign s_axi_wvalid=reg_s_axi_wvalid;

    // assign sstate=readstate;


     assign s_axi_araddr=reg_s_axi_araddr;
    assign s_axi_arburst=reg_s_axi_arburst;
    assign s_axi_arlen=reg_s_axi_arlen;
    assign  s_axi_arsize=reg_s_axi_arsize;
     assign s_axi_arvalid=reg_s_axi_arvalid;

    assign s_axi_rready=reg_s_axi_rready;
    // assign s_axi_bready=reg_s_axi_bready;

    //assign  s_axi_rdata=reg_s_axi_rdata;
   //assign s_axi_rlast=reg_s_axi_rlast;
     //assign s_axi_rstrb=reg_s_axi_wstrb;
    // assign s_axi_rvalid=reg_s_axi_rvalid;



    //read
    always @(posedge s_axi_aclk)begin
        if(!s_axi_aresetn || !en) begin
            reg_s_axi_awburst <= 0;
            reg_s_axi_awlen <= 0;
            reg_s_axi_awsize <= 0;
            reg_s_axi_awvalid<=0; 
            reg_s_axi_bready<=0;
            reg_s_axi_awaddr<=0;
            reg_s_axi_wdata<=0;
            reg_s_axi_wlast<=0;
            reg_s_axi_wstrb<=0;
            reg_s_axi_wvalid<=0;
            address_count<=0;
            //isQue<=0;
               isFirst<=1;
            data_mix<=0;
            data_next<=0;
            couter<=0;
            compare<=1;
           // turn2run <= 0;
            state <= 0;
        end
        else begin
            case(state)
            0:begin

                 if(address_count< (MAX_INSTRCOUNT)) begin
                        reg_s_axi_awburst <= 2'b01;
                        reg_s_axi_awaddr <= (Wadress+address_count*208);       
                        reg_s_axi_awlen<=4'b1100;
                         reg_s_axi_awsize<=3'b100; 
                         data_next<=0;
                         if(axi_read_en) begin
                         address_count<=address_count+1;
                         reg_s_axi_awvalid<=1;   
                          data_mix<=data;             
                         state <= 5;
                      end 
                 end 
//                 else if(address_count==20) begin
//                       reg_s_axi_awaddr <= (36'h0000f70);  
//                       reg_s_axi_awlen<=4'b0000;
//                       reg_s_axi_awsize<=2'b10;
//                       data_next<=0;
//                       reg_s_axi_awvalid<=1;  
//                       state<=1;
//                    end
                    else begin
                        address_count<=0;
                        state<=0;
                    end
               end
//            1:begin
//                if(s_axi_awready && reg_s_axi_awvalid ) begin
//                 reg_s_axi_awvalid <= 0; 
//                 reg_s_axi_awaddr<=0;
//                    state <= 2;
//                end else begin
//                    state<=1;
//                end
//            end
//            2: begin
//                 reg_s_axi_wvalid<=1;
//                 reg_s_axi_wstrb<=16'hFFFF;  
//                 reg_s_axi_wdata<=128'h0;
//                  reg_s_axi_bready<=1;
//                    reg_s_axi_wlast<=1;
//                    state<=3;
//               end
//             3: begin
//                 if(s_axi_wready && reg_s_axi_wvalid)begin
//                 reg_s_axi_wvalid<=0;
//                   reg_s_axi_wlast<=0;                   
//                      state<=4;
//                 end else begin
//                 state<=3;
//                 end
//             end  
//             4:begin
//             if(reg_s_axi_bready && s_axi_bresp==2'b00)begin
//                        reg_s_axi_bready<=0;
//                         address_count<=0;
//                          if(isFirst) begin
//                             isFirst<=0;
//                         end else begin
//                             data_next<=1;
//                             end
//                             state<=0;
//                   end  else  begin
//                   state<=4;
//                  end 
//             end    
            5:begin

             if(s_axi_awready && reg_s_axi_awvalid ) begin
                 reg_s_axi_awvalid <= 0; 
                 reg_s_axi_awaddr<=0;
                    state <= 6;
                end
            end
            6:begin
                reg_s_axi_wvalid<=1;
                 reg_s_axi_wstrb<=16'hFFFF;
                reg_s_axi_wdata<=data_mix[127:0];
                data_mix<=data_mix >> 128;               
                if(couter== 4'b1100) begin
                  reg_s_axi_bready<=1;
                    reg_s_axi_wlast<=1;
                end       
                state<=7;
            end
            7:begin 
                if(s_axi_wready && reg_s_axi_wvalid)begin
                    couter<=couter+1'b1; 
                    reg_s_axi_wvalid<=0;
                    if(couter<4'b1100) begin
                      state <= 6;      
                    end else begin 
                      reg_s_axi_wlast<=0;                      
                      state<=8;

                  end
                end 
               end
            8:begin
                if(reg_s_axi_bready && s_axi_bresp==2'b00)begin
                        reg_s_axi_bready<=0;
                        couter<=0;
                         if(address_count< (MAX_INSTRCOUNT)) begin  
                           data_next<=1; 
                            state<=0;
                            end else begin
                             data_next<=0;
                             state<=9;
                              end
                    end else begin 
                    state<=8;
                    end  
                end 
             9: begin
              if( read_count )begin
                    address_count<=0;
                     data_next<=1; 
                    state<=0;
                 end   
                 end     
            endcase
        end
    end






     always @(posedge s_axi_aclk)begin
       if(!s_axi_aresetn || !en) begin
            reg_s_axi_arburst <= 0;
            reg_s_axi_arlen <= 0;
            reg_s_axi_arsize <= 0;
            reg_s_axi_arvalid<=0; 
            //reg_s_axi_bready<=0;
            reg_s_axi_araddr<=0;
                lastdata<=64'hdeadbeff;
//            reg_s_axi_wdata<=0;
//            reg_s_axi_wlast<=0;
//            reg_s_axi_wstrb<=0;
//            reg_s_axi_wvalid<=0;
            reg_s_axi_rready<=0;   
            read_count<=0;        

           // turn2run <= 0;
            readstate <= 0;
            readata<=0;
        end
        else begin
            case(readstate)
            0:begin       
                 //data_next<=0;
                if( read_test_en) begin
                read_count<=0;
                reg_s_axi_arburst <= 2'b01;
                reg_s_axi_araddr <= (36'h0000f70);       
                reg_s_axi_arlen<=4'b0000;
                 reg_s_axi_arsize<=3'b100; 
                 reg_s_axi_arvalid<=1;   
               //  data_mix<=data;             
                 readstate <= 5; 
                 end else begin
                 read_count<=0;

                  readstate<=0;
                 end         
               end       
            5:begin
             if(s_axi_arready && reg_s_axi_arvalid ) begin
                    reg_s_axi_arvalid<=0;
                    readstate <= 6;
                end
            end
            6:begin                     
                reg_s_axi_rready<=1;
                readstate<=7;
            end
            7:begin 
                if(s_axi_rvalid && reg_s_axi_rready)begin
                    reg_s_axi_rready<=0;
                     if(s_axi_rdata[63:0]!=lastdata)begin
                      lastdata<=s_axi_rdata[63:0];
                         read_count<=1;
                    //rdata<=s_axi_rdata;
                      readstate <= 8;      
                    end else begin   
                      readstate<=0;
                     end 
                end else begin
                   readstate<=7;
                   end 
                end
              8:begin
                readstate<=0;
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
    else if(s_axi_awready && reg_s_axi_awvalid && do_counting && en)begin
        cpu_cycle <= cpu_cycle + 1;
    end
end
//数据包数量
endmodule