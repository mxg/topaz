//------------------------------------------------------------------------------
// cc_fsm_base
//------------------------------------------------------------------------------
virtual class cc_fsm_base extends uvm_object;

  `uvm_object_abstract_utils(cc_fsm_base)

  // A row is an associative array of states indexed by operation.
  typedef state_t row_t[operation_t];
  // A state table is an associative array of rows indexed by state.
  typedef row_t table_t[state_t];

  // Table of state transitions
  protected table_t state_table;

  // table of current states by address
  protected state_t state[addr_t];

  function new(string name = "cc_fsm_base");
    super.new(name);
    build_state_table();
  endfunction
  
  pure virtual function void build_state_table();

  //----------------------------------------------------------------------------
  // update_state
  //
  // Operate the state machine to update the cache state for a
  // particular address
  //----------------------------------------------------------------------------
  virtual function void update_state(operation_t op, addr_t addr);
    state_t curr_state;
    row_t curr_row;
    state_t next_state;

    // Get the current state for the address
    if(state.exists(addr))
      curr_state = state[addr];
    else
      curr_state = state_S;

    // Is the current state a valid state? (This should always
    // succeed.  If it does not something has gone terribly wrong,
    // thus the call to uvm_fatal)
    if(state_table.exists(curr_state))
      begin
	curr_row = state_table[curr_state];
      end
    else
      begin
	`uvm_fatal("CC_FSM", $sformatf("no state table entry for state %s",
				       curr_state.name()))
      end

    // If we have a valid state transition update the state for the
    // address, otherwise issue an error and attempt to resume at some
    // rational state.
    if(curr_row.exists(op)) begin
      next_state = curr_row[op];
      state[addr] = next_state;
      `uvm_info("CC_FSM", $sformatf("%16x : %s(%s) --> %s",
				    addr, curr_state.name(), 
				    op.name(), next_state.name()),
		UVM_NONE)
    end
    else begin
      `uvm_error("CC_FSM", $sformatf("invalid state transition from %s with operation %s at addr \'h%0x",
				     curr_state.name(), op.name(), addr))
      // assume the contents of the memory location are now invalid
      state[addr] = state_I;
    end
    
  endfunction

  //----------------------------------------------------------------------------
  // print_state_table
  //----------------------------------------------------------------------------
  function void print_state_table();
    state_t s;
    state_t next;
    operation_t op;

    $display("--- Cache Coherency State Table ---");
    $display(":: %s ::", get_type_name());
    
    foreach(state_table[s]) begin
      row_t row = state_table[s];
      $write("%s :", s.name());
      foreach(row[op]) begin
	next = row[op];
	$write(" %s->%s", op.name(), next.name());
      end
      $display();
    end

    $display("--- End Table ---");
    
  endfunction
  
endclass

