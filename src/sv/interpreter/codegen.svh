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

class codegen;

  local postfix_t postfix;

  function postfix_t get_postfix();
    return postfix;
  endfunction

  function postfix_t gen(ast t);

    code c;
    
    if(t == null)
      return postfix;
    
    foreach(t.children[c]) begin
      ast child = t.children[c];
      gen(child);
    end
    if(t.lexeme == "")
      return postfix;

    c = new();
    case(t.kind)
      "factor" : begin
	if(!t.is_const) begin
	  c.op = op_read;
	  c.name = t.lexeme;
	end
	if(t.is_const) begin
	  c.op = op_const;
	  case(t.data_type)
	    AST_NONE   : ;
	    AST_STRING : ;
	    AST_INT    : c.operand = t.lexeme.atoi();
	  endcase
	end
      end
      
      "assignment" : begin
	c.op = op_write;
	c.name = t.lexeme;
      end
      
      default:
	case(t.lexeme)
	  "+" : c.op = op_plus;
	  "-" : c.op = op_minus;
	  "*" : c.op = op_mult;
	  "/" : c.op = op_div;
	endcase
      
    endcase

    postfix.push_back(c);
  endfunction

  function void print();
    int i;
    foreach(postfix[i]) begin
      code c = postfix[i];
      $display("%3d : %s", i, c.convert2string());
    end
  endfunction

endclass

