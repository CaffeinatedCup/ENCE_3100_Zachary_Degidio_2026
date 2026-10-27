module P2_Counter_16bit(
	input ena,
	input clk,
	input clear,
	output reg [15:0] count
);

	always @(posedge clk) begin
		if (clear)
			count <= 16'd0;
		else if (ena)
			count <= count + 1'b1;
	end

endmodule
