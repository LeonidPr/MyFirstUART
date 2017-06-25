module divider(input wire reset, input wire in_clk, output wire output_sync);

reg [7:0]counter;
reg div_out_prev, div_out;

always @(posedge in_clk)
begin
	if (reset == 1'b1)
	begin
		counter <= 8'd0;
		div_out <= 1'b0;
	end
	else
	begin
		counter <= counter + 8'd1;
		
		if (counter == 8'd107)
		begin
			counter <= 8'd0;
			div_out <= !div_out;
		end
	end
	
	div_out_prev <= div_out;
end
	assign output_sync = ~div_out_prev & div_out;
endmodule