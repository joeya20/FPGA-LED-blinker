module synchronizer 
#(
	c_N = 1
)
(
	input 					i_clk,
	input						i_reset,
	input		[c_N-1:0]	i_D,
	output	[c_N-1:0]	o_Q
);

	reg [c_N-1:0] reg1;
	reg [c_N-1:0] reg2;
	
	always @ (posedge i_clk or posedge i_reset) begin
		if (i_reset == 1'b1) begin
			reg1 <= 0;
			reg2 <= 0;
		end else begin
			reg1	<= i_D;
			reg2	<= reg1;
		end
	end
	
	assign o_Q = reg2;
	
endmodule