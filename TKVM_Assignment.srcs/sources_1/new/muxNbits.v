`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 05:53:05 PM
// Design Name: 
// Module Name: muxNbits
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


module muxNbits
#(parameter N=5)(
    input [N-1:0] in_0, in_1,
    input sel,
    output [N-1:0] out
);
assign out = sel ? in_1 : in_0;
endmodule
