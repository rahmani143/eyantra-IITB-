// EcoMender Bot : Task 1B : Color Detection using State Machines
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will detect colors red, green, and blue using state machine and frequency detection.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//Color Detection
//Inputs : clk_1MHz, cs_out
//Output : filter, color


// Module Declaration
module t1b_cd_fd (
    input  clk_1MHz, cs_out,
    output reg [1:0] filter, color
);

// red   -> color = 1;
// green -> color = 2;
// blue  -> color = 3;

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE //////////////////

reg [9:0] counter;
initial begin // editing this initial block is allowed
    filter = 2; color = 0; counter=0;
end

// State encoding
localparam IDLE        = 3'b00;
localparam FILTER_RED  = 3'b00;
localparam FILTER_GREEN = 3'b10;
localparam FILTER_BLUE  = 3'b11;
localparam FILTER_clear = 2'b10;
localparam OUTPUT_COLOR = 3'b100;

reg [2:0] current_state, next_state;
reg [19:0] freq_r, freq_g, freq_b;

// State transition and frequency counting on clk_1MHz
always @(posedge clk_1MHz) begin
    current_state <= next_state;

    case (current_state)
        IDLE: begin
            counter <= 0;
            freq_r <= 0;
            freq_g <= 0;
            freq_b <= 0;
            color <= 0;
            if (cs_out) begin // Trigger the start
                next_state <= FILTER_GREEN;
            end else begin
                next_state <= IDLE;
            end
        end

        FILTER_RED: begin
            filter <= 2'b00; // Set filter for red
            if (counter < 500) begin
                counter <= counter + 1;
                if (cs_out) freq_r <= freq_r + 1; // Increment red frequency on cs_out
            end else begin
                counter <= 0;
                next_state <= FILTER_BLUE;
            end
        end

        FILTER_GREEN: begin
            filter <= 2'b11; // Set filter for green
            if (counter < 500) begin
                counter <= counter + 1;
                if (cs_out) freq_g <= freq_g + 1; // Increment green frequency on cs_out
            end else begin
                counter <= 0;
                next_state <= FILTER_RED;
            end
        end

        FILTER_BLUE: begin
            filter <= 2'b01; // Set filter for blue
            if (counter < 500) begin
                counter <= counter + 1;
                if (cs_out) freq_b <= freq_b + 1; // Increment blue frequency on cs_out
            end else begin
                counter <= 0;
                next_state <= FILTER_clear;
            end
        end
		  FILTER_clear: begin
            filter <= 2'b10; // Set filter for blue
            if (counter < 1) begin
                counter <= counter + 1;
					 end
              else
                next_state <= OUTPUT_COLOR;
            
        end

        OUTPUT_COLOR: begin
            // Determine the dominant color based on frequency counts
            if (freq_r > freq_g && freq_r > freq_b) begin
                color <= 2'b01; // Red
            end else if (freq_g > freq_r && freq_g > freq_b) begin
                color <= 2'b10; // Green
            end else if (freq_b > freq_r && freq_b > freq_g) begin
                color <= 2'b11; // Blue
            end else begin
                color <= 2'b00; // None or ambiguous
            end
            next_state <= IDLE; // Return to IDLE
        end

        default: next_state <= IDLE; // Safety reset
    endcase
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE //////////////////

endmodule

		  

      
