//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name: Jiale Wang (Somerville)
// Date: 18/06/21
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );
    
    //Parameters
    parameter CLK_PERIOD = 10;
    // parameter TEMP_ADJUSTMENT = 6;
    parameter UPPER_TEMP = 5'd22;
    parameter MID_TEMP = 5'd20;
    parameter LOWER_TEMP = 5'd18;
    

    //Registers and wires
    reg clk_p = 1'b0;
    reg clk_n = 1'b1;
    reg rst_n = 1'b0;
    reg err = 1'b0;     // Error flag
    reg [1:0]old_concat_states;
    reg [1:0]concat_states;


    wire temperature_0, temperature_1, temperature_2, temperature_3, temperature_4;
    reg [4:0] temperature_array = 5'd15;   // Initial value
    
    // Assign varying array values to different temperatures
    assign temperature_0 = temperature_array[0];
    assign temperature_1 = temperature_array[1]; 
    assign temperature_2 = temperature_array[2]; 
    assign temperature_3 = temperature_array[3]; 
    assign temperature_4 = temperature_array[4];

	wire heating;
	wire cooling;
	
	assign concat_states = {heating, cooling};
	

    //Clock generation
    initial
    begin
       forever
        begin
            #(CLK_PERIOD/2) 
            clk_p =~ clk_p;
            clk_n =~ clk_n;
        end
     end
    

    //Stimulus logic - using code from Ex5 testbench

    initial
    begin
        forever
        begin

            // Initial values
            temperature_array <= 5'd15;
            #(CLK_PERIOD);
            old_concat_states <= concat_states;
            
            
            // **** TEST 1: temp = 18deg ****
            temperature_array <= LOWER_TEMP;
            #(CLK_PERIOD * 3);
            $display("Test 1: Old State: %b, New State: %b, Temperature: %b", old_concat_states, concat_states, temperature_array);
    
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
            
            temperature_array <= MID_TEMP;
            #(CLK_PERIOD * 5);
            $display("Test 2: Old State: %b, New State: %b, Temperature: %b", old_concat_states, concat_states, temperature_array);
    
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
            temperature_array <= UPPER_TEMP;
            #(CLK_PERIOD * 7);
            $display("Test 3: Old State: %b, New State: %b, Temperature: %b", old_concat_states, concat_states, temperature_array);
    
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
        #500 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
    end


    //User's module
    top user_module ( 
        .rst_n (rst_n),
    	.clk_n (clk_n),
    	.clk_p (clk_p),
    
    	.heating (heating),
    	.cooling (cooling),
    	
    	.temperature_0 (temperature_array[0]),
        .temperature_1 (temperature_array[1]),
        .temperature_2 (temperature_array[2]),
        .temperature_3 (temperature_array[3]),
        .temperature_4 (temperature_array[4])
     );
     
endmodule 