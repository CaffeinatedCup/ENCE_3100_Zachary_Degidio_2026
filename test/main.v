module main(
	input [9:0] SW,
	output [9:0] LEDR
);

	assign LEDR[9:0] = SW[9:0];
	
	
	wire [3:0] count_4bit;
	
	param_counter u_counter_4(
	.clk(clk),
	.rst_n(rst_n),
	.count(count_4bit)
);

	wire [7:0] count_8bit;
	
	param_counter #(.WIDTH(8)) u_counter_8(
	.clk(clk),
	.rst_n(rst_n),
	.count(count_8bit)
);
endmodule