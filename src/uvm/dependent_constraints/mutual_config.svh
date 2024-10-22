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

class mutual_config;

  rand input_config incfg;  /* \label{code:dc:mutual1} */
  rand output_config outcfg;

  function new(); /* \label{code:dc:mutual2} */
    incfg = new();
    outcfg = new();
  endfunction /* \label{code:dc:mutual3} */

  constraint addr { (incfg.base_addr & 'h3) == 0;  /* \label{code:dc:mutual4} */
		    (outcfg.base_addr & 'h3) == 0;
                    incfg.base_addr != outcfg.base_addr; };
  constraint buff { outcfg.buffer_size == (4 * incfg.stride); }; /* \label{code:dc:mutual5} */

  function void post_randomize(); /* \label{code:dc:mutual6} */
    uvm_resource_db#(input_config)::set( "*", "input_config",  incfg);
    uvm_resource_db#(output_config)::set("*", "output_config", outcfg);
  endfunction /* \label{code:dc:mutual7} */

endclass

		    
