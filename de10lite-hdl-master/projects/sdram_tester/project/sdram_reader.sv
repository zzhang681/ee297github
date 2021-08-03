//our module for read data


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
        output [INTERFACE_ADDR_BITS-1:0]        interface_address,
        output [(INTERFACE_WIDTH_BITS / 8)-1:0] interface_byte_enable,
        output logic                            interface_read,
        output                                  interface_write,
        input [INTERFACE_WIDTH_BITS-1:0]        interface_read_data,
        output [INTERFACE_WIDTH_BITS-1:0]       interface_write_data,
        input                                   interface_acknowledge,
		  
		  output logic [INTERFACE_WIDTH_BITS-1:0] data
);

logic read;
integer count=0;
/*
assign interface_read = read;
assign interface_address = 0;
assign interface_write = 0;
assign interface_byte_enable = 16'h0001;

always@(negedge interface_clock) begin
	if(interface_acknowledge) data <= interface_read_data;
	else data <= data;
end

always_comb begin
	if(count <= 10) read = 1;
	else read = 0;
end

always@(negedge interface_clock) begin
	if(reset_n) count <= 0;
	else if(count < 100) count <= count + 1;
	else count <= 0;
end

*/

logic [1:0]       CS,NS; //for read and write
    parameter   S0=2'b00,S1=2'b01,S2=2'b10;
    
 

  always @(posedge interface_clock) 
    begin
        if (reset_n==0)
            CS <= S0;
        else
            CS <= S1;//NS;
        end

    always @(CS)
        begin
        case(CS)
            S0: 
            begin
            interface_address=0;
    //        interface_byte_enable=1;
            interface_byte_enable=1'b1;
            interface_read=1'b0;
            interface_write = 1'b1;
            interface_write_data = 8'hAA;
            
            NS=S1;
            end

            S1: 
            begin
            interface_address=0;
            interface_byte_enable=1'b1;
            interface_read=1'b1;
            interface_write = 1'b0;

            NS=S1;
            end
            
            

            S2:
            begin
            interface_address=0;
            interface_byte_enable=4;
            interface_read=1;
            interface_write = 0;
            interface_write_data = 2;

            NS=S2;
            end
         

            default:
            NS=S0;
    endcase 
end


        



endmodule