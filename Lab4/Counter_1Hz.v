module Counter_1Hz (
	input in_clk,
	input clear,
	output reg out_clk
);

	reg [25:0] count;

	always @(posedge in_clk) begin
		if(clear) begin
			count <= 25'd0;
			out_clk <= 1'b0;
		end
		else
			if(count == 26'd24_999_999) begin
				count <= 26'd0;
				out_clk <= ~out_clk;
		end
		else begin
			count <= count + 1'b1;
		end
	end
endmodule