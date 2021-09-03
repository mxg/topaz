//------------------------------------------------------------------------------
// top
//
// Top-level module that constructs a tree
//------------------------------------------------------------------------------
module top;

  initial begin

    tree_visitor tv;

    // create a hierarchy;
    tree treetop;
    tree t1;
    tree t2;
    tree t3;
    tree t4;

    treetop = new("top", null); // topmost node has no parent
    // two nodes whose parent is treetop


    t1 = new("t1", treetop);
    t2 = new("t2", treetop);

    // Two nodes whose parent is t1.
    t3 = new("t3", t1);
    t4 = new("t4", t1);
    //------------------------------

    tv = new();
    tv.traverse(treetop);

  end

endmodule

