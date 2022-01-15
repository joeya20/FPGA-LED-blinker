
module LED_blinker
	#(
		//max counts to get proper blinking rate with a 50% duty cycle (clk = 50MHz)
		//max count = clk / blinking rate * 0.5 
		parameter c_max_count_1Hz = 25_000_000,
		parameter c_max_count_5Hz = 10_000_000,
		parameter c_max_count_10Hz = 5_000_000,
		parameter c_max_count_20Hz = 2_500_000
	)
	(
		input 	i_clk,
		input 	i_enable,
		input 	i_select0,
		input 	i_select1,
		output 	o_led
	);

	//counter
	reg [31:0] r_count = 0;

	//LED toggle signal
	reg r_toggle = 1'b0;
	
	//current frequency max count
	reg [31:0] r_current_max_count;
	
	always @ (posedge i_clk) begin		
		//increment counter and toggle LED and roll over if max count is reached
		if(r_count < r_current_max_count-1) begin
			r_count <= r_count + 1;
		end else begin
			r_toggle <= !r_toggle;
			r_count <= 0;
		end
	end
	
	always @ (i_select0 or i_select1) begin
		case({i_select1, i_select0})
			2'b00 : r_current_max_count = c_max_count_1Hz;
			2'b01 : r_current_max_count = c_max_count_5Hz;
			2'b10 : r_current_max_count = c_max_count_10Hz;
			2'b11 : r_current_max_count = c_max_count_20Hz;
		endcase
	end
	
	assign o_led = r_toggle & i_enable;

endmodule