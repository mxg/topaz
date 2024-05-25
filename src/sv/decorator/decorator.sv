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

typedef int unsigned state_t;

interface class component_ifc;

   pure virtual function void operation();

endclass

//------------------------------------------------------------------------------
// component
//
// Component whose funtionality will be wrapped by a decorator.
//------------------------------------------------------------------------------
class component implements component_ifc;

  virtual function void operation();
  endfunction
  
endclass

//------------------------------------------------------------------------------
// decorator
//
// Also known as a "wrapper." The decorator wraps the component,
// providing additional operations and/or additional state.  The
// original component is unmodified.  Note that the decorator is
// derived from component so that we can ensure that the decorator haw
// the same interface as the original (plus the additional operations
// and state).
//
// A component instance is bound to the decorator via the constructor.
// The services expected from the original interface are delegated to
// the bound component.
//------------------------------------------------------------------------------
class decorator implements component_ifc;

  local component comp;
  local state_t additional_state;

  function new(component c);         /* \label{code:decorator:1} */
    comp = c;
  endfunction                      /* \label{code:decorator:2} */

  virtual function void operation();  /* \label{code:decorator:3} */
    comp.operation();
  endfunction                      /* \label{code:decorator:4} */

  function void new_operation();     /* \label{code:decorator:5} */
     // do some new operation
  endfunction                      /* \label{code:decorator:6} */

endclass

//------------------------------------------------------------------------------
// top
//
// Top-level module instantiates and uses a decorator
//------------------------------------------------------------------------------
module top;

  initial begin

    static component c = new;
    static decorator d = new(c);

    d.operation();
    d.new_operation();

  end

endmodule
