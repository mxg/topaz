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

  `base_factory(base)

  virtual function void print();
    $display("base");
  endfunction
  
endclass

class some_class extends base;

  `factory(base, some_class)

  virtual function void print();
    $display("some_class");
  endfunction
  
endclass

class some_other_class extends base;

  `factory(base, some_other_class)

  virtual function void print();
    $display("some_other_class");
  endfunction
  
endclass

module top;

  initial begin
    base b;

    b = base::factory::create();
    b.print();

    base::factory::set_override(concrete_factory#(base,some_class)::get());
    b = base::factory::create();
    b.print();

    base::factory::set_override(some_other_class::factory::get());
    b = base::factory::create();
    b.print();

  end
  
endmodule
