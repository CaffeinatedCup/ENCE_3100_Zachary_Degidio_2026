module main(
	input [9:0] SW,
	output [9:0] LEDR,
	
	input MAX10_CLK1_50,
	output [7:0] HEX0,
	output [7:0] HEX1,
	output [7:0] HEX2,
	output [7:0] HEX3,
	output [7:0] HEX4,
	output [7:0] HEX5
	
);
	assign LEDR[9:0] = SW[9:0];
	
	Seg7_Decoder D0(
	.m(SW[3:0]),
	.out(HEX0)
);


endmodule