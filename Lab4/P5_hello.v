// P5_hello.v - Lab 4 Part V
// Scrolling "HELLO" ticker tape across the 7-segment displays.
//
// Standalone module. Nothing else in the project references it; to run it,
// add this file to the project and set P5_hello as the top-level entity.
//
// Board note: the lab targets a DE2 with eight displays (HEX7-0). The DE10-Lite
// has six (HEX5-0), so the rotating window is 6 characters ("_HELLO") instead
// of 8 ("___HELLO"), and the pattern repeats every 6 seconds instead of 8.
//
//   SW[0]  up = run,    down = clear (reloads "_HELLO" right-aligned)
//   SW[1]  up = scroll,  down = pause
//
// Every flip-flop is clocked directly by MAX10_CLK1_50, as Part IV requires.
// The 1 Hz rate comes from a tick enable, not from a derived clock.

module P5_hello (
	input  MAX10_CLK1_50,
	input  [9:0] SW,
	output [7:0] HEX0,
	output [7:0] HEX1,
	output [7:0] HEX2,
	output [7:0] HEX3,
	output [7:0] HEX4,
	output [7:0] HEX5
);

	wire clear  = ~SW[0];
	wire enable =  SW[1];

	// 7-segment codes, {DP,g,f,e,d,c,b,a}, active low.
	// CH_E and CH_O match the 4'hE and 4'h0 entries in Seg7_Decoder.v.
	localparam [7:0] CH_H = 8'b1000_1001;     // b c e f g
   localparam [7:0] CH_E = 8'b1000_0110;     // a d e f g
   localparam [7:0] CH_L = 8'b1100_0111;     // d e f
   localparam [7:0] CH_O = 8'b1100_0000;     // a b c d e f, same as '0'
   localparam [7:0] BLNK = 8'b1111_1111;     // all segments off
	localparam [47:0] HELLO = {BLNK, CH_H, CH_E, CH_L, CH_L, CH_O};

	// ---- 1 Hz tick -------------------------------------------------------
	// One 20 ns pulse per second. A pulse, not a square wave: it gates an
	// enable, so it has to be exactly one clock cycle wide.
	localparam [25:0] ONE_SEC = 26'd49_999_999;

	reg [25:0] div = 26'd0;
	wire tick = (div == ONE_SEC);

	always @(posedge MAX10_CLK1_50) begin
		if (clear)
			div <= 26'd0;
		else if (tick)
			div <= 26'd0;
		else
			div <= div + 1'b1;
	end

	// ---- rotating character buffer ---------------------------------------
	// [47:40] drives HEX5 (leftmost) down to [7:0] driving HEX0 (rightmost).
	// Each tick slides every character one display to the left and wraps the
	// character leaving HEX5 back around onto HEX0. That concatenation is the
	// whole ticker-tape effect.
	reg [47:0] pattern = HELLO;

	always @(posedge MAX10_CLK1_50) begin
		if (clear)
			pattern <= HELLO;
		else if (enable && tick)
			pattern <= {pattern[39:0], pattern[47:40]};
	end

	assign HEX5 = pattern[47:40];
	assign HEX4 = pattern[39:32];
	assign HEX3 = pattern[31:24];
	assign HEX2 = pattern[23:16];
	assign HEX1 = pattern[15:8];
	assign HEX0 = pattern[7:0];

endmodule
