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

// stmt : A
// A    : id = E
// E    : T Ep
// Ep   : + T Ep | - T Ep | e
// T    : F Tp
// Tp   : * F Tp | / F Tp | e
// F    : ( E ) | id | num

class parser;

  local lexer lex;
  local token_t lookahead;
  local bit err;
  local ast parse_tree;

  function ast parse(string s);
    ast t;
    $display("parsing %s", s);
    lex = new();
    lex.start(s);
    err = 0;
    lookahead = lex.get_token();
    t = stmt();
    if(t == null || err)
      $display("*** parse error");
    return t;
  endfunction

  function ast stmt();
    ast t = new("stmt");
    t.add(assignment());
    if(!err && !match(TOKEN_EOL)) err = 1;
    return t;
  endfunction

  function ast assignment();
    string  lhs;
    ast t = new("assignment");
    lhs = lex.get_lexeme();
    if(!match(TOKEN_ID)) return t;
    if(!match(TOKEN_EQUAL)) return t;
    t.add(expr());
    t.set_lexeme(lhs);
    return t;
  endfunction

  function ast expr();
    ast t = new("expr");
    if(lookahead == TOKEN_EOL) return t;
    t.add(term());
    if(err) return t;
    t.add(expr_prime());
    return t;
  endfunction

  function ast expr_prime();
    ast t = new("expr_prime");
    case(lookahead)
      TOKEN_EOL   : return t;
      TOKEN_PLUS  : begin
	if(!match(TOKEN_PLUS)) return t;
	t.set_lexeme("+");
      end
      TOKEN_MINUS : begin
	if(!match(TOKEN_MINUS)) return t;	
	t.set_lexeme("-");
      end
      default : return t;
    endcase
    
    t.add(term());
    if(err || (lookahead == TOKEN_EOL))  return t;
    t.add(expr_prime());
    return t;
  endfunction

  function ast term();
    ast t = new("term");
    if(lookahead == TOKEN_EOL) return t;
    t.add(factor());
    if(err) return t;
    if(lookahead == TOKEN_EOL) return t;
    t.add(term_prime());
    return t;
  endfunction

  function ast term_prime();
    ast t = new("term_prime");
    case(lookahead)
      TOKEN_EOL   : return t;
      TOKEN_STAR  : begin
	if(!match(TOKEN_STAR)) return t;
	t.set_lexeme("*");
      end
      TOKEN_SLASH : begin
	if(!match(TOKEN_SLASH)) return t;
	t.set_lexeme("/");
      end
      default : return t;
    endcase

    if(err || (lookahead == TOKEN_EOL)) return t;
    t.add(factor());
    if(err || (lookahead == TOKEN_EOL)) return t;
    t.add(term_prime());
    return t;
  endfunction

  function ast factor();
    ast t = new("factor");
    case(lookahead)
      TOKEN_EOL : return t;
      TOKEN_ID  : begin
	t.set_lexeme(lex.get_lexeme());
	t.set_var();
	if(!match(TOKEN_ID))
	  error();
	return t;
      end
      TOKEN_INT : begin
	t.set_lexeme(lex.get_lexeme());
	t.set_const(AST_INT);
	if(!match(TOKEN_INT))
	  error();
	return t;
      end
      TOKEN_LEFT_PAREN :
	begin
	  if(!match(TOKEN_LEFT_PAREN)) return t;
	  t.add(expr());
	  if(!match(TOKEN_RIGHT_PAREN)) return t;
	  return t;
	end
      default: begin
	error();
	return t;
      end
    endcase
  endfunction
    
  function bit match(token_t token);
    if(lookahead == token) begin
      lookahead = lex.get_token();
      return 1;
    end
    error();
    return 0;
  endfunction

  function void error();
    $display("*** syntax error at token \"%s\" position %0d",
	     lex.get_lexeme(), lex.get_pos());
    err = 1;
  endfunction
  
endclass

    
    
