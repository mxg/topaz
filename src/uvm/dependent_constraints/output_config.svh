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

class output_config;
  rand bit [31:0] base_addr;
  rand int unsigned channels;
  rand int unsigned buffer_size;

  constraint addr { base_addr < 'h1000; };
  constraint chan { channels > 0 && channels < 16; };
  constraint buff { buffer_size >= 16;
		    buffer_size <= 512;
                    (buffer_size & 'hf) == 0; };

  function string convert2string();
    string s;
    s = "output_config :";
    s = {s, $sformatf(" base_addr = %08x",  base_addr)};
    s = {s, $sformatf(" channels = %0d",    channels)};
    s = {s, $sformatf(" buffer_size = %0d", buffer_size)};
    return s;
  endfunction
  
endclass
