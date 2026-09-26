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
	// Part I
	Seg7_Decoder D0(
		.m(SW[3:0]),
		.out(HEX0)
	);

	Seg7_Decoder D1(
		.m(SW[7:4]),
		.out(HEX1)
	);

	// Part II
	wire [3:0] M;
	wire z;

	Part2_BinToBCD BCD0(.V(SW[3:0]), .M(M), .z(z));

	Seg7_Decoder D2(
		.m(M),
		.out(HEX2)
	);

	Part2_CircuitB CB0(
		.z(z),
		.out(HEX3)
	);

	// Part III
	wire c1, c2, c3, cout;
	wire [3:0] sum;

	FullAdder FA0(.ci(SW[8]), .a(SW[4]), .b(SW[0]), .s(sum[0]), .co(c1));
	FullAdder FA1(.ci(c1),    .a(SW[5]), .b(SW[1]), .s(sum[1]), .co(c2));
	FullAdder FA2(.ci(c2),    .a(SW[6]), .b(SW[2]), .s(sum[2]), .co(c3));
	FullAdder FA3(.ci(c3),    .a(SW[7]), .b(SW[3]), .s(sum[3]), .co(cout));

	assign LEDR[9:6] = SW[9:6];
	assign LEDR[5]   = cout | (sum[3] & (sum[2] | (sum[1] & sum[0])));
	assign LEDR[4]   = cout;
	assign LEDR[3:0] = sum;

endmodule
