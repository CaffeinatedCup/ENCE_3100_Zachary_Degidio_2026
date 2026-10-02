module Part3_Top(
	input [8:0] SW,
	output [8:0] LEDR
);
	wire c1, c2, c3, cout;
	wire [3:0] sum;

	FullAdder FA0(.ci(SW[8]), .a(SW[4]), .b(SW[0]), .s(sum[0]), .co(c1));
	FullAdder FA1(.ci(c1),    .a(SW[5]), .b(SW[1]), .s(sum[1]), .co(c2));
	FullAdder FA2(.ci(c2),    .a(SW[6]), .b(SW[2]), .s(sum[2]), .co(c3));
	FullAdder FA3(.ci(c3),    .a(SW[7]), .b(SW[3]), .s(sum[3]), .co(cout));

	assign LEDR[8:6] = SW[8:6];
	assign LEDR[5]   = cout | (sum[3] & (sum[2] | (sum[1] & sum[0])));
	assign LEDR[4]   = cout;
	assign LEDR[3:0] = sum;

endmodule
