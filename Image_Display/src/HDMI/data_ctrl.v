module data_ctrl(
	input hdmi_clk,
	input rst_n,
	input [10:0] pixel_xpos,
	input [10:0] pixel_ypos,
	input [15:0] rd_data,
	input data_req,
	
	output  [15:0] out_data,
	output  rd_en
);

assign rd_en = (pixel_ypos <= 11'd480) & data_req;
assign out_data = (pixel_ypos <= 11'd480) ? rd_data : 16'h7FFF;

/*always @(posedge hdmi_clk or negedge rst_n)
begin
	if(!rst_n) begin rd_en<=1'b0; end
	else 
	begin
		if(pixel_ypos <= 11'd480-1 && data_req) rd_en<=1'b1;
		else rd_en<=1'b0;
	end
end*/

/*always @(posedge hdmi_clk or negedge rst_n)
begin
	if(!rst_n) begin out_data<=16'b0; end
	else 
	begin
		if(pixel_ypos <= 11'd480-1'b1) out_data<=rd_data;
		else out_data<=16'h7FFF;
	end
end*/

endmodule 
