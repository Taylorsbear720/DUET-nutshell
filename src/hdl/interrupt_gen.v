`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/21 17:46:39
// Design Name: 
// Module Name: interrupt_gen
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


module interrupt_gen(
input 				sys_clk,
input               full_break,
output              en,
output              nutshell_clk

    );
    
 	wire 				clk_en;  
 	
 	 
    vio_0  il_vio (
		.clk			(sys_clk),
		.probe_out0	(clk_en)
	);
assign en = clk_en;

BUFGCE inst_bufgce (
		.O(nutshell_clk),
		.I(sys_clk),
		.CE(clk_en & ~full_break) //no break 2
	);
endmodule
