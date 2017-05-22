module uart_test;

reg clk;
reg rst;
reg rx_line;
wire rx_finish;
wire [7:0]rx_data;
wire tx_out;
wire tx_finish;

always
    #10 clk = ~clk;

uart_rx receiver(clk, rst, rx_line, rx_data, rx_finish);
uart_tx transmitter(clk, rst, rx_finish, rx_data, tx_out, tx_finish);
initial
begin
    $dumpfile("uart_rx.vcd");
    $dumpvars(0,uart_test);

    clk = 0;
    rst = 1;
    rx_line = 1;
    #20 rst = 0;
    #40 rx_line = 0;
    #40 rx_line = 1;
    #40 rx_line = 0;
    #40 rx_line = 1;
    #40 rx_line = 0;
    #40 rx_line = 1;
    #40 rx_line = 0;
    #40 rx_line = 1;
    #40 rx_line = 0;
    #40 rx_line = 1;
    #850 $finish;
end
endmodule