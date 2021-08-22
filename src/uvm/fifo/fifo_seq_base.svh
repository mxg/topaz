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
// FIFO sequence base
//
// Bse class for fifo sequences.  Provides convenience API for driving
// FIFO transactions.
//------------------------------------------------------------------------------
class fifo_sequence_base extends uvm_sequence#(fifo_item);

  `uvm_object_utils(fifo_sequence_base)

  function new(string name = "fifo_seq");
    super.new(name);
  endfunction

  // generate a reset transaction
  virtual task reset();
    fifo_item t = new();            // create a new item
    // populate the request transaction
    t.req_rsp = fifo_item::REQ;
    t.state = fifo_item::UNKNOWN;
    t.op = fifo_item::RST;
    t.data = '0;
    execute_transaction(t);
  endtask

  // generate a write transaction -- put a new item into the fifo.
  virtual task write(input bit[31:0] data);
    fifo_item t = new();   // create a new item
    // populate the request transaction
    t.req_rsp = fifo_item::REQ;
    t.state = fifo_item::UNKNOWN;
    t.op = fifo_item::WR;
    t.data = data;
    execute_transaction(t);
  endtask

  // generate a read transaction -- pull an item from the fifo.
  virtual task read();
    fifo_item t = new();   // create a new item
    // populate the request transaction
    t.req_rsp = fifo_item::REQ;
    t.state = fifo_item::UNKNOWN;
    t.op = fifo_item::RD;
    t.data = '0;
    execute_transaction(t);
  endtask

  // generate a no-op transaction
  virtual task nop();
    fifo_item t = new();   // create a new item
    // populate the request transaction
    t.req_rsp = fifo_item::REQ;
    t.state = fifo_item::UNKNOWN;
    t.op = fifo_item::NOP;
    t.data = '0;
    execute_transaction(t);
  endtask

  // Take care of all the details of posting a request transaction to
  // the sequencer and obtaining he response.
  task execute_transaction(fifo_item t);
    wait_for_grant();      // block until sequencer is ready for us
    send_request(t);       // hand the transaction over to the sequencer
    get_response(t);       // block until response is available
  endtask

endclass
