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
// cc_fsm_mesi
//------------------------------------------------------------------------------
class cc_fsm_mesi extends cc_fsm_base
                  implements cc_fsm_intf;

  `uvm_object_utils(cc_fsm_mesi)

  function new(string name = "cc_fsm_mesi");
    super.new(name);
  endfunction  

  virtual function void build_state_table();

    state_table[state_M][PrRd]    = state_M;
    state_table[state_M][PrWr]    = state_M;
    state_table[state_M][BusRd]   = state_S;
    state_table[state_M][BusRdX]  = state_I;

    state_table[state_E][PrRd]    = state_E;
    state_table[state_E][PrWr]    = state_M;
    state_table[state_E][BusRd]   = state_S;
    state_table[state_E][BusRdX]  = state_I;
    
    state_table[state_S][PrRd]    = state_S;
    state_table[state_S][PrWr]    = state_M;
    state_table[state_S][BusRd]   = state_S;
    state_table[state_S][BusRdX]  = state_I;
    state_table[state_S][BusUpgr] = state_I;

    state_table[state_I][PrRd]    = state_S;
    state_table[state_I][PrRdS]   = state_S;
    state_table[state_I][PrRdNS]  = state_M;
    
    
  endfunction
  
endclass
