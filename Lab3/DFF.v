module DFF (
	input D,
	input Clk,
	output reg Q
);
	always @ (D, Clk)
		if (Clk)
			Q = D;

endmodule
