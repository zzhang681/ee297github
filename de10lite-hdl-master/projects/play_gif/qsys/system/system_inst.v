	system u0 (
		.clk_clk               (<connected-to-clk_clk>),               //           clk.clk
		.clk_100_clk           (<connected-to-clk_100_clk>),           //       clk_100.clk
		.clk_25_clk            (<connected-to-clk_25_clk>),            //        clk_25.clk
		.framecount_export     (<connected-to-framecount_export>),     //    framecount.export
		.imagecount_export     (<connected-to-imagecount_export>),     //    imagecount.export
		.interface_address     (<connected-to-interface_address>),     //     interface.address
		.interface_byte_enable (<connected-to-interface_byte_enable>), //              .byte_enable
		.interface_read        (<connected-to-interface_read>),        //              .read
		.interface_write       (<connected-to-interface_write>),       //              .write
		.interface_write_data  (<connected-to-interface_write_data>),  //              .write_data
		.interface_acknowledge (<connected-to-interface_acknowledge>), //              .acknowledge
		.interface_read_data   (<connected-to-interface_read_data>),   //              .read_data
		.reset_reset_n         (<connected-to-reset_reset_n>),         //         reset.reset_n
		.sdram_addr            (<connected-to-sdram_addr>),            //         sdram.addr
		.sdram_ba              (<connected-to-sdram_ba>),              //              .ba
		.sdram_cas_n           (<connected-to-sdram_cas_n>),           //              .cas_n
		.sdram_cke             (<connected-to-sdram_cke>),             //              .cke
		.sdram_cs_n            (<connected-to-sdram_cs_n>),            //              .cs_n
		.sdram_dq              (<connected-to-sdram_dq>),              //              .dq
		.sdram_dqm             (<connected-to-sdram_dqm>),             //              .dqm
		.sdram_ras_n           (<connected-to-sdram_ras_n>),           //              .ras_n
		.sdram_we_n            (<connected-to-sdram_we_n>),            //              .we_n
		.sdram_clk_100_clk     (<connected-to-sdram_clk_100_clk>)      // sdram_clk_100.clk
	);

