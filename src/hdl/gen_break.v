`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2023 01:01:04 PM
// Design Name: 
// Module Name: gen_break
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


module gen_break(
    input       [0:0]       clk,
    input       [0:0]       resetn,
    input       [0:0]       irq2,
    input       [0:0]       irq2_full,
    input       [0:0]       wenable,
    input       [0:0]       isMMIO,
    input       [0:0]       turn2run,
    output      [0:0]       break_encore,
    output      [0:0]       irq_mmio,
    output      [2:0]       debug_state
);

    reg     [0:0]       break_mmio;
    reg     [2:0]       state;

    assign debug_state = state;
    assign irq_mmio = break_mmio;
    assign break_encore = irq2 || irq2_full || break_mmio;
    always@(posedge clk)begin
        if(!resetn)begin
            break_mmio <= 0;
            state <= 0;
        end
        else begin
            case(state)
                0:begin
                    //Ready
                    break_mmio <= 0;
                    state <= 1;
                end
                1:begin
                    if(isMMIO && wenable)begin
                        if(irq2)begin
                            state <= 3;
                            break_mmio <= 1;
                        end
                        else begin
                            state <= 2;
                            break_mmio <= 1;
                        end   
                    end
                    else begin
                        state <= 1;
                        break_mmio <= break_mmio;
                    end
                end
                2:begin //mmio stall
                    if(turn2run)begin
                        state <= 0;
                        break_mmio <= 0;
                    end
                    else begin
                        state <= 2;
                        break_mmio <= break_mmio;
                    end
                end
                3:begin     //can be delete
                    if(turn2run)begin
                        state <= 4;
                    end
                    else begin
                        state <= 3;
                    end
                end
                4:begin
                    if(!irq2)begin
                        state <= 5;
                        break_mmio <= 0;
                    end
                    else begin
                        state <= 4;
                        break_mmio <= break_mmio;
                    end
                end
                5:begin
                    state <= 0;
                end   
            endcase

        end
    end
endmodule