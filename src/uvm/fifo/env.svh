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
// FIFO env
//
// Top-level environment for the FIFO testbench.  The role of the env is
// to provide the structure of the testbench.
// ----------------------------------------------------------------------
class env extends uvm_component;

  local fifo_agent agt;
  local fifo_scoreboard sb;
  local fifo_sequence_base seq;
  uvm_sequencer_base sqr;

  //--------------------------------------------------------------------
  // The usual constructor
  //--------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //--------------------------------------------------------------------
  // Build all of the testbench components
  //--------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    agt = new("fifo_agent", this);
    sb = new("fifo_scoreboard", this);
    seq = fifo_sequence_base::type_id::create();
  endfunction

  //--------------------------------------------------------------------
  // Connect things together.  Connect the driver to the sequencer and
  // the talker to the monitor.
  // --------------------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    sqr = agt.get_sequencer();
    agt.analysis_port.connect(sb.analysis_export);
  endfunction

  //--------------------------------------------------------------------
  // Initiate the sequence that executs the test.  Let the testbench
  // shutdown when the sequence finishes.
  // --------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(sqr);
    phase.drop_objection(this);
  endtask
  
endclass
