module uart_rx_top(Clk,Rst_n,Rs232_Rx);

	input Clk;
	input Rst_n;
	input Rs232_Rx;
	
	reg [7:0]data_rx_r;
	wire [7:0]data_rx;
	wire Rx_Done;
	
	uart_byte_rx uart_byte_rx(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.baud_set(3'd0),
		.Rs232_Rx(Rs232_Rx),
		
		.data_byte(data_rx),
		.Rx_Done(Rx_Done)
	);
	

	
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		data_rx_r <= 8'd0;
	else if(Rx_Done)
		data_rx_r <= data_rx;
	else
		data_rx_r <= data_rx_r;
		
endmodule
