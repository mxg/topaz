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

class multi_if_scoreboard extends uvm_component;

  uvm_analysis_imp_A#(transaction, multi_if_scoreboard) analysis_export_A;
  uvm_analysis_imp_B#(transaction, multi_if_scoreboard) analysis_export_B;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    analysis_export_A = new("analysis_export_A", this);
    analysis_export_B = new("analysis_export_B", this);
  endfunction

  function void write_A(transaction t);
  endfunction

  function void write_B(transaction t);
  endfunction

endclass
