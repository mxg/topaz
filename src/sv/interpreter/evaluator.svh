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

  
