moduel AND8(
	input [7:0] A,
	input [7:0] B,
	output [7:0] Y,
	);
	
	genvar i;
	
	generate
		if(i = 0; i < 8; i = i + 1) begin
			assign Y[i] = A[i] & B[i];
		end
	endgenerate
	
endmodule