/*
Design HDL code that will blink LEDs at a specified frequency of 100 Hz, 50 Hz, 10 Hz, or 1 Hz. 
For each of the blink frequencies, the LED will be set to 50% duty cycle (it will be on half the time). 
The LED frequency will be chosen via two switches which are inputs to the FPGA. 
There is an additional switch that needs to be ‘1’ to turn on the LED. The FPGA will be driven by a 50MHz clock.
*/

module LED_blinker 
	(
		i_clk,
		i_enable,
		i_select0,
		i_select1,
		o_led
	);
	
	//port declarations
	input i_clk;
	input i_enable;
	input i_select0;
	input	i_select1;
	output o_led;

	//max counts to get proper blinking rate with a 50% duty cycle 
	//(clk / blinking rate * 0.5)
	parameter c_max_count_100Hz = 250_000;
	parameter c_max_count_50Hz = 500_000;
	parameter c_max_count_10Hz = 2_500_000;
	parameter c_max_count_1Hz = 25_000_000;

	//counters
	reg [31:0] r_count_100hz = 0;
	reg [31:0] r_count_50hz = 0;
	reg [31:0] r_count_10hz = 0;
	reg [31:0] r_count_1hz = 0;

	//LED toggle signals
	reg r_toggle_100Hz = 1'b0;
	reg r_toggle_50Hz = 1'b0;
	reg r_toggle_10Hz = 1'b0;
	reg r_toggle_1Hz = 1'b0;

	//final LED state output
	wire w_LED_state;

	//4 parallel processes for each blinking rate
	always @ (posedge i_clk)
		begin
			if(r_count_100hz == c_max_count_100Hz-1)
				begin
					r_toggle_100Hz <= !r_toggle_100Hz;
					r_count_100hz <= 0;
				end
			else
				r_count_100hz <= r_count_100hz + 1;
		end

		
	always @ (posedge i_clk)
		begin
			if(r_count_50hz == c_max_count_50Hz-1)
				begin
					r_toggle_50Hz <= !r_toggle_50Hz;
					r_count_50hz <= 0;
				end
			else
				r_count_50hz <= r_count_50hz + 1;
		end

		
	always @ (posedge i_clk)
		begin
			if(r_count_10hz == c_max_count_10Hz-1)
				begin
					r_toggle_10Hz <= !r_toggle_10Hz;
					r_count_10hz <= 0;
				end
			else
				r_count_10hz <= r_count_10hz + 1;
		end

		
	always @ (posedge i_clk)
		begin
			if(r_count_1hz == c_max_count_1Hz-1)
				begin
					r_toggle_1Hz <= !r_toggle_1Hz;
					r_count_1hz <= 0;
				end
			else
				r_count_1hz <= r_count_1hz + 1;
		end

	assign w_LED_state = i_select0 ? (i_select1 ? r_toggle_1Hz : r_toggle_10Hz) : (i_select1 ? r_toggle_50Hz : r_toggle_100Hz);
		
	assign o_led = w_LED_state & i_enable;

endmodule