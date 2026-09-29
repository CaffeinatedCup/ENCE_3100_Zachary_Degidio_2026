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

	assign LEDR[8:6] = SW[8:6];
	assign LEDR[5]   = cout | (sum[3] & (sum[2] | (sum[1] & sum[0])));
	assign LEDR[4]   = cout;
	assign LEDR[3:0] = sum;

	// Part V
	wire [3:0] B0 = 4'd5;
	wire [3:0] B1 = 4'd4;
	wire c1_5;
	wire [3:0] S0;
	wire [3:0] S1;
	wire S2;

	Part4_BCDAdder ADD0(.ci(1'b0), .a(SW[3:0]), .b(B0), .s(S0), .cout(c1_5));
	Part4_BCDAdder ADD1(.ci(c1_5), .a(SW[7:4]), .b(B1), .s(S1), .cout(S2));

	Seg7_Decoder D3(
		.m(S0),
		.out(HEX4)
	);

	Seg7_Decoder D4(
		.m(S1),
		.out(HEX5)
	);

	assign LEDR[9] = S2;

endmodule
