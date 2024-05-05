`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2024 10:35:14
// Design Name: 
// Module Name: neuron
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


module neuron #(

    parameter Q = 15,
    parameter N = 32,
//    parameter [N-1:0] v = 32'h12345678,
    parameter [N-1:0] vr = 32'hABCDEF00,
    parameter [N-1:0] ge = 32'h11111111,
    parameter [N-1:0] Eexe = 32'h22222222,
    parameter [N-1:0] Einh = 32'h33333333,
    parameter [N-1:0] gi = 32'h44444444

)

(
    input s1,
    input s2,
    input s3,
    input [N-1:0] v,
    input clk,
    input reset,
    output spike,
    output [N-1:0] vnew

    );
    
   reg [N-1:0]  mux_inp2  ;
   reg [N-1:0] mux_inp3 ;
   wire [N-1:0] mux_out ;
   
//   always @(posedge clk or posedge reset)
//   begin
//    if (reset) begin
//        mux_inp2 <= 32'h0000_0000;
//        mux_inp2 <= 32'h0000_0000;
//    end

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        mux_inp2 = 32'b0;
        mux_inp3 = 32'b0_;
        // Any other initialization or reset actions
    end
//     else begin
//        // Non-reset condition

//        // Any other non-reset logic
//    end
end





// 1 mux   




   
    mux _mux(
    .data_in_1(v),
    .data_in_2(mux_inp2),
    .data_in_3(mux_inp3),
    .s1(s1),
    .s2(s2),
    .s3(s3),
    .data_out(mux_out)
);

wire [N-1:0] current_mod_out;
wire [N-1:0] current_mod_out_sift;

// 2 current module 

    current_module _current_inst (
        .v(v),
        .vr(vr),
        .ge(ge),
        .Eexe(Eexe),
        .Einh(Einh),
        .gi(gi),
        .o_result(current_mod_out)
    );
    
// 3 SHIFT
 assign current_mod_out_sift = current_mod_out >> 6;
 
 // 4 DEMUX
 reg [N-1:0] k1;
 reg [N-1:0] k2;
 reg [N-1:0] k3;
 
 wire [N-1:0] _k1;
 wire [N-1:0] _k2;
 wire [N-1:0] _k3;
 
     demux _demux(
        .data_in(current_mod_out_sift),
        .s1(s1),
        .s2(s2),
        .s3(s3),
        .data_out_1(_k1),
        .data_out_2(_k2),
        .data_out_3(_k3),
        .clk(clk),
        .reset(reset)
    );
    
    always@(_k1,_k2,_k3) begin 
    k1 = _k1;
    k2 = _k2;
    k3 = _k3;
    end
    
    wire [N-1:0] k1Rshift2;
    wire [N-1:0] k1Rshift1;
    wire [N-1:0] k2Lshift2;

    assign k1Rshift2 = k1 >> 2; // 5.1 mux input 2 
    assign k1Rshift1 = k1 >> 1;// 6.1 mux input 3 
    assign k2Lshift2 = k1 << 2; // 7.1
    
   // 5.2 mux input 2 
   
   wire [N-1:0]_level5_adder_out;
    
   qadd #(
   .N(N)
   )
   _level5_adder
   (
   .a(v),
   .b(k1Rshift2),
   .c(_level5_adder_out)
   );
   
   
  
   // 6.1 mux input 3 
   wire [N-1:0] _level6_add_out;
   qadd #(
   .N(N)
   )
   _level6_adder
   (
   .a(v),
   .b(k2),
   .c(_level6_add_out)
   );
   
   //6.2 subtractor 
   wire [N-1:0] k1Rshift1_neg;
    assign k1Rshift1_neg = k1Rshift1;
               
    wire [N-1:0]_level6_subt_out;
    qadd #(
   .N(N)
   )
   _level6_subt
   (
   .a(_mux_inp3_add_out),
   .b(k1Rshift1_neg),
   .c(_level6_subt_out)
   );
   // 
   
//   onchange modifying input to mux 

always @(_level5_adder_out,_level6_subt_out) 
    begin
    mux_inp2 = _level5_adder_out;
    mux_inp3 = _level6_subt_out;
    end

   // 7.2  aader
   
   wire [N-1:0] _level72_add_out;
   qadd #(
   .N(N)
   )
   level72_add
   (
   .a(k1),
   .b(k3),
   .c(_level72_add_out)
   );
   
   
   
    // level 7.2.1
    
   wire [N-1:0] _level721_add_out;
   qadd #(
   .N(N)
   )
   level8_add
   (
   .a(k2Lshift2),
   .b(_level72_add_out),
   .c(_level721_add_out)
   );
   
   // level 8 
   
   wire level8_shift4 = _level721_add_out >> 4;// 8.1.1
   wire level8_shift6 = _level721_add_out >> 6;// 8.1.2
   wire level8_shift8 = _level721_add_out >> 8;//8.1.3


// 8.2.1 

   wire [N-1:0] _level821_add_out;
   qadd #(
   .N(N)
   )
   level821_add
   (
   .a(v),
   .b(level8_shift4),
   .c(_level821_add_out)
   );
   
 // 8.2.2
   wire [N-1:0] _level822_add_out;
   qadd #(
   .N(N)
   )
   level822_add
   (
   .a(level8_shift6),
   .b(level8_shift8),
   .c(_level822_add_out)
   );
 
 // 8.2.3
 
   wire [N-1:0] spike_inp;
   qadd #(
   .N(N)
   )
   level83_add
   (
   .a(_level821_add_out),
   .b(_level822_add_out),
   .c(spike_inp)
   );
 
 // spike detection level 9
 
 //9.1
     mux2o1 _spike_mux (
        .vr(vr),
        .vnew(vnew),
        .s(spike),
        .data_out(vnew)
    );
    // 9.2
        comparator #(
        .vth(32'hABCDEF00) // Set parameter vth to 32'hABCDEF00
    ) spike_comp (
        .vnew(vnew),
        .result(spike)
    );
  
 
 
  
 
   
   

endmodule
