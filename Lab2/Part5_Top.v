module Part5_Top(
	input [7:0] SW,
	output [7:0] HEX5,
	output [7:0] HEX4,
	output [7:0] HEX3,
	output [7:0] HEX2,
	output [7:0] HEX1,
	output [7:0] HEX0,
	output [9:0] LEDR
);
	wire [3:0] A1 = SW[7:4];
	wire [3:0] A0 = SW[3:0];

	// DE10 only has 8 usable data switches here, so B1B0 is fixed at 45.
	wire [3:0] B1 = 4'd4;
	wire [3:0] B0 = 4'd5;

	wire c1;
	wire [3:0] S0, S1;
	wire S2;

	Part4_BCDAdder ADD0(.ci(1'b0), .a(A0), .b(B0), .s(S0), .cout(c1));
	Part4_BCDAdder ADD1(.ci(c1),   .a(A1), .b(B1), .s(S1), .cout(S2));

	Seg7_Decoder DA1(.m(A1), .out(HEX5));
	Seg7_Decoder DA0(.m(A0), .out(HEX4));
	Seg7_Decoder DB1(.m(B1), .out(HEX3));
	Seg7_Decoder DB0(.m(B0), .out(HEX2));
	Seg7_Decoder DS1(.m(S1), .out(HEX1));
	Seg7_Decoder DS0(.m(S0), .out(HEX0));

	assign LEDR[7:0] = SW[7:0];
	assign LEDR[8]   = 1'b0;
	assign LEDR[9]   = S2;

endmodule
