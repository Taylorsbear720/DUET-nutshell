`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2022 10:47:06 AM
// Design Name: 
// Module Name: interruption_logic_v1reg
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

module interruption_logic_v1reg(
//`ifdef MODEL_TECH   
//	input 				clk_en,
//	input [31:0] 		breakpoint,
//	input [63:0]  		breakpoint_reg_64,
//	input 				rst,
//`endif
	input 				sys_clk,
    input               sys_resetn,
	input [63:0] 		reg_64_monitor,
	input               difftest_break,
	input               dut_valid,
	
	output 				task_clk,
	output              sig_break,
	output              sig_break2,
	output              debug_break_df
);

	reg [63:0] 			counter;
	reg 				break;
	wire                break2;
	reg                 break_df;
	reg                 break_df_buf1;
	reg                 break_df_buf2;
	assign sig_break = break;
	assign sig_break2 = break2;
	assign debug_break_df = break_df;
	
//`ifndef MODEL_TECH
	wire 				clk_en;
	wire [63:0] 		breakpoint;
	wire [63:0] 		breakpoint_reg_64;
//`endif
    assign break2 = (reg_64_monitor == breakpoint_reg_64)?1'b1:1'b0;
    
//`ifndef MODEL_TECH
	vio_0 il_vio (
		.clk			(sys_clk),
		.probe_out0		(breakpoint),
		.probe_out1		(clk_en),

		.probe_out2		(breakpoint_reg_64)
	);
//`endif
   
   always @(posedge sys_clk)begin
        if(!sys_resetn)begin
            break_df <= 0;
        end
        else begin
            break_df <= difftest_break;
        end 
   end
   //always @(posedge sys_clk)begin
   //if(!sys_resetn)begin
   //    break_df <= 0; 
   //    break_df_buf1 <= 0;
   //    break_df_buf2 <= 0;
   //end
   //else begin
   //    if(difftest_break)begin
   //        break_df_buf1 <= 1;
   //        break_df_buf2 <= break_df_buf1;
   //        break_df <= break_df_buf2;
   //    end
   //    else begin
   //        break_df <= 0;
   //        break_df_buf1 <= 0;
   //        break_df_buf2 <= 0;
   //    end
   //end
   //end
    
	always @(posedge sys_clk)
	begin
		if (!sys_resetn)
		begin
			counter <= 0;
			break <= 1'b0;
		end
		else if (clk_en)
		begin
			if (counter == breakpoint)
			begin
				break <= 1'b1;
			end
			else
			begin
				counter <= counter + 1;
				break <= 1'b0;
			end
		end
	end

    //always @(posedge sys_clk)
    //begin
    //    if(!sys_resetn)
    //    begin
    //        break2 <= 1'b0;
    //    end
    //    else if(clk_en)
    //    begin
    //        if (reg_64_monitor == breakpoint_reg_64)
    //        begin
    //            break2 <= 1'b1;
    //        end
    //        else ;
    //    end
    //    
    //
    //end
    
    
	BUFGCE inst_bufgce (
		.O(task_clk),
		.I(sys_clk),
		.CE(clk_en & ~break & ~break2 &~break_df) //no break 2
	);

endmodule
