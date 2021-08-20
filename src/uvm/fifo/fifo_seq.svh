//----------------------------------------------------------------------
// FIFO sequence
//
// Drive stimulus to the sequencer.  A small collection of convenience
// functions does the dirty work.
// ----------------------------------------------------------------------
class fifo_sequence extends fifo_sequence_base;

  `uvm_object_utils(fifo_sequence)

  function new(string name = "fifo_seq");
    super.new(name);
  endfunction

  task body();

    reset();

    // The fifo has a depth of four.  WoSo the fourth and fifth writes
    // should return a status of FULL.  Further, the fifth write will be
    // dropped.
    write('ha);
    write('hb);
    write('hc);
    write('hd);
    write('he);

    // Five reads.  The last two should return a status of empty.  How
    // can we distinguish between when the fifo becomes empty upon the
    // last read and the fifo not returning data because it is empty?
    read();
    read();
    read();
    read();
    read();

    write(1);
    write(2);
    read();

    // Throw a couple of no-ops in just for fun.
    nop();
    nop();
    
    write(3);
    write(4);
    write(5);
    // Five writes punctuated with a read.  At this point the fifo
    // should be full.

    // A read followed by a write should again fill up the fifo.
    read();
    write(6);

    // The next three writes should fail since the fifo is full.
    write(7);
    write(8);
    write(9);

    // Two reads
    read();
    read();

    //We wouldn't need this if we had a proper shutdown methodology in
    //place
    #20;

  endtask

endclass
