module main(
	input [9:0] SW,
	output [9:0] LEDR
);


	/*
	//assign LEDR[9:0] = SW[9:0];
	
	
	wire signed [3:0] A = SW[3:0];
	wire signed [3:0] B = SW[7:4];
	wire [7:0] P;
	//wire [3:0] sum;
	//wire cout;
	
	//assign {cout, sum} = A + B;
	
	//assign LEDR[3:0] = sum;
	//assign LEDR[4] = cout;
	
	//assign LEDR[9] = (A[3] & B[3] & ~sum[3]) + (~A[3] & ~B[3] & sum[3]);
	assign P = A * B;
	
	assign LEDR[7:0] = P;
	*/
	
	ram32x8_LUT LUT0(
	.clk(SW[9]),
	.we(SW[8]),
	.addr(SW[4:0]),
	.din({ 5'd0, SW[7:0]}),
	.dout(LEDR[7:0])
);
	
endmodule