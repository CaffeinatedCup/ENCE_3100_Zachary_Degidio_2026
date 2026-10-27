module word_detector (
	input clk,
	input rst,
	input [7:0] din,
	input din_valid,
	output dout,
	output found
);

	assign found = (state == S5);
	assign dout = found && blink_cnt[25];

	parameter CHAR0 = "h";
	parameter CHAR1 = "e";
	parameter CHAR2 = "l";
	parameter CHAR3 = "l";
	parameter CHAR4 =	"o";


	reg [2:0] state, next_state;
	
	reg [27:0] blink_cnt;


	localparam 
	IDLE = 3'b000,
	S1 = 3'b001,
	S2 = 3'b010,
	S3 = 3'b011,
	S4 = 3'b100,
	S5 = 3'b101;


	

	always @(posedge clk) begin
		if(rst) begin
			state <= IDLE;
			blink_cnt <= 0;
		end
		else begin
			state <= next_state;
			if(state == S5)
				blink_cnt <= blink_cnt + 1;
			else
				blink_cnt <= 0;
		end
	end
	
	always @(*) begin
		next_state = state;
		case (state)
			IDLE: if (din_valid) next_state = din == CHAR0 ? S1 : IDLE;
			S1: if (din_valid) next_state = din == CHAR1 ? S2 : IDLE;
			S2: if (din_valid) next_state = din == CHAR2 ? S3 : IDLE;
			S3: if (din_valid) next_state = din == CHAR3 ? S4 : IDLE;
			S4: if (din_valid) next_state = din == CHAR4 ? S5 : IDLE;
			S5: if (blink_cnt[27]) next_state = IDLE;
			default: next_state = IDLE;
		endcase
	
	end

	
	
endmodule