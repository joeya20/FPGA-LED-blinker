module top_level 
	(
		MAX10_CLK1_50,
		SW,
		LEDR
	);
	
	input MAX10_CLK1_50;
	input  [9:0] SW;
	output [9:0] LEDR;

	wire r_led_state;

	LED_blinker blinker_ins0
		(
			.i_clk(MAX10_CLK1_50),
			.i_enable(SW[2]),
			.i_select0(SW[0]),
			.i_select1(SW[1]),
			.o_led(r_led_state)
		);
		
	assign LEDR = {10{r_led_state}};
	
endmodule