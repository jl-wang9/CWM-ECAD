/////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name: Jiale Wang (Somerville)
// Date: 15/06/21
//
// Description: A testbench module to test Ex5 - Air Conditioning
// You need to write the whole file
/////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );
    
    //Parameters
    parameter CLK_PERIOD = 10;

    //Registers and wires
    reg clk = 1'b0;
    reg [4:0]temperature = 5'd15;
    reg err = 1'b0;                 // Error Flag
    reg [1:0]old_concat_states = 2'b01;
    
    wire heating;
    wire cooling;
    wire [1:0]concat_states;        // {heating, cooling}

    assign concat_states = {heating, cooling};
    
    //Clock generation
    initial
    begin
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
    
    
    // Parameters
    parameter UPPER_TEMP = 5'd22;
    parameter MID_TEMP = 5'd20;
    parameter LOWER_TEMP = 5'd18;
    

    //Stimulus logic
    // TEST 1: temp = 18deg
    initial
    begin
        #(CLK_PERIOD);
        temperature <= LOWER_TEMP;

        case(old_concat_states)
            // Case 1: Heating OFF Cooling ON
            2'b01:
            begin
            $display("2b01, %b", concat_states);
                if (concat_states != 2'b00)
                begin
                    $display("***TEST FAILED***, expected state %b, got %b", 2'b00, concat_states);
                    err = 1'b1;
                end
            end
                    
            // Case 2: Heating ON Cooling OFF        
            2'b10:
            begin
            $display("2b10, %b", concat_states);
                if (concat_states != 2'b10)
                begin
                    $display("***TEST FAILED***, expected state %b, got %b", 2'b10, concat_states);
                    err = 1'b1;
                end
            end
                    
            // Case 3: Both in idle        
            2'b00:
            begin
            $display("2b00, %b", concat_states);
                if (concat_states != 2'b10)
                begin
                    $display("***TEST FAILED***, expected state %b, got %b", 2'b10, concat_states);
                err = 1'b1;
                end
            end
        endcase
    end
     
          
    //Finish simulation and check for success
    initial begin
        #500 
        if (err==1'b0)
            $display("***TEST PASSED! :)***");
            
        else
            $display("***OVERALL TEST FAILED***");
        $finish;
    end

    //User's module
    air_conditioning top (
        .clk (clk),
        .temperature (temperature),
        .heating(heating),
        .cooling(cooling)
    );
     
     
endmodule
