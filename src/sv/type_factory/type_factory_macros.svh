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
// string_factory_macros
//------------------------------------------------------------------------------

`define register_string_factory(type_name, B, T) \
  static bit __str_fact__ = string_factory#(B)::add(type_name, concrete_factory#(B,T)::get());

`define override_string_factory(type_name, B, T) \
  string_factory#(B)::override(type_name, concrete_factory#(B,T)::get());

`define create_string_factory(type_name, B, t)  \
  begin                                                       \
    abstract_factory#(B) cf;                                  \
    cf = string_factory#(B)::get_concrete_factory(type_name); \
    if(cf != null)                                            \
      t = cf.create();                                          \
  end
       
