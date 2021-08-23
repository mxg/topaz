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
//    Copyright 2021 Mark Glasser
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
// FIFO sequence item
//------------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
  // convert2string
  //
  // Convert a fifo item to a printable string.  Both the request and
  // response fields are converted.
  //----------------------------------------------------------------------------
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
