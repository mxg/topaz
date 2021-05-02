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
//                 T O P A Z   P A T T E R N   L I B R A RY 
//
//    TOPAZ is a library of SystemVerilog and UVM patterns and idioms.  The
//    code is suitable for study and for copying/pasting into your own work.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// environment
//
/// An environment is a component that contains other components and
/// sub-components. An environment usually represents the top-level
/// component of a system or sub-system.
//------------------------------------------------------------------------------
`include "uvm_macros.svh"
import uvm_pkg::*;

//------------------------------------------------------------------------------
// component
//------------------------------------------------------------------------------
class component extends uvm_component;

  `uvm_component_utils(component)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

endclass

//------------------------------------------------------------------------------
// environment
//
/// An environment is a container for the components and sub-components of a
/// system.  It has a typical component constructor with two arguments -- one
/// for the component name and the other for a handle to the component's parent.
///
/// A common convention is to name the components the same as the variable that
/// holds the component's handle.  E.g component c1 is named "c1".  When
/// debugging code in components it's very helpful that the external and
/// internal representations have the same name.
//------------------------------------------------------------------------------
class environment extends uvm_component;
  
  `uvm_component_utils(environment)

  component c1;
  component c2;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    c1 = new("c1", this);
    c2 = new("c2", this);
  endfunction

endclass

//------------------------------------------------------------------------------
// top
//------------------------------------------------------------------------------
module top;

  initial begin
    component c;
    run_test("environment");
  end
endmodule
