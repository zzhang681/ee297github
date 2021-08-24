
module tbram();

reg clk, reset;
reg write_ram, read_ram;
reg [7:0] addr_w;
reg [9:0] addr_r;
reg [127:0] data_store;
wire [7:0] dr_ram;


always begin
	#5 clk = 1;
	#5 clk = 0;
end

initial begin
	reset = 1;
	#20 reset = 0;
	write_ram = 1;
	addr_w = 0;
	data_store = 128'h0000000000000000123456789abcdef;
	#10 write_ram = 0;
	read_ram = 1;
	addr_r = 0;
	#10 addr_r = 1;
	#10 addr_r = 2;
	#10 addr_r = 3;
	#10 addr_r = 4;
	#10 addr_r = 5;
	#10 addr_r = 6;
	#10 addr_r = 7;
	#10 addr_r = 8;
	#10 addr_r = 9;
	#10 addr_r = 10;
	#100;
	$finish;
end


img_ram u1(
	.clk(clk),
	.reset(reset),
	.dw(data_store),
	.addr_w(addr_w),
	.write(wrrite_ram),
	.read(read_ram),
	.addr_r(addr_r),
	.dr(dr_ram)
);

endmodule