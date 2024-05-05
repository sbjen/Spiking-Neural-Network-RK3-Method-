`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 13:52:58
// Design Name: 
// Module Name: demux
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

module demux(
    input [31:0] data_in,
    input s1,
    input s2,
    input s3,
    output reg [31:0] data_out_1,
    output reg [31:0] data_out_2,
    output reg [31:0] data_out_3,
    input clk,
    input reset
);

reg [31:0] prev_data_out_1;
reg [31:0] prev_data_out_2;
reg [31:0] prev_data_out_3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        prev_data_out_1 <= 32'h0000_0000;
        prev_data_out_2 <= 32'h0000_0000;
        prev_data_out_3 <= 32'h0000_0000;
    end
    else begin
        case ({s3, s2, s1})
            3'b000 : begin
                data_out_1 <= data_in;
                data_out_2 <= prev_data_out_2;
                data_out_3 <= prev_data_out_3;
            end
            3'b001 : begin
                data_out_1 <= prev_data_out_1;
                data_out_2 <= data_in;
                data_out_3 <= prev_data_out_3;
            end
            3'b010 : begin
                data_out_1 <= prev_data_out_1;
                data_out_2 <= prev_data_out_2;
                data_out_3 <= data_in;
            end
            // Add more cases if needed
            default : begin
                data_out_1 <= 32'hXXXX_XXXX; // Default value
                data_out_2 <= 32'hXXXX_XXXX;
                data_out_3 <= 32'hXXXX_XXXX;
            end
        endcase
        prev_data_out_1 <= data_out_1;
        prev_data_out_2 <= data_out_2;
        prev_data_out_3 <= data_out_3;
    end
end

endmodule

