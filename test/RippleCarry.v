module RippleCarry (
	input [7:0] A,
	input [7:0] B,
	input Cin,
	output Sum,
	output Cout
);

	wire [8:0] C;
	
	assign C[0] = Cin;
	assign Cout = C[8];

	genvar = i;

	generate
		if(i = 0; i < 8; i = i + 1) begin :gen_adder
		FullAdder FA (
			.A(A[i]),
			.B(B[i]),
			.Cin(C[i]),
			.Sum(Sum[i],
			.Cout(C[i + 1])
		);

		end
	endgenerate
	
endmodule