
module qsys_system (
	clk_clk,
	dram_clk_ext_clk,
	dram_export_addr,
	dram_export_ba,
	dram_export_cas_n,
	dram_export_cke,
	dram_export_cs_n,
	dram_export_dq,
	dram_export_dqm,
	dram_export_ras_n,
	dram_export_we_n,
	led_export_export,
	reset_reset_n);	

	input		clk_clk;
	output		dram_clk_ext_clk;
	output	[12:0]	dram_export_addr;
	output	[1:0]	dram_export_ba;
	output		dram_export_cas_n;
	output		dram_export_cke;
	output		dram_export_cs_n;
	inout	[15:0]	dram_export_dq;
	output	[1:0]	dram_export_dqm;
	output		dram_export_ras_n;
	output		dram_export_we_n;
	output	[7:0]	led_export_export;
	input		reset_reset_n;
endmodule
