module P1_Counter_8bit(
	input ena,
	input clk,
	input clear,
	output [7:0] count
);

	wire [6:0] and_chain;

	assign and_chain[0] = ena & count[0];
	assign and_chain[1] = and_chain[0] & count[1];
	assign and_chain[2] = and_chain[1] & count[2];
	assign and_chain[3] = and_chain[2] & count[3];
	assign and_chain[4] = and_chain[3] & count[4];
	assign and_chain[5] = and_chain[4] & count[5];
	assign and_chain[6] = and_chain[5] & count[6];

	TFlipFlop TFF_0(
		.T(ena),
		.clk(clk),
		.clear(clear),
		.Qt(count[0])
	);
	TFlipFlop TFF_1(
		.T(and_chain[0]),
		.clk(clk),
		.clear(clear),
		.Qt(count[1])
	);
	TFlipFlop TFF_2(
		.T(and_chain[1]),
		.clk(clk),
		.clear(clear),
		.Qt(count[2])
	);
	TFlipFlop TFF_3(
		.T(and_chain[2]),
		.clk(clk),
		.clear(clear),
		.Qt(count[3])
	);
	TFlipFlop TFF_4(
		.T(and_chain[3]),
		.clk(clk),
		.clear(clear),
		.Qt(count[4])
	);
	TFlipFlop TFF_5(
		.T(and_chain[4]),
		.clk(clk),
		.clear(clear),
		.Qt(count[5])
	);
	TFlipFlop TFF_6(
		.T(and_chain[5]),
		.clk(clk),
		.clear(clear),
		.Qt(count[6])
	);
	TFlipFlop TFF_7(
		.T(and_chain[6]),
		.clk(clk),
		.clear(clear),
		.Qt(count[7])
	);

endmodule
