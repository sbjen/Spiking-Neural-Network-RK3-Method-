`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 10:34:48
// Design Name: 
// Module Name: qadd_tb
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


`timescale 1ns / 1ps

module qadd_tb();

    // Parameters
    parameter N = 32;

    // Signals
    reg [N-1:0] a;
    reg [N-1:0] b;
    wire [N-1:0] c;

    // Instantiate the module
    qadd #(
        .N(N)
    ) uut (
        .a(a),
        .b(b),
        .c(c)
    );

    // Clock generation
    reg clk;
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        $dumpfile("qadd_tb.vcd");
        $dumpvars(0, qadd_tb);

        // Initialize inputs
        a = 32'b00000000000000000000000000000000;
        b = 32'b00000000000000000000000000000000;

        // Test addition of two positive numbers
        #10;
        a = 32'b01000000000000000000000000000101; // 5
        b = 32'b01000000000000000000000000000110; // 6
        #10;
        $display("a + b = %b", c);

        // Test addition of two negative numbers
        a = 32'b11000000000000000000000000000101; // -5
        b = 32'b11000000000000000000000000000110; // -6
        #10;
        $display("a + b = %b", c);

        // Test subtraction of two positive numbers
        a = 32'b01000000000000000000000000000110; // 6
        b = 32'b01000000000000000000000000000101; // 5
        #10;
        $display("a - b = %b", c);

        // Test subtraction of two negative numbers
        a = 32'b11000000000000000000000000000110; // -6
        b = 32'b11000000000000000000000000000101; // -5
        #10;
        $display("a - b = %b", c);

        // Test subtraction of a positive and a negative number
        a = 32'b01000000000000000000000000000110; // 6
        b = 32'b11000000000000000000000000000101; // -5
        #10;
        $display("a - b = %b", c);

        // Test subtraction of a negative and a positive number
        a = 32'b11000000000000000000000000000110; // -6
        b = 32'b01000000000000000000000000000101; // 5
        #10;
        $display("a - b = %b", c);
                // Finish simulation
        #10;
        $finish;
    end

endmodule

