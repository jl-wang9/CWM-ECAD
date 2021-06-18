//////////////////////////////////////////////////////////////////////////////////
// Exercise #6 - RGB Colour Converter
// Student Name: Jiale Wang (Somerville)
// Date:  17/06/21
//
//
//  Description: In this exercise, you need to design a memory with 8 entries, 
//  converting colours to their RGB code.
//
//  inputs:
//           clk, colour [2:0], enable
//
//  outputs:
//           rgb [23:0]
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module colour_led (
    //Todo: add ports 
    input [2:0]colour,
    input enable,
    input clk,

    output [23:0]rgb
    );

//Template from .veo file

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG

blk_mem_gen_0 your_instance_name (
  .clka(clk),       // input wire clka - CLOCK INPUT
  .ena(enable),     // input wire ena - ENABLE INPUT
  .wea(1'b0),      // input wire [0 : 0] wea - DEFAULT 0
  .addra(colour),  // input wire [2 : 0] addra - COLOUR INPUT
  .dina(24'b0),    // input wire [23 : 0] dina - DEFAULT 0 BUT 24-BIT
  .douta(rgb)      // output wire [23 : 0] douta - RGB OUTPUT
);

// INST_TAG_END ------ End INSTANTIATION Template ---------
    
endmodule
