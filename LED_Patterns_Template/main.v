module main(
	// Board I/Os
	input		MAX10_CLK1_50,
	input 	[9:0]		SW,
	output	[9:0]		LEDR,
	output	[35:0]	GPIO
);

	//states
	//localparam 

	
	
	// 2 Next-State logic
	always @(*) begin
		next_state = A;
		
		case(state)
			A: next_state = W ? C : B;
			B: next_state = W ? A : E;
			C: next_state = W ? A : D;
			D: next_state = W ? 
	
	end
	
	// 3 Output logic
	
	
	always @(*) begin
	
		Y = 3'b111 // default state
		
		case(state)
			A: Y = 3'b111;
			B: Y = 3'b111;
			C: Y = 3'b111;
			D: Y = 3'b111;
			E: Y = 3'b111;
			F: Y = 3'b111;
		
		endcase
	
	end
		
	wire w_clk = MAX10_CLK1_50;

	wire w_tick;
	
	wire [9:0] w_counter0;
	wire [9:0] w_counter1;
	wire [9:0] w_counter2;
	wire [9:0] w_counter3;
	wire [9:0] w_counter4;
	wire [9:0] w_counter5;
	
	/*
	// fill out with wires
	MUX8_1_10bits M0(
	.in0(w_counter0),
	.in1(),
	.in2(),
	.in3(),
	.in4(),
	.in5(),
	.in6(),
	.in7(),
	.sel(),
	.out()
);
	*/
	
	// Patterns
	Pattern5 Patt (
		.clk(w_clk),
		.rst(SW[9]),
		.en(SW[8]),
		.dir(SW[0]),                 
		.counter(LEDR[9:0])
	);

endmodule
