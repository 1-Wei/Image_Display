module uart_rx(
	input clk,
	input clr,
	input uart_rxd,
	output reg [7:0] rx_data,
	output reg rx_ready
);

parameter UART_BPS = 115200;
localparam BPS_CNT = 50_000_000/UART_BPS;

localparam UART_IDLE = 2'b00;
localparam UART_START = 2'b01;
localparam UART_REC = 2'b10;
localparam UART_STOP = 2'b11;

reg [1:0] state,next_state;
reg [15:0] count;
reg [2:0] bit_cnt;
reg [7:0] data_latch;
reg rxd_now;
reg rxd_before;
wire rxd_neged;

assign rxd_neged = (~rxd_now) & rxd_before;

always @(posedge clk,negedge clr)
begin
	if(~clr) begin rxd_now<=1'b0; rxd_before<=1'b0; end
	else 
	begin 	
		rxd_now<=uart_rxd;
		rxd_before<=rxd_now;
	end
end

always @(posedge clk,negedge clr)
begin
	if(~clr) state<=UART_IDLE;
	else state<=next_state;
end

always @(*)
begin
	case(state)
	UART_IDLE:
	begin
		if(rxd_neged) next_state<=UART_START;
		else next_state<=UART_IDLE;
	end
	
	UART_START:
	begin
		if(count == BPS_CNT - 1) next_state<=UART_REC;
		else next_state<=UART_START;
	end
	
	UART_REC:
	begin
		if(count == BPS_CNT - 1 && bit_cnt == 4'd7 ) next_state<=UART_STOP;
		else next_state<=UART_REC;
	end
	
	UART_STOP:
	begin
		if(count == BPS_CNT/2 - 1) next_state<=UART_IDLE;
		else next_state<=UART_STOP;
	end
	default: next_state<=UART_IDLE;
	endcase
end

always @(posedge clk,negedge clr)
begin
	if(~clr) count<=16'b0;
	else if(count == BPS_CNT - 1 ||state == UART_IDLE) count<=16'b0;
	else count<=count+1'b1;
end

always @(posedge clk,negedge clr)
begin
	if(~clr) bit_cnt<=4'b0;
	else if(state == UART_REC)
	begin
		if(count == BPS_CNT - 1) bit_cnt<=bit_cnt+1'b1;
		else bit_cnt<=bit_cnt;
	end
	else bit_cnt<=4'b0;
end

always @(posedge clk,negedge clr)
begin
	if(~clr) rx_ready<=1'b0;
	else if(state == UART_STOP && count == BPS_CNT/2 - 1) rx_ready<=1'b1;
	else if(state == UART_IDLE) rx_ready<=1'b0;
end

always @(posedge clk,negedge clr)
begin
	if(~clr) rx_data<=8'b0;
	else if(state == UART_STOP && count == BPS_CNT/2 - 1) 
		rx_data<=data_latch;
end

always @(posedge clk,negedge clr)
begin
	if(~clr) data_latch<=8'b0;
	else if(state == UART_REC && count == BPS_CNT/2 - 1)
		data_latch[bit_cnt]<=uart_rxd;
	else data_latch<=data_latch;
end

endmodule
