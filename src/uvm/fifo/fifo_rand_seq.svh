//----------------------------------------------------------------------
// FIFO Randomized Sequence
//
// Drive randomized stimulus to the FIFO.
//----------------------------------------------------------------------
class fifo_rand_sequence extends fifo_sequence_base;

  `uvm_object_utils(fifo_rand_sequence)

  function new(string name = "fifo_rand_sequence");
    super.new(name);
  endfunction

  task body();

    int unsigned count = $random() % 1000;
    int unsigned i;
    int unsigned determinant;

    // Make sure the fifo is in a known state before applying randomized
    // transactions.
    reset();

    // Generate a stream of randomized transactions.  Randomize the
    // selection of operation and the data.  The randomization of the
    // operation is weighted.  The % probability of each operation is
    // identified in the case statement.
    for(i = 0; i< count; i++) begin
      determinant = $urandom() % 100;
      case(1)
	determinant >=  0 && determinant <   5 :  reset();            // 5%
	determinant >=  5 && determinant <  45 :  read();             // 40%
	determinant >= 45 && determinant <  90 :  write($urandom());  // 45%
	determinant >= 90 && determinant < 100 :  nop();              // 10%
      endcase
    end
      
  endtask

endclass

    
