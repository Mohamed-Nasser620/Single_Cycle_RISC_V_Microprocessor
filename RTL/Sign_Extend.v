module Sign_Extend
(
input [1:0] ImmSrc,
input [24:0] ImmIn,
output reg [31:0] ImmExt
);

always @ (*) begin

	case (ImmSrc)

		2'b00: ImmExt = { {20{ImmIn[24]}}, ImmIn[24:13] };
		2'b01: ImmExt = { {20{ImmIn[24]}}, ImmIn[24:18], ImmIn[4:0] };
		2'b10: ImmExt = { {20{ImmIn[24]}}, ImmIn[0], ImmIn[23:18], ImmIn[4:1], 1'b0 };
		default: ImmExt = 32'd 0;

	endcase

end

endmodule
