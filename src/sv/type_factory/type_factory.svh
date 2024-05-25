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
// type_factory
//------------------------------------------------------------------------------
class type_factory#(type B);

  static local abstract_factory#(B) factory_table [type_handle_base];

  static function bit add(type_handle_base th, abstract_factory#(B) cf);
    if(!factory_table.exists(th))
      factory_table[th] = cf;
    else
      $display("error: Type handle already exists in the type factory");
    return 1;
  endfunction

  static function void override(type_handle_base th, abstract_factory#(B) cf);
    if(factory_table.exists(th))
      factory_table[th] = cf;
    else
      $display("error: Type handle cannot be overridden in the type factory");
  endfunction    
      
  static function abstract_factory#(B) get_concrete_factory(type_handle_base th);
    if(factory_table.exists(th))
      return factory_table[th];
    $display("error: Type is not in the type factory");
    return null;
  endfunction

endclass

    
