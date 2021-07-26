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
// string_factory
//------------------------------------------------------------------------------
class string_factory#(type B);

  static local abstract_factory#(B) factory_table [string];

  static function bit add(string type_name, abstract_factory#(B) cf);
    if(!factory_table.exists(type_name))
      factory_table[type_name] = cf;
    else
      $display("error: Type %s already exists in the string factory", type_name);
    return 1;
  endfunction

  static function void override(string type_name, abstract_factory#(B) cf);
    if(factory_table.exists(type_name))
      factory_table[type_name] = cf;
    else
      $display("error: Type %s cannot be overridden in the string factory", type_name);
  endfunction    
      
  static function abstract_factory#(B) get_concrete_factory(string type_name);
    if(factory_table.exists(type_name))
      return factory_table[type_name];
    $display("error: Type %s is not in the string factory", type_name);
    return null;
  endfunction

endclass

    
