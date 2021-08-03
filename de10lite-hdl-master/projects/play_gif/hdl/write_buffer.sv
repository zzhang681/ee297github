
module write_buffer #(
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
        //output [(INTERFACE_WIDTH_BITS / 8)-1:0] interface_byte_enable,
        output logic                            interface_read,
        output                                  interface_write,
        input [INTERFACE_WIDTH_BITS-1:0]        interface_read_data,
        output [INTERFACE_WIDTH_BITS-1:0]       interface_write_data,
        input                                   interface_acknowledge,

        // General Module IO
        input [$clog2(NUM_BUFFER_ENTRIES)-1:0] read_address,
        output [INTERFACE_WIDTH_BITS-1:0]      read_data,

        // When asserted, begin buffering the next row.
        input start,
        // Byte address to begin buffering from.
        input [INTERFACE_ADDR_BITS-1:0] base_address,

        // Error indication
        output logic    timing_error,
        input           timing_error_reset
    );


endmodule : write_buffer
