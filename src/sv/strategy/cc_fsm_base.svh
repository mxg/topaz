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
//
//    Copyright 2021 Mark Glasser
// 
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
// 
//      http://www.apache.org/licenses/LICENSE-2.0
// 
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// cc_fsm_base
//------------------------------------------------------------------------------
virtual class cc_fsm_base extends uvm_object
                          implements cc_fsm_intf;

  `uvm_object_abstract_utils(cc_fsm_base)

  typedef state_t row_t[operation_t];
  typedef row_t table_t[state_t];

  protected table_t state_table;

  protected state_t state[addr_t];

  function new(string name = "cc_fsm_base");
    super.new(name);
    build_state_table();
  endfunction // new

  virtual function void build_state_table();
    `uvm_fatal("CC_FSM", "buikld_state_table() is unimplemented")
  endfunction
  
  //----------------------------------------------------------------------------
  // update_state
  //
  // Operate the state machine to update the cache state for a
  // particular address
  //----------------------------------------------------------------------------
  virtual function void update_state(operation_t op,
				     addr_t addr);
    state_t curr_state;
    row_t curr_row;
    state_t next_state;

    if(state.exists(addr))
      curr_state = state[addr];
    else
      curr_state = state_S;

    if(state_table.exists(curr_state))
      curr_row = state_table[curr_state];
    else
      `uvm_fatal("CC_FSM", 
		 $sformatf("no state table entry for state %s",
			   curr_state.name()))

    if(curr_row.exists(op)) begin
      next_state = curr_row[op];
      state[addr] = next_state;
      `uvm_info("CC_FSM",
		$sformatf("%16x : %s(%s) --> %s",
			  addr, curr_state.name(), 
			  op.name(), next_state.name()),
		UVM_NONE)
    end
    else begin
      `uvm_error("CC_FSM",
		 $sformatf({"invalid state transition ",
                            "from %s with operation %s",
			    "at addr \'h%0x"},
			   curr_state.name(),
			   op.name(), addr))
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

