//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name: Jiale Wang (Somerville)
// Date: 15/06/21
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module air_conditioning (

    //Todo: add ports 
    // NO RESET SIGNAL
    input clk,
    input [4:0]temperature,
    
    // Initialise initial state at idle
    output reg heating = 1'b0,
    output reg cooling = 1'b0
    );

    // Parameters
    parameter UPPER_TEMP = 5'd22;
    parameter MID_TEMP = 5'd20;
    parameter LOWER_TEMP = 5'd18;

    //Todo: add user logic
    assign concat_states = {heating, cooling};

    
    always @(posedge clk)	// Sensitivity list that is true when rising edge for clk
    begin
    
        // Case operation to define all posible conditions and actions to take
        case(concat_states)
        
            // Case 1: Heating OFF Cooling ON
            2'b01:
            begin
                if (temperature <= MID_TEMP)
                    cooling <= 1'b0;
                else
                    cooling <= 1'b1;
            end
                    
            // Case 2: Heating ON Cooling OFF        
            2'b10:
            begin
                if (temperature >= MID_TEMP)
                    heating <= 1'b0;
                else
                    heating <= 1'b1;
            end
                    
            // Case 3: Both in idle        
            2'b00:
            begin
                cooling <= (temperature >= UPPER_TEMP)? 1'b1 : 1'b0;
                heating <= (temperature <= LOWER_TEMP)? 1'b1 : 1'b0;
            end
                
            // No default statement given as Case 4 2'b11 is not possible
            
        endcase
    end
endmodule
