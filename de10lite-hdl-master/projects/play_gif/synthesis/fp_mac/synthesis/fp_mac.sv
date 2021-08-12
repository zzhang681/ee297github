// fp_mac.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module fp_mac (
		input  wire        clk,       // s1.clk
		input  [127:0]		 data,
		input  wire [31:0] din,			//input(image)
		input  wire	[31:0] din_bias,
		input					 datavalid,
		input  wire        reset,     //   .reset
		input  wire			 read_done,
		input  wire        start,     //   .start
		output wire        done,      //   .done
		output wire			 done_bias,
		output wire [31:0] result,     //   .result
		output wire [4:0] states,
		output wire next_in,
		output adone
);

enum bit[4:0] {
	IDLE,				//00000
	READ_IMG,		//00001
	READ_START,		//00010
	READ,				//00011
	READ_DONE,		//00100
	OP,				//00101
	OP_DONE,			//00110
	BIAS_START,		//00111
	BIAS,				//01000
	BIAS_DONE,		//01001
	RELU_START,		//01010
	RELU,				//01011
	ALL_DONE			//01100
} cs, ns;

//typedef union packed{
bit [15:0][127:0] hidden;				//16x128
//logic [63:0][31:0] h;
//} hidden_reg;

assign states = cs;
//hidden_reg hidden;


logic [31:0] dataa_bias, datab_bias, result_bias;
logic start_bias;
logic [7:0] count_bias;


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

//logic []

logic [127:0] data_reg, result_reg;
//logic [2:0] n_mul, n_add;
logic clk_en, reset_req;
logic [3:0] address, address_next;		//address for hidden (0-63)

logic edge_det_READ, start_mul;
assign edge_det_READ = (cs == READ) ? 1:0;
assign adone = (cs == ALL_DONE) ? 1:0;
assign next_in = (address == 15 && cs == OP_DONE) ? 1:0;
//assign reset_req = !reset;//(cs == IDLE) ? 1:0;

/*
assign dataa_fp = 32'h3e99999a;	//0.3
assign datab_fp = 32'h3ecccccd;	//0.4		//expect multiply result 0.12 3df5c28f
*/


parameter n_mul = 3'b100;
parameter n_add = 3'b101;
//multiply: 100
//add: 101

assign clk_en = 1'b1;

assign done = done_flag1 && done_flag2 && done_flag3 && done_flag4;

logic [7:0] count;

//count 9
always @(posedge clk or posedge reset) begin
	if(reset) count <= 0;
	else begin
		case(cs)
			OP: count <= count + 1;
			default: count <= 0;
		endcase
	end
end

//count_bias
always_ff @(posedge clk) begin
	if(reset) count_bias <= 0;
	else begin
		if(cs == BIAS_DONE && count_bias < 64) count_bias <= count_bias + 1;
	end
end

/*
1. start -> 9 cycle -> done -> wait start   (Finished)
2. make sure read correctly    (Finished?)
3. 1 IP start -> wait done			(Finished)
4. make sure result correct with mul & add with simple inputs	(Finished)
5. ****try some new inputs read from SDRAM****                  (Finished)
0 -> 0.1   16 -> 0.2    32 -> 0.3     48 -> 0.4    64 -> 0.5
3DCCCCCD   3E4CCCCD 32  3E99999A 48   3ECCCCCD     3F000000
in: 0.5       16   32  48   64
result: 0.05+0.1+0.15+0.2+0.25=0.75 (3F400000)
0.95 (0.75) (+0.2)
0.65 (0.5)  (+0.15)
0.4  (0.3)  (+0.1)  (0.05+0.1+0.15+0.1)
0.2  (0.15) (+0.05) (0.05+0.1+0.05)
6. PROBLEM: hidden: no reset problem? (Finished, final address may different)
7. Check m2-m4 stability   (Finished)
8. Add states to update input
	problem: unstable
	single input: finished
	different inputs
		something wrong with the input change (Finished)
9. how to input image?           (Finished)
	address 204000 - 204783
10. address of image does not increase
10.5. add bias
11. add ReLU
*/

//ns
always_comb begin
	ns = cs;
	case(cs)
		IDLE: begin
			if(start) ns = READ_START;
			else ns = IDLE;
		end
		READ_START: ns = READ;
		READ: begin
			if(datavalid) ns = READ_DONE;
			else if(read_done) ns = BIAS_START;
			else ns = READ;
		end
		READ_DONE: ns = OP;
		OP: begin
			if(done) begin
				if(read_done) ns = BIAS_START;
				else ns = OP_DONE;
			end else ns = OP;
		end
		OP_DONE: ns = READ;
		BIAS_START: ns = BIAS;
		BIAS: begin
			if(done_bias) ns = BIAS_DONE;
			else ns = BIAS;
		end
		BIAS_DONE: begin
			//ns = BIAS_DONE;
			
			if(count_bias >= 64) ns = ALL_DONE;//RELU_START;
			else ns = BIAS;
			
		end
		RELU_START: ns = RELU;
		RELU: begin
			if(address == 15) ns = ALL_DONE;
			else ns = RELU;
		end
		ALL_DONE: ns = ALL_DONE;
		default: ns = IDLE;
	endcase
end

// ----------------------- CONTROL SIGNALS ------------------------- //
//start_mul
always_comb begin
	start_mul = 0;
	if(cs == READ_DONE) start_mul = 1;
end

assign start_add1 = done_mul1;
assign start_add2 = done_mul2;
assign start_add3 = done_mul3;
assign start_add4 = done_mul4;
assign start_bias = (cs == BIAS_START) || (cs == BIAS_DONE) ? 1:0;

//address
always_ff @(posedge clk) begin
	if(reset) address <= 0;
	else begin
		address <= address_next;
	end
end

//address_next
always_comb begin
	address_next = address;
	case(cs)
		IDLE: begin
			if(address < 15) address_next = address + 1;
			else address_next = 0;
			if(ns == READ_START) address_next = 0;
		end
		BIAS_START: address_next = 0;
		BIAS_DONE: begin
			if(count_bias < 64) begin
				if((count_bias%4) == 3) address_next = address + 1;
				else address_next = address;
			end
		end
		RELU_START: address_next = 0;
		RELU: begin
			if(address < 15) address_next = address + 1;
			else address_next = 0;
		end
		
		default: begin
			if(done) begin 
				if(address < 15) address_next = address + 1;
				else address_next = 0;
			end
		end
	endcase
end

always @(posedge clk or posedge reset) begin
	if(reset) begin
		done_flag1 <= 0;
		done_flag2 <= 0;
		done_flag3 <= 0;
		done_flag4 <= 0;
	end else begin
		if(done_add1) done_flag1 <= 1;
		if(done_add2) done_flag2 <= 1;
		if(done_add3) done_flag3 <= 1;
		if(done_add4) done_flag4 <= 1;
		if(done) begin
			done_flag1 <= 0;
			done_flag2 <= 0;
			done_flag3 <= 0;
			done_flag4 <= 0;
		end
	end
end


// ----------------------------------------------------------------- //


// ------------------------- DATA SIGNALS -------------------------- //
assign dataa1 = din;
assign dataa2 = din;
assign dataa3 = din;
assign dataa4 = din;
assign datab1 = data[31:0];
assign datab2 = data[63:32];
assign datab3 = data[95:64];
assign datab4 = data[127:96];

//data_accu1
always_ff @(posedge clk) begin
	if(reset) data_accu1 <= 0;
	else begin
		if(cs == IDLE) data_accu1 <= 0;
		else if(done_add1) data_accu1 <= hidden[address][31:0];//result_add1;
		else data_accu1 <= data_accu1;
	end
end

//data_accu2
always_ff @(posedge clk) begin
	if(reset) data_accu2 <= 0;
	else begin
		if(cs == IDLE) data_accu2 <= 0;
		else if(done_add2) data_accu2 <= hidden[address][63:32];
		else data_accu2 <= data_accu2;
	end
end

//data_accu3
always_ff @(posedge clk) begin
	if(reset) data_accu3 <= 0;
	else begin
		if(cs == IDLE) data_accu3 <= 0;
		else if(done_add3) data_accu3 <= hidden[address][95:64];
		else data_accu3 <= data_accu3;
	end
end

//data_accu4
always_ff @(posedge clk) begin
	if(reset) data_accu4 <= 0;
	else begin
		if(cs == IDLE) data_accu4 <= 0;
		else if(done_add4) data_accu4 <= hidden[address][127:96];
		else data_accu4 <= data_accu4;
	end
end

//hidden

always_ff @(posedge clk) begin
	if(reset) hidden[address] <= 0;
	else begin
		case(cs)
		IDLE: hidden[address] <= 0;
		READ_START: begin
			hidden[0] <= 0;
			hidden[1] <= 0;
			hidden[2] <= 0;
			hidden[3] <= 0;
			hidden[4] <= 0;
			hidden[5] <= 0;
			hidden[6] <= 0;
			hidden[7] <= 0;
			hidden[8] <= 0;
			hidden[9] <= 0;
			hidden[10] <= 0;
			hidden[11] <= 0;
			hidden[12] <= 0;
			hidden[13] <= 0;
			hidden[14] <= 0;
			hidden[15] <= 0;
		end
		/*
		BIAS_DONE: begin
			case(count_bias % 4)
				0: hidden[address][31:0] <= result_bias;
				1: hidden[address][63:32] <= result_bias;
				2: hidden[address][95:64] <= result_bias;
				3: hidden[address][127:96] <= result_bias;
			endcase
		end
		*/
		RELU: begin
			if(hidden[address][31]) hidden[address][31:0] <= 0;
			if(hidden[address][63]) hidden[address][63:32] <= 0;
			if(hidden[address][95]) hidden[address][95:64] <= 0;
			if(hidden[address][127]) hidden[address][127:96] <= 0;
		end
		default: begin
			if(done_add1) hidden[address][31:0] <= result_add1;
			if(done_add2) hidden[address][63:32] <= result_add2;
			if(done_add3) hidden[address][95:64] <= result_add3;
			if(done_add4) hidden[address][127:96] <= result_add4;
		end
		endcase
	end
end

assign dataa_bias = din_bias;

//datab_bias

always_ff @(posedge clk) begin
	if(reset) datab_bias <= 0;
	else begin
		//case(cs)
			//BIAS_START: begin
				case(count_bias % 4)
					0: datab_bias <= hidden[address][31:0];
					1: datab_bias <= hidden[address][63:32];
					2: datab_bias <= hidden[address][95:64];
					3: datab_bias <= hidden[address][127:96];
				endcase
			//end
		//endcase
	end
end

//assign hidden[13][31:0] = 32'h12345678;

// ----------------------------------------------------------------- //

// ------------------------- TEST SIGNALS -------------------------- //
//result


always_ff @(posedge clk) begin
	if(reset) result <= 0;
	else begin
		if(cs == IDLE) result <= 0; 
		else if(done) result <= din;//hidden[0][31:0];//result_add1;
		else result <= result;
	end
end

/*
always_ff @(posedge clk) begin
	if(reset) result <= 0;
	else begin
		//if(cs == OP) begin
			if(done) result <= result + 1;			//count how many ops in total
			else result <= result;
		//end
	end
end
*/
//assign result = result_bias;//count_bias;//address;


// ----------------------------------------------------------------- //



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
		.n         (n_add),         //   .n
		.reset     (reset),     //   .reset
		.reset_req (reset_req), //   .reset_req
		.start     (start_add4),     //   .start
		.done      (done_add4),      //   .done
		.result    (result_add4)     //   .result
	);

//for the bias

fpoint2_multi #(
		.arithmetic_present (1),
		.root_present       (1),
		.conversion_present (1)
	) nios_custom_instr_floating_point_2_multi_9 (
		.clk       (clk),       // s1.clk
		.clk_en    (clk_en),    //   .clk_en
		.dataa     (dataa_bias),     //   .dataa
		.datab     (datab_bias),     //   .datab
		.n         (n_add),         //   .n
		.reset     (reset),     //   .reset
		.reset_req (reset_req), //   .reset_req
		.start     (start_bias),     //   .start
		.done      (done_bias),      //   .done
		.result    (result_bias)     //   .result
	);


endmodule
