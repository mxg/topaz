//------------------------------------------------------------------------------
//                 .
//               .o8
//             .o888oo  .ooooo.  oo.ooooo.   .oooo.     oooooooo
//               888   d88' `88b  888' `88b `P  )88b   d'""7d8P
//               888   888   888  888   888  .oP"888     .d8P'
//               888 . 888   888  888   888 d8(  888   .d8P'  .P
//               "888" `Y8bod8P'  888bod8P' `Y888""8o d8888888P
//                                888
//                               o888o
//
//                 T O P A Z   P A T T E R N   L I B R A R Y 
//
//    TOPAZ is a library of SystemVerilog and UVM patterns and idioms.  The
//    code is suitable for study and for copying/pasting into your own work.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// FIFO
//------------------------------------------------------------------------------
module fifo
  (
   input 	 clk,      // clock
   input 	 rst,      // reset
   input 	 rd_en,    // read enable
   input 	 wr_en,    // write enable
   input  [31:0] data_in,  // data in
   output [31:0] data_out, // data out
   output 	 empty,    // 1 when fifo is empty, 0 otherwise
   output 	 full,     // 1 when fifo is full, 0 otherwise
   input         cs        // chip (device) select
  );

  
  // local state data
  // fifo buffer
  reg [31:0] 	 buffer[4];
  // ptr to next item to read
  reg  [1:0]	 rd_ptr;
  // ptr to next item to write
  reg  [1:0]	 wr_ptr;

  // Note that the buffer size is a power of 2 and the ptr sizes are
  // log2(buffer_size).  This allows for some simplicity in the pointer
  // arithmetic.  When each get to the end of the buffer adding one more
  // will roll over to 0.  I.e. the count will go 0, 1, 2, 3, 0, ...  If
  // the size of the buffer were not a power of two or the size of the
  // ptrs was not log2(buffer_size) then a modulo operation would be
  // required to ensure that the ptrs rolled over to zero at the
  // appropriate time.

  // registers for outputs
  reg 		 r_full;
  reg 		 r_empty;
  reg [31:0] 	 r_data_out; 		 

  assign empty = r_empty;
  assign full = r_full;
  assign data_out = r_data_out;

//------------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  // reset process
  //
  // Synchronous active low reset. Clear the read and write pointers and
  // set the fifo to an empty state.
  always @(posedge clk)
    begin
      if(rst == 0) begin
	rd_ptr = 0;
	wr_ptr = 0;
	r_empty <= 1;
	r_full <= 0;
	@(negedge clk);
      end
    end

  //----------------------------------------------------------------------------
  // read process
  //
  // Read from the front of the fifo.  A read operation occurs on a
  // rising clock edge when the device is selected and read enable is
  // asserted.
  always @(posedge clk)
    begin
      if(cs == 1 && rst == 1 && rd_en == 1 && empty == 0) begin
	r_data_out <= buffer[rd_ptr]; // do the read
	rd_ptr = rd_ptr + 1;          // advance the read pointer
	r_full <= 0;
	// Does the read leave the fifo in an empty state?
	if(rd_ptr == wr_ptr)
	  r_empty <= 1;
	else
	  r_empty <= 0;
	@(negedge clk);
      end
    end

  //----------------------------------------------------------------------------
  // write process
  //
  // Write to the back of the fifo.  A write operation occurs on a
  // rising clock edge when the device is selected and write enable is
  // asserted.
  always @(posedge clk)
    begin
      if(cs == 1 && rst == 1 && wr_en == 1 && full == 0) begin
	buffer[wr_ptr] = data_in;  // do the write
	wr_ptr = wr_ptr + 1;       // advance the write pointer
	r_empty <= 0;
	// Does the write leave the fifo in a full state?
	if(wr_ptr == rd_ptr)
	  r_full <= 1;
	else
	  r_full <= 0;
	@(negedge clk);
      end
    end
  
endmodule
