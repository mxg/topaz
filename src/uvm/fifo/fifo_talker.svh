//----------------------------------------------------------------------
// FIFO talker
//
// A subscriber that simply prints the contents of each transactio.
// This is useful for debugging and demonsration purposec.
// ----------------------------------------------------------------------
class fifo_talker extends uvm_subscriber #(fifo_item);

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void write(fifo_item t);
    $display("talker %10t: %s", $time, t.convert2string());
  endfunction

endclass

