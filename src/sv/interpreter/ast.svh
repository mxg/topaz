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
//    Copyright 2023 Mark Glasser
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

class ast;

  string kind;
  string lexeme;
  ast children[$];

  function new(string k);
    kind = k;
  endfunction

  function void add(ast t);
    if(t == null)
      return;
    children.push_back(t);
  endfunction

  function void set_lexeme(string s);
    lexeme = s;
  endfunction

  function void indent(int level);
    for(int i = 0; i < level; i++)
      $write("  ");
  endfunction    

  function void print(int level = 0);
    ast child;
    foreach(children[c]) begin
      child = children[c];
      child.print(level+1);
    end
    do_print(level);
  endfunction

  virtual function void do_print(int level);
    indent(level);
    $display("%s : %s", kind, lexeme);
  endfunction

  virtual function int eval();
    ast child;
    int val;
    foreach(children[c]) begin
      child = children[c];
      val = child.eval();
    end
    return val;
  endfunction  
  
endclass

class ast_const extends ast;

  int val;

  function new(string k);
    super.new(k);
  endfunction
  
  virtual function void do_print(int level);
    indent(level);
    $display("const %0d", val);
  endfunction

  virtual function int eval();
    return val;
  endfunction
  
endclass

class ast_var extends ast;

  string name;

  function new(string k);
    super.new(k);
  endfunction
  
  virtual function void do_print(int level = 0);
    indent(level);
    $display("var %s", name);
  endfunction

  virtual function int eval();
    return 0;
  endfunction
  
endclass

class ast_op extends ast;

  op_t op;

  function new(string k);
    super.new(k);
  endfunction

  virtual function void do_print(int level);
    ast child;
    
    indent(level);
    case(op)
      op_plus  : $display("%s : plus", kind);
      op_minus : $display("%s : minus", kind);
      op_mult  : $display("%s : mult", kind);
      op_div   : $display("%s : div", kind);
      op_read  : $display("%s : read", kind);
      op_write : $display("%s : write", kind);
      op_const : $display("%s : %s", kind, lexeme);
    endcase
    
  endfunction

  virtual function int eval();
    int val;
    return 0;
  endfunction

endclass

    
      

  
