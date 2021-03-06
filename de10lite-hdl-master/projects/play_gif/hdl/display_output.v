`timescale 1ns / 1ps

module display_output(in1,in2,in3,in4,seg1,seg2,seg3,seg4,seg5,seg6,ledr);
input [7:0] in1,in2, in3, in4;
wire [3:0] in1_l4, in1_h4,in2_l4,in2_h4,in3_l4,in3_h4;

output reg [7:0] seg1,seg2,seg3,seg4,seg5,seg6;
output wire [7:0] ledr;

	assign in1_l4=in1[3:0];
	assign in1_h4=in1[7:4];
	assign in2_l4=in2[3:0];
	assign in2_h4=in2[7:4];
	assign in3_l4=in3[3:0];
	assign in3_h4=in3[7:4];
	assign ledr=in4[7:0];

		always@(*)
		begin 
			case(in1_l4)
			4'b0000: seg1=8'b11000000;//0
			4'b0001: seg1=8'b11111001;//1
			4'b0010: seg1=8'b10100100;//2
			4'b0011: seg1=8'b10110000;//3
			4'b0100: seg1=8'b10011001;//4
			4'b0101: seg1=8'b10010010;//5
			4'b0110: seg1=8'b10000010;//6
			4'b0111: seg1=8'b11111000;//7
			4'b1000: seg1=8'b10000000;//8
			4'b1001: seg1=8'b10010000;//9
			4'b1010: seg1=8'b10001000;//A or 10
			4'b1011: seg1=8'b10000011;//B or 11
			4'b1100: seg1=8'b11000110;//C or 12
			4'b1101: seg1=8'b10100001;//D or 13
			4'b1110: seg1=8'b10000110;//E or 14
			4'b1111: seg1=8'b10001110;//F or 15
			default: seg1=8'b11000000;//0
			endcase

			case(in1_h4)
			4'b0000: seg2=8'b11000000;//0
			4'b0001: seg2=8'b11111001;//1
			4'b0010: seg2=8'b10100100;//2
			4'b0011: seg2=8'b10110000;//3
			4'b0100: seg2=8'b10011001;//4
			4'b0101: seg2=8'b10010010;//5
			4'b0110: seg2=8'b10000010;//6
			4'b0111: seg2=8'b11111000;//7
			4'b1000: seg2=8'b10000000;//8
			4'b1001: seg2=8'b10010000;//9
			4'b1010: seg2=8'b10001000;//A or 10
			4'b1011: seg2=8'b10000011;//B or 11
			4'b1100: seg2=8'b11000110;//C or 12
			4'b1101: seg2=8'b10100001;//D or 13
			4'b1110: seg2=8'b10000110;//E or 14
			4'b1111: seg2=8'b10001110;//F or 15
			default: seg2=8'b11000000;//0
			endcase

			case(in2_l4)
			4'b0000: seg3=8'b11000000;//0
			4'b0001: seg3=8'b11111001;//1
			4'b0010: seg3=8'b10100100;//2
			4'b0011: seg3=8'b10110000;//3
			4'b0100: seg3=8'b10011001;//4
			4'b0101: seg3=8'b10010010;//5
			4'b0110: seg3=8'b10000010;//6
			4'b0111: seg3=8'b11111000;//7
			4'b1000: seg3=8'b10000000;//8
			4'b1001: seg3=8'b10010000;//9
			4'b1010: seg3=8'b10001000;//A or 10
			4'b1011: seg3=8'b10000011;//B or 11
			4'b1100: seg3=8'b11000110;//C or 12
			4'b1101: seg3=8'b10100001;//D or 13
			4'b1110: seg3=8'b10000110;//E or 14
			4'b1111: seg3=8'b10001110;//F or 15
			default: seg3=8'b11000000;//0
			endcase

			case(in2_h4)
			4'b0000: seg4=8'b11000000;//0
			4'b0001: seg4=8'b11111001;//1
			4'b0010: seg4=8'b10100100;//2
			4'b0011: seg4=8'b10110000;//3
			4'b0100: seg4=8'b10011001;//4
			4'b0101: seg4=8'b10010010;//5
			4'b0110: seg4=8'b10000010;//6
			4'b0111: seg4=8'b11111000;//7
			4'b1000: seg4=8'b10000000;//8
			4'b1001: seg4=8'b10010000;//9
			4'b1010: seg4=8'b10001000;//A or 10
			4'b1011: seg4=8'b10000011;//B or 11
			4'b1100: seg4=8'b11000110;//C or 12
			4'b1101: seg4=8'b10100001;//D or 13
			4'b1110: seg4=8'b10000110;//E or 14
			4'b1111: seg4=8'b10001110;//F or 15
			default: seg4=8'b11000000;//0
			endcase
			
			case(in3_l4)
			4'b0000: seg5=8'b11000000;//0
			4'b0001: seg5=8'b11111001;//1
			4'b0010: seg5=8'b10100100;//2
			4'b0011: seg5=8'b10110000;//3
			4'b0100: seg5=8'b10011001;//4
			4'b0101: seg5=8'b10010010;//5
			4'b0110: seg5=8'b10000010;//6
			4'b0111: seg5=8'b11111000;//7
			4'b1000: seg5=8'b10000000;//8
			4'b1001: seg5=8'b10010000;//9
			4'b1010: seg5=8'b10001000;//A or 10
			4'b1011: seg5=8'b10000011;//B or 11
			4'b1100: seg5=8'b11000110;//C or 12
			4'b1101: seg5=8'b10100001;//D or 13
			4'b1110: seg5=8'b10000110;//E or 14
			4'b1111: seg5=8'b10001110;//F or 15
			default: seg5=8'b11000000;//0
			endcase

			case(in3_h4)
			4'b0000: seg6=8'b11000000;//0
			4'b0001: seg6=8'b11111001;//1
			4'b0010: seg6=8'b10100100;//2
			4'b0011: seg6=8'b10110000;//3
			4'b0100: seg6=8'b10011001;//4
			4'b0101: seg6=8'b10010010;//5
			4'b0110: seg6=8'b10000010;//6
			4'b0111: seg6=8'b11111000;//7
			4'b1000: seg6=8'b10000000;//8
			4'b1001: seg6=8'b10010000;//9
			4'b1010: seg6=8'b10001000;//A or 10
			4'b1011: seg6=8'b10000011;//B or 11
			4'b1100: seg6=8'b11000110;//C or 12
			4'b1101: seg6=8'b10100001;//D or 13
			4'b1110: seg6=8'b10000110;//E or 14
			4'b1111: seg6=8'b10001110;//F or 15
			default: seg6=8'b11000000;//0
			endcase
			
		end
endmodule