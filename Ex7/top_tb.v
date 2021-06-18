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

    reg [2:0] colour_required = 3'b001;               // "Correct" colour (From lights)
    reg [23:0] rgb_required = 24'h0;                // "Correct" colour (From converter)
    reg [23:0] light_required  = 24'hFFFFFF;       // "Correct" light colour (From Mux)
    
    reg err = 1'b0;                        // Error flag
    
    wire [2:0] colour;
    wire [23:0] rgb;
    wire [23:0] light;       // Final output
    

    //Clock generation & colour changing
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
    // 6. if sel=1'b0: light=white done
    // 7. if sel=1'b1: light = rgb input done
    
    // ********* start from output (sel = 0) and work backwards (sel =1), then work backwards for colour
    
    // PART 1: Toggle selector on off to check for white light
    initial
    begin
        #(CLK_PERIOD * 3);
        sel <= ~ sel;
        #(CLK_PERIOD * 4);
        rst <= ~ rst;
        #(CLK_PERIOD * 8);
        rst <= ~ rst;
    end
    
    
    // PART 2: Press button
    initial
    begin
       forever
        begin
            #(CLK_PERIOD);
            button <=~ button;
        end
    end
    
    
    
    
    // LOGIC TO CHECK FOR TESTS PASSING
    
    // OVERALL TESTS CHECKER
    always @ (posedge clk)
    begin
    #(CLK_PERIOD * 2);
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
          
    
    // TEST 1: CHECK LIGHT SEL
    always
    begin
        #(CLK_PERIOD);
        if (sel == 1'b0)
            light_required <= 24'hFFFFFF;
        else
            light_required <= rgb_required;
    end
    
    
    // TEST 2: CHECK RGB CONVERSION
    always @ (posedge clk)
    begin
        case(colour)
            3'b111: 
                #CLK_PERIOD
                rgb_required <= 24'hFFFFFF;
                
            3'b110: 
                #CLK_PERIOD
                rgb_required <= 24'hFFFF00;
                
            3'b101: 
                #CLK_PERIOD
                rgb_required <= 24'hFF00FF;
                
            3'b100: 
                #CLK_PERIOD
                rgb_required <= 24'hFF0000;
                
            3'b011:
                #CLK_PERIOD
                rgb_required <= 24'h00FFFF;
                
            3'b010:
                #CLK_PERIOD
                rgb_required <= 24'h00FF00;       
                
            3'b001:
                #CLK_PERIOD
                rgb_required <= 24'h0000FF;       
                
            3'b000:
                #CLK_PERIOD
                rgb_required <= 24'h000000; 
                
            default:        // Failsafe, should return error if this is executed
            begin
//                $display("Default triggered!");
                #CLK_PERIOD
                rgb_required <= rgb_required; 
            end
                
        endcase
    end
          



    // TEST 3: CHECK RESET BUTTON & COLOUR CYCLING
    always
    begin
        #(CLK_PERIOD);
        if (rst == 1'b1)
            colour_required <= 3'b001;
        
        else
            if(button == 1'b1)
                colour_required <= (colour_required == 3'd6)? 3'b001 : colour_required + 3'b001;
            else
                colour_required <= colour_required;
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
        .light (light),
        .colour (colour),
        .rgb (rgb)
     );
    
endmodule 