module Seg7_Display(
	input [3:0] bin_number,
	output reg [7:0] seg_display
);
	
always @(*) begin
  case (bin_number)
    4'd0:  seg_display = 8'b1100_0000; // 0x0C0  a b c d e f
    4'd1:  seg_display = 8'b1111_1001; // 0xF9   b c
    4'd2:  seg_display = 8'b1010_0100; // 0xA4   a b d e g
    4'd3:  seg_display = 8'b1011_0000; // 0xB0   a b c d g
    4'd4:  seg_display = 8'b1001_1001; // 0x99   b c f g
    4'd5:  seg_display = 8'b1001_0010; // 0x92   a c d f g
    4'd6:  seg_display = 8'b1000_0010; // 0x82   a c d e f g
    4'd7:  seg_display = 8'b1111_1000; // 0xF8   a b c
    4'd8:  seg_display = 8'b1000_0000; // 0x80   all
    4'd9:  seg_display = 8'b1001_0000; // 0x90   a b c d f g
    4'd10: seg_display = 8'b1000_1000; // 0x88   A
    4'd11: seg_display = 8'b1000_0011; // 0x83   b
    4'd12: seg_display = 8'b1100_0110; // 0xC6   C
    4'd13: seg_display = 8'b1010_0001; // 0xA1   d
    4'd14: seg_display = 8'b1000_0110; // 0x86   E
    4'd15: seg_display = 8'b1000_1110; // 0x8E   F
    default: seg_display = 8'b1111_1111; // all off
   endcase
end

endmodule