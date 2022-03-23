class sqr_aggregator;

  typedef uvm_sequencer_base sqr_q_t[$];

  local uvm_sequencer_base sqr_table[string];
  local sqr_q_t kinds[string];

  function void add(uvm_sequencer_base sqr, string kind);
    sqr_q_t q;
    string path = sqr.get_full_name();
    sqr_table[path] = sqr;

    q = kinds[kind];
    q.push_back(sqr);
    kinds[kind] = q;
  endfunction

  function uvm_sequencer_base lookup_path(string path);
    if(sqr_table.exists(path))
      return sqr_table[path];
    else
      return null;
  endfunction

  function sqr_q_t lookup_path_regex(string regex);
    sqr_q_t q = {};
    foreach(sqr_table[path]) begin
      if(uvm_re_match(regex, path))
	q.push_back(sqr_table[path]);
    end
    return q;
  endfunction

  function sqr_q_t lookup_kind(string kind);
    return kinds[kind];
  endfunction

  function void dump();
    
    $display("--- SEQUENCER AGGREGATOR ---");
    
    $display("  by kind:");
    foreach(kinds[kind]) begin
      sqr_q_t q = kinds[kind];
      $display("    %s", kind);
      foreach(q[i]) begin
	uvm_sequencer_base sqr = q[i];
	$display("      %s", sqr.get_full_name());
      end
    end

    $display("  by path:");
    foreach(sqr_table[path]) begin
      $display("    %s", path);
    end

  endfunction

endclass


