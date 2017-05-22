module uart_tx(input wire clk, input wire rst, input wire tx_start, input wire [7:0]tx_in, output reg tx_out, output reg tx_finish);
parameter [1:0]STATE_IDLE	=2'b00;
parameter [1:0]STATE_TX_START	=2'b01;
parameter [1:0]STATE_TX_DATA	=2'b10;
parameter [1:0]STATE_TX_STOP	=2'b11;

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
        tx_finish <= 0;
	clk_count <= 0;
	bit_count <= 0;
	tx_out <= 1;
    end
    else
    begin
        if (tx_start)
        begin
            case (state)
                STATE_IDLE:
                begin
                    data <= tx_in;
                    state <= STATE_TX_START;
                    tx_out <= 0;
                    bit_count <= 0;
                    clk_count <= 0;
                end
                STATE_TX_START:
                begin
                    if (clk_count == 2'b01)
                    begin
                        state <= STATE_TX_DATA;
                        tx_out <= data[0];
                        data <= data>>1;
                        bit_count <= 1;
                    end
                end
                STATE_TX_DATA:
                begin
                    if (clk_count == 2'b01)
                    begin
                        if (bit_count<8)
                        begin
                            tx_out <= data[0];
                            data <= data>>1;
                            bit_count <= bit_count +1;
                        end
                        else
                        begin
                            state <= STATE_TX_STOP;
                            tx_out <= 1;
                        end
                    end
                end
                STATE_TX_STOP:
                    if (clk_count == 2'b01)
                    begin
                        state <= STATE_IDLE;
                        tx_finish <= 1;
                    end
            endcase
        end
    end
    
    if (state != STATE_IDLE)
        if (clk_count<1)
            clk_count <= clk_count + 2'b01;
        else
            clk_count <= 2'b00;
end

endmodule