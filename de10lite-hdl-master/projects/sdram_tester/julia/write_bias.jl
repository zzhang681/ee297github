
using CSV
using DataFrames
print("Reading bias1......")
df = DataFrame(CSV.File("bias1_hex.csv"))
println("Complete")

print("Reading bias2......")
df2 = DataFrame(CSV.File("bias2_hex.csv"))
println("Complete")

using Tester
using Sockets
using ProgressMeter
jtag = JTAG()

#start in 204784
#df[1,2] - df[64,2]

global arr = []
global addr = 204784
empty!(arr)
println("Writing bias into FPGA......")
for i in 1:size(df,1)
	str = df[i,2]
	arr_temp = [parse(UInt8, str[7:8],base=16),parse(UInt8, str[5:6],base=16),
				parse(UInt8, str[3:4],base=16),parse(UInt8, str[1:2],base=16)]				#little endian
	append!(arr,arr_temp)
end
for i in 1:size(df2,1)
	str = df2[i,2]
	arr_temp = [parse(UInt8, str[7:8],base=16),parse(UInt8, str[5:6],base=16),
				parse(UInt8, str[3:4],base=16),parse(UInt8, str[1:2],base=16)]				#little endian
	append!(arr,arr_temp)
end

write(jtag,addr,arr)
empty!(arr)

println("Writing bias into FPGA completed. Bias address starts from 204784 to 205079.")
