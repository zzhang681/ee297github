	qsys_system u0 (
		.clk_clk           (<connected-to-clk_clk>),           //          clk.clk
		.dram_clk_ext_clk  (<connected-to-dram_clk_ext_clk>),  // dram_clk_ext.clk
		.dram_export_addr  (<connected-to-dram_export_addr>),  //  dram_export.addr
		.dram_export_ba    (<connected-to-dram_export_ba>),    //             .ba
		.dram_export_cas_n (<connected-to-dram_export_cas_n>), //             .cas_n
		.dram_export_cke   (<connected-to-dram_export_cke>),   //             .cke
		.dram_export_cs_n  (<connected-to-dram_export_cs_n>),  //             .cs_n
		.dram_export_dq    (<connected-to-dram_export_dq>),    //             .dq
		.dram_export_dqm   (<connected-to-dram_export_dqm>),   //             .dqm
		.dram_export_ras_n (<connected-to-dram_export_ras_n>), //             .ras_n
		.dram_export_we_n  (<connected-to-dram_export_we_n>),  //             .we_n
		.led_export_export (<connected-to-led_export_export>), //   led_export.export
		.reset_reset_n     (<connected-to-reset_reset_n>)      //        reset.reset_n
	);

