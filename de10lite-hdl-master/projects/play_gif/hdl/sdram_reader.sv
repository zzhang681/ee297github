
//module for reading data

module sdram_reader #(
        // Size of Reads and Writes to the External Bridge to Avalon Bus
        // System
        parameter INTERFACE_WIDTH_BITS  = 128,
        // Number of entries in the Buffer
        parameter NUM_BUFFER_ENTRIES    = 64,
        // Number of bits used for the interface address space
        parameter INTERFACE_ADDR_BITS   = 26 
    )(
        // CLOCKS //

        // Clock for the interface to the QSYS system
        input interface_clock,
        // Clock used by the VGA circuitry.
        input read_clock,
        // System reset
        input reset_n,

        // QSYS INTERFACE //
        output logic [INTERFACE_ADDR_BITS-1:0]        interface_address,
        output logic [(INTERFACE_WIDTH_BITS / 8)-1:0] interface_byte_enable,
        output logic                            interface_read,
        output                                  interface_write,
        input [INTERFACE_WIDTH_BITS-1:0]        interface_read_data,
        //output [INTERFACE_WIDTH_BITS-1:0]       interface_write_data,
        input                                   interface_acknowledge,
		  input  next_img,
		  input  read_img_start,
		  input  mac_start,
		  input  mac_done,
		  output	logic[INTERFACE_WIDTH_BITS-1:0]			data_reg,
		  output read_done,
		  output logic acknowledge_flag,
		  output [4:0] states,
		  output [7:0] dr_ram,
		  output start_multi,
		  output reg ack
			/*
        // General Module IO
        input [$clog2(NUM_BUFFER_ENTRIES)-1:0] read_address,
        output [INTERFACE_WIDTH_BITS-1:0]      read_data,

        // When asserted, begin buffering the next row.
        input start,
        // Byte address to begin buffering from.
        input [INTERFACE_ADDR_BITS-1:0] base_address,
			
        // Error indication
        output logic    timing_error,
        input           timing_error_reset
		  */
);

logic clk, reset;
logic edge_det_IDLE, edge_IDLE, buffer_read, write_ram, read_ram;
logic [3:0] counter;
logic [7:0] addr_w;
logic [9:0] addr_r;
assign clk = interface_clock;
assign reset = reset_n;

logic [INTERFACE_ADDR_BITS-1:0] interface_address_next;

localparam INTERFACE_WIDTH_BYTES = INTERFACE_WIDTH_BITS / 8;

//assign interface_byte_enable = (2 ** INTERFACE_WIDTH_BYTES) - 1;

parameter final_address = 200704;//544;		//200688, 200704		//op# = address / 16

parameter img_address = 204000;			//204000-204783-205079 (addr 205088)
parameter img_address_fin = img_address + 783;// + 296 - 40;
parameter c_TDATA_WIDTH=128;


logic [127:0] data_store;


always_ff @(posedge clk) begin
	if(!reset) interface_address <= 0;
	else interface_address <= interface_address_next;
end


enum bit[3:0] {
	IDLE,
	READ_IMG_START,
	READ_IMG_START2,
	READ_IMG,
	READ_IMG_DONE,
	READ_IMG_FIN,
	READ_START,
	READ,
	READ_DONE,
	OP,
	OP_DONE,
	ALL_DONE,
	READ_IMG_STORE
} cs, ns;

/*
parameter IDLE = 5'b00000;
parameter READ_IMG_START = 5'b00001;
parameter READ_IMG_START2 = 5'b00010;
parameter READ_IMG = 5'b00011;
parameter READ_IMG_DONE = 5'b00100;
parameter READ_IMG_FIN = 5'b00101;
parameter READ_START = 5'b00110;
parameter READ = 5'b00111;
parameter READ_DONE = 5'b01000;
parameter OP = 5'b01001;
parameter OP_DONE = 5'b01010;
parameter ALL_DONE = 5'b01011;
read_img_store = 5'b01100

logic [4:0] cs, ns;
*/
assign states = cs;
assign read_done = (cs == ALL_DONE) ? 1 : 0;
assign edge_det_IDLE = (cs == IDLE) ? 1:0;

always begin
	//interface_address=0;
   interface_byte_enable=16'hffff;
   //interface_read=1'b1;
   interface_write = 1'b0;
end


//logic ack;
assign ack = (cs == READ_IMG_FIN) ? 1 : 0;//(cs == ALL_DONE) ? 1:0;

always_latch begin
	case(cs)
		IDLE: acknowledge_flag = 0;
		READ_IMG_START2: acknowledge_flag = 0;
		READ_IMG_DONE: acknowledge_flag = 0;
		READ_IMG_FIN: acknowledge_flag = 0;
		READ_START: acknowledge_flag = 0;
		READ_DONE: acknowledge_flag = 0;
		default: begin
			if(interface_acknowledge) acknowledge_flag = 1;
		end
	endcase
end

always_comb begin
	ns = cs;
	case(cs)
		IDLE: begin
			if(mac_start) ns = READ_START;
			else if(read_img_start) ns = READ_IMG_START;
			else ns = IDLE;
		end
		
		READ_IMG_START: ns = READ_IMG;
		
		READ_IMG: begin
			if(interface_address >= img_address_fin) ns = READ_IMG_FIN;
			else ns = READ_IMG;
		end
		
		READ_IMG_FIN: begin 
			if(mac_start) ns = READ_START;
			else ns = READ_IMG_FIN;
		end
		
		READ_START: ns = READ;
		
		READ: begin
			if(interface_address >= final_address) ns = READ_DONE;
			else ns = READ;
		end
		
		READ_DONE: ns = READ_DONE;
		
	endcase
end


/*
always_comb begin
	ns = cs;
	case(cs)
		IDLE: begin
			if(mac_start) ns = READ_START;
			else if(read_img_start) ns = READ_IMG_START;
			else ns = IDLE;
		end
		
		READ_IMG_START: ns = READ_IMG_START2;
		
		READ_IMG_START2: ns = READ_IMG;
		
		READ_IMG: begin
			if(acknowledge_flag) ns = READ_IMG_DONE;
			else if(interface_address > img_address_fin) ns = READ_IMG_FIN;
			else ns = READ_IMG;
		end
		
		READ_IMG_DONE: ns = READ_IMG;
		
		READ_IMG_STORE: begin
			if(next_img) ns = READ_IMG_START2;
			else ns = READ_IMG_STORE;
		end
		
		READ_IMG_FIN: begin 
			if(mac_start) ns = READ_START;
			else ns = READ_IMG_FIN;
		end
		
		READ_START: ns = READ;
		
		READ: begin
			if(acknowledge_flag) ns = READ_DONE;
			else if(interface_address > final_address) ns = ALL_DONE;
			else ns = READ;
		end
		
		READ_DONE: ns = OP;
		
		OP: begin
			if(mac_done) begin
				if(interface_address > final_address) ns = ALL_DONE;
				else ns = OP_DONE;
			end else ns = OP;
		end
		
		OP_DONE: begin
			if(interface_address > final_address) ns = ALL_DONE;
			else ns = READ;
		end
		ALL_DONE: begin
			ns = ALL_DONE;
		end
		
		default: ns = IDLE;
	endcase
end
*/

//interface_address
always @(*) begin
	interface_address_next = interface_address;
	begin
		case(cs)
			IDLE: interface_address_next = 0;
			
			READ_IMG_START: interface_address_next = img_address;
			
			READ_IMG_START2: interface_address_next = interface_address;
			
			READ_IMG: begin
				if(interface_acknowledge) begin 
					if(interface_address < img_address_fin) interface_address_next = interface_address + 5'h10;
					//else interface_address_next = interface_address;
				end else interface_address_next = interface_address;
			end
			
			//READ_IMG_DONE: interface_address_next = interface_address + 5'h10;
			
			READ_IMG_FIN: interface_address_next = interface_address;
			
			READ_START: interface_address_next = 0;
			
			READ: begin
				if(interface_acknowledge) begin 
					if(interface_address < img_address_fin) interface_address_next = interface_address + 5'h10;
					//else interface_address_next = interface_address;
				end else interface_address_next = interface_address;
			end
			
			OP_DONE: begin
				interface_address_next = interface_address + 5'h10;////////////////////////////////
				//else interface_address = interface_address;
			end
			
			//READ_FIN: interface_address <= 0;
			
			default: interface_address_next = interface_address;
		endcase
	end
end

always @(*) begin
	buffer_read = 0;
	case(cs)
		IDLE: buffer_read = 0;
		READ_IMG_START: buffer_read = 0;
		READ_IMG: buffer_read = 1;
		READ_IMG_FIN: buffer_read = 0;
	endcase
end

//addr_w
always_ff @(posedge interface_clock) begin
	if(!reset) addr_w <= 0;
	else begin
		if(cs == READ_IMG) begin
			if(interface_acknowledge) addr_w <= addr_w + 1;
		end
	end
end

always_ff @(posedge interface_clock) begin
	if(!reset) addr_r <= 0;
	else begin
		if(read_img_start && cs == READ_IMG_FIN) addr_r <= addr_r + 1;
	end
end

always @(*) begin
	read_ram = 0;
	if(cs == READ_IMG_FIN && addr_w > 7) read_ram = 1;
end


//interface_read
/*
always@(*) begin
	interface_read = 1'b0;
	begin 
		case(cs)
			IDLE: begin
				interface_read = 1'b1;
			end
			
			READ_IMG_START: interface_read = 1'b1;
			
			READ_IMG_START2: interface_read = 1'b1;
			
			READ_IMG: begin
				interface_read = 1'b1;
				//if(interface_acknowledge) interface_read = 1'b0;
				//else interface_read = 1'b1;
			end
			
			READ_START: interface_read = 1'b1;
			
			READ: begin
				interface_read = 1'b1;
			end
			
			//OP_DONE: interface_read = 1'b1;
			//ALL_DONE: interface_read = 1'b1;
			
			default: interface_read = 1'b0;
		endcase
	end
end
*/



//data_reg
/*
always_ff @(posedge clk) begin
	if(!reset) data_reg <= 0;
	else begin
		if(interface_acknowledge) data_reg <= interface_read_data;
		else data_reg <= data_reg;
	end
end
*/
//assign data_reg = interface_address;
//assign data_reg = count;

/*
logic [127:0] data_cap;

always_latch begin
	if(!reset) data_cap = 0;
	else if(interface_acknowledge) data_cap = interface_read_data;
end
*/
/*
always_ff @(posedge clk) begin
	if(!reset) data_reg <= 0;
	else 
	begin
		if(interface_acknowledge) data_reg <= interface_read_data;
		else data_reg <= data_reg;
	end
end
*/

//cs
always_ff @(posedge clk) begin
	if(!reset) cs <= IDLE;
	else cs <= ns;
end

rise_edge_trigger rr1(
	.clk(clk),
	.reset(reset),
	.level(edge_det_IDLE),
	.rise_edge(edge_IDLE)
);

avalonbridge_pipe_stage_buffered #(
	.c_TDATA_WIDTH(c_TDATA_WIDTH)
) u1 (
	.i_axis_aclk(interface_clock),
	.i_axis_aresetn(reset_n),
	
	.i_s_axis_tvalid(interface_acknowledge),
	.o_s_axis_tready(interface_read),
	.i_s_axis_tdata(interface_read_data),
	
	.o_m_axis_tvalid(write_ram),
	.i_m_axis_tready(buffer_read),
	.o_m_axis_tdata(data_reg)
); 

avalonbridge_pipe_stage_buffered #(
	.c_TDATA_WIDTH(c_TDATA_WIDTH)
) u2 (
	.i_axis_aclk(interface_clock),
	.i_axis_aresetn(reset_n),
	
	.i_s_axis_tvalid(interface_acknowledge),
	.o_s_axis_tready(interface_read),
	.i_s_axis_tdata(interface_read_data),
	
	.o_m_axis_tvalid(write_ram),
	.i_m_axis_tready(read_weight),
	.o_m_axis_tdata(data_reg)
); 

img_ram u3(
	.clk(interface_clock),
	.reset(~reset_n),
	.dw(data_reg),
	.addr_w(addr_w),
	.write(write_ram),
	.read(read_ram),
	.addr_r(addr_r),
	.dr(dr_ram)
);


endmodule