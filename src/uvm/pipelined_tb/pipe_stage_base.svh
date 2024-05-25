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

class pipe_stage_base #(type SEQ = uvm_sequence_item) extends uvm_component;

  uvm_seq_item_pull_export #(SEQ) seq_item_export; /* \label{code:pipe_stage_base:3} */

  bit done;
  protected uvm_sequencer#(SEQ) sqr;  /* \label{code:pipe_stage_base:1} */

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function bit is_done(); /* \label{code:pipe_stage_base:6} */
    return done;
  endfunction

  function void build_phase(uvm_phase phase);
    sqr = new("sequencer", this);    /* \label{code:pipe_stage_base:2} */
    seq_item_export = new("seq_item_export", this); /* \label{code:pipe_stage_base:4} */
  endfunction

  function void connect_phase(uvm_phase phase);
    seq_item_export.connect(sqr.seq_item_export); /* \label{code:pipe_stage_base:5} */
  endfunction

  virtual task process_item(SEQ item); /* \label{code:pipe_stage_base:7} */
  endtask

endclass
