`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 04:54:00 PM
// Design Name: 
// Module Name: Register
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


module registerNbits
#(parameter N = 8)
(
    input [N-1:0] in,
    input clk, rst, load,
    output reg [N-1:0] out
);

always @(posedge clk) begin
    if(rst)
        out <= 0;
    else if(load)
        out <= in;
end
endmodule
