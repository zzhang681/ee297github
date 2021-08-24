
module hidden_ram (
	input i_clk,
	input i_reset_p,
	input [127:0] i_wdata,
	input [3:0] i_addr_w,
	input [3:0] i_addr_r,
	input i_write,
	input i_read,
	output [127:0] o_rdata
);

logic [127:0] mdata [15:0];

assign o_rdata = i_read ? mdata[i_addr_r] : 0;

always @(posedge i_clk or posedge i_reset_p) begin
	if(i_reset_p) begin
		mdata[0] <= 0;
		mdata[1] <= 0;
		mdata[2] <= 0;
		mdata[3] <= 0;
		mdata[4] <= 0;
		mdata[5] <= 0;
		mdata[6] <= 0;
		mdata[7] <= 0;
		mdata[8] <= 0;
		mdata[9] <= 0;
		mdata[10] <= 0;
		mdata[11] <= 0;
		mdata[12] <= 0;
		mdata[13] <= 0;
		mdata[14] <= 0;
		mdata[15] <= 0;
	end else begin
		if(i_write) mdata[i_addr_w] <= i_wdata;
	end
end


endmodule