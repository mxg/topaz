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
// specialized factory macro
//
// Boilerplate code needed for classes to use the factory
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Specialized Factory
//
// A specialized factory can easily be created by redefineing the
// factory macro.  The redefined macro hardcodes the base type so that
// it does not have to be replicated in every invocatio of the
// macro. Of course, the new factory macro can only create objects
// whoaw base type is the hardcoded base type.
//------------------------------------------------------------------------------
`define my_factory(T)                                             \
  typedef abstract_factory#(T,my_base) factory;                   \
  static function concrete_factory_base#(my_base) get_factory();  \
    return factory::get();                                        \
  endfunction

class my_base;
  `my_factory(my_base)

  virtual function void print();
    $display("my_base");
  endfunction
  
endclass

class my_class extends my_base;

  `my_factory(my_class)

  virtual function void print();
    $display("my_class");
  endfunction
  
endclass


module top;

  initial begin
    my_base b;

    b = my_base::factory::create();
    b.print();

    my_base::factory::override(my_class::factory::get());
    b = my_base::factory::create();
    b.print();

  end
  
endmodule
