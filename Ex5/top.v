/////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning Complete
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
    
    // Initialise initial state at idle.
    // output heating,
    // output cooling,
    // !!!!! concat_states = {Heating, Cooling} concatenated into a vector !!!!
    output reg[1:0]concat_states    
    );

    // Parameters
    parameter UPPER_TEMP = 5'd22;
    parameter MID_TEMP = 5'd20;
    parameter LOWER_TEMP = 5'd18;
    
    // Flag
    reg flag = 1'b0;
    
    // Commented out following advice of demonstrator
    // assign concat_states = {heating, cooling} 

    // Todo: add user logic
    always @(posedge clk)	// Sensitivity list that is true when rising edge for clk
    begin
        flag <= 1'b0;
        // Case operation to define all posible conditions and actions to take
        case(concat_states)
            2'b01:
            begin
                if(flag == 1'b0)
                begin
                    concat_states <= (temperature > MID_TEMP)? 2'b01:2'b00;
                    flag <= 1'b1;
                end
            end
            
            2'b10:         
            begin
                if(flag == 1'b0)
                begin
                    concat_states <= (temperature < MID_TEMP)? 2'b10:2'b00;
                    flag <= 1'b1;
                end
            end
            
            default: 
            begin
                if(flag == 1'b0)
                begin
                    if((temperature > LOWER_TEMP) && (temperature < UPPER_TEMP))
                        concat_states <= 2'b00;
                    
                    else if (temperature <= LOWER_TEMP)
                        concat_states <= 2'b10;
                        
                    else
                        concat_states <= 2'b01;
                        
                    flag <= 1'b1;
                end
            end
            
        endcase
    end
endmodule
