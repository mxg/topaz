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

import uvm_pkg::*;

//------------------------------------------------------------------------------
// regex_toy
//
// A utility that you can use to experiment with regular expressions.
//------------------------------------------------------------------------------
class regex_toy;
  static function void re_matcher(string regex,
                                  ref string strings[$]);
    $display("matches for regular expression : %s", regex);
    foreach(strings[i]) begin
      bit match = uvm_is_match(regex, strings[i]);
      $display("%s : %s", (match?"match":"     "), strings[i]);
    end
  endfunction
endclass

//------------------------------------------------------------------------------
// top
//
// Define a regular expression and a bunch of strings.  Then use the
// regex_toy to see which strings mactch the regular expressions.
//------------------------------------------------------------------------------
module top;

  string regex = "/.*c$/";
  string strings[$] = { "a.b.c",
			"abc",
			"aa.bb.cc",
			"ab.bc.cd"
			};

  initial begin
    regex_toy::re_matcher(regex, strings);
  end
  
endmodule

    
