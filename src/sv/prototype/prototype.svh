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
//    Copyright 2021 Mark Glasser
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

virtual class abstract_prototype;

  pure virtual function abstract_prototype clone();
  pure virtual function string convert2string();

endclass

virtual class concrete_prototype #(type T) extends abstract_prototype;

  function abstract_prototype clone();
    T t = new();
    T rhs;
    $cast(rhs, this);
    t.copy(rhs);
    return t;
  endfunction

  pure virtual function void copy(T rhs);

endclass

class prototype_registry;

  abstract_prototype registry[string];

  function void add(string name, abstract_prototype thing);
    registry[name] = thing;
  endfunction

  function abstract_prototype get(string name);
    abstract_prototype thing;
    if(registry.exists(name)) begin
      thing = registry[name];
      return thing.clone();
    end
    return null;
  endfunction

endclass

    
  

  
