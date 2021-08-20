//----------------------------------------------------------------------
// FIFO test
//
// This is the top-level UVM component. Note that the component is
// registered with the factory by the `uvm_compoent_utils macros.  This
// allows the component to be located and instantiated by the factory.
// ----------------------------------------------------------------------
class test extends uvm_component;

  `uvm_component_utils(test)

  env e;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Instantiate the top-level environment.
  function void build_phase(uvm_phase phase);
    e = new("env", this);
    fifo_sequence_base::type_id::set_type_override(fifo_rand_sequence::type_id::get());
  endfunction
  
endclass
