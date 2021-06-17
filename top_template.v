`timescale 1ns / 100ps

module monitor (
    //Todo: add ports 
    input ADD_HERE,

    output ADD_HERE
	);
                    
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
