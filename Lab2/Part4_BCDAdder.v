module Part4_BCDAdder(
	input ci,
	input [3:0] a,
	input [3:0] b,
	output [3:0] s,
	output cout
);
	wire c1, c2, c3, raw_co;
	wire [3:0] sum;
	wire [3:0] r;

	FullAdder FA0(.ci(ci), .a(a[0]), .b(b[0]), .s(sum[0]), .co(c1));
	FullAdder FA1(.ci(c1), .a(a[1]), .b(b[1]), .s(sum[1]), .co(c2));
	FullAdder FA2(.ci(c2), .a(a[2]), .b(b[2]), .s(sum[2]), .co(c3));
	FullAdder FA3(.ci(c3), .a(a[3]), .b(b[3]), .s(sum[3]), .co(raw_co));

	Part4_Comparator PC(.co(raw_co), .s3(sum[3]), .s2(sum[2]), .s1(sum[1]), .z(cout));

	Part4_CircuitA CA(
		.co(raw_co),
		.s3(sum[3]),
		.s2(sum[2]),
		.s1(sum[1]),
		.s0(sum[0]),
		.r3(r[3]),
		.r2(r[2]),
		.r1(r[1]),
		.r0(r[0])
	);

	Part2_Mux4 MX(.s(cout), .x(sum), .y(r), .m(s));

endmodule
