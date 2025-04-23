`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 04:54:00 PM
// Design Name: 
// Module Name: CPU
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


module CPU(
    input wire clk,
    input wire reset,
    output wire [4:0] pc_debug,        // Program Counter (for debug/output)
    output wire [7:0] ac_debug,        // Accumulator
    output wire [7:0] ir_debug,        // Instruction Register
    output wire halt_flag              // HALT signal
);

wire [4:0] pc_out, mem_addr, jump_to_addr;
wire [7:0] mem_in_out, alu_out, ac_out, ir_out;
wire [2:0] opcode;
wire sel, rd, ld_ir, inc_pc, ld_ac, ld_pc, wr, wr_data_e, halt;

wire is_zero;
wire clock;

// Some output
assign pc_debug = pc_out;
assign ac_debug = ac_out;
assign ir_debug = ir_out;
assign halt_flag = halt;
//=============

assign clock = (halt == 1) ? 1'b0 : clk;

counterNbits #(.N(5)) pc (
    .clk(clock),
    .rst(reset),
    .inc(inc_pc),
    .load(ld_pc),
    .preset(ir_out[4:0]),
    .out(pc_out)
);
muxNbits #(.N(5)) muxx (
    .sel(sel),
    .in_0(ir_out[4:0]),
    .in_1(pc_out),
    .out(mem_addr)
);
wire rw = (wr == 1'b1) ? 1 : 0;
//assign mem_in_out = rw ? ac_out : mem_in_out;
bufferNbits #(.N(8)) buff(
    .in(ac_out),
    .en(rw),
    .out(mem_in_out)
);
//wire en = (rd || wr) ? 1 : 0;
memory32x8_bi mem (
    .clk(clock),
    .rw(rw),
    .en(1'b1),
    .addr(mem_addr),
    .data(mem_in_out)
);

ALU alu (
    .inA(ac_out),
    .inB(mem_in_out),
    .opcode(ir_out[7:5]),
    .is_zero(is_zero),
    .result(alu_out)
);

registerNbits ir(
    .clk(clock),
    .rst(reset),
    .load(ld_ir),
    .in(mem_in_out),
    .out(ir_out)
);
registerNbits ac(
    .clk(clock),
    .rst(reset),
    .load(ld_ac),
    .in(alu_out),
    .out(ac_out)
);

controller ctrl (
    .clk(clock),
    .reset(reset),
    .opcode(ir_out[7:5]),
    .is_zero(is_zero),
    .sel(sel),
    .rd(rd),
    .ld_ir(ld_ir),
    .halt(halt),
    .inc_pc(inc_pc),
    .ld_ac(ld_ac),
    .ld_pc(ld_pc),
    .wr(wr),
    .wr_data_e(wr_data_e)
 );

endmodule
