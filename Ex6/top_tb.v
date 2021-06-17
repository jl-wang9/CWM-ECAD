//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name: Jiale Wang (Somerville)
// Date: 17/06/21
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );
    
    // Working in hexadecimal where 8-bit binary = 2-bit hexadecimal
    // 24-bit binary = 6-bit hexadecimal
    
    //Parameters
    parameter CLK_PERIOD = 10;

    //Registers and wires
    reg [2:0]colour = 3'b000;
    reg [23:0]rgb_required = 24'h000000;  // The "correct" rgb output to check against
    reg clk = 1'b0;
    reg enable = 1'b0;
    reg err = 1'b0;        // Error Flag

    wire [23:0]rgb;
    

    //Clock generation
    initial
    begin
       forever
         #(CLK_PERIOD/2) clk=~clk;
    end
    

     //Stimulus logic

    
    // PART 1: Periodically change colour fed into module and toggle enable on/off 
    
    initial
    begin
       forever
        begin
            #(CLK_PERIOD);
            colour <= colour + 3'b001;    // Overflow is automatically handled by computer
            enable <=~ enable;
            
            #(CLK_PERIOD * 2);
            enable <=~ enable;
        end
    end
     


     // **** NOTE to demonstrator:**** Unlike my past 5 Exercises, I'm trying a new method here that doesn't involve a forever loop in testing the outputs... Please let me know if my new implementation may potentially cause problems..
    

    // PART 2: Always command to check if error flag should be triggered
    // CHECKS FOR: 1. Correct colour conversion & 2. Bench enable being correct
    always
    begin
    #(CLK_PERIOD);
        if(rgb != rgb_required)
        begin
            err <= 1'b1;
            $display("***TEST FAILED! :( *** Output wanted: %h, but got: %h. This is either due to wrong colour conversion OR enable function working incorrectly.", rgb_required, rgb);
        end
    end
    
    
    // PART 3: Check if colour is correct (copied from mem.coe)
    always @ (posedge clk && enable)
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
                $display("Default triggered!");
                #CLK_PERIOD
                rgb_required <= 24'h000000; 
            end
                
        endcase
    end
    
    
    
    // PART 4: Finish simulation and check for success
    initial
    begin
        #500 
        if (err==1'b0)
          $display("***TEST PASSED! :) ***");
        $finish;
    end

    //User's instance
    colour_led inst (
     .colour (colour),
     .clk (clk),
     .enable (enable),
     .rgb (rgb)
     );
     
endmodule 
