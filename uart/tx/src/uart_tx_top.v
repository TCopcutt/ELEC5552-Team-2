module uart_tx_top(Clk,Rst_n,Uart_Tx,key_in0,led);

	input Clk;
	input Rst_n;
	input key_in0;
	
	output Uart_Tx;
	output led;
	
	
	wire send_en;
	//wire [7:0]data_byte;
	wire key_flag0;
	wire key_state0;
	
	assign send_en = key_flag0 & (!key_state0);
	
	
	uart_byte_tx uart_byte_tx(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.data_byte(8'haa),
		.send_en(send_en),
		.baud_set(3'd0),
		
		.Uart_Tx(Uart_Tx),
		.Tx_Done(),
		.uart_state(led)
	);
	
	key_filter key_filter0(
		.Clk(Clk),
		.Rst_n(Rst_n),
		.key_in(key_in0),
		.key_flag(key_flag0),
		.key_state(key_state0)
	);
	

endmodule
