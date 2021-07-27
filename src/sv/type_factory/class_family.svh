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

class base;
  `register_type_factory(type_handle#(base)::get_type(), base, base)
   virtual function string convert2string();
      return "base";
   endfunction
endclass

class class_1 extends base;
  `register_type_factory(type_handle#(class_1)::get_type(), base, class_1)
   virtual function string convert2string();
      return "class_1";
   endfunction 
endclass

class class_2 extends base;
  `register_type_factory(type_handle#(class_2)::get_type(), base, class_2)
   virtual function string convert2string();
      return "class_2";
   endfunction
endclass

class class_3 extends base;
  `register_type_factory(type_handle#(class_3)::get_type(), base, class_3)
   virtual function string convert2string();
      return "class_3";
   endfunction
endclass
