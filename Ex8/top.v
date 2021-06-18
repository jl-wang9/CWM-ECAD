
//////////////////////////////////////////////////////////////////////////////////
// Exercise #8  - Simple End-to-End Design
// Student Name: Jiale Wang (Somerville)
// Date: 18/06/21
//
//  Description: In this exercise, you need to design an air conditioning systems
//
//  inputs:
//           rst_n, clk_n, clk_p, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk_p,
    input clk_n,
     //Todo: add all other ports besides clk_n and clk_p 
     // Defined following names in pin table
    input rst_n,
    
	output reg heating,
	output reg cooling,
    
    input temperature_0,
    input temperature_1,
    input temperature_2,
    input temperature_3,
    input temperature_4
   );
    
    // Parameters
    parameter UPPER_TEMP = 5'd22;
    parameter MID_TEMP = 5'd20;
    parameter LOWER_TEMP = 5'd18;
    parameter DELAY = 1;
    
    
    reg [4:0] temperature_array;
    

   /* clock infrastructure, do not modify */
        wire clk_ibufds;

    IBUFDS IBUFDS_sysclk (
	.I(clk_p),
	.IB(clk_n),
	.O(clk_ibufds)
);

     wire clk; //use this signal as a clock for your design
        
     BUFG bufg_clk (
	.I  (clk_ibufds),
	.O  (clk)
      );



//TODO: Add logic here
// concat all temperature bits into one
always
begin
#(DELAY);
	temperature_array = {temperature_4, temperature_3, temperature_2, temperature_1, temperature_0};
end


// Slightly modified from my Ex5 top.v code
    always @(posedge clk)	// Sensitivity list that is true when rising edge for clk
    begin
        // Case operation to define all posible conditions and actions to take
        case({heating, cooling})
            2'b01:
            begin
                cooling <= (temperature_array > MID_TEMP)? 1'b1 :1'b0;
            end
            
            2'b10:         
            begin
                heating <= (temperature_array < MID_TEMP)? 1'b1 :1'b0;
            end
            
            default: 
            begin
                if((temperature_array > LOWER_TEMP) && (temperature_array < UPPER_TEMP))
                    begin
                        cooling <= 1'b0;
                        heating <= 1'b0;
                    end
                
                else if (temperature_array <= LOWER_TEMP)
                    heating <= 1'b1;
                    
                else
                    cooling <= 1'b1;
            end
            
        endcase
    end


endmodule
