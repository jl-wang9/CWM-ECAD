/////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning Complete
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
    reg [4:0]temperature;
    reg err = 1'b0;                 // Error Flag
    reg [1:0]old_concat_states;

    wire [1:0]concat_states;        // {heating, cooling}
    
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
    

    // TESTING CODE: Test 3 boundary temps repeatedly.
    //Stimulus logic
    initial
    begin
        forever
        begin

            // Initial values
            temperature <= 5'd15;
            #(CLK_PERIOD);
            old_concat_states <= concat_states;
            
            
            // **** TEST 1: temp = 18deg ****
            temperature <= LOWER_TEMP;
            #(CLK_PERIOD * 3);
            $display("Test 1: Old State: %b, New State: %b, Temperature: %b", old_concat_states, concat_states, temperature);
    
            case(old_concat_states)
                // Case 1: Heating OFF Cooling ON
                2'b01:
                begin
                    if (concat_states != 2'b00)
                    begin
                        if(err != 1'b1)         // Added so error message only prints once
                        begin
                            $display("***TEST 1 FAILED***, expected state %b, got %b", 2'b00, concat_states);
                            err = 1'b1;
                        end
                    end
                end
                        
                // Case 2: Heating ON Cooling OFF        
                2'b10:
                begin
                    if (concat_states != 2'b10)
                    begin
                        if(err != 1'b1)         // Added so error message only prints once
                        begin
                            $display("***TEST 1 FAILED***, expected state %b, got %b", 2'b10, concat_states);
                            err = 1'b1;
                        end
                    end
                end
                        
                // Case 3: Both in idle        
                2'b00:
                begin
                    if (concat_states != 2'b10)
                    begin
                        if(err != 1'b1)         // Added so error message only prints once
                        begin
                            $display("***TEST 1 FAILED***, expected state %b, got %b", 2'b10, concat_states);
                            err = 1'b1;
                        end
                    end
                end
                
                // Other states - illegal
                default:
                begin
                    if(err != 1'b1)         // Added so error message only prints once
                    begin
                        $display("***TEST 1 FAILED***, Illegal state");
                        err = 1'b1;
                    end
                end
            endcase
            old_concat_states <= concat_states;
            


            // **** TEST 2: temp = 20deg ****
            
            temperature <= MID_TEMP;
            #(CLK_PERIOD * 5);
            $display("Test 2: Old State: %b, New State: %b, Temperature: %b", old_concat_states, concat_states, temperature);
    
            case(old_concat_states)
                // Case 1: Heating OFF Cooling ON
                2'b01:
                begin
                    if (concat_states != 2'b00)
                    begin
                        if(err != 1'b1)         // Added so error message only prints once
                        begin
                            $display("***TEST 2 FAILED***, expected state %b, got %b", 2'b00, concat_states);
                            err = 1'b1;
                        end
                    end
                end
                        
                // Case 2: Heating ON Cooling OFF        
                2'b10:
                begin
                    if (concat_states != 2'b00)
                    begin
                        if(err != 1'b1)         // Added so error message only prints once
                        begin
                            $display("***TEST 2 FAILED***, expected state %b, got %b", 2'b00, concat_states);
                            err = 1'b1;
                        end
                    end
                end
                        
                // Case 3: Both in idle        
                2'b00:
                begin
                    if (concat_states != 2'b00)
                    begin
                        if(err != 1'b1)         // Added so error message only prints once
                        begin
                            $display("***TEST 2 FAILED***, expected state %b, got %b", 2'b00, concat_states);
                            err = 1'b1;
                        end
                    end
                end
                
                // Other states - illegal
                default:
                begin
                    if(err != 1'b1)         // Added so error message only prints once
                    begin
                        $display("***TEST 2 FAILED***, Illegal state");
                        err = 1'b1;
                    end
                end
            endcase
            old_concat_states <= concat_states;
            
            
            
            
            // **** TEST 3: temp = 22deg ****
            temperature <= UPPER_TEMP;
            #(CLK_PERIOD * 7);
            $display("Test 3: Old State: %b, New State: %b, Temperature: %b", old_concat_states, concat_states, temperature);
    
            case(old_concat_states)
                // Case 1: Heating OFF Cooling ON
                2'b01:
                begin
                    if (concat_states != 2'b01)
                    begin
                        if(err != 1'b1)         // Added so error message only prints once
                        begin
                            $display("***TEST 3 FAILED***, expected state %b, got %b", 2'b01, concat_states);
                            err = 1'b1;
                        end
                    end
                end
                        
                // Case 2: Heating ON Cooling OFF        
                2'b10:
                begin
                    if (concat_states != 2'b00)
                    begin
                        if(err != 1'b1)         // Added so error message only prints once
                        begin
                            $display("***TEST 3 FAILED***, expected state %b, got %b", 2'b00, concat_states);
                            err = 1'b1;
                        end
                    end
                end
                        
                // Case 3: Both in idle        
                2'b00:
                begin
                    if (concat_states != 2'b01)
                    begin
                        if(err != 1'b1)         // Added so error message only prints once
                        begin
                            $display("***TEST 3 FAILED***, expected state %b, got %b", 2'b01, concat_states);
                            err = 1'b1;
                        end
                    end
                end
                
                // Other states - illegal
                default:
                begin
                    if(err != 1'b1)         // Added so error message only prints once
                    begin
                        $display("***TEST 3 FAILED***, Illegal state");
                        err = 1'b1;
                    end
                end
            endcase
            old_concat_states <= concat_states;            
            
            
        end // End forever
    end

    
    
    //Finish simulation and check for success
    initial begin
        #300 
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
        .concat_states(concat_states)
    );
     
     
endmodule
