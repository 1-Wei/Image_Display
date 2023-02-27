module display_ctrl(
	input clk,
	input clk_pixel,
	input rst_n,
	input [10:0] pixel_xpos,
	input [10:0] pixel_ypos,
	input [15:0] in_data,
	input rx_ready,
	input [7:0] rx_data,
	output reg LED,
	output [15:0] display_data
);

reg [3:0] count;
reg rx_ready_now;
reg rx_ready_before;
wire rx_ready_pose;
wire [15:0] data_temp;

reg [7:0] pixel_pos[7:0];

wire [15:0] x_start;
wire [15:0] y_start;
wire [15:0] x_end;  
wire [15:0] y_end;  

reg show_start;

assign rx_ready_pose = rx_ready_now & (~rx_ready_before);

always @(posedge clk or negedge rst_n)
begin
	if(!rst_n) begin rx_ready_now<=1'b0; rx_ready_before<=1'b0; end
	else
	begin
		rx_ready_now <= rx_ready;
		rx_ready_before <= rx_ready_now;
	end
end

always @(posedge clk or negedge rst_n)
begin
	if(!rst_n) begin count<=4'b0;show_start<=1'b0; end
	else 
	begin
		if(rx_ready_pose) count<=count+1'b1;
		if(count >= 4'd8) begin show_start<=1'b1; end
	end
end

always @(posedge clk or negedge rst_n)
begin
	if(!rst_n) 
	begin
		 pixel_pos[0]<=8'b0;
		 pixel_pos[1]<=8'b0;
		 pixel_pos[2]<=8'b0;
		 pixel_pos[3]<=8'b0;
		 pixel_pos[4]<=8'b0;
		 pixel_pos[5]<=8'b0;
		 pixel_pos[6]<=8'b0;
		 pixel_pos[7]<=8'b0;
	end
	else 
	begin
		case(count)
		4'd0: pixel_pos[0]<=rx_data;
		4'd1: pixel_pos[1]<=rx_data;
		4'd2: pixel_pos[2]<=rx_data;
		4'd3: pixel_pos[3]<=rx_data;
		4'd4: pixel_pos[4]<=rx_data;
		4'd5: pixel_pos[5]<=rx_data;
		4'd6: pixel_pos[6]<=rx_data;
		4'd7: pixel_pos[7]<=rx_data;
		default:;
		endcase
	end
end

assign		x_start={pixel_pos[0],pixel_pos[1]};
assign		y_start={pixel_pos[2],pixel_pos[3]};
assign		x_end={pixel_pos[4],pixel_pos[5]}; 
assign		y_end={pixel_pos[6],pixel_pos[7]};

assign data_temp=(pixel_xpos>=x_start && pixel_xpos<=x_end && pixel_ypos>=y_start && pixel_ypos<=y_end)? in_data:16'h7FFF;
assign display_data = (show_start ==1'b1) ? data_temp : in_data;

/*always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		x_start<=12'b0;
		y_start<=12'b0;
		x_end<=12'b0;  
		y_end<=12'b0;  
	end
	else if(count == 4'd8)
	begin
		x_start<={pixel_pos[0],pixel_pos[1]};
		y_start<={pixel_pos[2],pixel_pos[3]};
		x_end<={pixel_pos[4],pixel_pos[5]}; 
		y_end<={pixel_pos[6],pixel_pos[7]};  
	end
end */

/*always @(posedge clk_pixel or negedge rst_n)
begin
	if(!rst_n) display_data<=16'b0;
	else 
	begin
		if(show_start ==1'b1)
		begin
			if(pixel_xpos>=x_start && pixel_xpos<=x_end && pixel_ypos>=y_start && pixel_ypos<=y_end)
			begin display_data<=in_data; end
			else display_data<=16'h7FFF;
		end
		else display_data<=in_data;
   end
end*/

always @(posedge clk or negedge rst_n)
begin
	if(!rst_n) LED<=1'b0;
	else LED<=show_start;
end


endmodule
