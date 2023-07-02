module ALU_Decoder
(
input OP, funct7,
input [2:0] funct3,
input [1:0] ALUOP,
output reg [2:0] ALUControl
);
 
always @ (*) begin

	case (ALUOP)
		2'b 00: ALUControl = 3'b 000;
		2'b 01: ALUControl = 3'b 010;
		2'b 10: 
		begin
			if ((funct3 == 3'b 000) && ({OP, funct7} != 2'b 11))
				ALUControl = 3'b 000;
			else if ((funct3 == 3'b 000) && ({OP, funct7} == 2'b 11))
				ALUControl = 3'b 010;
			else if (funct3 == 3'b 001)
				ALUControl = 3'b 001;
			else if (funct3 == 3'b 100)
				ALUControl = 3'b 100;
			else if (funct3 == 3'b 101)
				ALUControl = 3'b 101;
			else if (funct3 == 3'b 110)
				ALUControl = 3'b 110;
			else if (funct3 == 3'b 111)
				ALUControl = 3'b 111;
			else
				ALUControl = 3'b 000;
		end
		default: ALUControl = 3'b 000;

	endcase

end

endmodule
