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

module top;

  import hierarchy_pkg::*;
  import visitor_pkg::*;
   
  initial begin

    tree_visitor tv;

    // create a hierarchy;
    tree treetop;
    tree t1;
    tree t2;
    tree t3;
    tree t4;

    treetop = new("top", null); // topmost node has no parent
    // two nodes whose parent is treetop


    t1 = new("t1", treetop);
    t2 = new("t2", treetop);

    // Two nodes whose parent is t1.
    t3 = new("t3", t1);
    t4 = new("t4", t1);
    //------------------------------

    tv = new();
    tv.traverse(treetop);

  end

endmodule

