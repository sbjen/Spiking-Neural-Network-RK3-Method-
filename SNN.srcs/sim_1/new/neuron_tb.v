`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2024 15:33:15
// Design Name: 
// Module Name: neuron_tb
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

module neuron_tb;
    // Parameters for configuring the neuron module
    localparam Q = 15;
    localparam N = 32;
    localparam vr = 32'hABCDEF00;
    localparam ge = 32'h11111111;
    localparam Eexe = 32'h22222222;
    localparam Einh = 32'h33333333;
    localparam gi = 32'h44444444;



    // Define signals
    reg s1, s2, s3;
    reg [N-1:0] v;
    reg clk, reset;
    wire spike;
    wire [N-1:0] vnew;

    // Instantiate the neuron module
    spike_neuron #() neuron_inst (
        .s1(s1),
        .s2(s2),
        .s3(s3),
        .v(v),
        .clk(clk),
        .reset(reset),
        .spike(spike),
        .vnew(vnew)
    );
initial begin         clk = 1'b0;
end

initial begin

        reset = 1'b1; // Assert reset

        // Wait for a few clock cycles
        #10;

        // Release reset
        reset = 1'b0;   
        
    
   end 
    // Clock generation
    always #5 clk = ~clk; // Toggle the clock every 5 time units

    // Stimulus generation
    initial begin
        // Initialize inputs
        s1 = 1'b0;
        s2 = 1'b0;
        s3 = 1'b0;
        v = 32'h00000001; // Initialize v to 0
        #10;
        v = 32'd15;//h00000001; // Initialize v to 0
        #10;
        v = 32'd2;//000000001; // Initialize v to 0
        #10;
        v = 32'd20;//00000001; // Initialize v to 0
        #10;
        v = 32'd17;//00000001; // Initialize v to 0


        // Apply stimulus
        // Example: Change inputs and observe outputs
        #20;
        s1 = 1'b0;
        s2 = 1'b0;
        s3 = 1'b1;
         // Change v value
        #20;
        s1 = 1'b0;
        s2 = 1'b1;
        s3 = 1'b0;
         // Change v value

        // Add more stimulus as needed

        // End simulation
        #200;
        $finish;
    end
endmodule

