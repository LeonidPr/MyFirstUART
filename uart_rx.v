module uart_rx(input wire clk, input wire rst, input wire rx, output reg [7:0]out, output reg recv_finish);
parameter [1:0]STATE_IDLE	=2'b00;
parameter [1:0]STATE_RX_START	=2'b01;
parameter [1:0]STATE_RX_STOP	=2'b10;

reg [1:0]state;
reg [8:0]data;
reg [1:0]clk_count;
reg [4:0]bit_count;

always @(posedge clk)
begin
    if (rst)
    begin
        state <= STATE_IDLE;
        data <= 8'h00;
        out <= 8'h00;
        recv_finish <= 0;
	clk_count <= 0;
	bit_count <= 0;
    end
    else
    begin
	case (state)
	    STATE_IDLE:
		begin
		    if (rx == 0)
		    begin
			clk_count <= 0;
			data <= 0;
			bit_count <= 0;
			state <= STATE_RX_START;
		    end
		end
	    STATE_RX_START:
		begin
		    if (clk_count < 2'b01)
			clk_count <= clk_count + 2'b01;
		    else
		    begin
                        clk_count <= 2'b00;
                        if (bit_count < 4'h8)
                        begin
                            data <= data>>1;
                            data[7] <= rx;
                            bit_count <= bit_count + 4'h1;
                        end
                        else
                        begin
                            out <= data;
                            recv_finish = 1;
                        end
		    end
		end
        endcase
    end
end

endmodule