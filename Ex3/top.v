//////////////////////////////////////////////////////////////////////////////////
// Exercise #3 - Active IoT Devices Monitor
// Student Name: Jiale Wang (Somerville)
// Date: 14/06/21
//
//  Description: In this exercise, you need to design a counter of active IoT devices, where 
//  if the rst=1, the counter should be set to zero. If event=0, the value
//  should stay constant. If on-off=1, the counter should count up every
//  clock cycle, otherwise it should count down.
//  Wrap-around values are allowed.
//
//  inputs:
//           clk, rst, change, on_off
//
//  outputs:
//           counter_out[7:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module monitor (rst, clk, change, on_off, counter_out);
    //Todo: add ports 
    input rst;			// reset
    input clk;			// clock
    input change;		// indicator if device is on or off
    input on_off;		// type of event
    output reg[7:0]counter_out;	// 8-bit output register of time
                    
    //Todo: add registers and wires, if needed
    // Not needed as reg assigned in output above.

    //Todo: add user logic
    always @(posedge clk or posedge rst)	// Sensitivity list that is true when rising edge for clk
    begin
	if(rst)
	   counter_out <= 8'd0;			// Counter set to zero when reset is triggered
	else
	   begin
	   if(change)				// When change==1
		counter_out = on_off? (counter_out + 8'd1) : (counter_out - 8'd1);
		
	   else
		counter_out = counter_out;		// Counter const if change==0
	   end
	 
    end
endmodule
