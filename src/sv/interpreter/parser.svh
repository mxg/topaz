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

// Language parsed by this parser
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
    t.print();
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
    
    ast t;
    ast_op optr;
    
    case(lookahead)
      TOKEN_EOL   : return null;
      TOKEN_PLUS  : begin
	if(!match(TOKEN_PLUS)) return null;
	optr = new("expr_prime");
	optr.op = op_plus;
	t = optr;
      end
      TOKEN_MINUS : begin
	if(!match(TOKEN_MINUS)) return null;	
	optr = new("expr_prime");
	optr.op = op_minus;
	t = optr;
      end
      default : return null;
    endcase
    
    t.add(term());
    if(err || (lookahead == TOKEN_EOL))  return t;
    t.add(expr_prime());
    return t;
  endfunction

  function ast term();
    ast t = new("term");
    t.add(factor());
    if(err) return t;
    t.add(term_prime());
    return t;
  endfunction

  function ast term_prime();
    
    ast t;
    ast_op optr;
    
    case(lookahead)
      TOKEN_EOL   : return null;
      TOKEN_STAR  : begin
	if(!match(TOKEN_STAR)) return null;
	optr = new("term_prime");
	optr.op = op_mult;
	t = optr;
      end
      TOKEN_SLASH : begin
	if(!match(TOKEN_SLASH)) return null;
	optr = new("term_prime");
	optr.op = op_div;
	t = optr;
      end
      default : return null;
    endcase

    if(err || (lookahead == TOKEN_EOL)) return t;
    t.add(factor());
    if(err || (lookahead == TOKEN_EOL)) return t;
    t.add(term_prime());
    return t;
  endfunction

  function ast factor();
    case(lookahead)
      TOKEN_EOL : return null;
      TOKEN_ID  : begin
	ast_var t = new("factor");
	t.set_lexeme(lex.get_lexeme());
	if(!match(TOKEN_ID))
	  error();
	t.name = t.lexeme;
	return t;
      end
      TOKEN_INT : begin
	ast_const t = new("factor");
	t.set_lexeme(lex.get_lexeme());
	if(!match(TOKEN_INT))
	  error();
	t.val = t.lexeme.atoi();
	return t;
      end
      TOKEN_LEFT_PAREN :
	begin
	  ast t = new("factor");
	  if(!match(TOKEN_LEFT_PAREN)) return t;
	  t.add(expr());
	  if(!match(TOKEN_RIGHT_PAREN)) return t;
	  return t;
	end
      default: begin
	error();
	return null;
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

    
    
