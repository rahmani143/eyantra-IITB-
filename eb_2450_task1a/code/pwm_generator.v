// EcoMender Bot : Task 1A : PWM Generator
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 1MHz Clock Frequency to 500Hz and perform Pulse Width Modulation on it.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//PWM Generator
//Inputs : clk_1MHz, pulse_width
//Output : clk_500Hz, pwm_signal

module pwm_generator(
    input clk_1MHz,
    input [3:0] pulse_width,
    output reg clk_500Hz, pwm_signal
);

initial begin
    clk_500Hz = 1; pwm_signal = 1;
end

//////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

/*
Add your logic here
*/

reg [10:0] counter = 0;
reg [10:0] counter_pwm = 0;

always @(posedge clk_1MHz) begin 
	if (counter == 1000) begin 
		clk_500Hz = ~clk_500Hz;
		counter <= 1;
	end else begin 
		counter <= counter + 1;
	end
end



always @(posedge clk_1MHz) begin 
	if (counter_pwm < (pulse_width * 100)) begin 
		pwm_signal <= 1;
	end else begin 
		pwm_signal <= 0;
	end
	
	counter_pwm = counter_pwm + 1;
	
	if (counter_pwm > 1999) begin 
		counter_pwm <= 0;
	end
end


//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule
