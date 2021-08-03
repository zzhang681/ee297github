// fp_mac.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module fp_mac (
		input  wire        clk,       // s1.clk
		input  [127:0]		 data,
		input  wire [31:0] din,			//input(image)
		input					 datavalid,
		input  wire        reset,     //   .reset
		input  wire			 read_done,
		input  wire        start,     //   .start
		output wire        done,      //   .done
		output wire [31:0] result,     //   .result
		output adone
);

enum bit[2:0] {
	IDLE,
	READ_START,
	READ,
	READ_DONE,
	ALL_DONE
} cs, ns;

//typedef union packed{
bit [15:0][127:0] hidden;				//16x128
//logic [63:0][31:0] h;
//} hidden_reg;

//hidden_reg hidden;

logic [31:0] dataa1, datab1, result_mul1, result_add1;
logic [31:0] dataa2, datab2, result_mul2, result_add2;
logic [31:0] dataa3, datab3, result_mul3, result_add3;
logic [31:0] dataa4, datab4, result_mul4, result_add4;
logic [31:0] dataa_add1;
logic [31:0] data_accu1, data_accu2, data_accu3, data_accu4;
logic done_mul1, start_add1, done_add1;
logic done_mul2, start_add2, done_add2;
logic done_mul3, start_add3, done_add3;
logic done_mul4, start_add4, done_add4;
logic done_flag1, done_flag2, done_flag3, done_flag4;

logic [127:0] data_reg, result_reg;
//logic [2:0] n_mul, n_add;
logic clk_en, reset_req;
logic [3:0] address;		//address for hidden (0-63)

logic edge_det_READ, start_mul;
assign edge_det_READ = (cs == READ) ? 1:0;
assign adone = (cs == READ_DONE) ? 1:0;//(cs == ALL_DONE) ? 1:0;
assign reset_req = (cs == IDLE) ? 1:0;

/*
assign dataa_fp = 32'h3e99999a;	//0.3
assign datab_fp = 32'h3ecccccd;	//0.4		//expect multiply result 0.12 3df5c28f
*/


parameter n_mul = 3'b100;
parameter n_add = 3'b101;
//multiply: 100
//add: 101

assign clk_en = 1'b1;

assign done = (count == 9) ? 1:0;// && done_flag2 && done_flag3 && done_flag4;

logic [4:0] count;

always @(posedge clk or posedge reset) begin
	if(reset) count <= 0;
	else begin
		if(count < 10 && !datavalid) count <= count + 1;
		else count <= 0;
	end
end



//done_flag
always @(posedge clk or posedge reset) begin
	if(reset) begin
		done_flag1 <= 0;
		done_flag2 <= 0;
		done_flag3 <= 0;
		done_flag4 <= 0;
	end else begin
		case(cs)
			IDLE: begin
				done_flag1 <= 0;
				done_flag2 <= 0;
				done_flag3 <= 0;
				done_flag4 <= 0;
			end
			
			READ: begin
				if(done_add1) done_flag1 <= 1;
				if(done_add2) done_flag2 <= 1;
				if(done_add3) done_flag3 <= 1;
				if(done_add4) done_flag4 <= 1;
			end
			
			READ_DONE: begin
				done_flag1 <= 0;
				done_flag2 <= 0;
				done_flag3 <= 0;
				done_flag4 <= 0;
			end

			default: begin
				done_flag1 <= 0;
				done_flag2 <= 0;
				done_flag3 <= 0;
				done_flag4 <= 0;
			end
		endcase
	end
end


//ns
always@(*) begin
	ns = cs;
	case(cs)
		IDLE: begin
			if(start) ns = READ_START;//READ_START;
			else ns = IDLE;
		end
		
		READ_START: begin
			ns = READ;
		end
		
		READ: begin
			if(done_mul1) ns = READ_DONE;			//start >> IDLE			////////////////////////////////
			else ns = READ;
		end
		
		READ_DONE: begin
			if(read_done) ns = ALL_DONE;
			else if(datavalid) ns = READ;
			else ns = READ_DONE;
		end
		
		ALL_DONE: begin
			ns = ALL_DONE;
		end
		
		default: ns = IDLE;
	endcase
end



//data signals
//address

always_ff @(posedge clk or posedge reset) begin
	if(reset) address <= 0;
	else begin
		if(done_mul1) address <= address + 1;			///////////////////////////////
		else address <= address;
	end
end


//hidden
always_ff @(posedge clk or posedge reset) begin
	if(reset) hidden = 0;
	else begin
		case(cs)
			IDLE: hidden = hidden;
			READ: begin
				if(done_add1) hidden[address][31:0] <= result_add1;
				if(done_add2) hidden[address][63:32] <= result_add2;
				if(done_add3) hidden[address][95:64] <= result_add3;
				if(done_add4) hidden[address][127:96] <= result_add4;
			end
			READ_DONE: begin
				if(done_add1) hidden[address][31:0] <= result_add1;
				if(done_add2) hidden[address][63:32] <= result_add2;
				if(done_add3) hidden[address][95:64] <= result_add3;
				if(done_add4) hidden[address][127:96] <= result_add4;
			end
				/*
				if(done) begin 
					hidden[0] = result_reg;
					//hidden = hidden >> 128;
				end
				//all_done, hidden <= result_reg/////////////////////////
			end
			*/
			default: hidden = hidden;
		endcase
	end
end

//result_reg (128bit)
always_ff @(posedge clk or posedge reset) begin
	if(reset) result_reg <= 0;
	else begin
		if(done_add1) result_reg[31:0] <= result_add1;
		if(done_add2) result_reg[63:32] <= result_add2;
		if(done_add3) result_reg[95:64] <= result_add3;
		if(done_add4) result_reg[127:96] <= result_add4;
	end
end

//data_accu1
//
always @(*) begin
	if(reset) begin 
		data_accu1 = 0;
		data_accu2 = 0;
		data_accu3 = 0;
		data_accu4 = 0;
	end else begin
		data_accu1 = hidden[address][31:0];//hidden[2047:2016];
		data_accu2 = hidden[address][63:32];//hidden[2015:1984];
		data_accu3 = hidden[address][95:64];//hidden[1983:1952];
		data_accu4 = hidden[address][127:96];//hidden[1951:1920];
	end
end


assign dataa1 = din;
assign dataa2 = din;
assign dataa3 = din;
assign dataa4 = din;

assign datab1 = data_reg[31:0];		//0.4
assign datab2 = data_reg[63:32];
assign datab3 = data_reg[95:64];
assign datab4 = data_reg[127:96];

//data_reg
always_ff @(posedge clk or posedge reset) begin
	if(reset) data_reg <= 0;
	else begin
		if(datavalid) data_reg <= data;
		else data_reg <= data_reg;
	end
end



//intermediate result of multiplication
always_ff @(posedge clk or posedge reset) begin
	//if(reset) result_ 
end

assign result = hidden[address][31:0];





//action signals

//start_add
assign start_add1 = done_mul1;
assign start_add2 = done_mul2;
assign start_add3 = done_mul3;
assign start_add4 = done_mul4;

//start_mul
always_ff @(posedge clk or posedge reset) begin
	if(reset) start_mul <= 0;
	else begin
		case(cs)
			IDLE: start_mul <= 0;
			READ_START: begin
				start_mul <= 1;

			end
			READ: begin
				start_mul <= 0;
				//if(datavalid)start_mul <= 1;
				//else start_mul <= 0;
			end
			READ_DONE: begin
				if(datavalid)start_mul <= 1;
				else start_mul <= 0;
			end
			ALL_DONE: start_mul <= 0;
			default: start_mul <= 0;
		endcase
	end
end



//cs
always_ff @(posedge clk or posedge reset) begin
	if(reset) cs <= IDLE;
	else cs <= ns;
end

//4 muls, 4 adds

//muls
fpoint2_multi #(
		.arithmetic_present (1),
		.root_present       (1),
		.conversion_present (1)
	) nios_custom_instr_floating_point_2_multi_1 (
		.clk       (clk),       // s1.clk
		.clk_en    (clk_en),    //   .clk_en
		.dataa     (dataa1),     //   .dataa
		.datab     (datab1),     //   .datab
		.n         (n_mul),         //   .n
		.reset     (reset),     //   .reset
		.reset_req (reset_req), //   .reset_req
		.start     (start_mul),     //   .start
		.done      (done_mul1),      //   .done
		.result    (result_mul1)     //   .result
	);
	
fpoint2_multi #(
		.arithmetic_present (1),
		.root_present       (1),
		.conversion_present (1)
	) nios_custom_instr_floating_point_2_multi_2 (
		.clk       (clk),       // s1.clk
		.clk_en    (clk_en),    //   .clk_en
		.dataa     (dataa2),     //   .dataa
		.datab     (datab2),     //   .datab
		.n         (n_mul),         //   .n
		.reset     (reset),     //   .reset
		.reset_req (reset_req), //   .reset_req
		.start     (start_mul),     //   .start
		.done      (done_mul2),      //   .done
		.result    (result_mul2)     //   .result
	);
	
fpoint2_multi #(
		.arithmetic_present (1),
		.root_present       (1),
		.conversion_present (1)
	) nios_custom_instr_floating_point_2_multi_3 (
		.clk       (clk),       // s1.clk
		.clk_en    (clk_en),    //   .clk_en
		.dataa     (dataa3),     //   .dataa
		.datab     (datab3),     //   .datab
		.n         (n_mul),         //   .n
		.reset     (reset),     //   .reset
		.reset_req (reset_req), //   .reset_req
		.start     (start_mul),     //   .start
		.done      (done_mul3),      //   .done
		.result    (result_mul3)     //   .result
	);
	
fpoint2_multi #(
		.arithmetic_present (1),
		.root_present       (1),
		.conversion_present (1)
	) nios_custom_instr_floating_point_2_multi_4 (
		.clk       (clk),       // s1.clk
		.clk_en    (clk_en),    //   .clk_en
		.dataa     (dataa4),     //   .dataa
		.datab     (datab4),     //   .datab
		.n         (n_mul),         //   .n
		.reset     (reset),     //   .reset
		.reset_req (reset_req), //   .reset_req
		.start     (start_mul),     //   .start
		.done      (done_mul4),      //   .done
		.result    (result_mul4)     //   .result
	);
/*
//adds
fpoint2_multi #(
		.arithmetic_present (1),
		.root_present       (1),
		.conversion_present (1)
	) nios_custom_instr_floating_point_2_multi_5 (
		.clk       (clk),       // s1.clk
		.clk_en    (clk_en),    //   .clk_en
		.dataa     (result_mul1),     //   .dataa
		.datab     (data_accu1),     //   .datab
		.n         (n_add),         //   .n
		.reset     (reset),     //   .reset
		.reset_req (reset_req), //   .reset_req
		.start     (start_add1),     //   .start
		.done      (done_add1),      //   .done
		.result    (result_add1)     //   .result
	);
	
fpoint2_multi #(
		.arithmetic_present (1),
		.root_present       (1),
		.conversion_present (1)
	) nios_custom_instr_floating_point_2_multi_6 (
		.clk       (clk),       // s1.clk
		.clk_en    (clk_en),    //   .clk_en
		.dataa     (result_mul2),     //   .dataa
		.datab     (data_accu2),     //   .datab
		.n         (n_add),         //   .n
		.reset     (reset),     //   .reset
		.reset_req (reset_req), //   .reset_req
		.start     (start_add2),     //   .start
		.done      (done_add2),      //   .done
		.result    (result_add2)     //   .result
	);
	
fpoint2_multi #(
		.arithmetic_present (1),
		.root_present       (1),
		.conversion_present (1)
	) nios_custom_instr_floating_point_2_multi_7 (
		.clk       (clk),       // s1.clk
		.clk_en    (clk_en),    //   .clk_en
		.dataa     (result_mul3),     //   .dataa
		.datab     (data_accu3),     //   .datab
		.n         (n_add),         //   .n
		.reset     (reset),     //   .reset
		.reset_req (reset_req), //   .reset_req
		.start     (start_add3),     //   .start
		.done      (done_add3),      //   .done
		.result    (result_add3)     //   .result
	);
	
fpoint2_multi #(
		.arithmetic_present (1),
		.root_present       (1),
		.conversion_present (1)
	) nios_custom_instr_floating_point_2_multi_8 (
		.clk       (clk),       // s1.clk
		.clk_en    (clk_en),    //   .clk_en
		.dataa     (result_mul4),     //   .dataa
		.datab     (data_accu4),     //   .datab
		.n         (n_mul),         //   .n
		.reset     (reset),     //   .reset
		.reset_req (reset_req), //   .reset_req
		.start     (start_add4),     //   .start
		.done      (done_add4),      //   .done
		.result    (result_add4)     //   .result
	);
	*/

endmodule
