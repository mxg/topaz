module top;

  import interpreter_pkg::*;
  
  parser p;
  codegen g;
  evaluator e;
  postfix_t postfix;

  initial begin
    p = new();
    g = new();
    e = new();

    g.gen(p.parse ("a = 1"));
    g.gen(p.parse ("b = 2"));
    g.gen(p.parse ("c = 3"));
    g.gen(p.parse ("d = 4"));
    g.gen(p.parse ("z = a + b * c - d"));
    g.gen(p.parse ("x = 5 *(72 - 33) / 8"));
    g.gen(p.parse ("t = 0 - 5 * 4 * 3 * 2 * 1"));
    g.gen(p.parse ("v = x * x * t + z"));

    postfix = g.get_postfix();
    e.eval(postfix);
    e.print_mem();
  end
  
endmodule
