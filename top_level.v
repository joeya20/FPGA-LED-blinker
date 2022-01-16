module top_level 
	(
		input			 	MAX10_CLK1_50,
		input		[9:0] SW,
		output 	[9:0] LEDR
	);

	wire w_led_state;
	
	wire [2:0] w_clean_sw;
	
	synchronizer #(.c_N(3))
		switch_synchronizer
		(
			.i_clk(MAX10_CLK1_50),
			.i_reset(1'b0),
			.i_D(SW[2:0]),
			.o_Q(w_clean_sw)
		);

	LED_blinker blinker_ins0
		(
			.i_clk		(MAX10_CLK1_50),
			.i_enable	(w_clean_sw[2]),
			.i_select0	(w_clean_sw[0]),
			.i_select1	(w_clean_sw[1]),
			.o_led		(w_led_state)
		);
		
	assign LEDR = {10{w_led_state}};
	
endmodule