`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 04:54:00 PM
// Design Name: 
// Module Name: ALU
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


module ALU (
    input [7:0] inA,
    input [7:0] inB,
    input [2:0] opcode,
    output reg [7:0] result,
    output reg is_zero
);

localparam HLT = 3'b000;
localparam SKZ = 3'b001;
localparam ADD = 3'b010;
localparam AND = 3'b011;
localparam XOR = 3'b100;
localparam LDA = 3'b101;
localparam STO = 3'b110;
localparam JMP = 3'b111;

always @(*) begin
    case (opcode)
        HLT: begin
            result = inA;
        end
        SKZ: begin
            if (inA == 8'b00000000) begin
                is_zero = 1'b1;
            end else begin
                is_zero = 1'b0;
            end
        end
        ADD: begin
            result = inA + inB;
        end
        AND: begin
            result = inA & inB;
        end
        XOR: begin
            result = inA ^ inB;
        end
        LDA: begin
            result = inB;
        end
        STO: begin
            result = inA;
        end
        JMP: begin
            result = inA;
        end
        default: begin
            result = inA;
        end
    endcase

    is_zero = (inA == 8'b00000000) ? 1'b1 : 1'b0;
end

endmodule
