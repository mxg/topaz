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

class lexer;

  local string s;
  local int unsigned p; 
  local int unsigned lexp;

  function void start(string _s);
    s = _s;
    p = 0;
    lexp = 0;
  endfunction

  function string get_lexeme();
    string lexeme = "";
    lexeme = s.substr(lexp, p-1);
    return lexeme; 
  endfunction

  function int get_pos();
    return p;
  endfunction

  local function byte getc();
    byte b;
    if(s.len() > 0 && p < s.len()) begin
      b = s[p];
      p++;
      return b;
    end
    return 0;
  endfunction

  local function void putc();
    if(p > 0) begin
      if(p < s.len())
        p--;
      else
        p = s.len() - 1;
    end
  endfunction

  local function void mark_lexeme();
    lexp = p;
    if(p > 0)
      lexp--;
  endfunction

  function token_t get_token();

    byte c;

    do c = getc(); while(isspace(c));

    mark_lexeme();

    if(isalpha(c) || (c == "_")) begin
      while(isalnum(c) || (c == "_")) c = getc();
      if(c != 0) putc();
      return TOKEN_ID;
    end

    if(c == "\"") begin
      do c = getc(); while(c != "\"");
      return TOKEN_STRING;
    end

    if(isdigit(c)) begin
      do c = getc(); while(isdigit(c));
      if(c != 0) putc();
      return TOKEN_INT;
    end

    case (c)
      0        : return TOKEN_EOL;
      "-"      : return TOKEN_MINUS;
      "+"      : return TOKEN_PLUS;
      "="      : return TOKEN_EQUAL;
      "*"      : return TOKEN_STAR;
      "/"      : return TOKEN_SLASH;
      "("      : return TOKEN_LEFT_PAREN;
      ")"      : return TOKEN_RIGHT_PAREN;
      default  : return TOKEN_ERROR;
    endcase
    
  endfunction
  
endclass
