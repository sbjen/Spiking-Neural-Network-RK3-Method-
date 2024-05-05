`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2024 12:30:30
// Design Name: 
// Module Name: mux2o1
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


module mux2o1

(
    input [31:0] vr,
    input [31:0] vnew,
    input s,
    output reg [31:0] data_out
 );
    
    
    always @(*) begin
    case ({s})
        3'b0 : data_out = vr;
        3'b1 : data_out = vnew;
        default : data_out = 32'hXXXX_XXXX; 
    endcase
end
    
    
endmodule
