//------------------------------------------------------------------------------
// cc_fsm_mesi
//------------------------------------------------------------------------------
class cc_fsm_mesi extends cc_fsm_base;

  `uvm_object_utils(cc_fsm_mesi)

  function new(string name = "cc_fsm_mesi");
    super.new(name);
  endfunction  

  virtual function void build_state_table();

    state_table[state_M][PrRd]    = state_M;
    state_table[state_M][PrWr]    = state_M;
    state_table[state_M][BusRd]   = state_S;
    state_table[state_M][BusRdX]  = state_I;

    state_table[state_E][PrRd]    = state_E;
    state_table[state_E][PrWr]    = state_M;
    state_table[state_E][BusRd]   = state_S;
    state_table[state_E][BusRdX]  = state_I;
    
    state_table[state_S][PrRd]    = state_S;
    state_table[state_S][PrWr]    = state_M;
    state_table[state_S][BusRd]   = state_S;
    state_table[state_S][BusRdX]  = state_I;
    state_table[state_S][BusUpgr] = state_I;

    state_table[state_I][PrRd]    = state_S;
    state_table[state_I][PrRdS]   = state_S;
    state_table[state_I][PrRdNS]  = state_M;
    
    
  endfunction
  
endclass
