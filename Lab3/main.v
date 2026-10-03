module main (
	input D,
	input Clk,
	output Q
);

wire Qm;

DFF Master (
	.D(D),
	.Clk(~Clk),
	.Q(Qm)
);

DFF Slave (
	.D(Qm),
	.Clk(Clk),
	.Q(Q)
);

endmodule
