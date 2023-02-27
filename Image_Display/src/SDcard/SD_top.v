module SD_top(
	input clk_ref, 		 //时钟信号
   input clk_ref_180deg, //时钟信号,与clk_ref相位相差180度
   input rst_n,  			 //复位信号,低电平有效
	
	input hdmi_clk, //fifo写时钟
	input sdram_out_en,	//sdram输出使能
	input [15:0] wr_fifo_data,  //fifo写数据
	input btn_flag, //按键使能
	
	input      sd_miso,  //SD卡SPI串行输入数据信号
   output     sd_clk,  //SD卡SPI时钟信号    
   output sd_cs,  //SD卡SPI片选信号
   output sd_mosi,  //SD卡SPI串行输出数据信号
	
	output reg sd_led
);

wire wr_en;
reg wr_flag;
wire [9:0] wrusedw;

//SDcard
reg [31:0] wr_sec_addr; //写地址
reg [11:0] wr_sec_cnt;
wire sd_init_done;
wire wr_start_en;
wire wr_busy;
wire wr_req;
wire [15:0] wr_data;
reg wr_done;

reg wr_busy_d0;
reg wr_busy_d1;

wire wr_busy_nege;
assign wr_busy_nege = (~wr_busy_d0) & wr_busy_d1;

assign wr_en = wr_flag & sdram_out_en & sd_init_done & (~wr_done); //fifo写使能
assign wr_start_en = (wrusedw == 10'd1) ? 1'b1 : 1'b0;

always @(posedge clk_ref or negedge rst_n)
begin
	if(!rst_n) wr_flag<=1'b0;
	else if(btn_flag) wr_flag<=1'b1;
end

always @(posedge clk_ref or negedge rst_n)
begin
	if(!rst_n) begin wr_busy_d0<=1'b0; wr_busy_d1<=1'b1; end
	else 
	begin
		wr_busy_d0<=wr_busy;
		wr_busy_d1<=wr_busy_d0;
	end
end

always @(posedge clk_ref or negedge rst_n)
begin
	if(!rst_n) begin wr_sec_cnt<=1'b0; wr_sec_addr<=32'd20000; end
	else if(wr_busy_nege)
	begin
		wr_sec_cnt<=wr_sec_cnt+1'b1;
		wr_sec_addr<=wr_sec_addr+1'b1;
	end
end

always @(posedge clk_ref or negedge rst_n)
begin
	if(!rst_n) begin wr_done<=1'b0; sd_led<=1'b0; end
	else if (wr_start_en) 
	begin
		//wr_done<=1'b1;
		sd_led<=1'b1;
	end
end

sd_ctrl_top u_sd_ctrl_top(
    .clk_ref           (clk_ref),
    .clk_ref_180deg    (clk_ref_180deg),
    .rst_n             (rst_n),
    //SD卡接口
    .sd_miso           (sd_miso),
    .sd_clk            (sd_clk),
    .sd_cs             (sd_cs),
    .sd_mosi           (sd_mosi),
    //用户写SD卡接口
    .wr_start_en       (wr_start_en),
    .wr_sec_addr       (wr_sec_addr),
    .wr_data           (wr_data),
    .wr_busy           (wr_busy),
    .wr_req            (wr_req),
    //用户读SD卡接口
    .rd_start_en       (),
    .rd_sec_addr       (),
    .rd_busy           (),
    .rd_val_en         (),
    .rd_val_data       (),    
    
    .sd_init_done      (sd_init_done)
    );


fifo_sd	fifo_sd_inst (
	.aclr ( ~rst_n ),
	
	.wrclk ( hdmi_clk ),
	.wrreq ( wr_en ),
	.data ( wr_fifo_data ),
	
	.rdclk ( clk_ref ),
	.rdreq ( wr_req ),
	.q ( wr_data ),
	
	.rdusedw (  ),
	.wrusedw ( wrusedw )
	);


endmodule 
