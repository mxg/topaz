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

module top;

  import chain_of_responsibility_pkg::*;

  mem m;

  initial begin
    mem_transaction tr;
    m = new();

    m.print_chain();

    for(int i = 0; i < 10; i++) begin
      tr = new();
      tr.randomize() with {
	addr dist {['h00000000:'h00007fff] :/1, 
                   ['h00008000:'h0000ffff] :/1,
                   ['h00010000:'hffffffff] :/1};
	(addr <= 'hffffffff && addr > 'h0000ffff) -> mode == USER;
	 addr < 'h00008000 -> mode == PROT;
	(addr >= 'h00008000 && addr <= 'h0000ffff) -> (mode == USER && op == READ);
      };
      m.exec(tr);
    end
  end
  
endmodule
