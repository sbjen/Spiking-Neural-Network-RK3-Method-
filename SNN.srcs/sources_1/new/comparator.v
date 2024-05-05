`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2024 12:49:38
// Design Name: 
// Module Name: comparator
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


module comparator #
(
    parameter [31:0] vth = 32'hABCDEF00
)

(

    input [7:0] vnew,
    output reg result

    );
    
    
    
    
always @* begin
    if (vnew > vth)
        result = 1;
    else
        result = 0;
end
endmodule
