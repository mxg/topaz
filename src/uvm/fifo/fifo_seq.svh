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
//
//    Copyright 2021 Mark Glasser
// 
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
// 
//      http://www.apache.org/licenses/LICENSE-2.0
// 
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// FIFO sequence
//
// Drive stimulus to the sequencer.  A small collection of convenience
// functions does the dirty work.
//------------------------------------------------------------------------------
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
