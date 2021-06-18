//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name: Jiale Wang (Somerville)
// Date: 17/06/21
//
// Description: A testbench module to test Ex7 - Lights Selector
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module top_tb(
    );
    
    //Parameters
    parameter CLK_PERIOD = 10;

    //Registers and wires
    reg clk = 1'b0;
    reg rst = 1'b0;
    reg sel = 1'b0;
    reg button = 1'b0;

    reg [2:0] colour_required = 3'b0;               // "Correct" colour (From lights)
    reg [23:0] rgb_required = 24'h0;                // "Correct" colour (From converter)
    reg [23:0] light_required  = 24'hFFFFFF;       // "Correct" light colour (From Mux)
    
    reg err = 1'b0;                        // Error flag
    
    wire [2:0] colour;
    wire [23:0] rgb;
    wire [23:0] light;       // Final output
    

    //Clock generation
    initial
    begin
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
    

    //Stimulus logic
    // INPUTS: clk, rst, button, sel; OUTPUT: light
    
    // TODO: TESTS TO RUN
    // LIGHTS
    // 1. if rst=1'b1: colour = 3'b00
    // 2. if button=1'b0: colour unchanged
    // 3. lights cycle correctly
    // CONVERTER
    // 4. if enable=1'b0: rgb unchanged
    // 5. colour to converter = correct rgb out
    // MUX
    // 6. if sel=1'b0: light=white
    // 7. if sel=1'b1: light = rgb input
    
    // ********* start from output (sel = 0) and work backwards (sel =1), then work backwards for colour
    
    // PART 1: Toggle selector on off to check for white light
    initial
    begin
        #(CLK_PERIOD * 3);
        sel <= ~ sel;
        #(CLK_PERIOD * 4);
    end
    
    
    
    // LOGIC TO CHECK FOR TESTS PASSING
    
    // OVERALL TESTS CHECKER
    always
    begin
    #(CLK_PERIOD);
        if(light != light_required)
        begin
            err <= 1'b1;
            $display("***LIGHT TEST FAILED! :( *** Output wanted: %h, but got: %h. Check your selector.", light_required, light);
        end
        
        if(rgb != rgb_required)
        begin
            err <= 1'b1;
            $display("***RGB CONVERSION TEST FAILED! :( *** Output wanted: %h, but got: %h. This is either due to wrong colour conversion OR enable function working incorrectly.", rgb_required, rgb);
        end
        
        if(colour != colour_required)
        begin
            err <= 1'b1;
            $display("***COLOUR GENERATION TEST FAILED! :( *** Output wanted: %b, but got: %b. This is either due to wrong colour conversion OR enable function working incorrectly.", colour_required, colour);
        end
    end
          
          
          

    //Finish simulation and check for success
    initial begin
        #500 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
    end


    //User's modules
    // Top.v module
    assembled top (
        .clk (clk), 
        .rst (rst), 
        .sel (sel), 
        .button (button),
        .light (light)
     );
    
    // Lightsv 
    led top1 (
        .clk (clk), 
        .rst (rst), 
        .button (button),
        .colour (colour)
     );
     
    // Converter.v 
    colour_led top2 (
        .clk (clk),
        .colour (colour),
        .rgb (rgb),
        .enable (1'b1)         // Assume always enabled
     ); 
     
endmodule 
