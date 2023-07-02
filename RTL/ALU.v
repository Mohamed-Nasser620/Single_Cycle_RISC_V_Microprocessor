module ALU 
(
input [2:0] ALUControl, 
input [31:0] SrcA, SrcB,
output reg [31:0] ALUResult, 
output reg CF, ZF, SF
);

reg [32:0] out_tot;
always @ (*) begin

case(ALUControl) 

3'b000: out_tot = SrcA + SrcB;
3'b001: out_tot = SrcA << SrcB;
3'b010: out_tot = SrcA - SrcB;
3'b100: out_tot = SrcA ^ SrcB;
3'b101: out_tot = SrcA >> SrcB;
3'b110: out_tot = SrcA | SrcB;
3'b111: out_tot = SrcA & SrcB;
default: out_tot = 33'b0;

endcase

ALUResult = out_tot[31:0];
CF = out_tot[32];
ZF = ~|(ALUResult);
SF = ALUResult[31];

end

endmodule
