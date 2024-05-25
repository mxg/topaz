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

class generate_trans;
  typedef enum{SMALL, MEDIUM, LARGE} selector_t;
  op_t last_op;
  int unsigned interval;

  function new();
    last_op = READ;
    interval = 5;
  endfunction

  function base_transaction factory(selector_t selector);
    base_transaction base;
    case(selector)
      SMALL: begin
	trans_small t = new();
	return t;
      end
      MEDIUM: begin
	trans_medium t = new();
	return t;
      end
      LARGE: begin
	trans_large t = new();
	return t;
      end
    endcase
  endfunction 

  function base_transaction gen();
    base_transaction t;
    selector_t selector;
    int n;
    
    std::randomize(selector);
    t = factory(selector);
    n = $urandom();
    t.randomize() with { if(local::n % interval == 0)
                           t.op == last_op;
                      else t.op != last_op; };
    last_op = t.op;
    return t;
  endfunction
    
endclass
