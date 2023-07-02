module PC
(
input clk, async_reset, load,
input [31:0] PCNext,
output reg [31:0] PC
);

// Program Counter Register

always @ (posedge clk or negedge async_reset) begin
	
	if (~async_reset) begin
		PC <= 0;
	end

	else begin
		if (load) begin	
			PC <= PCNext;
		end
	end

end

endmodule
