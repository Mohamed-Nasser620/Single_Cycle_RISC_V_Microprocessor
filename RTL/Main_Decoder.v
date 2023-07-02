module Main_Decoder
(
input [6:0] OP,
output reg ResultSrc, MemWrite, ALUSrc, RegWrite, branch, load,
output reg [1:0] ImmSrc, ALUOP
);
 
always @ (*) begin

	case (OP)
		7'b 000_0011: 
		begin
			RegWrite = 1'b 1;
			ImmSrc = 2'b 00;
			ALUSrc = 1'b 1;
			MemWrite = 1'b 0;
			ResultSrc = 1'b 1;
			branch = 1'b 0;
			ALUOP = 2'b 00;
			load = 1'b 1;
		end

		7'b 010_0011: 
		begin
			RegWrite = 1'b 0;
			ImmSrc = 2'b 01;
			ALUSrc = 1'b 1;
			MemWrite = 1'b 1;
			ResultSrc = 1'b 0;
			branch = 1'b 0;
			ALUOP = 2'b 00;
			load = 1'b 1;
		end

		7'b 011_0011: 
		begin
			RegWrite = 1'b 1;
			ImmSrc = 2'b 00;
			ALUSrc = 1'b 0;
			MemWrite = 1'b 0;
			ResultSrc = 1'b 0;
			branch = 1'b 0;
			ALUOP = 2'b 10;
			load = 1'b 1;
		end

		7'b 001_0011: 
		begin
			RegWrite = 1'b 1;
			ImmSrc = 2'b 00;
			ALUSrc = 1'b 1;
			MemWrite = 1'b 0;
			ResultSrc = 1'b 0;
			branch = 1'b 0;
			ALUOP = 2'b 10;
			load = 1'b 1;
		end

		7'b 110_0011: 
		begin
			RegWrite = 1'b 0;
			ImmSrc = 2'b 10;
			ALUSrc = 1'b 0;
			MemWrite = 1'b 0;
			ResultSrc = 1'b 0;
			branch = 1'b 1;
			ALUOP = 2'b 01;
			load = 1'b 1;
		end

		default: 
		begin
			RegWrite = 1'b 0;
			ImmSrc = 2'b 00;
			ALUSrc = 1'b 0;
			MemWrite = 1'b 0;
			ResultSrc = 1'b 0;
			branch = 1'b 0;
			ALUOP = 2'b 00;
			load = 1'b 0;
		end
	endcase

end

endmodule
