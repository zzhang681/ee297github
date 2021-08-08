module play_gif2(

    //////////// CLOCK //////////
    input ADC_CLK_10,
    input MAX10_CLK1_50,
    input MAX10_CLK2_50,

    //////////// SDRAM //////////
    output [12:0]   DRAM_ADDR,
    output [1:0]    DRAM_BA,
    output          DRAM_CAS_N,
    output          DRAM_CKE,
    output          DRAM_CLK,
    output          DRAM_CS_N,
    inout  [15:0]   DRAM_DQ,
    output          DRAM_LDQM,
    output          DRAM_RAS_N,
    output          DRAM_UDQM,
    output          DRAM_WE_N,

    //////////// KEY //////////
    input [1:0] KEY,

    //////////// LED //////////
    output logic [9:0] LEDR,
    output[7:0] HEX0,
    output[7:0] HEX1,
    output[7:0] HEX2,
    output[7:0] HEX3,
    output[7:0] HEX4,
    output[7:0] HEX5,
    //////////// VGA //////////
    output [3:0] VGA_B,
    output [3:0] VGA_G,
    output       VGA_HS,
    output [3:0] VGA_R,
    output       VGA_VS,
	 
	 //output [31:0] data_read_ob,
	 output [31:0] data_read_ob2,
	 output [31:0] data_read_ob3,
	 //output [31:0] data_read_ob4,
	 output [31:0] data,
	 output ack_ob,
	 output intf_read
);

// ---------------- //
// Local Parameters //
// ---------------- //

// Number of bits read at a time from the QSYS system
localparam INTERFACE_WIDTH_BITS  = 128;
localparam INTERFACE_ADDR_BITS   = 26;
localparam BITS_PER_PIXEL        = 16;

// Don't touch without being ready to really fix things.
localparam DISPLAY_WIDTH           = 640;
localparam DISPLAY_HEIGHT          = 480;

// Defived parameters
localparam INTERFACE_WIDTH_BYTES = INTERFACE_WIDTH_BITS / 8;
localparam PIXELS_PER_TRANSFER = INTERFACE_WIDTH_BITS / BITS_PER_PIXEL;

// NOTE: If this division is not exact, you must compute the ceiling manually
// because $ceil is not supported for synthesis :(
localparam NUM_BUFFER_ENTRIES = DISPLAY_WIDTH / PIXELS_PER_TRANSFER;

// Number of bytes to store the whole image. Useful for computing where one
// image ends and the next begins.
//
// Again, if this arithmetic is not exact, it probably will not behave as
// expected.
localparam IMAGE_SIZE = DISPLAY_WIDTH * DISPLAY_HEIGHT * INTERFACE_WIDTH_BYTES / PIXELS_PER_TRANSFER;

// ------------------------------------ //
// Clocks and Global Synchrounous Reset //
// ------------------------------------ //

// 50 MHz external clock
logic clk_50;
logic reset_n;

assign clk_50 = MAX10_CLK1_50;
assign reset_n = KEY[0];

// Derived 25 MHz and 100 MHz clocks from PLL in the QSYS system.
logic clk_25, clk_100;

// ------------- //
// SDRAM Signals //
// ------------- //

// SDRAM controller only has a single DQM port. Wire this to both the UDQM and
// LDQM ports at the top leve.
logic DRAM_DQM;
assign DRAM_LDQM = DRAM_DQM;
assign DRAM_UDQM = DRAM_DQM;

// -------------- //
// Bridge Signals //
// -------------- //

// Signals for interfacing with the external bridge side of the External
// Bridge to Avalon Master component.
logic [INTERFACE_ADDR_BITS-1:0]      interface_address;
logic [INTERFACE_WIDTH_BYTES-1:0]    interface_byte_enable;
logic                                interface_read;
logic                                interface_write;
logic [INTERFACE_WIDTH_BITS-1:0]     interface_write_data;
logic [INTERFACE_WIDTH_BITS-1:0]     interface_read_data;
logic                                interface_acknowledge;

logic [INTERFACE_WIDTH_BITS-1:0] data_reg;

//assign data_read_ob = interface_read_data[31:0];
assign data_read_ob2 = data_reg[63:32];
assign data_read_ob3 = data_reg[95:64];

//assign data_read_ob4 = interface_read_data[127:96];
assign ack_ob = interface_acknowledge;
assign data = data_reg[31:0];

//assign 

 
logic [7:0]      in1,in2,in3,in4;
logic [31:0]      in;  
logic [15:0]		mlp_out;
logic [15:0] 		datain;


assign datain = {8'h02, 8'h01};
//assign  in1 = data[7:0];
//assign  in2 = data[15:8];
//assign  in3 = data[23:16];
//assign  in4 = data[31:24];


//FP part test
logic [31:0] result_fp;
logic start_fp, done_fp, reset_p;				//start goes high for a cycle every 1 SECOND
logic clk_slow;
logic read_done_fp;
logic next_in_fp;

logic [31:0] din_fp;
logic adone_fp;
logic acknowledge_flag;

logic [4:0] states;

logic [31:0] data_comp;
logic [3:0] index_comp, index_out_comp;



/*
union packed {
	logic [783:0][7:0] twod;
	logic [6271:0] oned;
} img_reg;
*/
logic [783:0][7:0] img_reg;
logic [9:0] address, address_next;

logic [7:0] img_in;
logic [31:0] img_fp;
logic start_manual;

//assign img_in = 128;

//assign address = 0;
always_ff @(posedge clk_50) begin
	if(reset_p) address <= 0;
	else address <= address_next;
end

always_comb begin
	address_next = address;
	case(states) 
		5'b00100: address_next = address + 16;
		5'b00110: address_next = 0;
		//5'b01010: address_next = address + 1;
		default: begin
			if(next_in_fp) address_next = address + 1;
			else address_next = address;
		end
	endcase
end

//img_reg
always_ff @(posedge clk_50) begin
	case(states)
		5'b00000: img_reg[address] <= 0;
		5'b00010: img_reg[address] <= 127'hffffffffffffffffffffffffffffffff;
		5'b00011: begin
			img_reg[address] <= data_reg[7:0];
			img_reg[address+1] <= data_reg[15:8];
			img_reg[address+2] <= data_reg[23:16];
			img_reg[address+3] <= data_reg[31:24];
			img_reg[address+4] <= data_reg[39:32];
			img_reg[address+5] <= data_reg[47:40];
			img_reg[address+6] <= data_reg[55:48];
			img_reg[address+7] <= data_reg[63:56];
			img_reg[address+8] <= data_reg[71:64];
			img_reg[address+9] <= data_reg[79:72];
			img_reg[address+10] <= data_reg[87:80];
			img_reg[address+11] <= data_reg[95:88];
			img_reg[address+12] <= data_reg[103:96];
			img_reg[address+13] <= data_reg[111:104];
			img_reg[address+14] <= data_reg[119:112];
			img_reg[address+15] <= data_reg[127:120];
		end
		default: img_reg[address] <= img_reg[address];
	endcase
end

always_ff @(posedge clk_50) begin
	if(reset_p) img_in <= 0;
	else begin
		if(start_manual) img_in <= 0;
		else begin
			if(next_in_fp) img_in <= img_in + 1;
			else img_in <= img_in;
		end
	end
end

assign din_fp = 32'h3f000000;			//0.5
assign reset_p = ~reset_n;


//assign {in3, in2, in1, in4} = img_in;
assign {in3, in2, in1, in4} = result_fp;
//assign {in3, in2, in1, in4} = data_reg[31:0];
//assign {in3, in2, in1, in4} = address;

//assign LEDR[9] = read_done_fp;
assign LEDR[9] = adone_fp;

////////////////////////////////////////////////////////////////////////////////
// QSYS System Instantiation
////////////////////////////////////////////////////////////////////////////////
system u0 (
    .clk_clk               (clk_50),    //     clk.clk
    .reset_reset_n         (reset_n),   //     reset.reset_n

    // SDRAM SIGNALS
    .sdram_addr            (DRAM_ADDR), //     sdram.addr
    .sdram_ba              (DRAM_BA),   //          .ba
    .sdram_cas_n           (DRAM_CAS_N),//          .cas_n
    .sdram_cke             (DRAM_CKE),  //          .cke
    .sdram_cs_n            (DRAM_CS_N), //          .cs_n
    .sdram_dq              (DRAM_DQ),   //          .dq
    .sdram_dqm             (DRAM_DQM),  //          .dqm
    .sdram_ras_n           (DRAM_RAS_N),//          .ras_n
    .sdram_we_n            (DRAM_WE_N), //          .we_n
    .sdram_clk_100_clk     (DRAM_CLK),

    // External Bridge interface signals.
    .interface_address     (interface_address),     // interface.address
    .interface_byte_enable (interface_byte_enable), //          .byte_enable
    .interface_read        (interface_read),        //          .read
    .interface_write       (interface_write),       //          .write
    .interface_write_data  (interface_write_data),  //          .write_data
    .interface_acknowledge (interface_acknowledge), //          .acknowledge
    .interface_read_data   (interface_read_data),   //          .read_data

    // Clocks exported by PLL.
    .clk_25_clk            (clk_25),    //    clk_25.clk
    .clk_100_clk           (clk_100),   //   clk_100.clk

    // export frame-rate and frame-count registers
    .framecount_export (max_frame_count),
    .imagecount_export (max_image_count)
);

sdram_reader #(
    .INTERFACE_WIDTH_BITS   (INTERFACE_WIDTH_BITS),
    .INTERFACE_ADDR_BITS    (INTERFACE_ADDR_BITS),
    .NUM_BUFFER_ENTRIES     (NUM_BUFFER_ENTRIES)
) u2 (
    .interface_clock    (clk_50),
    .reset_n            (reset_n),
    // Interface signals
    .interface_address     (interface_address),
    .interface_byte_enable (interface_byte_enable),
    .interface_read        (interface_read),
    //.interface_write       (interface_write),
    //.interface_write_data  (interface_write_data),
    .interface_acknowledge (interface_acknowledge),
    .interface_read_data   (interface_read_data),
	 .read_img_start(start_fp),
	 .mac_start(start_manual),
	 .mac_done(done_fp),
	 .data_reg(data_reg),
	 .read_done(read_done_fp),
	 .acknowledge_flag(acknowledge_flag),
	 .states(states),
	 .ack(LEDR[8])
    // VGA signals
	 /*
    .read_address          (buffer_read_address),
    .read_data             (buffer_read_data),
    .start                 (buffer_start),
    .base_address          (buffer_base_address),
    // Timing Error indication
    .timing_error       (LEDR[0]),
    .timing_error_reset (~KEY[1])
	 */
);

simple_mlp #(
    .INTERFACE_WIDTH_BITS   (INTERFACE_WIDTH_BITS),
    .INTERFACE_ADDR_BITS    (INTERFACE_ADDR_BITS),
    .NUM_BUFFER_ENTRIES     (NUM_BUFFER_ENTRIES)
) u3 (
	.clk(clk_50),
	.reset(reset_n),
	.data(data_reg),
	.ack(interface_acknowledge),
	.in(datain),
	.out(mlp_out)
);

fp_mac u4 (
		.clk       (clk_50),       // s1.clk
		.data		  (data_reg),
		.din		  (img_fp),
		.datavalid (acknowledge_flag),
		.reset     (reset_p),     //   .reset
		.read_done (read_done_fp),
		.start     (start_manual),     //   .start
		.done      (done_fp),      //   .done
		.result    (result_fp),     //   .result
		.next_in   (next_in_fp),
		.adone	  (adone_fp)
);

clock_divider u5 (
	.clk(clk_50),
	.reset(reset_n), 
	.clk_out(clk_slow)
);

rise_edge_trigger u6(
	.clk(clk_50),
	.reset(reset_p),
	.level(clk_slow),
	.rise_edge(start_fp)
);


uint_to_float u7(
	.i_uint8_int(img_in),
	.o_fp32_hex(img_fp)
);

rise_edge_trigger u8(
	.clk(clk_50),
	.reset(reset_p),
	.level(~KEY[1]),
	.rise_edge(start_manual)
);

fp_compare u9(
	.dataa(data_comp),
	.index_in(index_comp),
	.index_out(index_out_comp)
);


display_output display0(
        .in1 (in1),
        .in2 (in2),
        .in3 (in3),
        .in4 (in4),
        .seg1 (HEX0),
        .seg2 (HEX1),
        .seg3 (HEX2),
        .seg4 (HEX3),
        .seg5 (HEX4),
        .seg6 (HEX5),
        .ledr (LEDR[7:0])
    );   



endmodule
