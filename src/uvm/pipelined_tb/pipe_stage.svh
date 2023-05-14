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
//    Copyright 2023 Mark Glasser
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

class pipe_stage#(type SEQ = uvm_sequence_item) extends pipe_stage_base #(SEQ);

  uvm_seq_item_pull_port #(SEQ) seq_item_port;
  uvm_tlm_analysis_fifo#(SEQ) fifo;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq_item_port = new("seq_item_port", this);
    fifo = new("fifo", this);
  endfunction

  task run_phase(uvm_phase phase);
    fork
      enqueue_items();
      dequeue_items();
    join
  endtask

  task enqueue_items();  /* \label{code:pipe_stage:1} */
    SEQ item;
    forever begin
      seq_item_port.get_next_item(item);
      fifo.put(item);
      seq_item_port.item_done();
    end
  endtask

  task dequeue_items();   /* \label{code:pipe_stage:2} */
    SEQ item;
    forever begin
      fifo.get(item);
      process_item(item);
      done = (fifo.used() == 0); /* \label{code:pipe_stage:3} */
    end
  endtask

  function void report_phase(uvm_phase phase);
    $display("%s: fifo has %0d entries", get_name(), fifo.used());
  endfunction

endclass
