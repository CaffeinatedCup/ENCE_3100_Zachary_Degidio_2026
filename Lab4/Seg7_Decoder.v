module Seg7_Decoder(
	input [3:0] m,
	output reg [7:0] out
);

	always @(*) begin
		case (m)
			4'h0: out = 8'hC0;
			4'h1: out = 8'hF9;
			4'h2: out = 8'hA4;
			4'h3: out = 8'hB0;
			4'h4: out = 8'h99;
			4'h5: out = 8'h92;
			4'h6: out = 8'h82;
			4'h7: out = 8'hF8;
			4'h8: out = 8'h80;
			4'h9: out = 8'h90;
			4'hA: out = 8'h88;
			4'hB: out = 8'h83;
			4'hC: out = 8'hC6;
			4'hD: out = 8'hA1;
			4'hE: out = 8'h86;
			4'hF: out = 8'h8E;
			default: out = 8'hFF;
		endcase
	end

endmodule
