//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name: Jiale Wang (Somerville)
// Date: 15/06/21
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps


module top_tb(
    );
    
    //Parameters
    parameter CLK_PERIOD = 10;

    //Registers and wires
    reg clk;
    reg rst;
    reg button;
    reg err = 1'b0;                  // Error flag
    reg [2:0]col_req; // Correct colour to benchmark against
    wire [2:0]colour;         // Actual colour output from top.v
    

    //Clock generation & button switching & monitoring in interface
    initial
    begin
       clk = 1'b0;
       button = 1'b0;
       forever
         #(CLK_PERIOD/2) 
         button=~button;
         clk=~clk;
         $monitor($time, "At clk is %b, button state is %b, LED colour is %b, reset state is %b", clk, button, colour, rst);
         
         #(CLK_PERIOD/2) clk=~clk;
         $monitor($time, "At clk is %b, button state is %b, LED colour is %b, reset state is %b", clk, button, colour, rst);
     end
    

     // PART 1: Check RESET function
    initial 
    begin
        #(CLK_PERIOD)
        forever begin
            // Initialise values
            rst = 1'b1;
            button = 1'b0;
            #(CLK_PERIOD)
            
            if(colour != 3'b001)
            begin
                if(err != 1'b1)    // Added so error message only prints once
                    $display("***TEST FAILED, colour does not reset when reset = 1***");
                    err = 1'b1;
            end
        end
        rst = 1'b0;
    end
    
    
    // PART 2: Check COLOURS
    
    // Define required output colours to check against later
    
    // Part 2a: Colours that step forward in an orderly fashion
    initial
    #(CLK_PERIOD);
    
    // always @(posedge clk and button)
    always @(posedge clk && button)
    // Sensitivity list that is true when rising edge
    begin
        rst <= 1'b0;
        $display("fdsafv");
        if(button == 1'b1) 
        begin
            if(col_req == 3'b110)
                col_req <= 3'b001;
            else
                col_req <= (col_req + 3'b001);
        end
        
        
        else 
        begin    // Button = 0
            col_req <= col_req;
        end
    end
    
    
    // Part 2b: Check if required and actual colours match up
    always
    begin
        #(CLK_PERIOD)
        if(colour != col_req)
        begin
            if(err != 1'b1)    // Added so error message only prints once
                begin
                    $display("***TEST FAILED! Wanted %b, Got %b***", col_req, colour);
                    err = 1'b1;   
                end
        end
    end
    
    

    //Finish simulation and check for success
    initial begin
        #500 
        if (err==1'b0)
          $display("***TEST PASSED! :) ***");
        $finish;
    end


    //User's module
    led top (
        .clk (clk),
        .button (button),
        .rst (rst),
        .colour (colour)
    );

endmodule 
