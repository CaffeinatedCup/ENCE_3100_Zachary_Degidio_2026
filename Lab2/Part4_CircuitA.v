module Part4_CircuitA(
	input co,
	input s3,
	input s2,
	input s1,
	input s0,
	output r3,
	output r2,
	output r1,
	output r0
);
	assign r0 = s0;
	assign r1 = ~s1 & (s2 | co);
	assign r2 = (s2 & s1) | (co & ~s2 & ~s1);
	assign r3 = co & ~s2 & s1;

endmodule
