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


