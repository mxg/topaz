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

class block_tb_env extends uvm_component;

  `uvm_component_utils(block_tb_env)

  uvm_analysis_port#(transaction) analysis_port;

  local agent agt;
  local sync_agent sync;
  local scoreboard sb;
  local coverage_collector cov;
  local sqr_aggregator sqrs;

  local uvm_sequence_base seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void get_sequencers(ref sqr_aggregator sqrs);
    sqrs.add(agt.get_sequencer(), "main", "main");
    sqrs.add(sync.get_sequencer(), "sync", "sync");
  endfunction

  function void build_phase(uvm_phase phase);

    uvm_object_wrapper seq_wrap;

    analysis_port = new("analysis_port", this);
    agt = new("agent", this);
    sync = new("sync_agent", this);
    sb = new("scoreboard", this);
    cov = new("coverage_collector", this);
    sqrs = new();
    uvm_resource_db#(sqr_aggregator)::set("*", "sqrs", sqrs, this);
    
    if(!uvm_resource_db#(uvm_object_wrapper)::read_by_name(get_full_name(),
							   "seq_wrap",
							   seq_wrap,
							   this))
      `uvm_fatal("BLOCK_TB_ENV",
		 "Unable to locate sequence wrapper in the resource database")
    
    if(!$cast(seq, seq_wrap.create_object("main_seq")))
      `uvm_fatal("BLOCK_TB_ENV", "Unable to case object to sequence")
    
  endfunction

  function void connect_phase(uvm_phase phase);
    agt.analysis_port.connect(analysis_port);
    agt.analysis_port.connect(sb.analysis_export);
    agt.analysis_port.connect(cov.analysis_export);
    get_sequencers(sqrs);
  endfunction

  task run_phase(uvm_phase phase);
    uvm_sequencer_base sqr;

    sqr = sqrs.lookup_name("main");
    if(sqr == null)
      `uvm_fatal("BLOCK_TB_ENV", "No main sequencer")
    phase.raise_objection(this);
    seq.start(sqr);
    phase.drop_objection(this);
  endtask
  
endclass

  
