//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name:
// Date: 
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

//Todo: Regitsers and wires
reg err;
reg rst;
reg clk;
reg change;
reg on_off;
wire counter_out;


//Todo: Clock generation
// Generates clock with period of 10 time units

initial
begin
   clk = 0;
   forever
	#(CLK_PERIOD/2)clk =~ clk;	// Happens every delay of 5 time units
end


//Todo: User logic
initial
begin
   // Initial inputs to test
   rst = 1;
   change = 0;
   on_off = 0;
   err = 0;			// Error flag
   
   forever begin
	#(CLK_PERIOD)

	// Check reset feature
	if(counter_out !=0)		// triggered if counter not zero (not supposed to happen)
 	begin
	   $display("***TEST FAILED, counter not reset when reset = 1***");
	   err = 1;
   	end

	rst = 0;
	
	

   end
end

    
//Todo: Finish test, check for success
initial
begin
   //#(256*CLK_PERIOD)		// Run for max possible period for a 8-bit to form 
   #50
   if (err==0)
	$display("***TEST PASSED! :) ***");
   $finish;
end


//Todo: Instantiate counter module
    monitor top (
     .rst (rst),
     .clk (clk),
     .change (change),
     .on_off (on_off),
     .counter_out (counter_out)
     );
 
endmodule 
