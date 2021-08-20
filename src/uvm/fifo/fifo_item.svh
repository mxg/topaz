//----------------------------------------------------------------------
// FIFO sequence item
//----------------------------------------------------------------------
class fifo_item extends uvm_sequence_item;

  // op_t identifies the operation to be performed on the fifo
  typedef enum { RD, WR, RST, NOP } op_t;

  // state_t identifes the state of the fifo,
  typedef enum { UNKNOWN, OK, EMPTY, FULL } state_t;

  // Does this item represent a request or a response
  typedef enum { REQ, RSP } req_rsp_t;

  rand op_t op;
  rand bit [ 31:0] data;
  state_t state;
  req_rsp_t req_rsp;

  function new(string name = "fifo_item");
    super.new(name);
  endfunction

  //--------------------------------------------------------------------
  // convert2string
  //
  // Convert a fifo item to a printable string.  Both the request and
  // response fields are converted.
  //--------------------------------------------------------------------
  function string convert2string();
    string    s;
    $sformat(s, "%3s : %s %s %8x [%s]",
	     op.name(),
	     req_rsp.name(),  ((req_rsp==REQ)?"-->":"<--"),
             data,
             state.name());
    return s;
  endfunction
  
endclass
