module main (
	input  [9:0] SW,
	input  [1:0] KEY,
	output [7:0] HEX0,
	output [7:0] HEX1,
	output [7:0] HEX2,
	output [7:0] HEX3,
	output [7:0] HEX4,
	output [7:0] HEX5
);

reg [7:0] A;

always @ (posedge KEY[1] or negedge KEY[0])
	if (!KEY[0])
		A <= 8'b0;
	else
		A <= SW[7:0];

wire [7:0] B = SW[7:0];

Seg7_Decoder A_hi(.m(A[7:4]), .out(HEX3));
Seg7_Decoder A_lo(.m(A[3:0]), .out(HEX2));

Seg7_Decoder B_hi(.m(B[7:4]), .out(HEX1));
Seg7_Decoder B_lo(.m(B[3:0]), .out(HEX0));

assign HEX4 = 8'hFF;
assign HEX5 = 8'hFF;

endmodule
