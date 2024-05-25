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
//    Copyright 2024 Mark Glasser
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

    
