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

class virtual_sequence_base #(type REQ = uvm_sequence_item,
                              type RSP = REQ)
  extends uvm_sequence#(REQ, RSP);

  local sqr_aggregator sqrs;
  local uvm_sequencer_base ctrl_sqr;
  local uvm_sequencer_base data_sqr;

  task pre_start();

    if(!uvm_resource_db#(sqr_aggregator)::read_by_name(get_full_name(),
                                                   "sqrs", sqrs, this))
      `uvm_fatal("VIRTUAL_SEQUENCE_BASE",
                 "sequencer aggregator cannot be located")

    ctrl_sqr = sqrs.lookup_name("control");
    data_sqr = sqrs.lookup_name("data");

  endtask

endclass