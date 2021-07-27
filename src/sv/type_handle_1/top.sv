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

class some_class;
endclass

class thingy;
endclass

//------------------------------------------------------------------------------
// top
//------------------------------------------------------------------------------
module top;

  import type_handle_pkg::*;

  initial begin

    string type_list[type_handle_base];

    type_list[type_handle#(some_class)::get_type()] = "some_class";
    type_list[type_handle#(thingy)::get_type()] = "thingy";

    foreach (type_list[type_index]) begin
      $display(type_list[type_index]);
    end

  end

endmodule
    
