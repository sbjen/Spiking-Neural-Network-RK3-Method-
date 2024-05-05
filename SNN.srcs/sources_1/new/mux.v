`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 13:51:51
// Design Name: 
// Module Name: mux
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


module mux(
    input [31:0] data_in_1,
    input [31:0] data_in_2,
    input [31:0] data_in_3,
    input s1,
    input s2,
    input s3,
    output reg [31:0] data_out
    );

always @(*) begin
    case ({s3, s2, s1})
        3'b000 : data_out = data_in_1;
        3'b001 : data_out = data_in_2;
        3'b010 : data_out = data_in_3;
       
        default : data_out = 32'hXXXX_XXXX; // Default value
    endcase
end
endmodule
