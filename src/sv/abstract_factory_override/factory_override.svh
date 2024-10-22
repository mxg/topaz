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
// factory
//------------------------------------------------------------------------------
class factory#(type B) extends concrete_factory#(B, B);

  local static abstract_factory#(B) override;

  local function new();
  endfunction

  static function void set_override(abstract_factory#(B) ovrd);
    override = ovrd;
  endfunction

  static function B construct();
    if(override != null)
      return override.create();
    else begin
      concrete_factory#(B,B) cf = concrete_factory#(B,B)::get();
      return cf.create();
    end
  endfunction

endclass
