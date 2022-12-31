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
// protected handler
//------------------------------------------------------------------------------
class protected_handler extends handler_base;

  function string name();
    return "protected";
  endfunction

  virtual function void handle_request(mem_transaction tr,
				       mem m);
    if(tr.addr < 'h00008000 && tr.mode == PROT) begin
      $write("%s handler: ", name());
      m.do_transaction(tr);
    end
    else
      next_handler.handle_request(tr, m);
  endfunction

endclass

//------------------------------------------------------------------------------
// read-only handler
//------------------------------------------------------------------------------
class read_only_handler extends handler_base;

  function string name();
    return "read-only";
  endfunction

  virtual function void handle_request(mem_transaction tr,
				       mem m);
    if(tr.addr >= 'h00008000 && tr.addr <= 'h0000ffff &&
      tr.op == READ) begin
      $write("%s handler: ", name());
      m.do_transaction(tr);
    end
    else 
      next_handler.handle_request(tr, m);
 endfunction

endclass
  
//------------------------------------------------------------------------------
// read_write handler
//------------------------------------------------------------------------------
class read_write_handler extends handler_base;

  function string name();
    return "read-write";
  endfunction

  virtual function void handle_request(mem_transaction tr,
				       mem m);
    if(tr.addr <= 'hffffffff && tr.addr > 'h0000ffff) begin
      $write("%s handler: ", name());
      m.do_transaction(tr);
    end
    else
      next_handler.handle_request(tr, m);
  endfunction

endclass
  
//------------------------------------------------------------------------------
// error handler
//
// Must be the last in the chain
//------------------------------------------------------------------------------
class error_handler extends handler_base;

  function string name();
    return "error";
  endfunction

  virtual function void handle_request(mem_transaction tr,
				       mem m);
    $write("%s handler: ", name());
    $display("no handler for transaction: %s", tr.convert2string());
  endfunction

endclass
