//----------------------------------------------------------------------
// FIFO env
//
// Top-level environment for the FIFO testbench.  The role of the env is
// to provide the structure of the testbench.
// ----------------------------------------------------------------------
class env extends uvm_component;

  local fifo_agent agt;
  local fifo_scoreboard sb;
  local fifo_sequence_base seq;
  uvm_sequencer_base sqr;

  //--------------------------------------------------------------------
  // The usual constructor
  //--------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //--------------------------------------------------------------------
  // Build all of the testbench components
  //--------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    agt = new("fifo_agent", this);
    sb = new("fifo_scoreboard", this);
    seq = fifo_sequence_base::type_id::create();
  endfunction

  //--------------------------------------------------------------------
  // Connect things together.  COnnect the driver to the sequencer an
  // the talker to the monitor.
  // --------------------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    sqr = agt.get_sequencer();
    agt.analysis_port.connect(sb.analysis_export);
  endfunction

  //--------------------------------------------------------------------
  // Initiate the sequence that executs the test.  Let the testbench
  // shutdown when the sequence finishes.
  // --------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(sqr);
    phase.drop_objection(this);
  endtask
  
endclass
