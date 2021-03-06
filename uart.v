module uart(input wire clk_in, input wire rst_in, input wire rx_in, output wire tx_out, output wire [7:0]rx_val);

wire sync;
wire rst;
wire rx_line;
wire rx_finish;
wire [7:0]rx_data;
wire tx_finish;

assign rst=~rst_in;

synchronizer sync_rx(rst, clk_in, rx_in, rx_line);
divider br_div(rst, clk_in, sync);
uart_rx receiver(clk_in, sync, rst, rx_line, rx_data, rx_finish);
uart_tx transmitter(clk_in, sync, rst, rx_finish, rx_data, tx_out, tx_finish);

assign rx_val = ~rx_data;
endmodule