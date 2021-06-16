////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name: Jiale Wang (Somerville)
// Date: 15/06/21
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps


module top_tb(
    );
    
    //Parameters
    parameter CLK_PERIOD = 10;

    //Registers and wires
    reg clk;
    reg rst;
    reg button = 1'b1;
    reg err = 1'b0;         // Error flag
    reg [2:0]previous_colour;
    integer i;              // For loop iteration
    
    wire [2:0]colour;       // Actual colour output from top.v
    

    //Clock generation
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) 
         clk=~clk;
     end
    
    
    // TESTING CODE. CHECKS: 1. RESET, 2. BUTTON=0 & NO CHANGE, 3. Cycling of colours & at no point do 000 and 111 appear
    initial 
    begin
        forever 
        begin
            // PART 1: Check RESET feature
            $display("Checking Reset feature...");
            rst <= 1'b1;     // Reset mode
            button <= 1'b1;
            #(CLK_PERIOD);

            if(colour != 3'b001)
            begin
                $display("***TEST FAILED***, colour does not reset when reset = 1");
                err = 1'b1;
            end
            previous_colour <= colour;
        
            // PART 2: Check CHANGE HOLDING feature
            $display("Checking colour holding feature...");
            rst <= 1'b0;
            button <= 1'b0;
            #(CLK_PERIOD * 3);
            
            if(colour != previous_colour)   // Triggered if colour changes
            begin
                if(err != 1'b1)    // Added so error message only prints once
                begin
                    $display("***TEST FAILED***, colour changed when button=0");
                    err = 1'b1;
                end
            end
            
            
            // PART 3: CHECK cycling of colours and that 000 and 111 do not appear
            #(CLK_PERIOD * 5);
            $display("Checking cycling of colours feature...");
            for (i=0; i<5; i=i+1)
            begin
                button <= 1'b1;
                #(CLK_PERIOD)
                $display("--------------------------------");
                $display("Iteration #%b", i);
                $display("Prev colr: %b, Curr colr: %b", previous_colour, colour);
                
                if((colour - previous_colour) != 3'b001)
                begin
                    $display("***TEST FAILED***, colour did not cycle correctly. Expected %b but got %b", (colour + 3'b001), colour);
                    err = 1'b1;  
                end
                
                else // Cycled correctly, check if 000 or 111 appears
                begin
                    $display("Checking if 000 or 111 appears in cycle (illegal)");
                    if((colour == 3'b000) || (colour == 3'b111))
                    begin
                        rst <= 1'b1;
                        #(CLK_PERIOD) rst <= 1'b0;
                        
                        
                            if(err != 1'b1)    // Added so error message only prints once
                            begin
                                $display("***TEST FAILED***, 000 or 111 appeared in colour cycle! Not allowed. Resetting colours...");
                                err = 1'b1;  
                            end                    
                    end
                    
                    else // No 000 or 111, check if button=0 works
                    begin
                        $display("Checking if button=0 works...");
                        previous_colour <= colour;
                        button <= 1'b0;
                        #CLK_PERIOD
                        
                        if(colour != previous_colour)   // Triggered if colour changes
                        begin
                            if(err != 1'b1)    // Added so error message only prints once
                            begin
                                $display("***TEST FAILED***, colour changed when button=0");
                                err = 1'b1;
                            end
                        end
                        $display("Current iteration complete!");
                    end    
                end
            end
                
                
            // PART 4: CHECK if 110 becomes 001
            #(CLK_PERIOD * 40);
            button <= 1'b1;    
                
            if(colour != 3'b001)
            begin
                if (err != 1'b1)
                begin
                $display("***TEST FAILED***, 110 did not become 001!");
                err = 1'b1;
                end
            end   
        end             // End forever
    end                 // End initial
    

    //Finish simulation and check for success
    initial begin
        #500 
        if (err==1'b0)
          begin
              $display("--------------------------------");
              $display("***TEST PASSED! :) ***");
          end
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
