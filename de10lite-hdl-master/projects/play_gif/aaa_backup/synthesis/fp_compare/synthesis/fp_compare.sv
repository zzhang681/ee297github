module fp_compare (
	clk,
	reset,
	start,
	dataa,
	index_in,
	index_out
);	

input clk, reset;			//posedge reset
input start;				//when start goes high, start comparing data
input	[31:0]	dataa;		//new data is coming every clk cycle
input [3:0]		index_in;	//new index is coming every clk cycle with data
logic	[31:0]	datab;		//datab is initially 0 after reset
logic	[3:0]	n;			//mod selection
logic	[31:0]	result;
output [3:0]	index_out;	//keep the index which comes with the biggest data

assign n = 3;



fpoint2_combi #(
		.arithmetic_present (0),
		.comparison_present (1)
	) nios_custom_instr_floating_point_2_combi_0 (
		.dataa  (dataa),  // s1.dataa
		.datab  (datab),  //   .datab
		.n      (n),      //   .n
		.result (result)  //   .result
	);

endmodule