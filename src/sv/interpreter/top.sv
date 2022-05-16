module top;

  import interpreter_pkg::*;
  
  parser p;
  codegen g;

  initial begin
    p = new();
    g = new();
    
    g.gen(p.parse("x=  (a+b) - 145/c2"));
    //p.parse("y = 12 / x *- 116");
    g.gen(p.parse ("z = a + b * c - d"));
    g.gen(p.parse ("t = 5 *(72 - 33) / 8"));
    g.gen(p.parse ("v = x * x * t + z"));
    g.print();
  end
  
endmodule
