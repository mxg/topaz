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
// mem_cache
//------------------------------------------------------------------------------
class mem_cache implements mem_if;

  local mem            m;
  local byte           data_cache[SIZE];
  local tag_t          tags[SIZE];
  local bit [SIZE-1:0] dirty;
  local bit [SIZE-1:0] full;

  local int 	       cache_hits;
  local int 	       cache_misses;
  local int 	       accesses;
  
  function new();
    m = new();
  endfunction

  function int get_cache_hits();
    return cache_hits;
  endfunction

  function int get_cache_misses();
    return cache_misses;
  endfunction

  //----------------------------------------------------------------------------
  // read
  //----------------------------------------------------------------------------
  virtual function byte read(addr_t addr);
    
    index_t index = get_index(addr);
    tag_t tag     = get_tag(addr);
    byte  data;

    accesses++;
    if(tags[index] == tag && full[index] == 1) begin
      data = data_cache[index];
      cache_hits++;
      return data;
    end
    
    data = m.read(addr);
    cache_misses++;
    if(dirty[index] == 0) begin
      data_cache[index] = data;
      tags[index] = tag;
      full[index] = 1;
    end
    
    return data;
  endfunction

  //----------------------------------------------------------------------------
  // write
  //----------------------------------------------------------------------------
  virtual function void write(addr_t addr, byte data);
    
    index_t index = get_index(addr);
    tag_t tag = get_tag(addr);

    accesses++;
    if(dirty[index] == 1 && tags[index] != tag) begin
      m.write(addr, data_cache[index]);
      dirty[index] = 0;
      cache_misses++;
    end
    else
      cache_hits++;
    
    tags[index] = tag;
    data_cache[index] = data;
    dirty[index] = 1;
    full[index] = 1;
    
  endfunction

  //----------------------------------------------------------------------------
  // flush
  //----------------------------------------------------------------------------
  function void flush();
    $display(" -- flush cache --");
    for(int unsigned i = 0; i < SIZE; i++)
      if(dirty[i]) begin
	m.write(make_addr(tags[i], i, tags), data_cache[i]);
	dirty[i] = 0;
	full[i] = 0;
      end
  endfunction

  //----------------------------------------------------------------------------
  // dump
  //----------------------------------------------------------------------------
  function void dump();
    int unsigned i;
    
    $display("--- cache ---");
    for(i = 0; i < SIZE; i++) begin
      $display("  %06x %02x : %02x (dirty = %0b full = %0b)",
	       tags[i], i, data_cache[i], dirty[i], full[i]);
    end
    $display("--- memory ---");
    m.dump();
  endfunction

  //----------------------------------------------------------------------------
  // dump_stats
  //----------------------------------------------------------------------------
  function void dump_stats();

    real hit_pct = (real'(cache_hits) / real'(accesses)) * 100.0;
    real miss_pct =( real'(cache_misses) / real'(accesses)) * 100.0;
    
    $display("cache stats");
    $display("  accesses     = %0d", accesses);
    $display("  cache hits   = %0d (%5.2f%%)", cache_hits, hit_pct);
    $display("  cache misses = %0d (%5.2f%%)", cache_misses, miss_pct);

  endfunction
  
endclass
