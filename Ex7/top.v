//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name: Jiale Wang (Somerville)
// Date: 17/06/21
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module assembled (
    //Todo: add ports 
    input clk,
    input rst,
    input button,
    input sel,      // Selector

    output wire [23:0]light,
    output wire [2:0]colour,
    output wire [23:0]rgb
	);

    //Todo: Internal Carry Signals
    wire enable = 1'b1;
    wire [23:0]white = 24'hFFFFFF;   // White light


    //Todo: Link to external modules
    // Example: full_adder fa_bit0(Cin,A[0],B[0],Cinternal,S[0]);
    
    led lights_output(clk, rst, button, colour);
    
    colour_led converter_output(colour, enable, clk, rgb);
    
    doorbell multiplexer_output(white, rgb, sel, light);

endmodule
