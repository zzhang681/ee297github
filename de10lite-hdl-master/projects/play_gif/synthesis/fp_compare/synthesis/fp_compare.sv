module fp_compare (
	dataa,
	index_in,
	index_out
);	

input	[31:0]	dataa;
input [3:0]		index_in;
logic	[31:0]	datab;
logic	[3:0]	n;
logic	[31:0]	result;
output [3:0]	index_out;

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