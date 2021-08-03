	component system is
		port (
			clk_clk               : in    std_logic                      := 'X';             -- clk
			clk_100_clk           : out   std_logic;                                         -- clk
			clk_25_clk            : out   std_logic;                                         -- clk
			framecount_export     : out   std_logic_vector(7 downto 0);                      -- export
			imagecount_export     : out   std_logic_vector(7 downto 0);                      -- export
			interface_address     : in    std_logic_vector(25 downto 0)  := (others => 'X'); -- address
			interface_byte_enable : in    std_logic_vector(15 downto 0)  := (others => 'X'); -- byte_enable
			interface_read        : in    std_logic                      := 'X';             -- read
			interface_write       : in    std_logic                      := 'X';             -- write
			interface_write_data  : in    std_logic_vector(127 downto 0) := (others => 'X'); -- write_data
			interface_acknowledge : out   std_logic;                                         -- acknowledge
			interface_read_data   : out   std_logic_vector(127 downto 0);                    -- read_data
			reset_reset_n         : in    std_logic                      := 'X';             -- reset_n
			sdram_addr            : out   std_logic_vector(12 downto 0);                     -- addr
			sdram_ba              : out   std_logic_vector(1 downto 0);                      -- ba
			sdram_cas_n           : out   std_logic;                                         -- cas_n
			sdram_cke             : out   std_logic;                                         -- cke
			sdram_cs_n            : out   std_logic;                                         -- cs_n
			sdram_dq              : inout std_logic_vector(15 downto 0)  := (others => 'X'); -- dq
			sdram_dqm             : out   std_logic_vector(1 downto 0);                      -- dqm
			sdram_ras_n           : out   std_logic;                                         -- ras_n
			sdram_we_n            : out   std_logic;                                         -- we_n
			sdram_clk_100_clk     : out   std_logic                                          -- clk
		);
	end component system;

	u0 : component system
		port map (
			clk_clk               => CONNECTED_TO_clk_clk,               --           clk.clk
			clk_100_clk           => CONNECTED_TO_clk_100_clk,           --       clk_100.clk
			clk_25_clk            => CONNECTED_TO_clk_25_clk,            --        clk_25.clk
			framecount_export     => CONNECTED_TO_framecount_export,     --    framecount.export
			imagecount_export     => CONNECTED_TO_imagecount_export,     --    imagecount.export
			interface_address     => CONNECTED_TO_interface_address,     --     interface.address
			interface_byte_enable => CONNECTED_TO_interface_byte_enable, --              .byte_enable
			interface_read        => CONNECTED_TO_interface_read,        --              .read
			interface_write       => CONNECTED_TO_interface_write,       --              .write
			interface_write_data  => CONNECTED_TO_interface_write_data,  --              .write_data
			interface_acknowledge => CONNECTED_TO_interface_acknowledge, --              .acknowledge
			interface_read_data   => CONNECTED_TO_interface_read_data,   --              .read_data
			reset_reset_n         => CONNECTED_TO_reset_reset_n,         --         reset.reset_n
			sdram_addr            => CONNECTED_TO_sdram_addr,            --         sdram.addr
			sdram_ba              => CONNECTED_TO_sdram_ba,              --              .ba
			sdram_cas_n           => CONNECTED_TO_sdram_cas_n,           --              .cas_n
			sdram_cke             => CONNECTED_TO_sdram_cke,             --              .cke
			sdram_cs_n            => CONNECTED_TO_sdram_cs_n,            --              .cs_n
			sdram_dq              => CONNECTED_TO_sdram_dq,              --              .dq
			sdram_dqm             => CONNECTED_TO_sdram_dqm,             --              .dqm
			sdram_ras_n           => CONNECTED_TO_sdram_ras_n,           --              .ras_n
			sdram_we_n            => CONNECTED_TO_sdram_we_n,            --              .we_n
			sdram_clk_100_clk     => CONNECTED_TO_sdram_clk_100_clk      -- sdram_clk_100.clk
		);

