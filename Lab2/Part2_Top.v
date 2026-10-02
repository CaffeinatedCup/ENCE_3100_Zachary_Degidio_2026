module Part2_Top(
	input [3:0] SW,
	output [7:0] HEX2,
	output [7:0] HEX3
);
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

endmodule
