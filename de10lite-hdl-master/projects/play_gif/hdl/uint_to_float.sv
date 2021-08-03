module uint_to_float (
	input [7:0] i_uint8_int,
	output [31:0] o_fp32_hex
);

//convert 8-bit input to 32-bit output
//example: input: 8'h01
//  1/256 = 0.00390625 -> 32'h3B800000
//  input(real number) / 256 -> result convert to floating point
//https://www.binaryconvert.com/convert_float.html?decimal=048046048048051057048054050053   Online converter
//Use combinational logic

always_comb begin
        case ( i_uint8_int )
	        8'd0   : o_fp32_hex = 32'h0;
	        8'd1   : o_fp32_hex = 32'h3b808081;
	        8'd2   : o_fp32_hex = 32'h3c008081;
	        8'd3   : o_fp32_hex = 32'h3c40c0c1;
	        8'd4   : o_fp32_hex = 32'h3c808081;
	        8'd5   : o_fp32_hex = 32'h3ca0a0a1;
	        8'd6   : o_fp32_hex = 32'h3cc0c0c1;
	        8'd7   : o_fp32_hex = 32'h3ce0e0e1;
	        8'd8   : o_fp32_hex = 32'h3d008081;
	        8'd9   : o_fp32_hex = 32'h3d109091;
	        8'd10  : o_fp32_hex = 32'h3d20a0a1;
	        8'd11  : o_fp32_hex = 32'h3d30b0b1;
	        8'd12  : o_fp32_hex = 32'h3d40c0c1;
	        8'd13  : o_fp32_hex = 32'h3d50d0d1;
	        8'd14  : o_fp32_hex = 32'h3d60e0e1;
	        8'd15  : o_fp32_hex = 32'h3d70f0f1;
	        8'd16  : o_fp32_hex = 32'h3d808081;
	        8'd17  : o_fp32_hex = 32'h3d888889;
	        8'd18  : o_fp32_hex = 32'h3d909091;
	        8'd19  : o_fp32_hex = 32'h3d989899;
	        8'd20  : o_fp32_hex = 32'h3da0a0a1;
	        8'd21  : o_fp32_hex = 32'h3da8a8a9;
	        8'd22  : o_fp32_hex = 32'h3db0b0b1;
	        8'd23  : o_fp32_hex = 32'h3db8b8b9;
	        8'd24  : o_fp32_hex = 32'h3dc0c0c1;
	        8'd25  : o_fp32_hex = 32'h3dc8c8c9;
	        8'd26  : o_fp32_hex = 32'h3dd0d0d1;
	        8'd27  : o_fp32_hex = 32'h3dd8d8d9;
	        8'd28  : o_fp32_hex = 32'h3de0e0e1;
	        8'd29  : o_fp32_hex = 32'h3de8e8e9;
	        8'd30  : o_fp32_hex = 32'h3df0f0f1;
	        8'd31  : o_fp32_hex = 32'h3df8f8f9;
	        8'd32  : o_fp32_hex = 32'h3e008081;
	        8'd33  : o_fp32_hex = 32'h3e048485;
	        8'd34  : o_fp32_hex = 32'h3e088889;
	        8'd35  : o_fp32_hex = 32'h3e0c8c8d;
	        8'd36  : o_fp32_hex = 32'h3e109091;
	        8'd37  : o_fp32_hex = 32'h3e149495;
	        8'd38  : o_fp32_hex = 32'h3e189899;
	        8'd39  : o_fp32_hex = 32'h3e1c9c9d;
	        8'd40  : o_fp32_hex = 32'h3e20a0a1;
	        8'd41  : o_fp32_hex = 32'h3e24a4a5;
	        8'd42  : o_fp32_hex = 32'h3e28a8a9;
	        8'd43  : o_fp32_hex = 32'h3e2cacad;
	        8'd44  : o_fp32_hex = 32'h3e30b0b1;
	        8'd45  : o_fp32_hex = 32'h3e34b4b5;
	        8'd46  : o_fp32_hex = 32'h3e38b8b9;
	        8'd47  : o_fp32_hex = 32'h3e3cbcbd;
	        8'd48  : o_fp32_hex = 32'h3e40c0c1;
	        8'd49  : o_fp32_hex = 32'h3e44c4c5;
	        8'd50  : o_fp32_hex = 32'h3e48c8c9;
	        8'd51  : o_fp32_hex = 32'h3e4ccccd;
	        8'd52  : o_fp32_hex = 32'h3e50d0d1;
	        8'd53  : o_fp32_hex = 32'h3e54d4d5;
	        8'd54  : o_fp32_hex = 32'h3e58d8d9;
	        8'd55  : o_fp32_hex = 32'h3e5cdcdd;
	        8'd56  : o_fp32_hex = 32'h3e60e0e1;
	        8'd57  : o_fp32_hex = 32'h3e64e4e5;
	        8'd58  : o_fp32_hex = 32'h3e68e8e9;
	        8'd59  : o_fp32_hex = 32'h3e6ceced;
	        8'd60  : o_fp32_hex = 32'h3e70f0f1;
	        8'd61  : o_fp32_hex = 32'h3e74f4f5;
	        8'd62  : o_fp32_hex = 32'h3e78f8f9;
	        8'd63  : o_fp32_hex = 32'h3e7cfcfd;
	        8'd64  : o_fp32_hex = 32'h3e808081;
	        8'd65  : o_fp32_hex = 32'h3e828283;
	        8'd66  : o_fp32_hex = 32'h3e848485;
	        8'd67  : o_fp32_hex = 32'h3e868687;
	        8'd68  : o_fp32_hex = 32'h3e888889;
	        8'd69  : o_fp32_hex = 32'h3e8a8a8b;
	        8'd70  : o_fp32_hex = 32'h3e8c8c8d;
	        8'd71  : o_fp32_hex = 32'h3e8e8e8f;
	        8'd72  : o_fp32_hex = 32'h3e909091;
	        8'd73  : o_fp32_hex = 32'h3e929293;
	        8'd74  : o_fp32_hex = 32'h3e949495;
	        8'd75  : o_fp32_hex = 32'h3e969697;
	        8'd76  : o_fp32_hex = 32'h3e989899;
	        8'd77  : o_fp32_hex = 32'h3e9a9a9b;
	        8'd78  : o_fp32_hex = 32'h3e9c9c9d;
	        8'd79  : o_fp32_hex = 32'h3e9e9e9f;
	        8'd80  : o_fp32_hex = 32'h3ea0a0a1;
	        8'd81  : o_fp32_hex = 32'h3ea2a2a3;
	        8'd82  : o_fp32_hex = 32'h3ea4a4a5;
	        8'd83  : o_fp32_hex = 32'h3ea6a6a7;
	        8'd84  : o_fp32_hex = 32'h3ea8a8a9;
	        8'd85  : o_fp32_hex = 32'h3eaaaaab;
	        8'd86  : o_fp32_hex = 32'h3eacacad;
	        8'd87  : o_fp32_hex = 32'h3eaeaeaf;
	        8'd88  : o_fp32_hex = 32'h3eb0b0b1;
	        8'd89  : o_fp32_hex = 32'h3eb2b2b3;
	        8'd90  : o_fp32_hex = 32'h3eb4b4b5;
	        8'd91  : o_fp32_hex = 32'h3eb6b6b7;
	        8'd92  : o_fp32_hex = 32'h3eb8b8b9;
	        8'd93  : o_fp32_hex = 32'h3ebababb;
	        8'd94  : o_fp32_hex = 32'h3ebcbcbd;
	        8'd95  : o_fp32_hex = 32'h3ebebebf;
	        8'd96  : o_fp32_hex = 32'h3ec0c0c1;
	        8'd97  : o_fp32_hex = 32'h3ec2c2c3;
	        8'd98  : o_fp32_hex = 32'h3ec4c4c5;
	        8'd99  : o_fp32_hex = 32'h3ec6c6c7;
	        8'd100 : o_fp32_hex = 32'h3ec8c8c9;
	        8'd101 : o_fp32_hex = 32'h3ecacacb;
	        8'd102 : o_fp32_hex = 32'h3ecccccd;
	        8'd103 : o_fp32_hex = 32'h3ecececf;
	        8'd104 : o_fp32_hex = 32'h3ed0d0d1;
	        8'd105 : o_fp32_hex = 32'h3ed2d2d3;
	        8'd106 : o_fp32_hex = 32'h3ed4d4d5;
	        8'd107 : o_fp32_hex = 32'h3ed6d6d7;
	        8'd108 : o_fp32_hex = 32'h3ed8d8d9;
	        8'd109 : o_fp32_hex = 32'h3edadadb;
	        8'd110 : o_fp32_hex = 32'h3edcdcdd;
	        8'd111 : o_fp32_hex = 32'h3edededf;
	        8'd112 : o_fp32_hex = 32'h3ee0e0e1;
	        8'd113 : o_fp32_hex = 32'h3ee2e2e3;
	        8'd114 : o_fp32_hex = 32'h3ee4e4e5;
	        8'd115 : o_fp32_hex = 32'h3ee6e6e7;
	        8'd116 : o_fp32_hex = 32'h3ee8e8e9;
	        8'd117 : o_fp32_hex = 32'h3eeaeaeb;
	        8'd118 : o_fp32_hex = 32'h3eececed;
	        8'd119 : o_fp32_hex = 32'h3eeeeeef;
	        8'd120 : o_fp32_hex = 32'h3ef0f0f1;
	        8'd121 : o_fp32_hex = 32'h3ef2f2f3;
	        8'd122 : o_fp32_hex = 32'h3ef4f4f5;
	        8'd123 : o_fp32_hex = 32'h3ef6f6f7;
	        8'd124 : o_fp32_hex = 32'h3ef8f8f9;
	        8'd125 : o_fp32_hex = 32'h3efafafb;
	        8'd126 : o_fp32_hex = 32'h3efcfcfd;
	        8'd127 : o_fp32_hex = 32'h3efefeff;
	        8'd128 : o_fp32_hex = 32'h3f008081;
	        8'd129 : o_fp32_hex = 32'h3f018182;
	        8'd130 : o_fp32_hex = 32'h3f028283;
	        8'd131 : o_fp32_hex = 32'h3f038384;
	        8'd132 : o_fp32_hex = 32'h3f048485;
	        8'd133 : o_fp32_hex = 32'h3f058586;
	        8'd134 : o_fp32_hex = 32'h3f068687;
	        8'd135 : o_fp32_hex = 32'h3f078788;
	        8'd136 : o_fp32_hex = 32'h3f088889;
	        8'd137 : o_fp32_hex = 32'h3f09898a;
	        8'd138 : o_fp32_hex = 32'h3f0a8a8b;
	        8'd139 : o_fp32_hex = 32'h3f0b8b8c;
	        8'd140 : o_fp32_hex = 32'h3f0c8c8d;
	        8'd141 : o_fp32_hex = 32'h3f0d8d8e;
	        8'd142 : o_fp32_hex = 32'h3f0e8e8f;
	        8'd143 : o_fp32_hex = 32'h3f0f8f90;
	        8'd144 : o_fp32_hex = 32'h3f109091;
	        8'd145 : o_fp32_hex = 32'h3f119192;
	        8'd146 : o_fp32_hex = 32'h3f129293;
	        8'd147 : o_fp32_hex = 32'h3f139394;
	        8'd148 : o_fp32_hex = 32'h3f149495;
	        8'd149 : o_fp32_hex = 32'h3f159596;
	        8'd150 : o_fp32_hex = 32'h3f169697;
	        8'd151 : o_fp32_hex = 32'h3f179798;
	        8'd152 : o_fp32_hex = 32'h3f189899;
	        8'd153 : o_fp32_hex = 32'h3f19999a;
	        8'd154 : o_fp32_hex = 32'h3f1a9a9b;
	        8'd155 : o_fp32_hex = 32'h3f1b9b9c;
	        8'd156 : o_fp32_hex = 32'h3f1c9c9d;
	        8'd157 : o_fp32_hex = 32'h3f1d9d9e;
	        8'd158 : o_fp32_hex = 32'h3f1e9e9f;
	        8'd159 : o_fp32_hex = 32'h3f1f9fa0;
	        8'd160 : o_fp32_hex = 32'h3f20a0a1;
	        8'd161 : o_fp32_hex = 32'h3f21a1a2;
	        8'd162 : o_fp32_hex = 32'h3f22a2a3;
	        8'd163 : o_fp32_hex = 32'h3f23a3a4;
	        8'd164 : o_fp32_hex = 32'h3f24a4a5;
	        8'd165 : o_fp32_hex = 32'h3f25a5a6;
	        8'd166 : o_fp32_hex = 32'h3f26a6a7;
	        8'd167 : o_fp32_hex = 32'h3f27a7a8;
	        8'd168 : o_fp32_hex = 32'h3f28a8a9;
	        8'd169 : o_fp32_hex = 32'h3f29a9aa;
	        8'd170 : o_fp32_hex = 32'h3f2aaaab;
	        8'd171 : o_fp32_hex = 32'h3f2babac;
	        8'd172 : o_fp32_hex = 32'h3f2cacad;
	        8'd173 : o_fp32_hex = 32'h3f2dadae;
	        8'd174 : o_fp32_hex = 32'h3f2eaeaf;
	        8'd175 : o_fp32_hex = 32'h3f2fafb0;
	        8'd176 : o_fp32_hex = 32'h3f30b0b1;
	        8'd177 : o_fp32_hex = 32'h3f31b1b2;
	        8'd178 : o_fp32_hex = 32'h3f32b2b3;
	        8'd179 : o_fp32_hex = 32'h3f33b3b4;
	        8'd180 : o_fp32_hex = 32'h3f34b4b5;
	        8'd181 : o_fp32_hex = 32'h3f35b5b6;
	        8'd182 : o_fp32_hex = 32'h3f36b6b7;
	        8'd183 : o_fp32_hex = 32'h3f37b7b8;
	        8'd184 : o_fp32_hex = 32'h3f38b8b9;
	        8'd185 : o_fp32_hex = 32'h3f39b9ba;
	        8'd186 : o_fp32_hex = 32'h3f3ababb;
	        8'd187 : o_fp32_hex = 32'h3f3bbbbc;
	        8'd188 : o_fp32_hex = 32'h3f3cbcbd;
	        8'd189 : o_fp32_hex = 32'h3f3dbdbe;
	        8'd190 : o_fp32_hex = 32'h3f3ebebf;
	        8'd191 : o_fp32_hex = 32'h3f3fbfc0;
	        8'd192 : o_fp32_hex = 32'h3f40c0c1;
	        8'd193 : o_fp32_hex = 32'h3f41c1c2;
	        8'd194 : o_fp32_hex = 32'h3f42c2c3;
	        8'd195 : o_fp32_hex = 32'h3f43c3c4;
	        8'd196 : o_fp32_hex = 32'h3f44c4c5;
	        8'd197 : o_fp32_hex = 32'h3f45c5c6;
	        8'd198 : o_fp32_hex = 32'h3f46c6c7;
	        8'd199 : o_fp32_hex = 32'h3f47c7c8;
	        8'd200 : o_fp32_hex = 32'h3f48c8c9;
	        8'd201 : o_fp32_hex = 32'h3f49c9ca;
	        8'd202 : o_fp32_hex = 32'h3f4acacb;
	        8'd203 : o_fp32_hex = 32'h3f4bcbcc;
	        8'd204 : o_fp32_hex = 32'h3f4ccccd;
	        8'd205 : o_fp32_hex = 32'h3f4dcdce;
	        8'd206 : o_fp32_hex = 32'h3f4ececf;
	        8'd207 : o_fp32_hex = 32'h3f4fcfd0;
	        8'd208 : o_fp32_hex = 32'h3f50d0d1;
	        8'd209 : o_fp32_hex = 32'h3f51d1d2;
	        8'd210 : o_fp32_hex = 32'h3f52d2d3;
	        8'd211 : o_fp32_hex = 32'h3f53d3d4;
	        8'd212 : o_fp32_hex = 32'h3f54d4d5;
	        8'd213 : o_fp32_hex = 32'h3f55d5d6;
	        8'd214 : o_fp32_hex = 32'h3f56d6d7;
	        8'd215 : o_fp32_hex = 32'h3f57d7d8;
	        8'd216 : o_fp32_hex = 32'h3f58d8d9;
	        8'd217 : o_fp32_hex = 32'h3f59d9da;
	        8'd218 : o_fp32_hex = 32'h3f5adadb;
	        8'd219 : o_fp32_hex = 32'h3f5bdbdc;
	        8'd220 : o_fp32_hex = 32'h3f5cdcdd;
	        8'd221 : o_fp32_hex = 32'h3f5dddde;
	        8'd222 : o_fp32_hex = 32'h3f5ededf;
	        8'd223 : o_fp32_hex = 32'h3f5fdfe0;
	        8'd224 : o_fp32_hex = 32'h3f60e0e1;
	        8'd225 : o_fp32_hex = 32'h3f61e1e2;
	        8'd226 : o_fp32_hex = 32'h3f62e2e3;
	        8'd227 : o_fp32_hex = 32'h3f63e3e4;
	        8'd228 : o_fp32_hex = 32'h3f64e4e5;
	        8'd229 : o_fp32_hex = 32'h3f65e5e6;
	        8'd230 : o_fp32_hex = 32'h3f66e6e7;
	        8'd231 : o_fp32_hex = 32'h3f67e7e8;
	        8'd232 : o_fp32_hex = 32'h3f68e8e9;
	        8'd233 : o_fp32_hex = 32'h3f69e9ea;
	        8'd234 : o_fp32_hex = 32'h3f6aeaeb;
	        8'd235 : o_fp32_hex = 32'h3f6bebec;
	        8'd236 : o_fp32_hex = 32'h3f6ceced;
	        8'd237 : o_fp32_hex = 32'h3f6dedee;
	        8'd238 : o_fp32_hex = 32'h3f6eeeef;
	        8'd239 : o_fp32_hex = 32'h3f6feff0;
	        8'd240 : o_fp32_hex = 32'h3f70f0f1;
	        8'd241 : o_fp32_hex = 32'h3f71f1f2;
	        8'd242 : o_fp32_hex = 32'h3f72f2f3;
	        8'd243 : o_fp32_hex = 32'h3f73f3f4;
	        8'd244 : o_fp32_hex = 32'h3f74f4f5;
	        8'd245 : o_fp32_hex = 32'h3f75f5f6;
	        8'd246 : o_fp32_hex = 32'h3f76f6f7;
	        8'd247 : o_fp32_hex = 32'h3f77f7f8;
	        8'd248 : o_fp32_hex = 32'h3f78f8f9;
	        8'd249 : o_fp32_hex = 32'h3f79f9fa;
	        8'd250 : o_fp32_hex = 32'h3f7afafb;
	        8'd251 : o_fp32_hex = 32'h3f7bfbfc;
	        8'd252 : o_fp32_hex = 32'h3f7cfcfd;
	        8'd253 : o_fp32_hex = 32'hc30c8ea1;
	        8'd254 : o_fp32_hex = 32'h3f7efeff;
	        8'd255 : o_fp32_hex = 32'h3f800000;
            default: o_fp32_hex = 32'h0;			
	    endcase;
	end

endmodule