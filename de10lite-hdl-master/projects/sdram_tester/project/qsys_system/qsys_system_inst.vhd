	component qsys_system is
		port (
			clk_clk           : in    std_logic                     := 'X';             -- clk
			dram_clk_ext_clk  : out   std_logic;                                        -- clk
			dram_export_addr  : out   std_logic_vector(12 downto 0);                    -- addr
			dram_export_ba    : out   std_logic_vector(1 downto 0);                     -- ba
			dram_export_cas_n : out   std_logic;                                        -- cas_n
			dram_export_cke   : out   std_logic;                                        -- cke
			dram_export_cs_n  : out   std_logic;                                        -- cs_n
			dram_export_dq    : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			dram_export_dqm   : out   std_logic_vector(1 downto 0);                     -- dqm
			dram_export_ras_n : out   std_logic;                                        -- ras_n
			dram_export_we_n  : out   std_logic;                                        -- we_n
			led_export_export : out   std_logic_vector(7 downto 0);                     -- export
			reset_reset_n     : in    std_logic                     := 'X'              -- reset_n
		);
	end component qsys_system;

	u0 : component qsys_system
		port map (
			clk_clk           => CONNECTED_TO_clk_clk,           --          clk.clk
			dram_clk_ext_clk  => CONNECTED_TO_dram_clk_ext_clk,  -- dram_clk_ext.clk
			dram_export_addr  => CONNECTED_TO_dram_export_addr,  --  dram_export.addr
			dram_export_ba    => CONNECTED_TO_dram_export_ba,    --             .ba
			dram_export_cas_n => CONNECTED_TO_dram_export_cas_n, --             .cas_n
			dram_export_cke   => CONNECTED_TO_dram_export_cke,   --             .cke
			dram_export_cs_n  => CONNECTED_TO_dram_export_cs_n,  --             .cs_n
			dram_export_dq    => CONNECTED_TO_dram_export_dq,    --             .dq
			dram_export_dqm   => CONNECTED_TO_dram_export_dqm,   --             .dqm
			dram_export_ras_n => CONNECTED_TO_dram_export_ras_n, --             .ras_n
			dram_export_we_n  => CONNECTED_TO_dram_export_we_n,  --             .we_n
			led_export_export => CONNECTED_TO_led_export_export, --   led_export.export
			reset_reset_n     => CONNECTED_TO_reset_reset_n      --        reset.reset_n
		);

