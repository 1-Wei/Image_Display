module debounce(
	input clk,
	input clr,
	input btn,
	output reg btn_flag
);

parameter TIME1 = 1_000_000;

reg btn_now;
reg btn_before;
wire btn_neged;
reg [19:0] count;
reg delay_flag;

assign btn_neged = (~btn_now) & btn_before;

always @(posedge clk,negedge clr)
begin
	if(~clr) begin btn_now<=1'b0; btn_before<=1'b0; end
	else begin btn_now<=btn; btn_before<=btn_now; end
end

always @(posedge clk,negedge clr)
begin
	if(~clr) delay_flag<=1'b0;
	else if(btn_neged) delay_flag<=1'b1;
	else if(count == TIME1 -1) delay_flag<=1'b0;
end

always @(posedge clk,negedge clr)
begin
	if(~clr) count<=20'b0;
	else if(delay_flag) 
	begin
		if(count == TIME1 -1) count<=20'b0;
		else count<=count+1'b1;
	end
end

always @(posedge clk,negedge clr)
begin
	if(~clr) btn_flag<=1'b0;
	else if(count == TIME1 -1) btn_flag<=~btn;
	else btn_flag<=1'b0;
end

endmodule
