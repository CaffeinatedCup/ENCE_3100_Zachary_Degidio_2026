module Part4_Top (
	input  [1:0] SW,
	output [2:0] LEDR
);

wire D, Clk;
wire Qa, Qb, Qc;

assign D   = SW[0];
assign Clk = SW[1];

assign LEDR[0] = Qa;
assign LEDR[1] = Qb;
assign LEDR[2] = Qc;

DFF Latch (
	.D(D),
	.Clk(Clk),
	.Q(Qa)
);

MasterSlaveDFF PosEdgeFF (
	.D(D),
	.Clk(Clk),
	.Q(Qb)
);

MasterSlaveDFF NegEdgeFF (
	.D(D),
	.Clk(~Clk),
	.Q(Qc)
);

endmodule
