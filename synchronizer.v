module synchronizer(input wire rst, input wire clk, input wire async_in, output reg sync_out);
reg stage1, stage2;

always @(posedge clk)
begin
	if (rst)
	begin
		sync_out <= 0;
		stage1 <= 0;
		stage2 <= 0;
	end
	else
	begin
		sync_out <= stage2;
		stage2 <= stage1;
		stage1 <= async_in;
	end
end
endmodule