`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 05:35:43 PM
// Design Name: 
// Module Name: controller
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


module controller (
    input wire clk,           // Clock signal
    input wire reset,         // Reset signal
    input wire [2:0] opcode,  // Opcode (3 bits to encode ADD, AND, XOR, LDA, etc.)
    input wire is_zero,          // Zero flag for SKZ (skip if zero)
    output reg sel,           // Select signal
    output reg rd,            // Read signal
    output reg ld_ir,         // Load instruction register
    output reg halt,          // Halt signal
    output reg inc_pc,        // Increment program counter
    output reg ld_ac,         // Load accumulator
    output reg ld_pc,         // Load program counter
    output reg wr,            // Write signal
    output reg wr_data_e     // Write data enable
);

    // State encoding
    localparam INST_ADDR = 3'b000,
               INST_FETCH = 3'b001,
               INST_LOAD  = 3'b010,
               IDLE       = 3'b011,
               OP_ADDR    = 3'b100,
               OP_FETCH   = 3'b101,
               ALU_OP     = 3'b110,
               STORE      = 3'b111;

    // Opcode encoding (example)
    localparam OP_HLT = 3'b000,
               OP_SKZ = 3'b001,
               OP_ADD = 3'b010,
               OP_AND = 3'b011,
               OP_XOR = 3'b100,
               OP_LDA = 3'b101,
               OP_STO = 3'b110,
               OP_JMP = 3'b111;
               

    // State register
    reg [2:0] current_state, next_state;

    // State transition (sequential logic)
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= INST_ADDR; // Reset to INST_ADDR
        else
            current_state <= next_state;
    end

    // Next state logic (combinational)
    always @(*) begin
        case (current_state)
            INST_ADDR: next_state = INST_FETCH;
            INST_FETCH: next_state = INST_LOAD;
            INST_LOAD: next_state = IDLE;
            IDLE: next_state = OP_ADDR;
            OP_ADDR: next_state = OP_FETCH;
            OP_FETCH: next_state = ALU_OP;
            ALU_OP: next_state = STORE;
            STORE: next_state = INST_ADDR; // Loop back to start
            default: next_state = INST_ADDR;
        endcase
    end

    // Output logic (combinational)
    always @(*) begin
        // Default outputs
        sel = 0;
        rd = 0;
        ld_ir = 0;
        halt = 0;
        inc_pc = 0;
        ld_ac = 0;
        ld_pc = 0;
        wr = 0;
        wr_data_e = 0;


        case (current_state)
            INST_ADDR: begin
                sel = 1;
                rd = 0;
                ld_ir = 0;
                halt = 0;
                inc_pc = 0;
                ld_ac = 0;
                ld_pc = 0;
                wr = 0;
                wr_data_e = 0;
            end
            INST_FETCH: begin
                sel = 1;
                rd = 1;
                ld_ir = 0;
                halt = 0;
                inc_pc = 0;
                ld_ac = 0;
                ld_pc = 0;
                wr = 0;
                wr_data_e = 0;
            end
            INST_LOAD: begin
                sel = 1;
                rd = 1;
                ld_ir = 1;
                halt = 0;
                inc_pc = 0;
                ld_ac = 0;
                ld_pc = 0;
                wr = 0;
                wr_data_e = 0;
            end
            IDLE: begin
                sel = 1;
                rd = 1;
                ld_ir = 1;
                halt = 0;
                inc_pc = 0;
                ld_ac = 0;
                ld_pc = 0;
                wr = 0;
                wr_data_e = 0;
            end
            OP_ADDR: begin
                sel = 0;
                rd = 0;
                ld_ir = 0;
                halt = (opcode == OP_HLT) ? 1 : 0; // HALT if opcode is HLT
                inc_pc = 1;
                ld_ac = 0;
                ld_pc = 0;
                wr = 0;
                wr_data_e = 0;
            end
            OP_FETCH: begin
                sel = 0;
                rd = (opcode == OP_ADD || opcode == OP_AND || opcode == OP_XOR || opcode == OP_LDA) ? 1 : 0;
                ld_ir = 0;
                halt = 0;
                inc_pc = 0;
                ld_ac = 0;
                ld_pc = 0; // JMP sets ld_pc
                wr = 0;
                wr_data_e = 0;
            end
            ALU_OP: begin
                sel = 0;
                rd = (opcode == OP_ADD || opcode == OP_AND || opcode == OP_XOR || opcode == OP_LDA) ? 1 : 0;
                ld_ir = 0;
                halt = 0;
                inc_pc = (opcode == OP_SKZ && is_zero == 1) ? 1 : 0;
                ld_ac = 0; // ALU_OP always loads accumulator
                ld_pc = (opcode == OP_JMP) ? 1 : 0; // JMP sets ld_pc
                wr = 0;
                wr_data_e = (opcode == OP_STO) ? 1 : 0;
            end
            STORE: begin
                sel = 0;
                rd = (opcode == OP_ADD || opcode == OP_AND || opcode == OP_XOR || opcode == OP_LDA) ? 1 : 0;
                ld_ir = 0;
                halt = 0;
                inc_pc = 0;
                ld_ac = (opcode == OP_ADD || opcode == OP_AND || opcode == OP_XOR || opcode == OP_LDA) ? 1 : 0;
                ld_pc = (opcode == OP_JMP) ? 1 : 0;
                wr = (opcode == OP_STO) ? 1 : 0; // STO sets wr
                wr_data_e = (opcode == OP_STO) ? 1 : 0; // STO sets wr_data_e
            end
        endcase
    end

endmodule
