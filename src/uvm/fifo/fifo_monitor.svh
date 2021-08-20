//----------------------------------------------------------------------
// FIFO monitor
//----------------------------------------------------------------------
class fifo_monitor extends uvm_component;

  uvm_analysis_port#(fifo_item) analysis_port;
  local virtual fifo_if vif;

  //--------------------------------------------------------------------
  // usual constructor
  //--------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //--------------------------------------------------------------------
  // Build all of the subordinate components.  In this case the only
  // subordinate component is the analysis port.
  // --------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    analysis_port = new("anlysis_port", this);

    // Locate the virtual interface
    if(!uvm_resource_db#(virtual fifo_if)::read_by_name(get_full_name(),
							"fifo_if", vif, this))
      `uvm_fatal("NO_VIF", "no virtual interface available for the fifo monitor");
  endfunction

  //--------------------------------------------------------------------
  // run_phase
  //--------------------------------------------------------------------
  task run_phase(uvm_phase phase);

    fifo_item t;

    // We know the driver operates on the falling edge of the clock.  So
    // there is no point in monitoring transactions until the first
    // falling clock edge because no transactions will appear until
    // then.
    @(negedge vif.clk);

    forever begin

      @(vif.clk);

      // Ensure the monitor process runs last
      #0;

      // Are we in reset?
      if(vif.rst == 0) begin
	t = new();
	t.op = fifo_item::RST;
	t.req_rsp = (vif.clk == 1) ? fifo_item::REQ : fifo_item::RSP;
	analysis_port.write(t);
	continue;
      end
	
      if(vif.cs == 0)
	continue;
      
      t = new();

      // what operation are we doing?  The write-enable abd read-ebable
      // bits identify the operation.
      case(vif.wr_en << 1 | vif.rd_en)
	2'b00:
	  begin
	    t.op = fifo_item::NOP;
	  end

	2'b01:
	  begin
	    t.data = vif.data_out;
	    t.op = fifo_item::RD;
	  end

	2'b10:
	  begin
	    t.data = vif.data_in;
	    t.op = fifo_item::WR;
	  end

	2'b11:
	  begin
	    t.op = fifo_item::NOP;
	  end
	endcase
	  
      // What's the state of the fifo? The full and empty bits identify
      // the state of the fifo.
      case(vif.full << 1 | vif.empty)
	2'b00: t.state = fifo_item::OK;
	2'b01: t.state = fifo_item::EMPTY;
	2'b10: t.state = fifo_item::FULL;
	2'b11: t.state = fifo_item::UNKNOWN;
      endcase

      // Requests come on posedge of the clock, responses on negedge.
      t.req_rsp = (vif.clk == 1) ? fifo_item::REQ : fifo_item::RSP;

      // Send the transaction out to any subscribers connected to this
      // analysis port.
      analysis_port.write(t);
      
    end
    
  endtask


endclass

