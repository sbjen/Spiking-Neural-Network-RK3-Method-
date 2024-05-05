`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2024 18:00:47
// Design Name: 
// Module Name: sneuron
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


module sneuron  #(

    parameter Q = 15,
    parameter N = 32,
//    parameter [N-1:0] v = 32'h12345678,
    parameter [N-1:0] vr = 32'hABCDEF00,
    parameter [N-1:0] ge = 32'h11111111,
    parameter [N-1:0] Eexe = 32'h22222222,
    parameter [N-1:0] Einh = 32'h33333333,
    parameter [N-1:0] gi = 32'h44444444

)(
    input s1,
    input s2,
    input s3,
    input [N-1:0] v,
    input clk,
    input reset,
    output spike,
    output [N-1:0] vnew
    );
    
    
   reg [N-1:0]  mux_inp2 ;
   reg [N-1:0]  mux_inp3 ;
   wire [N-1:0]  mux_out ;
   
   always @(posedge clk or posedge reset)
   begin
    if (reset) begin
        mux_inp2 <= 32'b0;
        mux_inp3 <= 32'b0;
    end
    end
    
    

 
endmodule
