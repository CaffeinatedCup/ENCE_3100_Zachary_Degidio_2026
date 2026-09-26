module Part2_Comparator(
	input [3:0] v,
	output z
);
	// z = 1 when v > 9 (v = 1010 to 1111)
	assign z = v[3] & (v[2] | v[1]);

endmodule
