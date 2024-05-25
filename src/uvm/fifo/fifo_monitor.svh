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
//    Copyright 2024 Mark Glasser
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
// FIFO monitor
//------------------------------------------------------------------------------
class fifo_monitor extends uvm_component;

  uvm_analysis_port#(fifo_item) analysis_port;
  local virtual fifo_if vif;


  //----------------------------------------------------------------------------
  // usual constructor
  //----------------------------------------------------------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //--------------------------------------------------------------------
  // Build all of the subordinate components.  In this case the only
  // subordinate component is the analysis port.
  //--------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    analysis_port = new("anlysis_port", this);

    // Locate the virtual interface
    if(!uvm_resource_db#(virtual fifo_if)::read_by_name(get_full_name(),
			 "fifo_if", vif, this))
      `uvm_fatal("NO_VIF", "no virtual interface available for the fifo monitor");
  endfunction

  //----------------------------------------------------------------------------
  // run_phase
  //----------------------------------------------------------------------------
  task run_phase(uvm_phase phase);

    fifo_item t;

    @(negedge vif.clk);
    forever begin
      @(vif.clk);

      #0;

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
      case({vif.wr_en, vif.rd_en})
	2'b00: t.op = fifo_item::NOP;
	2'b01: begin
	         t.data = vif.data_out;
	         t.op = fifo_item::RD;
	       end
	2'b10: begin
	         t.data = vif.data_in;
	         t.op = fifo_item::WR;
	       end
	2'b11: t.op = fifo_item::NOP;
	endcase
	  
      case({vif.full, vif.empty})
	2'b00: t.state = fifo_item::OK;
	2'b01: t.state = fifo_item::EMPTY;
	2'b10: t.state = fifo_item::FULL;
	2'b11: t.state = fifo_item::UNKNOWN;
      endcase

      t.req_rsp = (vif.clk == 1) ? fifo_item::REQ : fifo_item::RSP;
      analysis_port.write(t);
      
    end
    
  endtask


endclass

