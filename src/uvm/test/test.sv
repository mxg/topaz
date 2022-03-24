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

//------------------------------------------------------------------------------
// test
//
/// A test is the very topmost component in a UVM testbench.  It is responsible
/// for instantiating the reset of the structural environment and providing
/// configuiration information to the rest of the testbench.
//
//------------------------------------------------------------------------------

`include "uvm_macros.svh"
import uvm_pkg::*;

//------------------------------------------------------------------------------
// component
//------------------------------------------------------------------------------
class component extends uvm_component;

  `uvm_component_utils(component)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

endclass

//------------------------------------------------------------------------------
// environment
//------------------------------------------------------------------------------
class environment extends uvm_component;
  
  `uvm_component_utils(environment)

  component c1;
  component c2;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    c1 = new("c1", this);
    c2 = new("c2", this);
  endfunction

endclass

//------------------------------------------------------------------------------
// test
//------------------------------------------------------------------------------
class test extends uvm_component;

  `uvm_component_utils(test)

  environment env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    env = new("env", this);
  endfunction

endclass

//------------------------------------------------------------------------------
// top
//------------------------------------------------------------------------------
module top;

  initial begin
    run_test();
  end
endmodule

