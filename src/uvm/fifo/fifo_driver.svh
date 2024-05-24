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
//    Copyright 2023 Mark Glasser
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
// FIFO driver
//------------------------------------------------------------------------------
class fifo_driver extends uvm_component;

  // port connection to sequence
  uvm_seq_item_pull_port #(fifo_item) seq_item_port;

  // virtual interface connection to DUT
  local virtual fifo_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //----------------------------------------------------------------------------
  // build_phase
  //
  // create all the bits and peices used by the driver.
  //----------------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    seq_item_port = new("seq_item_port", this);

    // Retrieve the virtual interface for the driver
    if(!uvm_resource_db#(virtual fifo_if)::read_by_name(get_full_name(),
							"fifo_if", vif, this))
      `uvm_fatal("NO_VIF", "no virtual interface available for the fifo driver");
  endfunction

  //----------------------------------------------------------------------------
  // run_phase
  //
  // Main loop for the driver.  Pull new transactions from the sequencer
  // on the negedge of the clock.
  //----------------------------------------------------------------------------
  task run_phase(uvm_phase phase);

    fifo_item t;

    forever begin
      @(negedge vif.clk);
      seq_item_port.try_next_item(t);
      if(t == null)
	continue;
      send_to_bus(t);
      seq_item_port.put(t);
      seq_item_port.item_done();
    end
    
  endtask

  //----------------------------------------------------------------------------
  // send_to_bus
  //
  // Translate a transaction to pin-level protocol
  //----------------------------------------------------------------------------
  task send_to_bus(fifo_item t);

    vif.cs_r <= 1;

    case(t.op)
      
      fifo_item::RD:  // Read
	begin
	  vif.rd_en_r <= 1;
	  @(negedge vif.clk);
	  t.data = vif.data_out;
	end
      
      fifo_item::WR:  // Write
	begin
	  vif.wr_en_r <= 1;
	  vif.data_in_r <= t.data;
	  @(negedge vif.clk);
	end
      
      fifo_item::RST: // Reset
	begin
	  vif.rst_r <= 0;
	  @(negedge vif.clk);
	  vif.rst_r <= 1;
	end
      
      fifo_item::NOP: // No-op
	begin
	  @(negedge vif.clk);
	end

    endcase

    vif.wr_en_r <= 0;
    vif.rd_en_r <= 0;
    vif.cs_r <= 0;

    case({vif.full, vif.empty})
      2'b00: t.state = fifo_item::OK;
      2'b01: t.state = fifo_item::EMPTY;
      2'b10: t.state = fifo_item::FULL;
      2'b11: t.state = fifo_item::UNKNOWN;
    endcase

    t.req_rsp = fifo_item::RSP;
      
  endtask

endclass
