//------------------------------------------------------------------------------
// top
//
// Top-level module that constructs a tree
//------------------------------------------------------------------------------
module top;

  initial begin

    hier a, b, c, d, e, g, h, i;

    a = new("A", null); // topmost node has no parent
    b = new("B", a);
    c = new("C", a);

    d = new("D", b);
    e = new("E", b);
    f = new("F", b);

    g = new("G", c);
    h = new("H", c);
     
    i = new("I", g);
  end

endmodule
