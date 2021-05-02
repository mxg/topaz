//------------------------------------------------------------------------------
// top
//
// Top-level module that constructs a tree
//------------------------------------------------------------------------------
module top;

  initial begin

    // create a hierarchy;
    tree treetop;
    tree t1;
    tree t2;

    treetop = new(null); // topmost node has noi parent
    // two odes whose parent is treetop
    t1 = new(treetop);
    t1.id = 15;
    t2 = new(treetop);
    t2.id = 133;

    // Two nodes whose parent is t1.
    t2 = new(t1);
    t2.id = 9;
    t2 = new(t1);
    t2.id = 175;

  end

endmodule
