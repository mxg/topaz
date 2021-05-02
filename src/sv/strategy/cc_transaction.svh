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

