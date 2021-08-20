//------------------------------------------------------------------------------
// FIFO testbench package
//
// Package of all the testbench components used to verify the fifo.
//------------------------------------------------------------------------------
package tb_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  import fifo_pkg::*;

  `include "fifo_seq_base.svh"
  `include "fifo_seq.svh"
  `include "fifo_rand_seq.svh"
  `include "fifo_scoreboard.svh"
  `include "env.svh"
  `include "test.svh"
  
endpackage
