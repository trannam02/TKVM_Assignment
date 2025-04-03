`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 11:31:22 PM
// Design Name: 
// Module Name: bufferNbits
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


module bufferNbits
#(parameter N=8)(
    input [N-1:0] in,
    input en,
    output [N-1:0] out
);
assign out = en ? in : 'bz;
endmodule
