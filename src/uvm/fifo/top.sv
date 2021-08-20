//------------------------------------------------------------------------------
// top-level module
//
// This module is the tippy-top of the Verilog hierarchy.  It is the
// place where the testbench and the DUT are connected.
//------------------------------------------------------------------------------
`include "uvm_macros.svh"
import uvm_pkg::*;

module top;

  // The wires that are shared between the DUT and the testbench.
  wire clk;
  wire rst;
  wire cs;
  wire rd_en;
  wire wr_en;
  wire [31:0] data_in;
  wire [31:0] data_out;
  wire empty;
  wire full;

  // Instantiate the DUT
  fifo f(
	 .clk(clk),
	 .rst(rst),
	 .cs(cs),
	 .rd_en(rd_en),
	 .wr_en(wr_en),
	 .data_in(data_in),
	 .data_out(data_out),
	 .empty(empty),
	 .full(full)
	 );

  // Instantiate the interface that will connect the DUT to the testbench
  fifo_if fif(
	      .clk(clk),
	      .rst(rst),
	      .cs(cs),
	      .rd_en(rd_en),
	      .wr_en(wr_en),
	      .data_in(data_in),
	      .data_out(data_out),
	      .empty(empty),
	      .full(full)
	      );

  // Instantiate the clock generator and connect it to the clk
  clkgen cg(.clk(clk));

  initial begin
    // Put the virtual interface into the resoure database
    uvm_resource_db#(virtual fifo_if)::set("*", "fifo_if", fif, null);

    // Let'er rip!  Without an argument run_test() will look to the
    // command line for the name of the test to instantiate.  The
    // +UVM_TESTNAME command line option identifies the top-level test
    // component to instantiate.
    run_test();
  end
  
endmodule
