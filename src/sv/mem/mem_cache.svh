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
// mem_cache
//------------------------------------------------------------------------------
class mem_cache implements mem_if;

  local mem            m;
  local byte           data_cache[SIZE];
  local tag_t          tags[SIZE];
  local bit [SIZE-1:0] dirty;
  
  function new();
    m = new();
  endfunction

  //----------------------------------------------------------------------------
  // read
  //----------------------------------------------------------------------------
  virtual function byte read(addr_t addr);
    
    index_t index = get_index(addr);
    tag_t tag     = get_tag(addr);
    byte  data;

    if(tags[index] == tag) begin
      data = data_cache[index];
      $display("read : %8x %2x", addr, data);
      return data;
    end
    
    data = m.read(addr);
    if(dirty[index] == 0) begin
      data_cache[index] = data;
      tags[index] = tag;
    end
    
    $display("read : %8x %2x", addr, data);
    return data;
  endfunction

  //----------------------------------------------------------------------------
  // write
  //----------------------------------------------------------------------------
  virtual function void write(addr_t addr, byte data);
    
    index_t index = get_index(addr);
    tag_t tag = get_tag(addr);
    
    $display("write: %8x %2x", addr, data);
    flush_index(index, tag);
    tags[index] = tag;
    data_cache[index] = data;
    dirty[index] = 1;
  endfunction

  //----------------------------------------------------------------------------
  // flush_index
  //----------------------------------------------------------------------------
  local function void flush_index(index_t index, tag_t tag);
    
    addr_t addr = make_addr(tag, index, tags);

    if(dirty[index] == 0 || tags[index] == tag)
      return;
    
    m.write(addr, data_cache[index]);
    dirty[index] = 0;
  endfunction

  //----------------------------------------------------------------------------
  // flush
  //----------------------------------------------------------------------------
  function void flush();
    for(int unsigned i = 0; i < SIZE; i++)
      if(dirty[i])
	m.write(make_addr(tags[i], i, tags), data_cache[i]);
  endfunction

  //----------------------------------------------------------------------------
  // dump
  //----------------------------------------------------------------------------
  function void dump();
    int unsigned i;
    
    $display("--- cache ---");
    for(i = 0; i < SIZE; i++) begin
      $display("  %06x %02x : %02x (%0b)", tags[i], i, data_cache[i], dirty[i]);
    end
    $display("--- memory ---");
    m.dump();
  endfunction

endclass

