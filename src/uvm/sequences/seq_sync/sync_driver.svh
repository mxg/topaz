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

class sync_driver extends uvm_component;

  uvm_seq_item_pull_port #(sync_trans) seq_item_port;
  
  local virtual sync_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    seq_item_port = new("seq_item_port", this);
    if(!uvm_resource_db#(virtual sync_if)::read_by_type(get_full_name,
							vif, this))
      `uvm_fatal("SYNC_DRIVER", "Unable to locate sync interface in the resource database")
  endfunction

  task run_phase(uvm_phase phase);

    sync_trans t;

    wait (vif.reset == 0);
    
    forever begin
      seq_item_port.get_next_item(t);
      wait (vif.reset == 1);
      t.reset_state = vif.reset;
      seq_item_port.item_done(t);
    end

  endtask

endclass

  

