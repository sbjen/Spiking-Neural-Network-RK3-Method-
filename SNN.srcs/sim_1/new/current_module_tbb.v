`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 12:39:57
// Design Name: 
// Module Name: current_module_tbb
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


module current_module_tbb;

    parameter Q = 15;
    parameter N = 32;

    // Signals
    reg [N-1:0] v, vr, ge, Eexe, Einh, gi;
    wire [N-1:0] o_result;
    
       current_module #(
        .Q(Q),
        .N(N)
    ) dut (
        .v(v),
        .vr(vr),
        .ge(ge),
        .Eexe(Eexe),
        .Einh(Einh),
        .gi(gi),
        .o_result(o_result)
    );
    
    
       // Stimulus
    initial begin
        // Stimulus generation
        // You can modify these values or add more stimulus as needed
        v = 32'h12345678;
        vr = 32'h87654321;
        ge = 32'hABCDEF12;
        Eexe = 32'hABC12345;
        Einh = 32'h54321ABC;
        gi = 32'h87654321;

        // Add delay for stimulus to settle
        #10;

        // Display inputs
        $display("Input v: %h", v);
        $display("Input vr: %h", vr);
        $display("Input ge: %h", ge);
        $display("Input Eexe: %h", Eexe);
        $display("Input Einh: %h", Einh);
        $display("Input gi: %h", gi);

        // Add delay for processing in the module
        #10;

        // Display output
        $display("Output o_result: %h", o_result);

        // Add any other desired checks or actions here
    end

    // Add any necessary clocks or other stimulus here

    
    
    
endmodule
