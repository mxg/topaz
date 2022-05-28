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

module top;

  import interpreter_pkg::*;
  
  parser p;
  codegen g;
  evaluator e;
  postfix_t postfix;
  ast tree;

  initial begin
    p = new();
    g = new();
    e = new();

    g.gen(p.parse ("a = 1"));
    g.gen(p.parse ("b = 2"));
    g.gen(p.parse ("c = 3"));
    g.gen(p.parse ("d = 4"));
    g.gen(p.parse ("z = a + b * c - d"));
    g.gen(p.parse ("x = 5 *(72 - 33) / 8"));
    g.gen(p.parse ("t = 0 - 5 * 4 * 3 * 2 * 1"));
    g.gen(p.parse ("v = x * x * t + z"));

    tree = p.parse("q = (t + 198) * (18 - d + 48)");
    g.gen(tree);


    g.print();
    postfix = g.get_postfix();
    e.eval(postfix);
    e.print_mem();
  end
  
endmodule
