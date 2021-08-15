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
// cc_transaction
//------------------------------------------------------------------------------
class cc_transaction;

  rand operation_t op;
  rand addr_t addr;

  function string convert2string();
    string s;
    s = $sformatf("%16x : %s", addr, op.name());
    return s;
  endfunction

endclass

class cc_transaction_constrained extends cc_transaction;

  constraint a { addr >= 0 && addr < 32; };

endclass

