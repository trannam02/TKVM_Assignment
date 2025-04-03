`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 09:59:46 PM
// Design Name: 
// Module Name: CPU_tb
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

module CPU_tb;
    reg clk;
    reg reset;
    
    // Instantiate the CPU module
    CPU uut (
        .clk(clk),
        .reset(reset)
    );
    
    // Clock generation
    always #5 clk = ~clk; // 10ns period
    
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        
        // Apply reset
        #10;
        reset = 0;
        
        // Wait for a few cycles
        #400;
        
        // End simulation
        $stop;
    end
    
    initial begin
        $dumpfile("CPU_tb.vcd");
        $dumpvars(0, CPU_tb);
    end
    
endmodule
