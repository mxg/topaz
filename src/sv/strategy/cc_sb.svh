//------------------------------------------------------------------------------
// cc_sb_base
//------------------------------------------------------------------------------
class cc_sb_base extends uvm_subscriber#(cc_transaction);

  `uvm_component_utils(cc_sb_base)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void write (cc_transaction t);
  endfunction
  
endclass  

//------------------------------------------------------------------------------
// cc_sb
//------------------------------------------------------------------------------
class cc_sb#(type FSM) extends cc_sb_base;

  typedef cc_sb#(FSM) this_t;
  `uvm_component_param_utils(this_t)

  local FSM fsm;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    fsm = new();
    fsm.print_state_table();
  endfunction

  function void write (cc_transaction t);
    fsm.update_state(t.op, t.addr);
  endfunction

endclass

