//----------------------------------------------------------------------
// FIFO driver
//----------------------------------------------------------------------
class fifo_driver extends uvm_component;

  // port connection to sequence
  uvm_seq_item_pull_port #(fifo_item) seq_item_port;

  // virtual interface connection to DUT
  local virtual fifo_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //--------------------------------------------------------------------
  // build_phase
  //
  // create all the bits and peices used by the driver.
  //--------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    seq_item_port = new("seq_item_port", this);

    // Retrieve the virtual interface for the driver
    if(!uvm_resource_db#(virtual fifo_if)::read_by_name(get_full_name(),
							"fifo_if", vif, this))
      `uvm_fatal("NO_VIF", "no virtual interface available for the fifo driver");
  endfunction

  //--------------------------------------------------------------------
  // run_phase
  //
  // Main loop for the driver.  Pull new transactions from the sequencer
  // on the negedge of the clock.
  // --------------------------------------------------------------------
  task run_phase(uvm_phase phase);

    fifo_item t;

    forever begin

      // Pull the next transaction from the sequencer on the falling
      // edge of the clock.
      @(negedge vif.clk);

      // Retrieve next request
      seq_item_port.try_next_item(t);

      // No transaction?  Then let's wait for the next clock cycle.
      if(t == null)
	continue;

      // Let's do this thing.
      send_to_bus(t);

      // send response
      seq_item_port.put(t);

      // release the sequencer to get another transaction
      seq_item_port.item_done();

    end
    
  endtask

  //--------------------------------------------------------------------
  // send_to_bus
  //
  // Translate a transaction to pint-level protocol
  //--------------------------------------------------------------------
  task send_to_bus(fifo_item t);

    // Enable the device
    vif.cs <= 1;

    // Switch on the operation type
    case(t.op)
      
      fifo_item::RD:  // Read
	begin
	  vif.rd_en <= 1;
	  @(negedge vif.clk);
	  t.data = vif.data_out;
	end
      
      fifo_item::WR:  // Write
	begin
	  vif.wr_en <= 1;
	  vif.data_in <= t.data;
	  @(negedge vif.clk);
	end
      
      fifo_item::RST: // Reset
	begin
	  vif.rst <= 0;
	  @(negedge vif.clk);
	  vif.rst <= 1;
	end
      
      fifo_item::NOP: // No-op
	begin
	  @(negedge vif.clk);
	end

    endcase

    // Put the device into a neutral state in preparation for the next
    // transaction.
    vif.wr_en <= 0;
    vif.rd_en <= 0;
    vif.cs <= 0;

    // Identify the state of the fifo in each transaction.
    case(vif.full << 1 | vif.empty)
      2'b00: t.state = fifo_item::OK;
      2'b01: t.state = fifo_item::EMPTY;
      2'b10: t.state = fifo_item::FULL;
      2'b11: t.state = fifo_item::UNKNOWN;
    endcase

    t.req_rsp = fifo_item::RSP;
      
  endtask

endclass
