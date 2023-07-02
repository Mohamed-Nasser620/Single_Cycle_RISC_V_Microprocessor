module RISC_V
(
input clk, reset
);

//Control Unit Block Instantiation
wire [31:0] Instr;
wire ZF, SF, CF, PCSrc, ResultSrc, MemWrite, ALUSrc, RegWrite, load;
wire [1:0] ImmSrc;
wire [2:0] ALUControl;
Control_Unit CU (.OP(Instr[6:0]), .funct3(Instr[14:12]), .funct7(Instr[30]), .ZF(ZF), .SF(SF), .PCSrc(PCSrc), 
                 .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .ImmSrc(ImmSrc), 
		 .load(load), .ALUControl(ALUControl));

// Sign Extension Block Instantiation
wire [31:0] ImmExt;
Sign_Extend S_Ex (.ImmSrc(ImmSrc), .ImmExt(ImmExt), .ImmIn(Instr[31:7]));

// Program Counter Block Instantiation
wire [31:0] PCNext, PC;
PC ProgCount (.clk(clk), .async_reset(reset), .PCNext(PCNext), .load(load), .PC(PC));

// Next Count Logic
wire [31:0] PCPlus4, PCTarget;
assign PCPlus4 = (PC + 32'd 4);
assign PCTarget = (PC + ImmExt);
assign PCNext = (~PCSrc)? PCPlus4 : PCTarget;

//Instruction Memory Block Instantiation
Instruction_Memory I_Mem (.A(PC), .RD(Instr));

//Register File Block Instantiation
wire [31:0] SrcA, WriteData, Result;
Reg_File RF (.clk(clk), .async_reset(reset), .WE(RegWrite), .RA_addr(Instr[19:15]), .RB_addr(Instr[24:20]), .W_addr(Instr[11:7]), 
	     .WD(Result), .RDA(SrcA), .RDB(WriteData));

// ALU Block Instantiation
wire [31:0] SrcB, ALUResult;
assign SrcB = (~ALUSrc)? WriteData: ImmExt; 
ALU ALU (.ALUControl(ALUControl), .SrcA(SrcA), .SrcB(SrcB), .ALUResult(ALUResult), .CF(CF), .ZF(ZF), .SF(SF));

//Data Memory Block Instantiation
wire [31:0] ReadData;
Data_Memory D_Mem (.clk(clk), .WE(MemWrite), .Addr(ALUResult), .WD(WriteData), .RD(ReadData));

//Result Logic
assign Result = (ResultSrc)? ReadData: ALUResult;

endmodule
