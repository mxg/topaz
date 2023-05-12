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

class env extends uvm_component;

  stage_1 s1;
  stage_2 s2;
  stage_3 s3;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    s1 = new("stage_1", this);
    s2 = new("stage_2", this);
    s3 = new("stage_3", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    //s3.seq_item_port.connect(s1.seq_item_export);
    s2.seq_item_port.connect(s1.seq_item_export);
    s3.seq_item_port.connect(s2.seq_item_export);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    wait(s1.done && s2.done && s3.done);
    phase.drop_objection(this);
  endtask

endclass
