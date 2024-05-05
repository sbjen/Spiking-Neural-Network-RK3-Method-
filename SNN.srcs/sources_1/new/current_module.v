`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2024 12:00:01
// Design Name: 
// Module Name: current_module
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


module current_module #(
	parameter Q = 15,
	parameter N = 32
)(
     input			[N-1:0]	v,
	 input			[N-1:0]	vr,
	 input			[N-1:0]	ge,
	 input			[N-1:0]	Eexe,
	 input			[N-1:0]	Einh,
	 input			[N-1:0]	gi,	 	 
	 output			[N-1:0]	o_result
//	 output	reg				ovr
    
    );
    wire [N-1:0] vr_neg; // to subtract adding addition minus sign
    assign vr_neg = vr;
    assign  vr_neg[N-1] = -vr[N-1];
    wire [N-1:0] sub_out_1;
    
    // need to change sign of vr 
    qadd #(
   .N(N)
   )
   inst1
   (
   .a(v),
   .b(vr_neg),
   .c(sub_out_1)
   );
   
    wire [N-1:0] Eexe_neg; // to subtract adding addition minus sign
    assign Eexe_neg = Eexe;
    assign  Eexe_neg[N-1] = -Eexe[N-1];
    wire [N-1:0] sub_out_2;
   
       qadd #(
   .N(N)
   )
   inst2
   (
   .a(v),
   .b(Eexe_neg),
   .c(sub_out_2)
   );
   
   
     wire [N-1:0] Einh_neg; // to subtract adding addition minus sign
    assign Einh_neg = Einh;
    assign  Einh_neg[N-1] = -Einh[N-1];
    wire [N-1:0] sub_out_3;
   
   
       qadd #(
   .N(N)
   )
   inst3
   (
   .a(v),
   .b(Einh_neg),
   .c(sub_out_3)
   );
   
   
    wire [N-1:0] mul_out_1;
   qmult #()
   mult_inst1
   (
   .i_multiplicand(ge),
   .i_multiplier(sub_out_2),
   .o_result(mul_out_1)
   );
    
    
    
   wire [N-1:0] mul_out_2;
   qmult #()
   mult_inst2
   (
   .i_multiplicand(gi),
   .i_multiplier(sub_out_3),
   .o_result(mul_out_2)
   );
   
   
   
    wire [N-1:0] add_out_level3;
   qadd #(
   .N(N)
   )
   inst4
   (
   .a(mul_out_1),
   .b(mul_out_2),
   .c(add_out_level3)
   );
   
   
      
   wire [N-1:0] add_out_level4;
   qadd #(
   .N(N)
   )
   inst5
   (
   .a(sub_out_1),
   .b(add_out_level3),
   .c(o_result)
   );
    
    
endmodule
