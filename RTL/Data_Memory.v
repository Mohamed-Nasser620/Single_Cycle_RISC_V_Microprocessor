module Data_Memory 
(
input clk, WE,
input [31:0] Addr, WD,
output [31:0] RD
);

reg [31:0] data_mem [63:0];

always @ (posedge clk) begin

	if (WE) begin
		data_mem[Addr[31:2]] <= WD;	
	end

end

assign RD = data_mem[Addr[31:2]];

endmodule
