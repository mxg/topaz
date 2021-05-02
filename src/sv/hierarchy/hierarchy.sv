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
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// node
//
// A node that can be assembled into a hierarchy
//------------------------------------------------------------------------------
class node;

  local node children[$];

  function new(node parent);

    // If the parent is null then this nodeis a root node and not the
    // child of some other node.
    if(parent == null)
      return;

    // Connect this node into the hierarchy as a child of the current
    // node.
    parent.add_child(this);
    
  endfunction

  function void add_child(node child);

    // Check to make sure that the node is not already in the
    // hierarchy.
    foreach(children[c]) begin
      if(child == children[c]) begin
        $display("cannot add duplicate child node");
        return;
      end
    end

    // Put the child into the list oc children.
    children.push_back(child);

  endfunction

  function void get_children(ref node c[$]);
    c = children;
  endfunction

endclass

//------------------------------------------------------------------------------
// tree

// A tree is derived from a node. The tree has some interesting data
// into it, in this case id, whereas node is just a hierarchical
// shell.
//------------------------------------------------------------------------------
class tree extends node;

  int id;

  function new(tree parent);
    super.new(parent);
  endfunction

endclass
