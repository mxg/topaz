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
// type_handle_base
//------------------------------------------------------------------------------
virtual class type_handle_base;

  pure virtual function type_handle_base get_type_handle();

endclass

//------------------------------------------------------------------------------
// type_handle
//------------------------------------------------------------------------------
class type_handle #(type T=int) extends type_handle_base;

  typedef type_handle#(T) this_t;
  static this_t my_type;

  local function new();
  endfunction

  static function this_t get_type();
    if(my_type == null)
      my_type = new();
    return my_type;
  endfunction

  function type_handle_base get_type_handle();
    return get_type();
  endfunction

endclass
