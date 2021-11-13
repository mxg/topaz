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

class class_1 extends concrete_prototype#(class_1);

  int a;
  
  virtual function void copy(class_1 rhs);
    a = rhs.a;
  endfunction
  
  virtual function string convert2string();
    return $sformatf("class_1 : a = %0d", a);
  endfunction
  
endclass

class class_2 extends concrete_prototype#(class_2);

  int b;
  
  virtual function void copy(class_2 rhs);
    b = rhs.b;
  endfunction
  
  virtual function string convert2string();
    return $sformatf("class_2 : b = %0d", b);;
  endfunction
  
endclass

class class_3 extends concrete_prototype#(class_3);

  int c;
 
  virtual function void copy(class_3 rhs);
    c = rhs.c;
  endfunction

  virtual function string convert2string();
    return $sformatf("class_3 : c = %0d", c);
  endfunction
  
endclass
