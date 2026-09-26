module FullAdder(
	input ci,
	input a,
	input b,
	output s,
	output co
);
	assign s  = a ^ b ^ ci;
	assign co = (a & b) | (ci & (a ^ b));

endmodule
