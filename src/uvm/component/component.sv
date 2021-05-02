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
// component
//
/// A component is the essential structural element in a UVM
/// testbench.  A testbench is typically organized as a hierarchy of
/// components.
//------------------------------------------------------------------------------
`include "uvm_macros.svh"
import uvm_pkg::*;

//------------------------------------------------------------------------------
// component
//
/// The constructor takes two arguments, the name of the component and
/// a handle to its parent. Default values are explicitly not used for
/// the constructor arguments.  In some cases the default values may
/// be incorrect for the current situation. Providing defaults would
/// allow erroneous values to be supplied, in which case UVM will
/// silently do the wrong thing.  By requiring users to explicitly
/// provide actual argument values this problem can be avoided.
//------------------------------------------------------------------------------
class component extends uvm_component;

  `uvm_component_utils(component)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

endclass

//------------------------------------------------------------------------------
// top
//------------------------------------------------------------------------------
module top;

  initial begin
    component c;
    run_test("component");
  end
endmodule
