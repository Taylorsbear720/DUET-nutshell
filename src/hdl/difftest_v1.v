`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/02/2022 02:50:53 PM
// Design Name: 
// Module Name: difftest_v1
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


module difftest_v1(

 (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 FIFO_READ_1 ALMOST_EMPTY" *) input   [0:0]     emu_fifo_almost_empty,
 (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 FIFO_READ_1 EMPTY" *)        input   [0:0]     emu_fifo_empty,
 (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 FIFO_READ_1 RD_DATA" *)      input   [127:0]   emu_fifo_rd_data,
 (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 FIFO_READ_1 RD_EN" *)        output  [0:0]     emu_fifo_rd_en,
 (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 FIFO_READ_2 ALMOST_EMPTY" *) input   [0:0]     dut_fifo_almost_empty,
 (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 FIFO_READ_2 EMPTY" *)        input   [0:0]     dut_fifo_empty,
 (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 FIFO_READ_2 RD_DATA" *)      input   [127:0]   dut_fifo_rd_data,
 (* X_INTERFACE_INFO = "xilinx.com:interface:fifo_read:1.0 FIFO_READ_2 RD_EN" *)        output  [0:0]     dut_fifo_rd_en,
 input      [0:0]           clk,
 input      [0:0]           resetn,
 //input      [0:0]           dequeue,
 output     [0:0]           irq_emu,               //Used to interrupt the EMU on the PS side
 output     [0:0]           irq_dut,               //Used to interrupt the DUT on the PL side
 output     [0:0]           right,
 //debug
 output     [2:0]           debug_state,
 output     [63:0]          debug_counter     

    );
    reg     [0:0]       reg_emu_fifo_rd_en;
    reg     [0:0]       reg_dut_fifo_rd_en;
    reg     [0:0]       reg_irq_emu;
    reg     [0:0]       reg_irq_dut;
    reg     [0:0]       reg_right;
    reg     [63:0]      reg_debug_counter;
    
    assign emu_fifo_rd_en = reg_emu_fifo_rd_en;
    assign dut_fifo_rd_en = reg_dut_fifo_rd_en;
    assign irq_emu = reg_irq_emu;
    assign irq_dut = reg_irq_dut;
    assign right = reg_right;
    assign debug_counter = reg_debug_counter;
    
    
    reg     [2:0]       state = 0;
    //debug
    assign debug_state = state;
    //
    parameter   N = 8;                          //N is 8, which means eight comparators are used
    reg [N-1:0] eq_r;
    reg         eq;
    reg         pipeline_mark = 0;
    reg [7:0]   irq_counter = 0;

    parameter DF_READY     = 3'd0;
    parameter DF_WAIT      = 3'd1;
    parameter DF_COMPARE   = 3'd2;
    parameter DF_DUT_IRQ   = 3'd3;
    parameter DF_EMU_IRQ   = 3'd4;
    parameter DF_ERROR     = 3'd5;
    parameter DF_END       = 3'd6;

    
    always@(posedge clk)begin
        if(!resetn) begin
            reg_emu_fifo_rd_en <= 0;
            reg_dut_fifo_rd_en <= 0;
            reg_irq_emu <= 0;
            reg_irq_dut <= 0;
            reg_right <= 1;
            pipeline_mark <= 0;
            eq_r <= 8'b1111_1111;
            eq <= 1;
            reg_debug_counter <= 0;
            irq_counter <= 0;
            state <= DF_READY;
            
        end
        else begin
            case(state)
            //Status 0, preparation phase
            DF_READY:begin             
                reg_irq_emu <= 0;
                reg_irq_dut <= 0;
                reg_emu_fifo_rd_en <= 0;
                reg_dut_fifo_rd_en <= 0;
                state <= DF_WAIT;
            end
            //State 1 is the data retrieval stage
            DF_WAIT:begin    
                 // If the FIFO on the DUT and EMU is not empty, enter State 2 for comparison         
                if(!emu_fifo_almost_empty && !dut_fifo_almost_empty)begin        
                    reg_emu_fifo_rd_en <= 1;
                    reg_dut_fifo_rd_en <= 1;
                    state <= DF_COMPARE;
                end
                //If the EMU side FIFO is empty and the DUT side FIFO is not empty, interrupt the DUT
                else if (emu_fifo_almost_empty && !dut_fifo_almost_empty)begin    
                   reg_irq_dut <=  1;
                   state <= DF_DUT_IRQ;
                end
                //If the DUT side FIFO is empty and the EMU side FIFO is not empty, interrupt the EMU
                else if (!emu_fifo_almost_empty && dut_fifo_almost_empty)begin    
                    reg_irq_emu <= 1;
                    state <= DF_EMU_IRQ;
                end
                //All empty, wait
                else begin          
                    state <= DF_WAIT;
                end
            end
            //Status 2: N-way pipeline comparison
            DF_COMPARE:begin         
                reg_debug_counter <= reg_debug_counter + 1;
                reg_emu_fifo_rd_en <= 0;
                reg_dut_fifo_rd_en <= 0;
                //FIFO_DATA TYPE:
                //[127:64]       [63]       [62]        [61:57]         [56:39]         [38:0]
                //destregdata    ismmio     wenable     destreg            0               pc
                if((dut_fifo_rd_data[62:55] == {8'h80}) ||(dut_fifo_rd_data[62] == 0)||(dut_fifo_rd_data[63] == 1))begin
                    eq_r <= 8'hff;
                end
                else begin
                    eq_r[0] <= ( emu_fifo_rd_data[128/N*0 +:128/N] == dut_fifo_rd_data[128/N*0 +:128/N] );
                    eq_r[1] <= ( emu_fifo_rd_data[128/N*1 +:128/N] == dut_fifo_rd_data[128/N*1 +:128/N] );
                    eq_r[2] <= ( emu_fifo_rd_data[128/N*2 +:128/N] == dut_fifo_rd_data[128/N*2 +:128/N] );
                    eq_r[3] <= ( emu_fifo_rd_data[128/N*3 +:(128/N-2)] == dut_fifo_rd_data[128/N*3 +:(128/N-2)] );
                    eq_r[4] <= ( emu_fifo_rd_data[128/N*4 +:128/N] == dut_fifo_rd_data[128/N*4 +:128/N] );
                    eq_r[5] <= ( emu_fifo_rd_data[128/N*5 +:128/N] == dut_fifo_rd_data[128/N*5 +:128/N] );
                    eq_r[6] <= ( emu_fifo_rd_data[128/N*6 +:128/N] == dut_fifo_rd_data[128/N*6 +:128/N] );
                    eq_r[7] <= ( emu_fifo_rd_data[128/N*7 +:128/N] == dut_fifo_rd_data[128/N*7 +:128/N] );
                end   
                eq <= &eq_r;
                if(!pipeline_mark)begin
                    pipeline_mark <= 1;
                    state <= DF_WAIT;
                end
                else begin
                    if(eq)begin
                        reg_right <= 1;
                        state <= DF_WAIT;
                    end
                    //to wrong state 
                    else begin
                        reg_right <= 0;
                        state <= DF_ERROR; 
                    end
                end   
            end
            //State 3, interrupt the DUT until the FIFO on the DUT side is not empty, and the interrupt lasts for at least 10 cycles to avoid frequent interrupts
            DF_DUT_IRQ:begin                 
                if(!emu_fifo_almost_empty && irq_counter >= 10) begin
                    reg_irq_dut <= 0;
                    irq_counter <= 0;
                    state <= DF_WAIT;
                end
                else begin
                    if(irq_counter <= 10)begin
                        irq_counter <= irq_counter + 1;
                    end
                    else;
                    state <= DF_DUT_IRQ;
                end
            end
            //State 4, interrupt the EMU until the FIFO on the EMU side is not empty, and the interrupt lasts for at least 10 cycles to avoid frequent interrupts
            DF_EMU_IRQ:begin                 
                if(!dut_fifo_almost_empty && irq_counter >= 10) begin
                    reg_irq_emu <= 0;
                    irq_counter <= 0;
                    state <= DF_WAIT;
                end
                else begin
                    if(irq_counter <= 10)begin
                        irq_counter <= irq_counter + 1;
                    end
                    else;
                    state <= DF_EMU_IRQ;
                end
            end
            //Status 5. Error is found in CPU status comparison between DUT and EMU, indicating DUT execution error. Set the right signal to 0
            DF_ERROR:begin
               reg_irq_emu <= 1;
               //debug :wrong then run nutshell to avoid stall
               reg_irq_dut <= 0;
               //reg_irq_dut <= 1;
               reg_right <= 0;
               state <= DF_END;     
            end
            //Status 6: In order to avoid the bus stuck problem caused by full FIFO, the FIFO is always read after an error occurs
            DF_END:begin                 //debug always read 2
                reg_right <= 0;
                if(!emu_fifo_almost_empty)begin
                    reg_emu_fifo_rd_en <= 1;
                end
                else begin
                    reg_emu_fifo_rd_en <= 0;
                end
                if(!dut_fifo_almost_empty)begin
                    reg_dut_fifo_rd_en <= 1;
                end
                else begin
                    reg_dut_fifo_rd_en <= 0;
                end
                state <= DF_END;
            end
         
            
            endcase
        end
    end
    
    
endmodule
