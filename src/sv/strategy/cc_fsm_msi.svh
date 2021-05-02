//------------------------------------------------------------------------------
// cc_fsm_msi
//------------------------------------------------------------------------------
class cc_fsm_msi extends cc_fsm_base;

  `uvm_object_utils(cc_fsm_msi)

  function new(string name = "cc_fsm_msi");
    super.new(name);
  endfunction

  virtual function void build_state_table();

    state_table[state_M][PrRd]    = state_M;
    state_table[state_M][PrWr]    = state_M;
    state_table[state_M][BusRd]   = state_S;
    state_table[state_M][BusRdX]  = state_I;

    state_table[state_S][PrRd]    = state_S;
    state_table[state_S][PrWr]    = state_M;
    state_table[state_S][BusRd]   = state_S;
    state_table[state_S][BusUpgr] = state_I;

    state_table[state_I][PrRd]    = state_S;
    state_table[state_I][BusRd]   = state_S;
    state_table[state_I][PrWr]    = state_M;
 
  endfunction
      
endclass
