module divider(input wire reset, input wire in_clk, output reg output_clk);

reg [7:0]counter;

always @(posedge in_clk)
begin
	if (reset == 1'b1)
	begin
		counter <= 8'd0;
		output_clk <= 1'b0;
	end
	else
	begin
		counter <= counter + 8'd1;
		
		if (counter == 8'd107)
		begin
			counter <= 8'd0;
			output_clk <= !output_clk;
		end
	end
end
endmodule