//----------------------------------------------------------------------
// FIFO agent
//----------------------------------------------------------------------

class fifo_agent extends uvm_component;

  uvm_analysis_port#(fifo_item) analysis_port;

  local fifo_driver drv;
  local fifo_monitor mon;
  local fifo_talker tlk;
  local uvm_sequencer#(fifo_item) sqr;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    drv = new("fifo_driver", this);
    sqr = new("fifo_sqr", this);
    mon = new("fifo_monitor", this);
    tlk = new("fifo_talker", this);
    analysis_port = new("analysis_port", this);
  endfunction

  //--------------------------------------------------------------------
  // Connect things together.  Connect the driver to the sequencer an
  // the talker to the monitor.
  // --------------------------------------------------------------------
  function void connect_phase(uvm_phase phase);

    // connect the sequencer to the driver
    drv.seq_item_port.connect(sqr.seq_item_export);

    // connect the monitor analysis port to the driver analysis port
    mon.analysis_port.connect(analysis_port);

    // connect the analysis port to the talker
    mon.analysis_port.connect(tlk.analysis_export);
  endfunction

  function uvm_sequencer_base get_sequencer();
    return sqr;
  endfunction

endclass

