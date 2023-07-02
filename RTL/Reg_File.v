module Reg_File (
input clk, async_reset, WE, 
input [4:0] RA_addr, RB_addr, W_addr,
input [31:0] WD, 
output [31:0] RDA, RDB
);

reg [31:0] reg_file [31:0];
integer i = 0;

// Write Operation
always @ (posedge clk or negedge async_reset) begin

	if (~async_reset)
	begin
		for (i = 0; i < 32; i = i + 1)
		begin
			reg_file[i] <= 0;
		end
	end

	else if (WE)
	begin
		reg_file[W_addr] <= WD;
	end

end

// Read Operation
assign RDA = reg_file[RA_addr];
assign RDB = reg_file[RB_addr];

endmodule
