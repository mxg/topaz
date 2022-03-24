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
// static_type_handle_base
//------------------------------------------------------------------------------
virtual class static_type_handle_base;
endclass

//------------------------------------------------------------------------------
// static_type_handle
//------------------------------------------------------------------------------
class static_type_handle#(type T=int) extends static_type_handle_base;
endclass

//------------------------------------------------------------------------------
// type_handle_base
//------------------------------------------------------------------------------
virtual class type_handle_base;

  pure virtual function static_type_handle_base get_type_handle();

endclass

//------------------------------------------------------------------------------
// type_handle
//------------------------------------------------------------------------------
class type_handle #(type T=int) extends type_handle_base;

  typedef type_handle#(T) this_t;
  typedef static_type_handle#(T) this_handle_t;
  static this_handle_t handle;
 
  static function this_handle_t get_type();
    if(handle == null)
      handle= new();
    return handle;
  endfunction

  function static_type_handle_base get_type_handle();
    return get_type();
  endfunction

endclass


class some_class;
endclass

class thingy;
endclass

//------------------------------------------------------------------------------
// top
//------------------------------------------------------------------------------
module top;

  initial begin

    string type_list[static_type_handle_base];
    type_handle#(int) th1;
    type_handle#(string) th2;
    type_handle#(int) th3;

    type_list[type_handle#(some_class)::get_type()] = "some_class";
    type_list[type_handle#(thingy)::get_type()] = "thingy";

    foreach (type_list[type_index]) begin
      $display(type_list[type_index]);
    end

    th1 = new();
    th2 = new();
    th3 = new();

    // Two handles of the same type are npt "equal".  They are
    // different objects.
    if(th1 == th3)
      $display("th1 == th3");
    else
      $display("th1 != th3");

    // Two handles of different types are not "equal".
    if(th1.get_type_handle() == th2.get_type_handle())
      $display("th1 == th2");
    else
      $display("th1 != th2");
    
    if(th1.get_type_handle() == th3.get_type_handle())
      $display("th1 == th3");
    else
      $display("th1 != th3");
    
  end

endmodule
    
