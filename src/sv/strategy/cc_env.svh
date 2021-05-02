//------------------------------------------------------------------------------
// cc_env
//------------------------------------------------------------------------------
class cc_env extends uvm_component;

  uvm_analysis_port#(cc_transaction) analysis_port;
  cc_sb_base sb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    analysis_port = new("analysis_port", this);
    sb = cc_sb_base::type_id::create("cc_sb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    analysis_port.connect(sb.analysis_export);
  endfunction

  task run_phase(uvm_phase phase);

    int unsigned i;
    cc_transaction_constrained t;

    phase.raise_objection(this);

    for(i = 0; i < 100; i++) begin
      t = new();
      t.randomize();
      analysis_port.write(t);
      #1;
    end

    phase.drop_objection(this);
  endtask

endclass
