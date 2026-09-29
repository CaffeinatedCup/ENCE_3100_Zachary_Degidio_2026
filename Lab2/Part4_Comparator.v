module Part4_Comparator(
	input co,
	input s3,
	input s2,
	input s1,
	output z
);
	assign z = co | (s3 & (s2 | s1));

endmodule
