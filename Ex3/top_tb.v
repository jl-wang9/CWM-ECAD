//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name: Jiale Wang (Somerville
// Date: 14/06/21
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
parameter CLK_PERIOD = 10;	// Clock period


//Todo: Initialise Registers and wires
reg err = 1'b0;    // Error flag
reg rst_tb;
reg clk_tb = 1'b0;
reg change_tb;
reg on_off_tb;
reg [7:0]counter_old = 8'd0;     // For tracking previous value
wire [7:0]counter_out_tb;


//Todo: Clock generation
// Generates clock with period of 10 time units

initial
begin
   forever
	#(CLK_PERIOD/2)clk_tb =~ clk_tb;	// Happens every delay of 5 time units
end


//Todo: User logic
// Check reset feature
initial
begin
    forever begin
        rst_tb = 1'b1;
        change_tb = 1'b0;
        on_off_tb = 1'b0;
        #(CLK_PERIOD)
        
        if(counter_out_tb != 8'd0)	    // triggered if counter not zero (not supposed to happen)
        begin
            if(err != 1'b1)    // Added so error message only prints once
            begin
                $display("***TEST FAILED, counter not reset when reset = 1***");
                err = 1'b1;
            end
        end
        
        
        //  PASSED RESET TEST
        // Check change feature
        else
        begin
            // Set reset to 0 & get initial counter value
            rst_tb <= 1'b0;
            counter_old <= counter_out_tb;
            #(CLK_PERIOD)
            
            if(counter_old != counter_out_tb)		// triggered if counter not zero (not supposed to happen)
            begin
                if(err != 1'b1)         // Added so error message only prints once
                begin
                    $display("***TEST FAILED, counter NOT CONSTANT when change is 0***");
                    err = 1'b1;
                end
            end
            
            
            // PASSED CHANGE TEST
            // Check counting features
            else
            begin
                change_tb <= 1'b1;
                counter_old <= counter_out_tb;
                #(CLK_PERIOD)
                
                // Check if successfully counted down
                if((counter_old - counter_out_tb) != 8'd1)
                begin
                    if(err != 1'b1)         // Added so error message only prints once
                    begin
                        $display("***TEST FAILED, counter did not count DOWN when required!***");
                        err = 1'b1;
                    end
                end
                
                
                // Check if successfully counted up
                else
                begin
                    on_off_tb <= 1'b1;
                    counter_old <= counter_out_tb;
                    #(CLK_PERIOD)
                    
                    // Check if successfully counted up
                    if((counter_out_tb - counter_old) != 8'd1)
                    begin
                        if(err != 1'b1)         // Added so error message only prints once
                        begin
                            $display("***TEST FAILED, counter did not count UP when required!***");
                            err = 1'b1;
                        end
                    end
                end
            end
        end            
    end
end


    
//Todo: Finish test, check for success
initial
begin
   #500 
   if (err!=1'b1)
      $display("***TEST PASSED! :) ***");
   $finish;
end


//Todo: Instantiate counter module
    monitor top (
     .rst (rst_tb),
     .clk (clk_tb),
     .change (change_tb),
     .on_off (on_off_tb),
     .counter_out (counter_out_tb)
     );
 
endmodule 
