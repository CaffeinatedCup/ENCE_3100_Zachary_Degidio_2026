
`default_nettype none

module main(
	// Board I/Os
	input		MAX10_CLK1_50,
	input 	[9:0]		SW,
	output	[9:0]		LEDR,
	inout		[35:0]	GPIO,
	output 	[7:0]		HEX0,
	output 	[7:0]		HEX1,
	output 	[7:0]		HEX2,
	output 	[7:0]		HEX3,
	output 	[7:0]		HEX4
	//inout		[15:0]	ARDUINO_IO
);

	
	wire w_clk = MAX10_CLK1_50;
	wire found, blink;
	wire [7:0] disp_char;
	wire RxD_data_ready;
	wire [7:0] RxD_data;
	reg [7:0] GPout;

	async_receiver RX(
		.clk(w_clk), 
		.RxD(GPIO[35]), 
		.RxD_data_ready(RxD_data_ready), 
		.RxD_data(RxD_data)
	);
	
	always @(posedge w_clk) 
		if(RxD_data_ready) 
			GPout <= RxD_data;

	async_transmitter TX(
		.clk(w_clk), 
		.TxD(GPIO[33]), 
		.TxD_start(RxD_data_ready), 
		.TxD_data(RxD_data)
	);
	
	assign disp_char = found ? (blink ? "o" : 8'h00) : GPout;
	assign LEDR[7:0] = GPout;

	wire [7:0] hex1_char = (found && blink) ? "l" : 8'h00;
	wire [7:0] hex2_char = (found && blink) ? "l" : 8'h00;
	wire [7:0] hex3_char = (found && blink) ? "e" : 8'h00;
	wire [7:0] hex4_char = (found && blink) ? "h" : 8'h00;

	char2seg Display0(
		.char(disp_char),
		.HEX0(HEX0)
	);

	char2seg Display1(
		.char(hex1_char),
		.HEX0(HEX1)
	);

	char2seg Display2(
		.char(hex2_char),
		.HEX0(HEX2)
	);

	char2seg Display3(
		.char(hex3_char),
		.HEX0(HEX3)
	);

	char2seg Display4(
		.char(hex4_char),
		.HEX0(HEX4)
	);
	
	
	word_detector WD(
	.clk(w_clk),
	.rst(SW[9]),
	.din(RxD_data),
	.din_valid(RxD_data_ready),
	.dout(blink),
	.found(found)
);


	
endmodule

`default_nettype wire
