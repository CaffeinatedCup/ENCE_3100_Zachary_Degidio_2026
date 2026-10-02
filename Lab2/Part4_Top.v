module Part4_Top(
	input [8:0] SW,
	output [7:0] HEX5,
	output [7:0] HEX4,
	output [7:0] HEX1,
	output [7:0] HEX0,
	output [9:0] LEDR
);
	wire [3:0] A = SW[7:4];
	wire [3:0] B = SW[3:0];

	wire [3:0] S0;
	wire S1;
	wire errA, errB;

	Part4_BCDAdder ADD0(.ci(SW[8]), .a(A), .b(B), .s(S0), .cout(S1));

	Part2_Comparator CMPA(.v(A), .z(errA));
	Part2_Comparator CMPB(.v(B), .z(errB));

	Seg7_Decoder DA (.m(A),          .out(HEX5));
	Seg7_Decoder DB (.m(B),          .out(HEX4));
	Seg7_Decoder DS0(.m(S0),         .out(HEX0));
	Seg7_Decoder DS1(.m({3'b0, S1}), .out(HEX1));

	assign LEDR[8:0] = SW[8:0];
	assign LEDR[9]   = errA | errB;

endmodule
