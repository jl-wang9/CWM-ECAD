
`timescale 1ns / 100ps

module top_tb(
    );
    
    //Parameters
    parameter CLK_PERIOD = 10;

    //Registers and wires
    reg ADD_HERE;

    wire ADD_HERE;
    

    //Clock generation
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
    

     //Stimulus logic
     initial begin
 	//INTIAILISE HERE
       #CLK_PERIOD
       forever begin
         #(CLK_PERIOD)
		//ADD HERE
       end
     end
     
          
      //Finish simulation and check for success
      initial begin
        #500 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end

    //User's module
    REPLACE_MEtop (
     .a (ab[1]),
     .b (ab[0]),
     .sel (sel),
     .out (out)
     );
     
endmodule 