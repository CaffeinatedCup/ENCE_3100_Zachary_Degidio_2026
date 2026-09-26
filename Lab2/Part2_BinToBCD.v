module Part2_BinToBCD(
	input [3:0] V,
	output [3:0] M,
	output z
);
	wire [2:0] a;

	Part2_Comparator cmp(.v(V), .z(z));
	Part2_CircuitA   ca (.v(V[2:0]), .out(a));
	Part2_Mux4       mx (.s(z), .x(V), .y({1'b0, a}), .m(M));

endmodule
