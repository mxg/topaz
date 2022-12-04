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
//    Copyright 2022 Mark Glasser
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

class environment extends uvm_component;

  local uvm_sequencer#(abstract_command) sqr;
  local driver drv;
  local channel chan;
  uvm_sequence_base seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);

    uvm_object_wrapper seq_wrap;

    sqr = new("sequencer", this);
    drv = new("driver", this);
    chan = new();
    drv.bind_channel(chan);

    if(!uvm_resource_db#(uvm_object_wrapper)::read_by_name(get_full_name(),
							   "seq_wrap",
							   seq_wrap,
							   this))
      `uvm_fatal("ENV",
                 "Unable to locate sequence wrapper in the resource database")
    if(!$cast(seq, seq_wrap.create_object("cmd_seq")))
      `uvm_fatal("ENV", "Unable to cast object to sequence")

  endfunction

  function void connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(sqr);
    phase.drop_objection(this);
  endtask

endclass
