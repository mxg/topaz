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

`include "type_factory_macros.svh"

//------------------------------------------------------------------------------
// top
//------------------------------------------------------------------------------
module top;

  import class_family_pkg::*;
  import abstract_factory_pkg::*;
  import type_factory_pkg::*;
  import type_handle_pkg::*;
  
  initial begin
    
    base b;
    
    `create_type_factory(type_handle#(class_1)::get_type(), base, b)
    $display(b.convert2string());
    
    `create_type_factory(type_handle#(base)::get_type(), base, b)
    $display(b.convert2string());

    `override_type_factory(type_handle#(base)::get_type(), base, class_2)
    `create_type_factory(type_handle#(base)::get_type(), base, b)
    $display(b.convert2string());   
  end

endmodule

    
