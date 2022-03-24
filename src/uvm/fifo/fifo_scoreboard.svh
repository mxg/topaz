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
//    Copyright 2022 Mark Glasser
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

//----------------------------------------------------------------------
// FIFO Scoreboard
//
// The scoreboard determines if each transaction is correct or not.  It
// does this by establishing an expection and the determining if the
// expectation was met by the DUT.  Each request sent to the DUT and
// each response returned is captured by the scoreboard.  The requests
// are used to establish the expectation and the responses are compared
// with the expected result to ses if there s a match.
// ----------------------------------------------------------------------
class fifo_scoreboard extends uvm_subscriber#(fifo_item);

  const int unsigned FIFO_DEPTH = 4;

  local bit [31:0] fifo[$];
  
  local bit [31:0] expected_read_data;
  local bit [31:0] expected_write_data;
  local bit        expected_empty;
  local bit        expected_full;
  local bit        transaction_completed;
  local bit 	   has_been_reset;

  // counters to track the activity of the scoreboard.  These are
  // reported at the end of simulation in the report_phase.
  local int        error_count;
  local int        req_count;
  local int        rsp_count;
  local int        dropped_writes;
  local int        dropped_reads;
  local int        read_requests;
  local int        write_requests;
  local int        reset_requests;
  local int        nop_requests;

  //--------------------------------------------------------------------
  // constructor
  //
  // Initialize class-scoped variables
  //--------------------------------------------------------------------           
  function new(string name, uvm_component parent);
    super.new(name, parent);
    // Initialize all the counters.  This is not strictly necessary
    // because SystemVerilog guarnatees members are initialized to 0
    // upon construction, but its a good habit to make sure everything
    // is initialized.
    error_count     = 0;
    req_count       = 0;
    rsp_count       = 0;
    dropped_writes  = 0;
    dropped_reads   = 0;
    read_requests   = 0;
    write_requests  = 0;
    reset_requests  = 0;
    nop_requests    = 0;
    has_been_reset  = 0;
  endfunction

  //--------------------------------------------------------------------
  // write
  //
  // This is the implementation of the write interface used by the
  // analysis export in the parent subscriber.  Requests are used to
  // eatablish an expectation of DUT behavior, and respionses are used
  // to confirme wither or not the expectation was met.
  // --------------------------------------------------------------------
  function void write(fifo_item t);

    case (t.req_rsp)
      fifo_item::REQ: set_expectation(t);
      fifo_item::RSP: check_result(t);
    endcase
    
  endfunction

  //====================================================================
  //
  // use request to establish expectation
  //
  //====================================================================

  //--------------------------------------------------------------------
  // set_expectation
  //--------------------------------------------------------------------
  function void set_expectation(fifo_item t);
    req_count++;
    case(t.op)
      fifo_item::RD  : expect_read(t);
      fifo_item::WR  : expect_write(t);
      fifo_item::RST : expect_reset();
      fifo_item::NOP : expect_nop();
    endcase
  endfunction

  //--------------------------------------------------------------------
  // expect_read
  //
  // Read from the fifo reference model.  Set the full and empty flags
  // as asappropriate to reflect the state of the reference model after
  // the read has com[leted.
  // --------------------------------------------------------------------
  function void expect_read(fifo_item t);
    read_requests++;
    if(fifo.size() == 0) begin
      expected_empty = 1;
      expected_full = 0;
      transaction_completed = 0;
      return;
    end

    expected_read_data = fifo.pop_back();
    transaction_completed = 1;
    if(fifo.size() == 0)
      expected_empty = 1;
    expected_full = 0;

  endfunction
  
  //--------------------------------------------------------------------
  // expect_write
  //
  // Write to the fifo reference mode.  Set the full and empty flags as
  // appropriate to reflect the state of the reference model after the
  // write has completed.
  // --------------------------------------------------------------------
  function void expect_write(fifo_item t);
    write_requests++;
    if(fifo.size() == FIFO_DEPTH) begin
      expected_empty = 0;
      expected_full = 1;
      transaction_completed = 0;
      return ;
    end

    fifo.push_front(t.data);
    transaction_completed = 1;
    if(fifo.size() == FIFO_DEPTH)
      expected_full = 1;
    expected_empty = 0;
      
  endfunction
  
  //--------------------------------------------------------------------
  // expect_reset
  //
  // Clear out the fifo and set it to the empty state.
  //--------------------------------------------------------------------
  function void expect_reset();

    reset_requests++;
    
    // empty the fifo
    while(fifo.size() > 0)
      expected_read_data = fifo.pop_front();

    expected_full = 0;
    expected_empty = 1;
  endfunction

  //--------------------------------------------------------------------
  // expect_nop
  //
  // There is no expectation fot eh nop since it does not change the
  // state of the fifo.  Just count the occurence of a nop.
  // --------------------------------------------------------------------
  function void expect_nop();
    nop_requests++;
  endfunction

  //====================================================================
  //
  // Use response to see if actual result matches the expectation
  //
  //====================================================================

  //--------------------------------------------------------------------
  // check_result
  //
  // See if the result matches the expectation for a transaction.  There
  // really isn't anything to chek for a RST (reset) transaction.  The
  // expectatio is that the fifo is cleared out.  If the fifo was not
  // cleared then subsequent read and write transactions will fail.
  //--------------------------------------------------------------------
  function void check_result(fifo_item t);
    rsp_count++;
    case(t.op)
      fifo_item::RD  : check_read(t);
      fifo_item::WR  : check_write(t);
      fifo_item::RST : check_reset();
      fifo_item::NOP : ;
    endcase
  endfunction

  //--------------------------------------------------------------------
  // check_read
  //--------------------------------------------------------------------
  function void check_read(fifo_item t);

    if(!has_been_reset)
      `uvm_warning("DEVICE NOT RESET",
		   "Fifo has not been reset before read transaction.");
    
    if(!transaction_completed) begin
      `uvm_warning("READ_NOT_COMPLETE",
		   "Read did not complete because fifo was empty.");
      dropped_reads++;
    end
    else begin
      if(expected_read_data != t.data) begin
        `uvm_error("READ_MISMATCH",
		   $sformatf("Read data mismatch expectation = %x, actual = %x",
			     expected_read_data, t.data));
        error_count++;
      end
    end

    if((t.state == fifo_item::FULL) != expected_full) begin
      `uvm_error("READ_FULL_MISMATCH",
		 $sformatf("Full state mismatch on read - expectation = %b, actual = %b",
			   expected_full, (t.state == fifo_item::FULL)));
      error_count++;
    end

    if((t.state == fifo_item::EMPTY) != expected_empty) begin
      `uvm_error("READ_EMPTY_MISMATCH",
		 $sformatf("Empty state mismatch on read - expectation = %b, actual = %b",
			   expected_empty, (t.state == fifo_item::EMPTY)));
      error_count++;
    end
    
  endfunction

  //--------------------------------------------------------------------
  // check_write
  //--------------------------------------------------------------------
  function void check_write(fifo_item t);

    if(!has_been_reset)
      `uvm_warning("DEVICE NOT RESET",
		   "Fifo has not been reset before write transaction.");

    if(!transaction_completed) begin
      `uvm_warning("WRITE_NOT_COMPLETE",
		   "Write did not complete because fifo was full.");
      dropped_writes++;
    end

    if((t.state == fifo_item::FULL) != expected_full) begin
      `uvm_error("WRITE_FULL_MISMATCH",
		 $sformatf("Full state mismatch on write - expectation = %b, actual = %b",
			   expected_full, (t.state == fifo_item::FULL)));
      error_count++;
    end

    if((t.state == fifo_item::EMPTY) != expected_empty) begin
      `uvm_error("WRITE_EMPTY_MISMATCH",
		 $sformatf("Empty state mismatch on read - expectation = %b, actual = %b",
			   expected_empty, (t.state == fifo_item::EMPTY)));
      error_count++;
    end
      
  endfunction

  //--------------------------------------------------------------------
  // check_reset
  //--------------------------------------------------------------------
  function void check_reset();
    has_been_reset = 1;
  endfunction

  //--------------------------------------------------------------------
  // report_phase
  //
  // Print a summary report about what happened during simulation.
  //--------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
    $display("\n----- FIFO SCOREBOARD REPORT -----");
    $display();
    $display("** Transaction Counts **");
    $display(" %0d reads", read_requests);
    $display(" %0d writes", write_requests);
    $display(" %0d resets", reset_requests);
    $display(" %0d nops", nop_requests);
    $display();
    $display("** Activity Summary **");
    $display("%0d requests", req_count);
    $display("%0d responses", rsp_count);
    $display("%0d dropped writes", dropped_writes);
    $display("%0d dropped reads", dropped_reads);
    $display("%0d failures", error_count);
    $display("\n----- END FIFO SCOREBOARD REPORT -----\n");
  endfunction

endclass
