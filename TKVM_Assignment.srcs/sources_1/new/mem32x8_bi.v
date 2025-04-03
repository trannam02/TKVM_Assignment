`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 04:54:00 PM
// Design Name: 
// Module Name: Memory 38x8 bidirectional
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

module memory32x8_bi
(
    input clk, rw, en,
    input [4:0] addr,
    inout [7:0] data
);
reg [7:0] memory [31:0];
reg [7:0] data_out;

initial begin
$readmemh("output.mem", memory);
end;

assign data = (en & !rw) ? (data_out) : 8'bz;

always @(posedge clk) begin
    if(en)
        if(!rw)
            data_out <= memory[addr];
        else if(rw)
            memory[addr] <= data; 
end
endmodule
