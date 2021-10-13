module uart_byte_tx(
	Clk,
	Rst_n,
	data_byte,
	send_en,
	baud_set,
	
	Uart_Tx,
	Tx_Done,
	uart_state
);

	input Clk;
	input Rst_n;
	input [7:0]data_byte;
	input send_en;
	input [2:0]baud_set;
	
	output reg Uart_Tx;
	output reg Tx_Done;
	output reg uart_state;
	
	reg bps_clk;	//Baudrate clock波特率时钟
	
	reg [15:0]div_cnt;//fre divider counter 分频计数器
	
	reg [15:0]bps_DR;//maximun of fre divider分频计数最大值
	
	reg [3:0]bps_cnt;//Baudrate clokc counter 波特率时钟计数器
	
	reg [7:0]r_data_byte;
	
	localparam START_BIT = 1'b0;
	localparam STOP_BIT = 1'b1;
	
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		uart_state <= 1'b0;
	else if(send_en)
		uart_state <= 1'b1;
	else if(bps_cnt == 4'd11)
		uart_state <= 1'b0;
	else
		uart_state <= uart_state;
	
	
	//store the data to be sent once send_en=1
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		r_data_byte <= 8'd0;
	else if(send_en)
		r_data_byte <= data_byte;
	else
		r_data_byte <= r_data_byte;
	
	
	//LUT of baudrate
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		bps_DR <= 16'd5207;
	else begin
		case(baud_set)
			0:bps_DR <= 16'd5207; //9600
			1:bps_DR <= 16'd2603; //19200
			2:bps_DR <= 16'd1301; //38400
			3:bps_DR <= 16'd867;  //57600 
			4:bps_DR <= 16'd433;  //115200
			default:bps_DR <= 16'd5207;			
		endcase
	end	
	
	//counter
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		div_cnt <= 16'd0;
	else if(uart_state)begin
		if(div_cnt == bps_DR)
			div_cnt <= 16'd0;
		else
			div_cnt <= div_cnt + 1'b1;
	end
	else
		div_cnt <= 16'd0;
	
	// bps_clk gen
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		bps_clk <= 1'b0;
	else if(div_cnt == 16'd1)
		bps_clk <= 1'b1;
	else
		bps_clk <= 1'b0;
	
	//bps counter
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)	
		bps_cnt <= 4'd0;
	else if(bps_cnt == 4'd11)
		bps_cnt <= 4'd0;
	else if(bps_clk)
		bps_cnt <= bps_cnt + 1'b1;
	else
		bps_cnt <= bps_cnt;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Tx_Done <= 1'b0;
	else if(bps_cnt == 4'd11)
		Tx_Done <= 1'b1;
	else
		Tx_Done <= 1'b0;
		
	always@(posedge Clk or negedge Rst_n)
	if(!Rst_n)
		Uart_Tx <= 1'b1;
	else begin
	
		case(bps_cnt)
			0:Uart_Tx <= 1'b1;
			1:Uart_Tx <= START_BIT;
			2:Uart_Tx <= r_data_byte[0];
			3:Uart_Tx <= r_data_byte[1];
			4:Uart_Tx <= r_data_byte[2];
			5:Uart_Tx <= r_data_byte[3];
			6:Uart_Tx <= r_data_byte[4];
			7:Uart_Tx <= r_data_byte[5];
			8:Uart_Tx <= r_data_byte[6];
			9:Uart_Tx <= r_data_byte[7];
			10:Uart_Tx <= STOP_BIT;
			default:Uart_Tx <= 1'b1;
		endcase
	end	

endmodule
