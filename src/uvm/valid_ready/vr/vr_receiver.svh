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

//------------------------------------------------------------------------------
// vr_receiver
//------------------------------------------------------------------------------
class vr_receiver extends uvm_component;

  local virtual vr_if vif;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_resource_db#(virtual vr_if)::read_by_name(get_full_name(),
						      "vif", vif, this))
      `uvm_fatal("VR_RECEIVER", "virtual interface cannot be located")
  endfunction
  
  task run_phase(uvm_phase phase);
    
    fork
      ctrl_task();
      data_task();
    join
    
  endtask
  
  task ctrl_task();
    forever begin
      @(posedge vif.valid);
      vif.ready <= 1;
      @(posedge vif.clk);
      vif.ready <= 0;
    end
  endtask
  
  task data_task();
    forever begin
      @(posedge vif. clk);
      if(vif.valid == 1 && vif.ready == 1)
	$display("%12t : receiving <- %0x", $time, vif.data);
    end    
  endtask
  
endclass

