////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name: Jiale Wang (Somerville)
// Date: 15/06/21
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module led (
    //Todo: add ports 
    input clk,
    input rst,
    input button,
    output reg [2:0]colour
    );
    
    
    //Todo: add user logic
    always @(posedge clk or posedge rst)	// Sensitivity list that is true when rising edge
    begin
        // Part 1: Implement reset, move colour to binary "001" on reset
        if(rst)
        begin  
            colour <= 3'b001;
        end
        
        // Part 2: Implement colour change with "case" command
        // The case statement checks if the given expression matches one among the other expressions inside the list and branches.
        else
        begin
            case(colour)
                // Set up according to trasition diagram on exercise
                3'b111: colour <= 3'b001;
                3'b000: colour <= 3'b001;
                3'b110: begin
                    if(button)
                        colour <= 3'b001;   // To ensure b111 is never reached
                    else
                        colour = colour;    // Unchanged if button = 0
                end
                
                // Overflow / error cases
                3'dx: 
                begin
                    colour <= 3'b001;
//                    $display("Gentle reminder: May have overflow / undefined colour value. Value has been reset to 001...");
                end
                
                3'bx: 
                begin
                    colour <= 3'b001;
//                    $display("Gentle reminder: May have overflow / undefined colour value. Value has been reset to 001...");
                end
                
                
                // For all other cases - cycle colour
                default: begin
                    if(button)
                        colour <= (colour + 3'b001);  // Step forward by 1 binary number
                    else
                        colour = colour;    // Unchanged if button = 0                
                end
            endcase
        end
    end
endmodule
