class ast;

  string kind;
  string lexeme;
  bit 	 is_const;
  data_type_t data_type;
  ast children[$];

  function new(string k);
    kind = k;
  endfunction

  function void add(ast t);
    children.push_back(t);
  endfunction

  function void set_lexeme(string s);
    lexeme = s;
  endfunction

  function void set_const(data_type_t dt);
    data_type = dt;
    is_const = 1;
  endfunction

  function void set_var();
    is_const = 0;
  endfunction

  function void print(int level = 0);
    ast child;
    for(int i = 0; i < level; i++)
      $write("  ");
    $display("%s : %s", kind, lexeme);
    foreach(children[c]) begin
      child = children[c];
      if(child == null)
	continue;
      child.print(level+1);
    end
  endfunction
  
endclass
