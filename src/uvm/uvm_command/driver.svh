
class driver extends uvm_component;

  uvm_seq_item_pull_port #(abstract_command) seq_item_port;
  local channel chan;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    seq_item_port = new("seq_iten_port", this);
  endfunction
  
  function void bind_channel(channel c);
    chan = c;
  endfunction

  task run_phase(uvm_phase phase);
    abstract_command cmd;
    forever begin
      seq_item_port.get_next_item(cmd);
      cmd.bind_channel(chan);
      cmd.execute();
      seq_item_port.item_done();
    end
  endtask

endclass
