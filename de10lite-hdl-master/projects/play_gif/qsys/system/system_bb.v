
module system (
	clk_clk,
	clk_100_clk,
	clk_25_clk,
	framecount_export,
	imagecount_export,
	interface_address,
	interface_byte_enable,
	interface_read,
	interface_write,
	interface_write_data,
	interface_acknowledge,
	interface_read_data,
	reset_reset_n,
	sdram_addr,
	sdram_ba,
	sdram_cas_n,
	sdram_cke,
	sdram_cs_n,
	sdram_dq,
	sdram_dqm,
	sdram_ras_n,
	sdram_we_n,
	sdram_clk_100_clk);	

	input		clk_clk;
	output		clk_100_clk;
	output		clk_25_clk;
	output	[7:0]	framecount_export;
	output	[7:0]	imagecount_export;
	input	[25:0]	interface_address;
	input	[15:0]	interface_byte_enable;
	input		interface_read;
	input		interface_write;
	input	[127:0]	interface_write_data;
	output		interface_acknowledge;
	output	[127:0]	interface_read_data;
	input		reset_reset_n;
	output	[12:0]	sdram_addr;
	output	[1:0]	sdram_ba;
	output		sdram_cas_n;
	output		sdram_cke;
	output		sdram_cs_n;
	inout	[15:0]	sdram_dq;
	output	[1:0]	sdram_dqm;
	output		sdram_ras_n;
	output		sdram_we_n;
	output		sdram_clk_100_clk;
endmodule
