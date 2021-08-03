
module uint_to_float (
	input [7:0] in,
	output [31:0] out
);

//convert 8-bit input to 32-bit output
//example: input: 8'h01
//  1/256 = 0.00390625 -> 32'h3B800000
//  input(real number) / 256 -> result convert to floating point
//https://www.binaryconvert.com/convert_float.html?decimal=048046048048051057048054050053   Online converter
//Use combinational logic

always_comb begin
	out = 32'h00000000;
	case(in)
		8'h00: out = 32'h00000000;
		8'h01: out = 32'h3B800000;
		//.... All 256 cases
	endcase
end

endmodule
