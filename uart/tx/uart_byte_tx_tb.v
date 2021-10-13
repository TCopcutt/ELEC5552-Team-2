`timescale 1ns/1ns
`define clk_period 20

module uart_byte_tx_tb;

	reg Clk;
	reg Rst_n;
	reg key_in0=1;
	wire	Uart_Tx;
	wire Rs232_Tx;
	wire	led;
	
	uart_tx_top uart_tx_top(
	.Clk		(Clk		),
	.Rst_n		(Rst_n		),
	.Uart_Tx	(Uart_Tx	),
	.key_in0	(key_in0	),
	.led        (led        )
	);
	
	
	initial Clk = 1;
	always#(`clk_period/2)Clk = ~Clk;
	
	initial begin
		Rst_n = 1'b0;
		#(`clk_period*20 + 1 )
		Rst_n = 1'b1;
		#(`clk_period*50);
		key_in0 = 1'd0;
		#(`clk_period*50);
		key_in0 = 1'd1;
		
		#(`clk_period*5000);

		#(`clk_period*60000);
		$stop;	
	end

endmodule
