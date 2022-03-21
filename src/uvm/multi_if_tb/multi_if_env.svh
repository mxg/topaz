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

class multi_if_env extends uvm_component;

  uvm_analysis_port#(transaction) analysis_port_A;
  uvm_analysis_port#(transaction) analysis_port_B;

  local agent agt_A;
  local agent agt_B;
  local multi_if_scoreboard sb;
  local multi_if_cov_collector cov;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    agt_A = new("agent_A", this);
    agt_B = new("agent_B", this);
    sb = new("multi_if_scoreboard", this);
    cov = new("multi_if_cov_collector", this);
    analysis_port_A = new("analysis_port_A", this);
    analysis_port_B = new("analysis_port_B", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    agt_A.analysis_port.connect(analysis_port_A);
    agt_B.analysis_port.connect(analysis_port_B);
  endfunction

  function void get_sequencers(ref uvm_sequencer_base sqr_table [string]);
    sqr_table["control"] = agt_A.get_sequencer();
    sqr_table["data"] = agt_B.get_sequencer();
  endfunction

endclass

  
