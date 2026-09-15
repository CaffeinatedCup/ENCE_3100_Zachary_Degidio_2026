module mux_2_1(
	input	[7:0] s,
	input [7:0] x,
	input [7:0] y,
	output [7:0] m
);
	mux_2_1 MUX0(
	.s(s[0]),
	.x(x[0]),
	.y(y[0]),
	.m(m[0])
);	
mux_2_1 MUX1(
	.s(s[1]),
	.x(x[1]),
	.y(y[1]),
	.m(m[1])
);	
mux_2_1 MUX2(
	.s(SW[0]),
	.x(SW[1]),
	.y(SW[2]),
	.m(LEDR[0])
);	
mux_2_1 MUX_0(
	.s(SW[0]),
	.x(SW[1]),
	.y(SW[2]),
	.m(LEDR[0])
);	
mux_2_1 MUX_0(
	.s(SW[0]),
	.x(SW[1]),
	.y(SW[2]),
	.m(LEDR[0])
);	
mux_2_1 MUX_0(
	.s(SW[0]),
	.x(SW[1]),
	.y(SW[2]),
	.m(LEDR[0])
);	
mux_2_1 MUX_0(
	.s(SW[0]),
	.x(SW[1]),
	.y(SW[2]),
	.m(LEDR[0])
);	
mux_2_1 MUX_0(
	.s(SW[0]),
	.x(SW[1]),
	.y(SW[2]),
	.m(LEDR[0])
);
endmodule