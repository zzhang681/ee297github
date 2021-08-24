
module output_ram(
	input i_clk,
	input i_reset_p,
	input [63:0] i_wdata,
	input [3:0] i_addr_w,	//0 - 4
	input [3:0] i_addr_r,	//0 - 4
	input i_write,
	input i_read,
	output [63:0] o_rdata
);


//input 64 output 32
logic [63:0] mdata [4:0];

assign o_rdata = i_read ? mdata[i_addr_r] : 0;

always @(posedge i_clk or posedge i_reset_p) begin
	if(i_reset_p) begin
		mdata[0] <= 0;
		mdata[1] <= 0;
		mdata[2] <= 0;
		mdata[3] <= 0;
		mdata[4] <= 0;
	end else begin
		if(i_write) begin
			mdata[i_addr_w] <= i_wdata;
		end
	end
end 


endmodule
