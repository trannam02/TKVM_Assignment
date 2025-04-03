`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 04:53:30 PM
// Design Name: 
// Module Name: counterNbits
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


module counterNbits
#(parameter N = 5)
(
    input clk, rst, load,
    input [N-1:0] preset,
    input inc,
    output reg [N-1:0] out = 0
);

always @(posedge clk or posedge rst) begin
    if (rst)
        out <= 5'b0;
    else if (load)
        out <= preset;
    else if (inc)
        out <= out + 1;
end

endmodule
