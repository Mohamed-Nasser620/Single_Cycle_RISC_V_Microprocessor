module Control_Unit
(
input [6:0] OP,
input [2:0] funct3,
input funct7, ZF, SF,
output reg PCSrc, 
output ResultSrc, MemWrite, ALUSrc, RegWrite, load,
output [1:0] ImmSrc,
output [2:0] ALUControl
);

// Main Decoder Block Instantiation
wire branch;
wire [1:0] ALUOP;
Main_Decoder Dec1 (.OP(OP), .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), 
		   .branch(branch), .ALUOP(ALUOP), .ImmSrc(ImmSrc), .load(load));

// ALU Decoder Block Instantiation 
ALU_Decoder Dec2 (.OP(OP[5]), .funct7(funct7), .funct3(funct3), .ALUOP(ALUOP), .ALUControl(ALUControl));

// Program Counter Source Logic
always @ (*) begin

	case (funct3)
		3'b 000: PCSrc = branch & ZF;           // beq
		3'b 001: PCSrc = branch & (~ZF);        // bnq
		3'b 100: PCSrc = branch & SF;           // blt
		default: PCSrc = 0;
	endcase

end

endmodule
