module main(
	input MAX10_CLK1_50,
	input [9:0] SW,
	input [1:0] KEY,
	output [9:0] LEDR,
	output [7:0] HEX0,
	output [7:0] HEX1,
	output [7:0] HEX2,
	output [7:0] HEX3,
	output [7:0] HEX4,
	output [7:0] HEX5
	
);
	//assign LEDR[9:0] = SW[9:0];
	
	//TFlipFlop TFF_1(
	//	input T,
	//input clk,
	//input clear,
	//output QT
	//);

	wire [7:0] count;

	Counter_8bit Counter_0(
		.ena(SW[2]),
		.clk(SW[9]),
		.clear(SW[1]),
		.count(count)
	);

	assign LEDR[7:0] = count;

	Seg7_Display D0(
		.bin_number(count[7:0]),
		.seg_display(HEX0)
	);

	Seg7_Display D1(
		.bin_number(count[7:0]),
		.seg_display(HEX1)
	);
	
	//Counter_1Hz Clock_0(
	//.in_clk(MAX10_CLK1_50),
	//.clear(SW[1]),
	//.out_clk(LEDR[7:0])
//);


endmodule