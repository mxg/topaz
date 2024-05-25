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

class evaluator;

  local int mem[string];
  local int stack[$];

  function void print_mem();
    int val;
    foreach(mem[n]) begin
      val = mem[n];
      $display("%s = %0d", n, val);
    end
  endfunction

  function void eval(ref postfix_t postfix);

    code c;
    int i;
    int r;
    int a;
    int b;

    for(i = 0; i < postfix.size(); i++) begin
      
      c = postfix[i];
      case (c.op)
	op_plus  : begin
	  a = pop();
	  b = pop();
	  r = a + b;
	  push(r);
	end
	
	op_minus :begin
	  a = pop();
	  b = pop();
	  r = b - a;
	  push(r);
	end
	
	op_mult  :  begin
	  a = pop();
	  b = pop();
	  r = a * b;
	  push(r);
	end
	
	op_div   :  begin
	  a = pop();
	  b = pop();
	  r = b / a;
	  push(r);
	end
	
	op_read  : begin
	  r = read(c.name);
	  push(r);
	end
	
	op_write : begin 
	  r = pop();
	  write(c.name, r);
	end
	
	op_const : begin
	  push(c.operand);
	end
	
      endcase
    end
  endfunction

  function int pop();
    return stack.pop_back();
  endfunction

  function void push(int a);
    stack.push_back(a);
  endfunction

  function int read(string name);
    if(mem.exists(name))
      return mem[name];
    else
      return 0;
  endfunction

  function void write(string name, int val);
    mem[name] = val;
  endfunction

endclass

  
