module main(
	input [9:0] SW,
	output [9:0] LEDR
	
	input MAX10_CLK1_50;
	output [7:0] HEX0,
	
);
	//assign m = (~s & y) | (s & y);
	//assign LEDR[0] = (~SW[0] & SW[1]) | (SW[0] & SW[2]);
	
	//PART II
	mux_2_1_8b MUX0(
	.s(SW[0]),
	.x(SW[1]),
	.y(8'd170),
	.m(LEDR[0])
);

endmodule