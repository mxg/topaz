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
// receiver
//------------------------------------------------------------------------------
module receiver #(parameter DATA_WIDTH=8)
  (input clk,
   output ready,
   input valid,
   input [DATA_WIDTH-1:0] data
  );

  reg r_ready;
  reg [DATA_WIDTH-1:0] r_buf;

  assign ready = r_ready;

  always @(posedge clk) begin   /* \label{code:xmit_recv:recv1} */
    r_buf = (valid == 1 && ready == 1) ? data : 'z;
  end

  always @(posedge valid) begin /* \label{code:xmit_recv:recv2} */
    r_ready <= 1;
    @(posedge clk);
    r_ready <= 0;
  end

  always @(r_buf) begin         /* \label{code:xmit_recv:recv3} */
    if(valid == 1 && ready == 1)
      $display("%12t : received <- %0x", $time, r_buf);
  end

endmodule
