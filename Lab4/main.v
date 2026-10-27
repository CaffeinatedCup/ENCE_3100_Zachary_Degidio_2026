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

	// ================= Part V - scrolling HELLO =================
	// P5_hello drives all six displays itself, so main just forwards
	// the board pins into it. SW[0] = clear, SW[1] = scroll/pause.

	P5_hello Hello_0(
		.MAX10_CLK1_50(MAX10_CLK1_50),
		.SW(SW),
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5)
	);

	assign LEDR[9:0] = 10'b0;	// unused in Part V


/* ================= Parts I - III (inactive) =================

	//assign LEDR[9:0] = SW[9:0];

	//TFlipFlop TFF_1(
	//	input T,
	//input clk,
	//input clear,
	//output QT
	//);

	wire slow_clk;
	wire clk = slow_clk;
	wire enable = SW[1];
	wire clear = ~SW[0];

	wire [15:0] count;

	Counter_1Hz Clock_0(
		.in_clk(MAX10_CLK1_50),
		.clear(clear),
		.out_clk(slow_clk)
	);

	P3_LPM_Counter Counter_0(
		.clock(clk),
		.clk_en(enable),
		.sclr(clear),
		.q(count)
	);
	//P1_Counter_8bit Counter_0(
	//	.ena(enable),
	//	.clk(clk),
	//	.clear(clear),
	//	.count(count[7:0])
	//);

	assign LEDR[9:0] = count[9:0];

	Seg7_Decoder D0(
		.m(count[3:0]),
		.out(HEX0)
	);

	Seg7_Decoder D1(
		.m(count[7:4]),
		.out(HEX1)
	);

	Seg7_Decoder D2(
		.m(count[11:8]),
		.out(HEX2)
	);

	Seg7_Decoder D3(
		.m(count[15:12]),
		.out(HEX3)
	);

============================================================= */


endmodule
