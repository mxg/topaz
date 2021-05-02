//------------------------------------------------------------------------------
// cc_test
//------------------------------------------------------------------------------
class cc_test extends uvm_component;

  `uvm_component_utils(cc_test)

  cc_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    env = new("cc_env", this);

    cc_sb_base::type_id::set_type_override(cc_sb#(cc_fsm_msi)::get_type());
  endfunction

endclass
