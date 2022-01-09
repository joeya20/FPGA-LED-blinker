module LED_blinker_tb;
	
	reg r_clk;
	reg r_enable;
	reg r_select0;
	reg r_select1;
	wire w_LED_state;

	LED_blinker 
	#(
		.c_max_count_1Hz(25),
		.c_max_count_5Hz(10),
		.c_max_count_10Hz(5),
		.c_max_count_20Hz(2)
	)
	DUT
	(
		.i_clk		(r_clk),
		.i_enable	(r_enable),
		.i_select0	(r_select0),
		.i_select1	(r_select1),
		.o_led		(w_LED_state)
	);
	
	parameter c_CLK_PERIOD = 10;
	
	//generate clk
	always begin
		#(c_CLK_PERIOD/2) r_clk <= !r_clk;
	end
	
	//initialize signals
	initial begin
		r_clk <= 0;
		r_enable <= 0;
		r_select0 <= 0;
		r_select1 <= 0;
	end
	
	//main testing
	initial begin		
		//testing switching max count
		#c_CLK_PERIOD r_select0 = 1;	// 01
		#c_CLK_PERIOD r_select1 = 1;	// 11
		#c_CLK_PERIOD r_select0 = 0;	// 10
		
		//testing output with enable on;
		r_select0 = 1;
		r_select1 = 1;
		r_enable = 1;
		#(c_CLK_PERIOD*10);
		
		//testing output with enable off;
		#5 r_enable = 0;
		#(c_CLK_PERIOD*10);
		
		//finish simulation
		$finish;
	end
	
endmodule