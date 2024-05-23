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

//------------------------------------------------------------------------------
// Specialized Type Factory
//
// In this variant of the type factory we provide consztructor
// arguments.  The create() and construct() methods have to be
// redefined and reimolemented to support arguments.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// concrete_factory_base
//------------------------------------------------------------------------------
virtual class concrete_factory_base#(type B);

  pure virtual function B construct(string name);
    
endclass

//------------------------------------------------------------------------------
// concrete_factory
//------------------------------------------------------------------------------
class concrete_factory#(type T, type B) extends concrete_factory_base#(B);

  function B construct(string name);
    T t = new(name);
    return t;
  endfunction

endclass

//------------------------------------------------------------------------------
// abstract_factory
//------------------------------------------------------------------------------
class abstract_factory#(type T, type B) extends concrete_factory#(T,B);

  typedef abstract_factory#(T,B) this_t;

  static local concrete_factory_base#(B) cfb;

  local function new();
    cfb = this;
  endfunction

  static function concrete_factory_base#(B) get();
    static this_t inst;
    if(inst == null)
      inst = new();
    return inst;
  endfunction

  static function B create(string name);
    if(cfb == null) begin
      concrete_factory#(T,B) t = new();
      cfb = t;
    end
    return cfb.construct(name);
  endfunction
  
  static function void override(concrete_factory_base#(B) override_cfb);
    cfb = override_cfb;
  endfunction
    
endclass

