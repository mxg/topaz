//------------------------------------------------------------------------------
// FIFO interface
//
// Note that all the wires are on the port list.  This makes it much
// easier to bind them to devices without using a mucnh of assignment
// statements.
//------------------------------------------------------------------------------
interface fifo_if (wire        clk,
		   wire        rst,
		   wire        rd_en,
		   wire        wr_en,
		   wire [31:0] data_in,
		   wire [31:0] data_out,
		   wire        empty,
		   wire        full,
		   wire        cs
		   );
endinterface
